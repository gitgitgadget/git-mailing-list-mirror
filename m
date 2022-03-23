Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C1C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 01:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiCWBLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCWBLD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 21:11:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7337F5BD1E
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 18:09:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g8so55629qke.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CayvU33vS21Y38u9vq93Be8ZlLXdfMMPFNQVT2q8arc=;
        b=H+T3dFDpoVvB8mP3k7rlr3NOrz+Yct+QrcYEs+y9zMJ+IyI6yT2qamtStMeyehS50T
         v3ud0AFdEl4tQ0dkP36UDTIkggSowWerjh9HlBC86/8JP2pwerzuPQhQZSt7e1F8QTpP
         c9oBjkhKLCjCgMZJvcXSLKpnCllXoL6afwnhU5ME1G/8mcECJTxjE+RrUthbp9KGCFth
         sDnfG7Jz1NHq7K6J4tW4VFyCvs9vjSARiAYPAKfFNkUjJAApaLpAHrfhb3NdK0jOIX4k
         /91IGnjmHrjoTYJRDRe7K/gahOKiwZi06//4/68EgoU8egQhGyb3rFBazQcVdx4oHmFi
         dy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CayvU33vS21Y38u9vq93Be8ZlLXdfMMPFNQVT2q8arc=;
        b=LJbZ9IuLVSW+nCpmGPXFrjurfL3bkrx1AAUFL8wchD23hdWLYMU5qdkKar61RQbAAN
         RloDM0xxdeG4ysnx/fka7l3MKKPToVEqZbMnCNjadFvqWXajyJM9noZWg5dziZHuFZ+G
         k5PA/YW38k+EwU/0LxagigG9XoAOaWFPM8B71nB23Bk6AbAo42Pq/BMdyRpRqmX9i8CN
         rG96FOpOEJzWZ8wTjbmR7zD32dS8IqhpJiIockFssQ79iYnIk9f6Gcv7aqNR6jjcG1fH
         cdwWkJi0+FlLgvbSzh7AraF5SkDBVsVBJQXW0uk1P//qORragfLMby4GDrXXsIk41Ni6
         3Q/g==
X-Gm-Message-State: AOAM530aH2oYWSJF7bTPVuR7oKoSGsTqURlkXhzkwPQe747vkdRyPGdB
        4q6Nfo0/e2CUVCouAMsF7+E=
X-Google-Smtp-Source: ABdhPJwthx3f8cD7U218wM1I3taUWeOPYwMMesx28LH0txHyiFyz9wm6FPUkm9jc5DSwK2m3sMDXhA==
X-Received: by 2002:a05:620a:4142:b0:67b:21fe:918b with SMTP id k2-20020a05620a414200b0067b21fe918bmr17469652qko.708.1647997773538;
        Tue, 22 Mar 2022 18:09:33 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id m3-20020a05622a118300b002e1beed4908sm15378883qtk.3.2022.03.22.18.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 18:09:33 -0700 (PDT)
Date:   Tue, 22 Mar 2022 18:09:31 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Paul Eggert <eggert@cs.ucla.edu>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: improve performance of PCRE2 bug 2642 bug workaround
Message-ID: <20220323010931.jzf7op7hdusdty33@carlos-mbp.lan>
References: <bd751d5c-2f8b-4c52-72ec-f2b7268a30a8@cs.ucla.edu>
 <99b0adb6-26ba-293c-3a8f-679f59e7cb4d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99b0adb6-26ba-293c-3a8f-679f59e7cb4d@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 09:26:10PM +0100, René Scharfe wrote:
> Am 22.03.22 um 17:38 schrieb Paul Eggert:
> > Today, Carlo Arenas pointed out[1] that GNU grep didn't work around
> > PCRE2 bug 2642, which Git grep has a workaround for. While installing
> > a GNU grep patch to fix this[2] I noticed that Git's workaround
> > appears to be too pessimistic: on older PCRE2 libraries Git grep sets
> > PCRE2_NO_START_OPTIMIZE even when PCRE2_CASELESS is not set.
> 
> Interesting.  So you say bug 2642 [3] requires the flag PCRE2_CASELESS
> (i.e. --ignore-case) to be triggered.  (That's probably documented in
> Bugzilla, but I'm not authorized to access it.)

AFAIK the contents of the bugzilla are no longer accessible to anyone (lost in the migration of PCRE2 to github), but the use of PCRE2_CASELESS introduced in 95ca1f987e (grep/pcre2: better support invalid UTF-8 haystacks, 2021-01-24) might had been a mistake all along.

the bug will trigger when both PCRE2_UTF and PCRE2_MULTILINE are set (as shown in the PCRE2 regression added), with the later set by default in git and NEVER set in GNU grep, hence why I later retracted[6] my suggestion to add the workaround to grep, and suggest updating git with the following

Carlo

[6] https://lists.gnu.org/r/grep-devel/2022-03/msg00006.html
--- >8 ---
Subject: [PATCH] grep: remove check for case sensitivity in workaround for
 PCRE's bug2642

95ca1f987e (grep/pcre2: better support invalid UTF-8 haystacks, 2021-01-24)
add a workaround to an old PCRE2 bug, but includes in the logic a partial
check for case sensitivity without explanation.

Remove it so that the workaround (and its performance impact) will be only
triggered when needed (both PCRE2_MULTILINE and PCRE2_UTF and JIT is used)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 82eb7da102..d910836569 100644
--- a/grep.c
+++ b/grep.c
@@ -296,8 +296,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
 
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
-	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
-	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS))
+	/* Work around PCRE2 bug2642 fixed in 10.36 */
+	if (SUPPORT_JIT && PCRE2_MATCH_INVALID_UTF && (options & PCRE2_UTF))
 		options |= PCRE2_NO_START_OPTIMIZE;
 #endif
 
-- 
2.35.1.505.g27486cd1b2d

