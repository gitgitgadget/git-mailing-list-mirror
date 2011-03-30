From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Make "git notes add" more user-friendly when there
 are existing notes
Date: Wed, 30 Mar 2011 12:32:56 -0700
Message-ID: <7vsju4mmjb.fsf@alter.siamese.dyndns.org>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net> <4D9226B4.20806@warpmail.net> <7vd3l9rbnq.fsf@alter.siamese.dyndns.org> <201103300202.55973.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <drmicha@warpmail.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:33:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q518l-0006Kj-Ek
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab1C3TdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:33:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab1C3TdH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:33:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B9A348B7;
	Wed, 30 Mar 2011 15:34:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1f7WzvhdLxEBoxYqNGD+GS8GQdc=; b=TwKIMp
	QcPmFBtlRm7rrLLayeTjLTMI74baBWX+t9jSTRgQQ8B4pfnwt6eqfrZAI1GRFfSX
	gR/y3rtBhoiJZEap7iwIRSzbfaw2N17pt9MHw+6xdj0qFaeeJGohLePRZBRSfaq5
	Xj2gH5ntY2WnqT4FxKAcwvTBEJjAW6l0VPbeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SWb+m+Tk+376wyDrmBye4lbAYVN4xhZb
	Ggw+JIt+Y8ij8WTfiAYw0TBhyQvcvI751pWNKZO5S/vzpSz6WsjYYnHa8bmNc4tw
	IoF72YOX9hj5bTXNwxdCS06xL+q5+VHAn6FeQIhO0UMmV4dBcqarcevCHicO2An8
	eR4WZB6hAyI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED8A848B6;
	Wed, 30 Mar 2011 15:34:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B7A8348B3; Wed, 30 Mar 2011
 15:34:45 -0400 (EDT)
In-Reply-To: <201103300202.55973.johan@herland.net> (Johan Herland's message
 of "Wed, 30 Mar 2011 02:02:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C711B08A-5B04-11E0-87DE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170413>

Johan Herland <johan@herland.net> writes:

> Currently, "notes add" (without -f/--force) will abort when the given object
> already has existing notes. This makes sense for the modes of "git notes add"
> that would necessarily overwrite the old message (when using the -m/-F/-C/-c
> options). However, when no options are given (meaning the notes are created
> from scratch in the editor) it is not very user-friendly to abort on existing
> notes, and forcing the user to run "git notes edit".
>
> Instead, it is better to simply "redirect" to "git notes edit" automatically,
> i.e. open the existing notes in the editor and let the user edit them.
> This patch does just that.
>
> This changes the behavior of "git notes add" without options when notes
> already exist for the given object, but I doubt that many users really depend
> on the previous failure from "git notes add" in this case.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>
> On Tuesday 29 March 2011, Junio C Hamano wrote:
>> Michael J Gruber <drmicha@warpmail.net> writes:
>> > and while at it rename "add" to "edit"
>> That one I think is older wart that may be harder to change.
>
> Here's one attempt at giving Michael a nicer "git notes add" without
> breaking too many existing users. It's not very pretty, but I hope it
> gets the job done without inconveniencing current users too much.
>
> After all, current (script) users of "git notes add" that depend on it
> failing to overwrite existing notes, should already use -m/-F/-C/-c
> instead of the default interactive mode, anyway.

Looks sensible, by addressing the issue gently without going overboard.

Thanks; I like it.
