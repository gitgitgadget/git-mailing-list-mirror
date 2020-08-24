Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81E9C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 11:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2749206BE
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 11:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHuJ+vMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHXLIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHXLIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 07:08:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44FC061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 04:08:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x25so4630581pff.4
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CkdrHL4kMcT+nIWdUA984J3DOQC3isJZYtTAQPQZAcU=;
        b=UHuJ+vMJ9y88jdKBo16UHpn+var4ZNO4NgDmPdihNID/Ko7Wuvlt+nfatjrguG6EHN
         53PPzHyMSrRjJWciL6Ss2Ks7KjjRjApSgJKWiQ6hGuv1ybgUvLJuUciFzm+pZ8d6GXv4
         XLKVmculSruxSMBQ7KZtKVNB1CDIO1gGUQGtguyRsKpkCupX7SElB72vMnr6187B+ZuJ
         PiD7UnAN+IE7oKDh7vT1DmM9d0QBD7GFoagX6tj7i24caGZ9p/s0vO4tVVTws/4uZTUL
         Cs8a+m517fGwXTsDavcUF4ZVPU5rVQs9VOL54shP6li0IX+TqtLZgPeSDjjP+mIJTc4/
         CKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CkdrHL4kMcT+nIWdUA984J3DOQC3isJZYtTAQPQZAcU=;
        b=elrmV57GekHs3S23apFvWNGPlFxc9w6QmxurdgLqL3AN6UpCnD6tnUQZdKviZBFze5
         Wj0eTDmnLoC/RZfr6ctCNVbBXowyJbVCaZOtISLRX4MltGP7V35CSVrquc3LF/+2ludc
         3SC8azxoP9nvwtFzECnFB3oX7ke7YcEeCwIHrkbzMrx0TE93tOXWRYv+OQFQJNtFfxgr
         gM1qZp1Sb3CHTQ5obHM0ZHg7omDlOLWP5dB8L10NI01kRTwiUoF7MUCO9owc6Mt4/JQq
         AiGElGivmDdzlCn89nsHng9byClx63f1oY0bgfMSJfoA7B2JdZlqn7BNfmBitNEsXd3T
         lUUA==
X-Gm-Message-State: AOAM532RM36sELWaBTJ6KGEvo1GX5t3a4qqOxVps/94im9I2UXk9SuUe
        Q3xcsRfJ6BBDNNXZxmbrUBU=
X-Google-Smtp-Source: ABdhPJzzPQP3gF9E3fpdONNTEM8gOGy8z0tushykPowzF3Ky/4mvS1ghSFTot9AEk0i2hxG6rE0lwA==
X-Received: by 2002:aa7:9e4f:: with SMTP id z15mr3914511pfq.80.1598267328876;
        Mon, 24 Aug 2020 04:08:48 -0700 (PDT)
Received: from lwitch-pc ([49.205.77.238])
        by smtp.gmail.com with ESMTPSA id v6sm3450734pgf.55.2020.08.24.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 04:08:48 -0700 (PDT)
Message-ID: <a30f43ecbbc5fa64fe62eb5903d81bce7440986c.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, liu.denton@gmail.com,
        pc44800@gmail.com, stefanbeller@gmail.com
Date:   Mon, 24 Aug 2020 16:38:39 +0530
In-Reply-To: <20200824084634.GA377527@konoha>
References: <20200824084634.GA377527@konoha>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-08-24 at 14:16 +0530, Shourya Shukla wrote:
> Or rather, we can do this:
> 
> -----8<-----
> if (S_ISGITLINK(p->mod_src)) {
> 		struct strbuf sb = STRBUF_INIT;
> 		strbuf_addstr(&sb, p->sm_path);
> 		if (is_nonbare_repository_dir(&sb))
> 			src_abbrev = verify_submodule_committish(p->sm_path,
> 								                     oid_to_hex(&p->oid_src));
> 		strbuf_release(&sb);
> 		if (!src_abbrev) {
> 			missing_src = 1;
> 			/*
> 			 * As `rev-parse` failed, we fallback to getting
> 			 * the abbreviated hash using oid_src. We do
> 			 * this as we might still need the abbreviated
> 			 * hash in cases like a submodule type change, etc.
> 			 */
> 			src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
> 		}
> 	} else {
> 		/*
> 		 * The source does not point to a submodule.
> 		 * So, we fallback to getting the abbreviation using
> 		 * oid_src as we might still need the abbreviated
> 		 * hash in cases like submodule add, etc.
> 		 */
> 		src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
> 	}
> ----->8-----
> 
> Similarly for dst as well. This solution passes all the tests and does
> not call 'verify_submodule_committish()' all the time. The previous
> approach failed a couple of tests, this one seems fine to me.
> 
> How is this one?
> 

This is more or less what I had in mind initially. But later after
being reminded about the fact that there's a code path which calls
`generate_submodule_summary` only when `is_nonbare_repository_dir`
succeeds, I realized any conditional that uses
`is_nonbare_repository_dir` or the likes of it would be confusing. So,
I think a better approach would be something like:

-- 8< --
diff --git builtin/submodule--helper.c builtin/submodule--helper.c
index 63ea39025d..b490108cd9 100644
--- builtin/submodule--helper.c
+++ builtin/submodule--helper.c
@@ -1036,7 +1036,7 @@ static void print_submodule_summary(struct summary_cb *info, char* errmsg,
 static void generate_submodule_summary(struct summary_cb *info,
                                       struct module_cb *p)
 {
-       char *displaypath, *src_abbrev, *dst_abbrev;
+       char *displaypath, *src_abbrev = NULL, *dst_abbrev;
        int missing_src = 0, missing_dst = 0;
        char *errmsg = NULL;
        int total_commits = -1;
@@ -1062,8 +1062,9 @@ static void generate_submodule_summary(struct summary_cb *info,
        }
 
        if (S_ISGITLINK(p->mod_src)) {
-               src_abbrev = verify_submodule_committish(p->sm_path,
-                                                        oid_to_hex(&p->oid_src));
+               if (p->status != 'D')
+                       src_abbrev = verify_submodule_committish(p->sm_path,
+                                                                oid_to_hex(&p->oid_src));
                if (!src_abbrev) {
                        missing_src = 1;
                        /*
diff --git t/t7421-submodule-summary-add.sh t/t7421-submodule-summary-add.sh
index 59a9b00467..b070f13714 100755
--- t/t7421-submodule-summary-add.sh
+++ t/t7421-submodule-summary-add.sh
@@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submodules with changed paths'
        git commit -m "change submodule path" &&
        rev=$(git -C sm rev-parse --short HEAD^) &&
        git submodule summary HEAD^^ -- my-subm >actual 2>err &&
-       grep "fatal:.*my-subm" err &&
+       test_must_be_empty err &&
        cat >expected <<-EOF &&
        * my-subm ${rev}...0000000:
 
-- >8 --

I suggest this as the other code path that calls
`generate_submodule_summary` without going through the
`is_nonbare_repository_dir` condition is the one where we get
`p->status` as 'T' (typechange) or 'D' (deleted). We don't have to
worry about 'T' as we would want the hash for the new object anyway.
That leaves us with 'D' which we indeed have to handle.

Note that no such handling is required for the similar portion
corresponding to `dst_abbrev` as the conditional `if (S_ISGITLINK(p-
>mod_dst))` already guards the `verify_submodule_committish` when we
have a status of 'D'.

-- 
Sivaraam

