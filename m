From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 06 May 2013 09:17:26 -0700
Message-ID: <7vppx4rskp.fsf@alter.siamese.dyndns.org>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 18:17:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZO6Y-0001qE-G8
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 18:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346Ab3EFQRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 12:17:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236Ab3EFQR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 12:17:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79ABF1C4DB;
	Mon,  6 May 2013 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RjJ0UI2gywF2sCFRIxMxwvMJif4=; b=obbr+u
	f9ihpQNWTWGp5um7e0/f5yGKlxtIiYgmHmeWW4q9fX+XZwu8f2CchiMlVflx+RgF
	MWnafp8ghORVBWCe7xLtq1zRev1a6egIgGZrx9yhfIHt0LOsWiaattIS1UE05BUU
	paBLxU0IAV9navteuvYBPyQnHZdk1IxZ9+5CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hGpLYl0aWZBjnVDCVpMofwj+I/shJTpT
	oR00DBDKhWss3MEN6E0pTI9zLoivgPobkHmBc1C/wdnOBbrgyViDyyg8nQziEd/c
	oz/ut1EX5oG1zJ8YcVLGB40YvuFYkCfCZTLD+ichy3QJPg0lLTE7SV0QoKc4mB4Z
	7TPCB/wAP9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EC6E1C4D9;
	Mon,  6 May 2013 16:17:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E63631C4D8;
	Mon,  6 May 2013 16:17:27 +0000 (UTC)
In-Reply-To: <7v7gjctabm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 May 2013 08:08:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71F8B550-B668-11E2-AEE9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223466>

Junio C Hamano <gitster@pobox.com> writes:

> By discarding marks on blobs, we may be robbing some optimization
> possibilities, and by discarding marks on tags, we may be robbing
> some features, from users of fast-export; we might want to add an
> option "--use-object-marks={blob,commit,tag}" or something to both
> fast-export and fast-import, so that the former can optionally write
> marks for non-commits out, and the latter can omit non commit marks
> if the user do not need them. But that is a separate issue.

s/--use-object-marks/--persistent-object-marks/; I think that would
express the issue better.
