From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 06 May 2013 08:18:33 -0700
Message-ID: <7v38u0t9va.fsf@alter.siamese.dyndns.org>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 06 17:18:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZNBa-00035r-Ps
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab3EFPSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:18:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714Ab3EFPSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:18:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 440911A22C;
	Mon,  6 May 2013 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q3kxk5jKS4bU0WjOUGH2HkBhuIs=; b=sReLX+
	3IM8Und8m40XFnPi3fYgdR5l5mgth7/EPs6moF8115Z/w5lh2dfdIo+t74nwGm9z
	YZdfoUoIyEkkZl/lbdZWxvrwPRwIzI6acMgTOpH1nAdK2/IymNBHhYeQt1c3wtWV
	fOi+KNRhXctC8ozflfnfqqj8bcZ/D11/yTSyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XMcQUsaq9N602R7oqyQ5zIHq+Ovm/8uq
	/tML+aELE8aUKhEANTDRlUZqMaNYBPoobynZBiaaev5NZIZvuQC+D0RKvObVqPb9
	UlClfvFnC97k1CcCP+BvLMOmuw8+xc+TyZSfFsuY6f54qznJFzrlAtZ3H/hP0h9Y
	dN/3HbNITxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36A051A22B;
	Mon,  6 May 2013 15:18:36 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A0471A22A;
	Mon,  6 May 2013 15:18:35 +0000 (UTC)
In-Reply-To: <518789D1.4010905@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 06 May 2013 12:45:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 388CD042-B660-11E2-8F5B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223458>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Yes, it can be handy to start loading the first "blobfile" in parallel
> with the later stages of the conversion, before the second "dumpfile" is
> ready.  In that case the user needs to pass --export-marks to the first
> fast-import process to export marks on blobs so that the marks can be
> passed to the second fast-import via --import-marks.
>
> So the proposed change would break a documented use of cvs2git.
>
> Making the export of blob marks optional would of course be OK, as long
> as the default is to export them.

Thanks for a concise summary.  Your use case fits exactly what
Felipe conjectured as the nonexistent minority.

An option that lets the caller say "I only care about marks on these
types of objects to be written to (and read from) the exported marks
file" would help Felipe's use case without harming your use case,
and would be a sane and safe way to go.
