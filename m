From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
Date: Sun, 25 Aug 2013 00:09:11 -0700
Message-ID: <20130825070911.GU2882@elie.Belkin>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
 <1377316906-70338-4-git-send-email-draenog@pld-linux.org>
 <20130824203414.GD2960@elie.Belkin>
 <xmqq8uzql0vr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 09:09:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDURs-0004nt-Rc
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 09:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab3HYHJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 03:09:17 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37026 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab3HYHJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 03:09:16 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so2232422pab.35
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ITcEUzN+xphFQkSP0Cih4yyFg+n3HfO+t4pbsArzrQs=;
        b=inrmVibOljZ/pw3NXT5SL9vb9Tnol6CzyAkG6WlQH0pr0OfdefNLjlWqU7zmk2PKMy
         nRRRMNX9l66Je3ChHWKpEW4ZGPJ8p3555Wni1GbYtyUNQVJDIVFDgni5/vc2su3nf1Jv
         S6ZU+I52FrZTrdlWTD6WujSZV8NUD9r4H8sqcCKnqOG2frmyy6sejztq6SvOZGA8167m
         5yMr9FPWGz1qw+oRvW/NzH9rVQpEe5kY0q2QvFemdtKza3jDfmDpEFtifKqLclykJl4f
         NkxDXervkHnUwndhgjUj0coVfW7oOXRIlHBbB9rL/ljKEUyyTVy/4ITqhDL/LTmIkD71
         4QXw==
X-Received: by 10.66.232.39 with SMTP id tl7mr1209775pac.140.1377414555887;
        Sun, 25 Aug 2013 00:09:15 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id om2sm10295860pbc.30.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 25 Aug 2013 00:09:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq8uzql0vr.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232933>

Junio C Hamano wrote:

> The change to the one that feeds 'y' to "reset -p" may be a bit too
> pedantic, as we are not in the business of testing "echo y", though.

Yeah, that's true.  Here's a patch for squashing in.

diff --git i/t/t7106-reset-unborn-branch.sh w/t/t7106-reset-unborn-branch.sh
index af00ab4d..bd28feba 100755
--- i/t/t7106-reset-unborn-branch.sh
+++ w/t/t7106-reset-unborn-branch.sh
@@ -12,9 +12,8 @@ test_expect_success 'reset' '
 	git add a b &&
 	git reset &&
 
-	>expect &&
 	git ls-files >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'reset HEAD' '
@@ -36,12 +35,10 @@ test_expect_success 'reset $file' '
 test_expect_success PERL 'reset -p' '
 	rm .git/index &&
 	git add a &&
-	echo y >yes &&
-	git reset -p <yes &&
+	echo y | git reset -p &&
 
-	>expect &&
 	git ls-files >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'reset --soft is a no-op' '
@@ -60,9 +57,8 @@ test_expect_success 'reset --hard' '
 	test_when_finished "echo a >a" &&
 	git reset --hard &&
 
-	>expect &&
 	git ls-files >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 	test_path_is_missing a
 '
 
