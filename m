From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 12:58:11 -0800
Message-ID: <xmqq1toysyak.fsf@gitster.dls.corp.google.com>
References: <6997784.RuzRO1AFsK@al> <20141119190800.GB9908@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Peter Wu <peter@lekensteyn.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:58:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCKU-0008VH-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 21:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933080AbaKSU6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 15:58:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932702AbaKSU6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 15:58:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A384D1FE48;
	Wed, 19 Nov 2014 15:58:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=53K6omUcQGFGBszlM5zqN/qJiGw=; b=jRxYs2
	Hr9LvB98RGYxKKetbUhpUz89TSH+OLv5C8rQqrJt00svboIORYOM14ojgsYUwlDh
	VHjLpwkjfae1dpRb5g/0cjNWzXcZPl6lbqWuADVKch/Hf/Ncc6TVrX4xWxvE1U4Z
	p3GBapP+75a4GB21xyC9NxiE+7jRBwV8ENVAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TUTk+N00xmwCpwgF+afOEm03pOi/CDYa
	sUuK97/DYncwP6Y2QnBgYnli0JUK8n9RzXbD6aUB0Ii3oOiNmL/JKj71uLVh86VP
	HpydIyEsMClgj3G40a8vf/os33Ob6tzvftdB5+017Vq60vG1GpTKKWy64wiCBssH
	zbXntpP9xrY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9967A1FE47;
	Wed, 19 Nov 2014 15:58:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1536F1FE46;
	Wed, 19 Nov 2014 15:58:13 -0500 (EST)
In-Reply-To: <20141119190800.GB9908@peff.net> (Jeff King's message of "Wed, 19
	Nov 2014 14:08:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C69D61C4-702E-11E4-990C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But here you do not have a pushurl defined in the first place. So I
> guess this is really just a shortcut for swapping the two, like:
>
>   git remote set-url --push gh $(git config remote.gh.url)
>   git remote set-url gh new-fetch-url

It seems that this swapping is only necessary because the repository
is set up in this way:

    $ browser github.com
    ... fork upstream to your own publishing repository ...
    $ git clone <your publish repo>
    ... oops, I am set up to fetch from myself ...
    $ git remote set-url --push mine <url for your publish repo>
    $ git remote set-url <url for your upstream repo>

If you are fetching from somebody else and then pushing into your
own publishing repository (i.e. fork of that upstream), why isn't
the sequence of event like this, instead?

    $ git clone $upstream
    $ browser github.com
    ... fork upstream to your own publishing repository ...
    $ git remote set-url --push mine <url for your publish repo>

Isn't this one of those bad workflows encouraged by GitHub, for
which you guys have to be punished ;-)?
