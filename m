From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] HEAD detached at HEAD
Date: Mon, 21 Sep 2015 10:20:13 -0700
Message-ID: <xmqq8u7zbsfm.fsf@gitster.mtv.corp.google.com>
References: <vpqk2rnirz0.fsf@anie.imag.fr>
	<CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
	<vpqeghviqu1.fsf@anie.imag.fr>
	<CAGZ79kZxAwMvv6UoZLBd2wTOdj1DFWKQqSPBYL449KSokA8DQQ@mail.gmail.com>
	<vpqlhc3h7e7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jacob Keller <jacob.keller@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:20:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4lK-0001ef-TB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbbIURUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:20:17 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35257 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbIURUP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:20:15 -0400
Received: by pacfv12 with SMTP id fv12so124408417pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vVqdH5S3cDzTrM2wVATd48MAPH8k9Nc9+2+82SF9OTA=;
        b=q7QK32d5qMtP1zAuk2tTJw8lNfvkbOs+jaPJygrak8ydOv5hfHq2ADeJBHedAo8Iwl
         HLNR9OcsXcp1J2QrsJm7e7k/8PeriCy0X7HgFse3X5/mmrUjyJ+VFumzHFuUo1kBh/dR
         l6GdQfQpQAd0b7Gi/EkrbQZXB2NtNW5e9pwmIVoOdbyxC+4ZZEApbtvvGr/3ZFDmUC2z
         8z1iK8xqALVXNCwE5/NUfySsB8Y99Q43mr96Stn3VY8SIGuys0HPsnRnRFVG/ZYIGj65
         fBl9oArkSSAfgqjGzhnLk/JVS4+VAer+Sja6JOY+F1dzzx7VxuWrAWscy4KaXCw3MPkx
         g4fg==
X-Received: by 10.66.141.165 with SMTP id rp5mr2544425pab.127.1442856015116;
        Mon, 21 Sep 2015 10:20:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id xv1sm25587977pbb.25.2015.09.21.10.20.14
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 10:20:14 -0700 (PDT)
In-Reply-To: <vpqlhc3h7e7.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	18 Sep 2015 21:09:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278316>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I investigated a bit more. The root of the problem is "git checkout
> --detach" and the reflog. Here's a reproduction script:
> ...
> If one replaces "git checkout --detach" with "git checkout HEAD^0", then
> the output is the one I expected:
>
>   HEAD detached at cb39b20
>
> The guilty line in the reflog is:
>
>   checkout: moving from master to HEAD

Yeah, that sounds broken.  --detach should write the same reflog entry
as "git checkout HEAD^0".
