From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Tue, 18 Sep 2012 12:22:26 +0530
Message-ID: <CALkWK0k9P9-K5R2Amipujq2DFvJTXy8T3ZyfFa31CcxeKSFL2g@mail.gmail.com>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
 <1347901579-5545-2-git-send-email-artagnon@gmail.com> <7v7grstlp9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrg0-0006J0-8W
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab2IRGws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:52:48 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:64111 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab2IRGwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:52:47 -0400
Received: by qaas11 with SMTP id s11so2248109qaa.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 23:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=71W4gNxXNO85Y2imdS2YeLyLP0qKwrFLdCyuZxwZvdI=;
        b=jNWMdgT74F3cDF/kTrdw9wQh0O/LDUGiHpc7tvzxslu3BJacLxf4jqvKG2WX/V0HTq
         1RGPcaitjRWvirutxxX7SIFw0F6W8+9F2jgajUcHDvaAsrRNbO65dykEOo9baOzC5AX/
         D9SQzw89wBx4zDSOhpEimhV/yjJ5prXXdxLytZnDo87BHj5WIegJXvvKBJU9s6yRtCOr
         8xrt9d+RqdaTNdfnUpKcDM3Uyh1sc4M/UO1vRgNkIyh5Zi4lwYGiI8UFc1k8aiXUuwq6
         8sTX1Ce/3lwNKnnLOMjf1J9P9AbXhHA3z7CKMpDPGXiOExlQWt81u9XGHsYJvtOokiFc
         Btog==
Received: by 10.229.111.156 with SMTP id s28mr8797417qcp.93.1347951166952;
 Mon, 17 Sep 2012 23:52:46 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 23:52:26 -0700 (PDT)
In-Reply-To: <7v7grstlp9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205799>

Hi Junio,

Junio C Hamano wrote:
> Is this a sufficient replacement for what you removed from 0000?
> Can the BUILD-OPTIONS file exist when your build of git failed?

Oops, I didn't realize that BUILD-OPTIONS would be written when the
build fails.  How about something like this instead:

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ae6a3f0..08677df 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -18,16 +18,6 @@ swapping compression and hashing order, the person
who is making the
 modification *should* take notice and update the test vectors here.
 '

-################################################################
-# It appears that people try to run tests without building...
-
-../git >/dev/null
-if test $? != 1
-then
-	echo >&2 'You do not seem to have built git yet.'
-	exit 1
-fi
-
 . ./test-lib.sh

 ################################################################
	Modified   t/test-lib.sh
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f8e3733..8cc7755 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,6 +51,12 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..

+if ! test -x "$GIT_BUILD_DIR"/git || "$GIT_BUILD_DIR"/git && test $? != 1
+then
+	echo 'error: you do not seem to have built git yet.' >&2
+	exit 1
+fi
+
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 export PERL_PATH SHELL_PATH
