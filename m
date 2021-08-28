Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E74C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451CB6054E
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 09:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhH1JsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhH1JsU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 05:48:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D17C061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 02:47:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso10894788wmc.5
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xKCfkNTAoD9lwQpmZaejw2gyx4NDWPwa67LImHKX0og=;
        b=G+MY6Xv5Ta98mWtofInBJmUYYS0VRkrQNRt9wl9Szvm8QWXiO31+2LjCHKsriBbx6A
         m1BvfiA5YjZuV+NhkDl75nUZ7zJ9LKk7NYd013R88X0liP5GOd+jO17x/q5VogYuspkL
         j4gULiQFLpQ8xy1y/5THHBJTcY4JQygGGsObNR0CN8p3xqVavVDjJdqyQMMCCKGWECC3
         6TB1Rs0Ptf1MrokfcDuUwAMcgFYr7XhZM0Rtl2azxlNFw5ko5lKHXlRx1qToSoalTUc7
         +umiAKIb7s3mN5oB4fX76rQ+FIbGb1651kg98vHxMg7JtmIcpz10scc8LubwPUks0Rnp
         DY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xKCfkNTAoD9lwQpmZaejw2gyx4NDWPwa67LImHKX0og=;
        b=Yj0NVaLHVfX2+mYtzixEqh+5Z6i7fazr0PUw3hf/9z6QcgrFwgqxRLCbyk/hgeUPNS
         qmqkUCMX2/vfiEJ+PI5O4K2VYw3BqqB7/oI0q6AfXh9WXlCOZzvNWxgIl3GL58r+O/0b
         6QrxV9+POcdpk0gLB7ykPSDddtB5HXX2zqE/W9Df4hNSfBEB53py3y0qmmqIh+Wt1Xwn
         KpXcYETQXfcPWVyIhO71wl9D7JQ6tiaE0zP0LKgw3i0azAQA5KqgrdOebFIyqCCoh1Qw
         nJs3acl5ReAs4dLpM6SeAI0KF98sNCBafkubPhnzbU+1ggbW5fZWbq3JAhdGgK1wRIM8
         KUEQ==
X-Gm-Message-State: AOAM5301l/t6QaCTGDjjxFPhleIVo+Jlj/l3p7W38s2KeqUIAvCjY51l
        vA2ej2O5YbalQ8pPywN1RIs=
X-Google-Smtp-Source: ABdhPJz1Tih1xH53Z5orZw5HgpgdUuGbAW8+Dzw0QoE5sv8UcGo8r0XgTnASHizmt6GhLc9zh5c7kw==
X-Received: by 2002:a05:600c:3384:: with SMTP id o4mr21402785wmp.12.1630144049034;
        Sat, 28 Aug 2021 02:47:29 -0700 (PDT)
Received: from szeder.dev (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id i14sm7454295wmq.40.2021.08.28.02.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 02:47:28 -0700 (PDT)
Date:   Sat, 28 Aug 2021 11:47:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Mickey Endito <mickey.endito.2323@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
Message-ID: <20210828094726.GG2257957@szeder.dev>
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
 <xmqq8s0rpwiw.fsf@gitster.g>
 <20210824185942.GE2257957@szeder.dev>
 <YSWeeEgzCCT/3kxR@coredump.intra.peff.net>
 <xmqqsfyxjyfe.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsfyxjyfe.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 09:12:37AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Hmm. I think that one is different, in that the "cd" is not redundant,
> > but wrong. But it turns out not to matter to the test. ;)
> 
> Funny. 
> 
> We are lucky because 'cd ""' stays in the same repository as the
> current one and not to a random place,

Actually, the results of 'cd ""' are unspecified, though most shells
do as you said.  Do we want something like this?

  ---  >8  ---

Subject: [PATCH] test-lib: catch 'cd "$dir"' with unset variable

We just had to fix two test cases [1] that invoked 'cd "$dir"' while
the given variable was accidentally unset.  While POSIX states that if
'cd's directory parameter "is an empty string, the results are
unspecified" [2], most shells treat this as a no-op [3], i.e. they
neither change directory nor return error, that's why both of those
tests happened to succeed on common shells, and thus these issues
remained hidden for a while.

Catch 'cd ""' by adding a thin wrapper function overriding the
shell's 'cd' command to verify the non-emptiness of its parameters and
call BUG if necessary.

[1] bd72824c60 (t5582: remove spurious 'cd "$D"' line, 2021-08-23)
    c21b2511c2 (t5323: drop mentions of "master", 2021-08-24)
[2] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/cd.html
[3] 'ksh' and 'ksh93' are the only shells I found that error out on
    'cd ""' with "cd: bad directory" (though these shells are unable
    to run significant portion of our test sute anyway).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d6..06b75d8430 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1436,6 +1436,14 @@ EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
 _z40=$ZERO_OID
 
+cd () {
+	if test -z "$@"
+	then
+		BUG "cd invoked with empty parameter"
+	fi
+	command cd "$@"
+}
+
 # Provide an implementation of the 'yes' utility; the upper bound
 # limit is there to help Windows that cannot stop this loop from
 # wasting cycles when the downstream stops reading, so do not be
-- 
2.33.0.358.g803110d36e

