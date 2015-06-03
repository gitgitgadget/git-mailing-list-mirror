From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug "$message" literal in commit message
Date: Wed, 03 Jun 2015 11:16:40 -0700
Message-ID: <xmqqzj4gwtbr.fsf@gitster.dls.corp.google.com>
References: <CAF-5DQ+WGhHq0OZZh+90iuD1qrffcYyuprzW9m7XC6NGXPZzSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yauheni Zablotski <e.zablotski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0DDj-0005Fd-R7
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470AbbFCSQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 14:16:46 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38772 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933468AbbFCSQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:16:43 -0400
Received: by igblz2 with SMTP id lz2so21190210igb.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UpHF8VwSpYUQ3sCUFbzfIjX/KH9rSfJYoX1ZKEr+1Lg=;
        b=XcOkHYS+I15QXWuvQkU4BNwUqqd4J2JhWpdSaGvTESVM8OaQbObyqskAUrTNINiDo+
         gTcCXri9s1o4Ra/qbuJmzNYTDBe34hLiHBoM/igTGYm+hcPFunz+tV4blPqOS1KzlqOl
         Z/dwntn96wy0pk6Xp25Rmkdn3ZEXPL28duq+YdRRYEDcCl3kJB7zrmSErq7IeuZVD3T5
         zoPi6ZS7zZVMbjND34lmZRRNGpk7464kCGTOSICFlToxasMIdCP2BjC9fVgCbmksVe2u
         5pxtHw1ZVp13cOQVGUFv0MJW3n2HucjeheMqVFWxa3QGmXatpvIw5wQBdfdZGm0JNZuy
         Qgiw==
X-Received: by 10.42.161.74 with SMTP id s10mr41529770icx.5.1433355401698;
        Wed, 03 Jun 2015 11:16:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id k74sm15217858iok.30.2015.06.03.11.16.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 11:16:41 -0700 (PDT)
In-Reply-To: <CAF-5DQ+WGhHq0OZZh+90iuD1qrffcYyuprzW9m7XC6NGXPZzSQ@mail.gmail.com>
	(Yauheni Zablotski's message of "Wed, 3 Jun 2015 18:51:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270718>

Yauheni Zablotski <e.zablotski@gmail.com> writes:

> Hello,
>
> I think I found a bug(or strange behavior) in the git.
> If commit message contains literal "$message" than that literal
> disappears from commit message.
>
> For example:
> -------------
> user@comp ~/cc $ git commit -am "1$message1"
> [master (root-commit) d36a841] 1
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 1
>
> user@comp ~/cc $ git log
> commit d36a841ae25510ada80246a78225446083fcb3e1
> Author: user <e.zablotski@gmail.com>
> Date:   Wed Jun 3 18:21:45 2015 +0200
>
>     file
> ----------------
>
> Sorry for having disturbed you

Learn shell ;-)

Instead of "git commit -am", try "echo" and repeat your exercise,
and you would see:

	$ echo "1$message1"
        1

If you prepare a shell variable message1 beforehand, e.g.

	$ message1='This is the contents of message1 variable'
        $ echo "1$message1"
        1This is the contents of message1 variable

Your shell interpolates the value of message1 variable if you write
"$message1" on your command line, way before individual commands
(e.g. echo and git above) that receive the string as its parameter
sees them.

Contrast the above with this invocation after understanding the
above.

	$ git commit -a -m '1$message1'
	$ git log
