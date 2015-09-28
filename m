From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/7] git-p4: add support for large file systems
Date: Mon, 28 Sep 2015 12:55:28 -0700
Message-ID: <xmqqa8s6co9b.fsf@gitster.mtv.corp.google.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 28 21:55:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgeWO-0003hD-5l
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 21:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbI1Tzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 15:55:31 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36289 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbI1Tzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 15:55:31 -0400
Received: by pablk4 with SMTP id lk4so85962320pab.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=L86KxyDDpMzulsFqW4TVD7L8L83HK1JwuaCMcSBq0s8=;
        b=een4IANXycV+P78drc48CH0/a5JELQORrthP56CvHJIEtOfnOpOW7t19/+SJQQEoKp
         6zqZq2XXp0RGSK9H6Nah9KwSXuX95C6oiiNuUlSO9OutgmwvNRBUNcaV5L53TZdsg0SG
         f9cWUKCeffBfRoDCQ4+eaQRw2p//xKSYuITQwmVK6GMxqyzqRSbTH/UQPUsqIdE1/rNi
         +ikktMGyZhK5CoZsN+fJIki7wtjmzWYmJyZ9dFGV0BRk228mW9TqK5ltlB/fbEtJ/roT
         UUkSBJSsD5D30pCa9Jx2a6VH1PcJE1PTfyYmsVLki6pQG+UrAXuUjrOa2YAI0q4kYKRH
         gPug==
X-Received: by 10.66.193.132 with SMTP id ho4mr29012831pac.154.1443470130580;
        Mon, 28 Sep 2015 12:55:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id f5sm21075008pas.23.2015.09.28.12.55.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 12:55:29 -0700 (PDT)
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sat, 26 Sep 2015 09:54:57
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278747>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v7:
> * fix commit message line length (thanks Junio)
> * fix sync command for large file system support (thanks Luke!)
> * add test case for sync command
> * rename git-p4.pushLargeFiles to git-p4.largeFilePush for consistency with
>   other git-p4.largeFile* configs
> * fix relative path handling for clone operation which caused a crash in the
>   disk space check and t9819 (thanks Luke!)
> * use test_path_is_missing instead of !test_path_is_file (thanks Luke!)

Thanks.  Also v7's 5/7 had what should have been part of 6/7,
resulting in double assignemnt to largeFileSystemConstructor, but
this reroll seems to fix that.

Will queue.

>
> The patch is again based on maint (ee6ad5f) as patches v1-v6 before.
>
> Cheers,
> Lars
>
> Lars Schneider (7):
>   git-p4: add optional type specifier to gitConfig reader
>   git-p4: add gitConfigInt reader
>   git-p4: return an empty list if a list config has no values
>   git-p4: add file streaming progress in verbose mode
>   git-p4: check free space during streaming
>   git-p4: add support for large file systems
>   git-p4: add Git LFS backend for large file system
>
>  Documentation/git-p4.txt   |  32 +++++
>  git-p4.py                  | 270 +++++++++++++++++++++++++++++++++++++++---
>  t/t9823-git-p4-mock-lfs.sh | 192 ++++++++++++++++++++++++++++++
>  t/t9824-git-p4-git-lfs.sh  | 288 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 766 insertions(+), 16 deletions(-)
>  create mode 100755 t/t9823-git-p4-mock-lfs.sh
>  create mode 100755 t/t9824-git-p4-git-lfs.sh
>
> --
> 2.5.1
