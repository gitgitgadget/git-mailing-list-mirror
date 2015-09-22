From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Tue, 22 Sep 2015 15:03:59 -0700
Message-ID: <xmqq8u7y1580.fsf@gitster.mtv.corp.google.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 23 00:04:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeVfV-0005La-G1
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 00:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934862AbbIVWEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 18:04:04 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35132 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbbIVWEC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 18:04:02 -0400
Received: by pacfv12 with SMTP id fv12so20923676pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IPegtnYuBJIcfXuctzmuuVczcRXCtI7mZB+Vkoml94k=;
        b=YIJGIY2WXaLp353MrDswEHa7YZDGCIK2ZdCsMhEI3sjlT1/6JccrvFuUR6uagelfmm
         Bo/1G4VaVZ5+AhPP37+szH7ykBrV7MYY5eZ8WmiXpOHnuRUkisE7sbhk+dgRFu+REMYQ
         qawZoYj4KC7enK6N6XcdurlWBr22HNfg3q0idbOnC6Gy6NSwDcvUF6PbAxneBL+n8L0J
         GsxvR1D1KMMz3u3VTt2iF+U5aJsW7SutZoTffBxYpqkvGkHCU+dUAD1FjB78UZ6J5vY7
         hyMnrqOI28TnyZN8QhXL6U2edVqQs5pCgyO++I4z8qTlWUfE+l7hXENlq8aBoYxwHodB
         kk5g==
X-Received: by 10.66.220.2 with SMTP id ps2mr33087974pac.128.1442959441688;
        Tue, 22 Sep 2015 15:04:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id gq7sm4156174pac.5.2015.09.22.15.04.00
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 15:04:00 -0700 (PDT)
In-Reply-To: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Tue, 22 Sep 2015 00:41:06
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278444>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v6:
> * fix spaces in .gitattributes for Git-LFS files (old "[:space:]", new "[[:space:]]")
> * generated patch on top of next (95c4325) to resolve merge conflicts
>
> I am sorry about the "[:space:]" bug this late. I had the fix in my development
> branch but missed to apply it in this patch series.
>
> @Junio:
> Your conflict resolution in pu looks good. Nevertheless, I made this patch on
> top of next to ease the integration. I hope this is ok.

Please don't rebase without a good reason, especially after you
checked the conflict resolution is OK and your reroll does not
affect the way the conflicts are resolved.  If you based your
v6 patch on v2.6.0-rc0 and then your v7 patch needs to use something
that did not exist v2.6.0-rc3, you cannot avoid rebasing on top of
that newer codebase to use that new feature, but otherwise, no.

This is because I prefer to apply the new series to the same base
version so that each step can be compared with the corresponding
step in the previous round.

I even try hard to keep the commits from the older round if the
patch text and log message are unchanged.  This time, I had to
backport [v7 6/7] to apply to the same base before noticing and
verifying that [v7 7/7] is the only thing that was changed in this
round.  All the other ones turned out to be identical.

Hence, the end result for me was

    $ git checkout ls/p4-lfs
    $ git reset --hard HEAD^
    $ git am -s git-p4-lfs-7-of-7.mbox

but it took me a lot longer than necessary because of the rebase.

Thanks.
