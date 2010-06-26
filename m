From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] t7006: test pager configuration for several git
 commands
Date: Sat, 26 Jun 2010 14:28:36 -0500
Message-ID: <20100626192836.GE20051@burratino>
References: <20100626192203.GA19973@burratino>
 <20100626192450.GB20051@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 21:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSb3f-0001EL-PN
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 21:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab0FZT2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 15:28:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40416 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab0FZT2u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 15:28:50 -0400
Received: by iwn41 with SMTP id 41so3108418iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t+IAmO1jzErmZqb5Jlbc64dx+ZSWHULaLjmawEGQK/Q=;
        b=HmSnb8Sgks9FHMtYNPfo40PrYO7K7d4FJCPdGCaAXe8lNrDuByVsMhmr8YFHMQ1Qs4
         r1d0oMM8bmrnkuRiSoHwpZfGcLq+JeFiPYRq/8mNWmaogDOu0s/bYP88EgqSB1oCfnTL
         rkxOM0vkVFH5EcO58E782/yJDSAPb2SQqcaK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w4d1fQwFAPg3QGrpCe7xV54tSs/1GZ0chQdTqvWKgf0mPo79ENL2zNe4OkVih2npiI
         E6db+fZ0VTYdTYG/Zl3+Uv7mq594BuyTNr9FGoXtIbozsLctT1t95/FLfE0xiYjSDa57
         HFBY0SEfgwMRbOzJFfjP2IRRDSMqWd52yJzy0=
Received: by 10.231.125.158 with SMTP id y30mr2668190ibr.99.1277580530276;
        Sat, 26 Jun 2010 12:28:50 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm1470458ibk.13.2010.06.26.12.28.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 12:28:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626192450.GB20051@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149776>

Jonathan Nieder wrote:

> Test choice of pager at several stages of repository setup.

Here it is again, without whitespace changes. :)

 t/t7006-pager.sh |   40 ++++++++++++++++++++++++++++++++++++----
 1 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index b117ebb..4420f91 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -204,7 +204,9 @@ parse_args() {
 	full_command="$full_command $1"
 }
 
-parse_args expect_success 'git log'
+test_default_pager() {
+	parse_args "$@"
+
 $test_expectation SIMPLEPAGER "$cmd - default pager is used by default" "
 	unset PAGER GIT_PAGER;
 	test_might_fail git config --unset core.pager &&
@@ -223,8 +225,11 @@ $test_expectation SIMPLEPAGER "$cmd - default pager is used by default" "
 	) &&
 	test -e default_pager_used
 "
+}
+
+test_PAGER_overrides() {
+	parse_args "$@"
 
-parse_args expect_success 'git log'
 $test_expectation TTY "$cmd - PAGER overrides default pager" "
 	unset GIT_PAGER;
 	test_might_fail git config --unset core.pager &&
@@ -236,8 +241,11 @@ $test_expectation TTY "$cmd - PAGER overrides default pager" "
 	$full_command &&
 	test -e PAGER_used
 "
+}
+
+test_core_pager_overrides() {
+	parse_args "$@"
 
-parse_args expect_success 'git log'
 $test_expectation TTY "$cmd - core.pager overrides PAGER" "
 	unset GIT_PAGER;
 	rm -f core.pager_used ||
@@ -249,8 +257,11 @@ $test_expectation TTY "$cmd - core.pager overrides PAGER" "
 	$full_command &&
 	test -e core.pager_used
 "
+}
+
+test_GIT_PAGER_overrides() {
+	parse_args "$@"
 
-parse_args expect_success 'git log'
 $test_expectation TTY "$cmd - GIT_PAGER overrides core.pager" "
 	rm -f GIT_PAGER_used ||
 	cleanup_fail &&
@@ -261,5 +272,26 @@ $test_expectation TTY "$cmd - GIT_PAGER overrides core.pager" "
 	$full_command &&
 	test -e GIT_PAGER_used
 "
+}
+
+test_default_pager        expect_success 'git log'
+test_PAGER_overrides      expect_success 'git log'
+test_core_pager_overrides expect_success 'git log'
+test_GIT_PAGER_overrides  expect_success 'git log'
+
+test_default_pager        expect_success 'git -p log'
+test_PAGER_overrides      expect_success 'git -p log'
+test_core_pager_overrides expect_success 'git -p log'
+test_GIT_PAGER_overrides  expect_success 'git -p log'
+
+test_default_pager        expect_success test_must_fail 'git -p'
+test_PAGER_overrides      expect_success test_must_fail 'git -p'
+test_core_pager_overrides expect_success test_must_fail 'git -p'
+test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
+
+test_default_pager        expect_success test_must_fail 'git -p nonsense'
+test_PAGER_overrides      expect_success test_must_fail 'git -p nonsense'
+test_core_pager_overrides expect_success test_must_fail 'git -p nonsense'
+test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p nonsense'
 
 test_done
-- 
1.7.1.579.ge2549
