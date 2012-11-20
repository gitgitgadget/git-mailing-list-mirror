From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4.1 5/5] push: update remote tags only with force
Date: Mon, 19 Nov 2012 21:44:51 -0800
Message-ID: <7vwqxgsu98.fsf@alter.siamese.dyndns.org>
References: <1353183397-17719-6-git-send-email-chris@rorvick.com>
 <1353189237-19491-1-git-send-email-chris@rorvick.com>
 <7va9udxryf.fsf@alter.siamese.dyndns.org>
 <CAEUsAPa9fiF9cuMqRHNsQSz_CsbbvdO-eGDS9HWW3MrAYZPA8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 06:45:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tagdx-0007A8-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 06:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab2KTFoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 00:44:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab2KTFoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 00:44:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16D5966F4;
	Tue, 20 Nov 2012 00:44:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nKm4CdKFVeSDc2LpgwJeZZRcqr8=; b=whKUFN
	n5WXvOTr913HFufBmWgSps0rDr/ZUfCXCvlA9UdgBRxo4aJEy3xfjEcsjYy1h3HA
	r69pmaMkKDWYm9PR24pDnb40g8mNfdsKdHh29q2eC/97/JAo8fvL0xJSJzdcblf6
	Ch/oc4JVNCNhS5GZNNd96wEcIKvImDBbo/p7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hugVB29t1oghhR4I6993dZb19Er+9dpM
	HYwxYniZyWMdKDYDhG1qBecSHRFjMcxAEVBt5da5JqNrHW2z8lXX5hB8Jw642fl2
	Vso8I38wfpyROPdVAwUBUTszWRw15dGU5diuzO2bmH8LxMD0o2uimKjAEKttWj/k
	CEaYDbO3jLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 036CA66F2;
	Tue, 20 Nov 2012 00:44:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70E2366EA; Tue, 20 Nov 2012
 00:44:53 -0500 (EST)
In-Reply-To: <CAEUsAPa9fiF9cuMqRHNsQSz_CsbbvdO-eGDS9HWW3MrAYZPA8w@mail.gmail.com> (Chris
 Rorvick's message of "Mon, 19 Nov 2012 22:43:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 685D63AE-32D5-11E2-978C-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210079>

Chris Rorvick <chris@rorvick.com> writes:

> On Mon, Nov 19, 2012 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Yeah, this was one of a few stupid mistakes.  Previously I used
> 'forwardable' throughout, but that is awkward except in the last
> commit since until then everything is allowed to fast-forward and the
> flag is only used to output tag-specific advice.  But inverting the
> meaning of the flag is dumb, and I didn't even do it right.
>
> But, as I think you're suggesting, it probably makes more sense to use
> a flag that prevents fast-forwarding when set.  So maybe
> "not_forwardable", or "is_a_tag" => "not_forwardable" if you think the
> renaming is a good idea.

Yeah, calling it not-forwardable from the beginning would be a
sensible approach, I would think.

Thanks.
