Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E6C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FF1206D7
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKljT/MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEEAyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgEEAyK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:54:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5408EC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 17:54:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t9so263573pjw.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tm9wusKB8gyenJ2vqHF+OC/GTge0jgn07/GSzEQCDs8=;
        b=CKljT/MKh/fafUEg7DOmvPvNyfAlfYGZp4on+x6f8INrH57xACItANNRYovlgI86/N
         CmNyjGDDHgH96VFNxbkPfnxKJfPM5o+Hu1Snvw87uKTiwMTrZDUtv0w4vIfh0zBTgLJo
         jh2OcXPREgfl0g8ONsy2BxBZF8iy9B1/1HCDbI6xdd4d2jDFjJSqCgHwqnsWdzUaSukM
         3ewNnYDlS45V2mL/lDPcbzrtBMBC9dYuUMx0to3j259VqikqdBtMYxTGoF7x1lSKxK1k
         EYMjzlPYikB+ZBJW+tfH89R+ewrTUFwyuW0X5p0lFm+cbY/eVqQgLyrXihj80ahth+sX
         6Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tm9wusKB8gyenJ2vqHF+OC/GTge0jgn07/GSzEQCDs8=;
        b=quuSupEuwYBonP7zW/vXJATS3WwNl3KalxIENel1gvI4tYsootAR2AmJO6QP5JPm0d
         DHWP9mBjNmfJRjuub/TMYniYo9OMdyruHxCSgElKmzZKbDbvgZCv4OOqdryWNZWDfSj1
         Rk58TEyxgbw5tRX50r5QMFQvcGrYpqb20gaTISU07jiZ+B3zpMrPKqy18CHxZ9p1JBNK
         evPjb8bMM/c4C5HeV+5I4qqcc/WPbYn8zS/ZegCsqg+ck3wF7I5y+nXSR31iv3fPMH6z
         6NFYVWTZVdf4u/iNjwNAn3ovElSgts8VoGLL3K1kDNyoHux58XX3JfYA1Oe+Zwlhiw/P
         V2Zw==
X-Gm-Message-State: AGi0PuYoFfChVbEfYmS9ubiaEFUIi/xx1Va7Is3GB2EVKz7sfo8+2UFq
        3QKpj1JQGzYvIhKmmPbAdPc=
X-Google-Smtp-Source: APiQypJ2KfBOUJbturpUltMGi5Pyn4hE4PJ5hO4XjkjVNUolq0cK9H3gOoKKOHWghCymJcbiYXSBGw==
X-Received: by 2002:a17:90a:fd16:: with SMTP id cv22mr29971pjb.169.1588640048526;
        Mon, 04 May 2020 17:54:08 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id w14sm224491pgt.36.2020.05.04.17.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:54:08 -0700 (PDT)
Date:   Mon, 4 May 2020 17:54:05 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
Message-ID: <20200505005405.GA1218@Carlos-MBP>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
 <20200504174636.GG86805@Carlos-MBP>
 <20200504232511.GB29599@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504232511.GB29599@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 06:25:11AM +0700, Danh Doan wrote:
> On 2020-05-04 10:46:36-0700, Carlo Marcelo Arenas Belón <carenas@gmail.com> wrote:
> > On Sat, Apr 11, 2020 at 12:18:12AM +0700, Đoàn Trần Công Danh wrote:
> > > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > > index 0ea1e5a05e..40a00983f7 100644
> > > --- a/t/test-lib.sh
> > > +++ b/t/test-lib.sh
> > > @@ -657,6 +657,18 @@ die () {
> > >  	fi
> > >  }
> > >  
> > > +file_lineno () {
> > > +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> > > +	local i
> > > +	for i in ${!BASH_SOURCE[*]}
> > 
> > this line breaks with NetBSD's sh (and probably other POSIX complaint shells)
> > 
> > the Coding Guidelines mention "no shell arrays" and while the tests are more
> > relaxed against that rule, usually workarounds are needed, as it is shown by:
> > 5826b7b595 (test-lib: check Bash version for '-x' without using shell arrays,
> > 2019-01-03)
> 
> This function will be called in CI only, and when the the shell used
> is bash, to annotate the faulty line.

that part is correct, but the test is meant to be able to also run outside
of CI (specially considering that there are several systems that are not
covered by it yet)

> We have a test guarding it already.
> So, I think it's fine.

no; because the shell has to parse the whole script (regardless if it
executes the line or not), so if you checkout master in a NetBSD machine
and try to run the tests you get :

** t0000-basic.sh ***
./test-lib.sh: 681: Syntax error: Bad substitution
gmake[2]: *** [Makefile:56: t0000-basic.sh] Error 2

the coding guidelines warns specifically against using arrays for this
reason, and therefore it will be ideal that we follow such guidelines
by rewriting the code not to use shell arrays (which is not a POSIX sh
feature) as it affects not only NetBSD but anyone else not running bash.

but there is an "easy" workaround as shown by the reference I sent, so a
naive and very ugly "fix" would be:

--- >8 ---
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b221951a8..b6b7175dfe 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -677,6 +677,7 @@ die () {
 
 file_lineno () {
 	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
+	eval '
 	local i
 	for i in ${!BASH_SOURCE[*]}
 	do
@@ -685,6 +686,7 @@ file_lineno () {
 		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
 		esac
 	done
+	'
 }
 
 GIT_EXIT_OK=
