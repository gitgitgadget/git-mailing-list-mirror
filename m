From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] format-patch: preserve subject newlines with -k
Date: Thu, 26 May 2011 14:18:33 -0700
Message-ID: <7vboypw47q.fsf@alter.siamese.dyndns.org>
References: <20110526203625.GA31018@sigill.intra.peff.net>
 <20110526205504.GC31340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 23:18:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhxA-0002OV-K9
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210Ab1EZVSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:18:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab1EZVSn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:18:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09BB156A9;
	Thu, 26 May 2011 17:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b3piHZ8PKjH/XrIuO8nHoeJqkjA=; b=oYR3EJ
	b5pWlRYUu50Ip7gkX4pcFIXbyiD53U6d4kM+rqi310gFSRyTQc0xTfqo5E+JFC+D
	nUbDHL/ZX8hIVDgT+UXSyoUvu0Rc3kUANfmoEkh3khLpvgCdQ5zSxRd4fPnE+5TU
	sMrarzXPtaY+0+lc20hYY6R2up5eLI9Hm6qTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmeuzJFW4GO3AX5YeD9JzWCxz7uENLEV
	mgaa3iMLoAXZieZHJptL3B/fa5lVrJdmZUs2wDrUcdLcLJLlskXMJUEkS+NdQ/q8
	XRm13GIWJo8zinz4HpJoU+XQj9S7F7t/n6j/rBjeDa3hp2z/5Il3irI6atuLQeac
	LNWQIyarRjw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C559156A8;
	Thu, 26 May 2011 17:20:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7A0B056A6; Thu, 26 May 2011
 17:20:42 -0400 (EDT)
In-Reply-To: <20110526205504.GC31340@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 May 2011 16:55:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 059078E0-87DE-11E0-93AA-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174573>

Jeff King <peff@peff.net> writes:

> We have always treated multi-line subjects as second-class citizens, so
> this is not a must-have patch. But I think it makes sense to do,
> considering how simple it is, and the fact that it makes "format-patch
> -k | am -k" always a no-op, even with multi-line subjects.

I think this is a good thing to have, as the reason why we treated
multi-line subjects as second-class citizens is exactly because we didn't
try to stuff multiple lines on "Subject:" like you did with this patch.

> diff --git a/builtin/log.c b/builtin/log.c
> index d8c6c28..3fdf488 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -768,7 +768,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
>  		     encoding);
>  	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
> -		      encoding, need_8bit_cte);
> +		      encoding, need_8bit_cte, 0);

I do not appreciate a single-bit tweak as separate parameter to a
function.  Back when pp_title_line() had only "do we need 8-bit cte", it
was Ok, but now that you are adding another bit, could we make it an
"unsigned flag"?
