From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9 v2] t7006: test pager.<cmd> configuration
Date: Tue, 13 Apr 2010 21:19:50 -0500
Message-ID: <20100414021950.GB22766@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413022505.GD4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 04:20:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1sCt-0001Uq-R8
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 04:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab0DNCTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 22:19:55 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:64175 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab0DNCTy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 22:19:54 -0400
Received: by iwn35 with SMTP id 35so2446926iwn.21
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 19:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ev1Pl2SWxqH7JF9UrYQPo128YixhYbAF2SLCkrssLXs=;
        b=PPox9OrwR4KtNr2D2K5GJqtoyMP3EKbv+UquV/YQtf2sk85fAg0g4hwsGtxHsNxMjT
         soFrwCTqY2KF+qZbzcp/OqrDGPBjtMPsFrFgwF9a1wnS0xKkNVLXDaTV+iD7hwCjqSWF
         7Msry5zD+zG1sYqceRHp5jAHwJ90r8gkZQUDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=S9TB8l85rvgUnQbJpXwV4OL/Yju9FA3dAUBrc7//cFl+6ICLJN/dHC+eJFUzN8+PCO
         khSNDGsdd/c+vypAuhPtI9FcMRwlpPKX7pfn6B9p1BP2s5gz1JcgYRWnDfGaalFIzYoa
         3bNXT0v4k7WByUkWQrEu0PsuZc305LOH9CTqY=
Received: by 10.231.60.19 with SMTP id n19mr3015630ibh.79.1271211593742;
        Tue, 13 Apr 2010 19:19:53 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id co35sm3481441ibb.8.2010.04.13.19.19.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 19:19:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413022505.GD4118@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144844>


Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Rebased against patch 3 v2.

 t/t7006-pager.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index a240b15..97ca5d6 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -71,6 +71,22 @@ test_expect_success TTY 'git --paginate rev-list uses a pager' '
 	test -e paginated.out
 '
 
+rm -f paginated.out
+test_expect_success TTY 'git rev-list uses a pager if configured to' '
+	git config pager.rev-list true &&
+	test_terminal git rev-list HEAD &&
+	test -e paginated.out
+'
+git config --unset pager.rev-list
+
+rm -f paginated.out
+test_expect_failure TTY 'git config uses a pager if configured to' '
+	git config pager.config true &&
+	test_terminal git config --list &&
+	test -e paginated.out
+'
+git --no-pager config --unset pager.config
+
 rm -f file paginated.out
 test_expect_success 'no pager even with --paginate when stdout is a pipe' '
 	git --paginate log | cat &&
@@ -300,4 +316,14 @@ test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
 
 test_doesnt_paginate expect_success test_must_fail 'git -p nonsense'
 
+test_doesnt_paginate expect_success 'git rev-list HEAD'
+test_expect_success 'set up rev-list to use a pager' '
+	git config pager.rev-list true
+'
+test_default_pager        expect_success 'git rev-list HEAD'
+test_PAGER_overrides      expect_success 'git rev-list HEAD'
+test_core_pager_overrides expect_success 'git rev-list HEAD'
+test_core_pager_subdir    expect_success 'git rev-list HEAD'
+test_GIT_PAGER_overrides  expect_success 'git rev-list HEAD'
+
 test_done
-- 
1.7.0.4
