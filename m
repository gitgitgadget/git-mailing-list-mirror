Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C9FC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 07:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8456D20714
	for <git@archiver.kernel.org>; Wed,  6 May 2020 07:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7luYDcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEFHat (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgEFHat (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 03:30:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FFCC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 00:30:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u10so135723pls.8
        for <git@vger.kernel.org>; Wed, 06 May 2020 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WrIm1JgVzwgrvNiflifCL/29/nIlNLZ/mXLvwg5BqTA=;
        b=R7luYDccXczHtgE5Z+ZXPLCerxi8eT0Cfm2EhGRqY7C6Ev9AuJafBeSQ0sWeBZRnyb
         wCA3m3lNKakdmlehtcGUPY8hWpF2EMFq82tKeWNr7onYuRk4zDFUhQc0PIbT1HcrbpsW
         Vm+8kXUyCSWhOyOHS56I4hbeKegd2Bdo24ndxSwgMtxeSB2/E+JuxBStdRgldPQWghkc
         Uo86XBJP4JscCJm7K+4PIvNKpfAgJ+IkmZy52RrAjUVsdIav/SOJGDuFk4IuioKthGzB
         sSbJtrnSsaz9T+voYtFyhba+4LGYQkBIE+3ivYzickmG9aSOca8DQg3lZ8xJL2LUlR7D
         zuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WrIm1JgVzwgrvNiflifCL/29/nIlNLZ/mXLvwg5BqTA=;
        b=CeVZe0iwycV8m5goVlOds72nalFtpQ+Pry5paqg1GUFZ6WFxMAaiwHl16WO0TOsPCB
         1944mT40l+HCSavFieJ83GiCV+EoAv4SmRk/WzrMLzVfgCqW9UxZLkUs/w4ksRmgANu2
         UQXPXzyIJC5cZn+sra8f1Hw8u/V6C+U7zD36Nxv+4M8/EgL+1Jec6+2pIXHAQ646q9ll
         SMpksHS91F/Ph8eTxGArNBwFfjBcFxLuERcNb/quxefI6D+myeooq17dkiLhDF3KQkts
         oSHslLoOvYGLrjF88eacWJwctPpNmeWnD1ErEuDxlBLM8Vxishvqecgx71OlRhwb90hH
         aDXQ==
X-Gm-Message-State: AGi0Pubwy4X1g18u4ZRg7MPrmt4ruuqTNCCfpOF4ErQd6wwhS+J/JzuP
        803+nAw8YYWfT9L4QJAwasU=
X-Google-Smtp-Source: APiQypJg16SuDgwm4iLFjkWv5mLMZddPRfP0Cz+dU8VIb4FjHAfUTGqUcQohSyWhEnus6415xwB1PQ==
X-Received: by 2002:a17:902:9002:: with SMTP id a2mr6809635plp.220.1588750248464;
        Wed, 06 May 2020 00:30:48 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id u13sm3921464pjb.45.2020.05.06.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 00:30:47 -0700 (PDT)
Date:   Wed, 6 May 2020 00:30:45 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
Message-ID: <20200506073045.GA52959@Carlos-MBP>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
 <20200504174636.GG86805@Carlos-MBP>
 <20200504232511.GB29599@danh.dev>
 <xmqqlfm7cj7s.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlfm7cj7s.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 05:35:03PM -0700, Junio C Hamano wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
> 
> >> > +file_lineno () {
> >> > +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> >> > +	local i
> >> > +	for i in ${!BASH_SOURCE[*]}
> >> 
> >> this line breaks with NetBSD's sh (and probably other POSIX complaint shells)
> >>  ...
> > This function will be called in CI only, and when the the shell used
> > is bash, to annotate the faulty line.
> >
> > We have a test guarding it already.
> 
> Carlo, you said "this line breaks"---implying that you actually saw
> breakage when running our tests on affected platforms.  Is that the
> case?

correct. and as described in the followup email[1]

> It is entirely possible that some shell implementations may try to
> parse the contents of the shell function and trigger a syntax error
> on that line, even before evaluationg "are we running tests and do
> we have BASH set?", so I can believe "we have a test guarding", if
> the mention refers to the first line of the helper function, is
> insufficient and does break with some shells.

it would seem that a POSIX sh version would be enough for what we
need and as shown after the scissors.

got away also with the IMHO unnecesary rewriting of the script path
and hardcoding of "t/" as it looks cleaner.

Carlo
--- >8 ---
Subject: [PATCH] tests: make file_lineno() POSIX sh compatible

662f9cf154 (tests: when run in Bash, annotate test failures with file
name/line number, 2020-04-11), introduces a way to report the exact
location where an error was triggered.

The implementation was using bash specific syntax and was restricted
with a guard so it will only be used with bash, but NetBSD sh will
still have to parse the function and the use of arrays triggers a
syntax error as shown by:

** t0000-basic.sh ***
./test-lib.sh: 681: Syntax error: Bad substitution

Instead of guarding the code, use a simpler version written in POSIX
sh as per the Coding Guidelines.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/test-lib.sh | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b221951a8..a8f8e4106b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -676,15 +676,9 @@ die () {
 }
 
 file_lineno () {
-	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
-	local i
-	for i in ${!BASH_SOURCE[*]}
-	do
-		case $i,"${BASH_SOURCE[$i]##*/}" in
-		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
-		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
-		esac
-	done
+	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" || return 0
+
+	echo "$0:$LINENO: ${1+$1: }"
 }
 
 GIT_EXIT_OK=
-- 
2.26.2.686.gfaf46a9ccd

