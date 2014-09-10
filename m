From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 1/2] Makefile: add check-headers target
Date: Wed, 10 Sep 2014 10:09:56 -0700
Message-ID: <xmqq38bzieqj.fsf@gitster.dls.corp.google.com>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
	<xmqqiokylz46.fsf@gitster.dls.corp.google.com>
	<vpqsik13o84.fsf@anie.imag.fr>
	<xmqqa969nav9.fsf@gitster.dls.corp.google.com>
	<20140910000328.GB12644@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 19:10:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRlPM-0005DM-BI
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 19:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbaIJRKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 13:10:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58724 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbaIJRKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 13:10:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5324386F3;
	Wed, 10 Sep 2014 13:10:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fO2eNvCqtjDFdolTqAEWzmA4shE=; b=k7HvVW
	jhbyIQUO59907/ikyT8fM4NjtW/hGWr4S0SB0tHkrLVZruxMk4QjQ02XOJsKQjnc
	ynQUzjrTZ/PDMlHY+pxgrWkElIGol9QtVr4Wk8J2AM5ux83qUgrtZLZt4ZFbxEVF
	3Lc1URsiYcWKJmpDNMBafYitbqPAyNFsqwqJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TE5bGvgJjnXfu2wwqG6LpQWMGnCHkKyo
	nrNKfYhCAuV2DUscTe1nxCZRvmNoS1HmN+6ARcDNlRoi6ryi8cspaes++8gNsS/P
	ayF5NLk8EC6ttuMlzeYwRzXM1C865kgNpqciYV34xr9IfKIZRuxtjKWMmSeQa4ZO
	Ha6XVUEEhxk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 594DA386F1;
	Wed, 10 Sep 2014 13:10:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CEBD4386EA;
	Wed, 10 Sep 2014 13:09:58 -0400 (EDT)
In-Reply-To: <20140910000328.GB12644@gmail.com> (David Aguilar's message of
	"Tue, 9 Sep 2014 17:03:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4B4C3C5A-390D-11E4-97C4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256753>

David Aguilar <davvid@gmail.com> writes:

> On Mon, Sep 08, 2014 at 12:57:46PM -0700, Junio C Hamano wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> ...
>> > for header in .h ewah/*.h vcs-svn/*.h xdiff/*.h
>> > do
>> > 	...
>> > done
>> 
>> Yes, that would be even better.  Then you wouldn't even have to
>> worry about $IFS dance.
>
> The original motivation was to avoid picking up the generated
> common-cmds.h header file.

	for header
        do
        	case "$header" in $exceptions) continue ;; esac
		...
	done

with comments describing why these exceptions are made would be a
better way to go in such a case.

> It was the N_() function that was messing it up.
>
> Would it make sense to split out a separate patch that makes common-cmds.h
> check-headers clean?

Depends on why "gcc -c $header"-cleanliness needs to be strictly
enforced, I think.  

"common-cmds.h" is merely a way to allow us maintain a part of its
single includer help.c mechanically maintained, and if anybody else
includes it, it is an error, even if that includer does so after
including "gettext.h".

Some effort would be required to butcher "common-cmds.h' to make it
include "gettext.h" but that amount of effort can be better spent to
add a check to make sure nobody else includes it, I would have to
say.
