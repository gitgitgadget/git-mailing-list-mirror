From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] t7006: test pager.<cmd> configuration
Date: Mon, 12 Apr 2010 21:25:05 -0500
Message-ID: <20100413022505.GD4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:25:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1VoY-0007Wt-7J
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab0DMCZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 22:25:14 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:50987 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab0DMCZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:25:13 -0400
Received: by ywh32 with SMTP id 32so1944506ywh.33
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=50BQFd99AK1vgYraZG7XYwhqMgQOTVKJLR6Sy3g3NSU=;
        b=YlVi9IPC/rv65i8BeyN+n4aYWYNeZRmiZFqZ5YyqDxS5ils7WIVl4BLEqBDpI7dMt/
         fAV1b0KmNCCT+Vsgj8IVg0F/PO8nCbgcB7XkyJF+Md5dnmB8ZuAjDdDqmb2+xMO3XlMw
         U8V1W2Vi8TPNFW+SKd4hEyBHl6tEA0eq5pqOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DTnUYoENix/sknxjs4fpzqDoMuRWA93h8UtRkLuPOoIGadbVrloctPJ62SdquXCiK2
         JDFH/iETMcMUbzaYReRftBWiaR+tlZnfVKub+uwfN95bjcV+6BmtNhTQ03f0aEZ/5uHw
         yoteVZYpy6b41IPzDeIpF4kMRnKzZvKtBoDjs=
Received: by 10.101.155.34 with SMTP id h34mr8744476ano.156.1271125510903;
        Mon, 12 Apr 2010 19:25:10 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 20sm4486347iwn.5.2010.04.12.19.25.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:25:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144782>


Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7006-pager.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 944e830..237a689 100755
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
@@ -239,4 +255,8 @@ test_pager_choice test_must_fail 'git -p' failure no
 
 doesnt_paginate test_must_fail 'git -p nonsense'
 
+doesnt_paginate 'git rev-list HEAD'
+git config pager.rev-list true
+test_pager_choice 'git rev-list HEAD'
+
 test_done
-- 
1.7.0.4
