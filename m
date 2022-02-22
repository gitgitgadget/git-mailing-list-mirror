Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D5CC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 02:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiBVCgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:36:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiBVCgj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 21:36:39 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251A25C66
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:36:15 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id bm39so8630703qkb.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAxGKllV9gAsH7mYHGXstB9Ds84HThe7JbgztrhsrTM=;
        b=TciJkVthPOoAVvycqhxscjRysYPdHVwkTNRVFQD/7Mkr4tQWpHyonJ6zMpSkd+R7If
         Rj5TxhNuASW8bwhhPFBGIEvRTZYtxVKmd8EwUfW2/+HnGcLTfTAgzsErCJwRUmPWVSMg
         Ig12wMF9KuK8b171iY0XlP3bGCb20O6C/UktETyLvgL8IBGyGWJztnDPGRuaKiKUqp0K
         /iMj1G1ZXEHm3tWRDfapoJJSgVdi0v6HYtkoMQBcodRgS1tVxA/m9//eCquxRC5IMVXN
         9h+JNxE7t6RjTZVsNCtvffUZ7QMEYg3LQUIP43IZiNsvF0LxIG5K7/Jig2rc2iFUmtjV
         UtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAxGKllV9gAsH7mYHGXstB9Ds84HThe7JbgztrhsrTM=;
        b=5iqTAL2EngrA6RIi6uvz+avdKDsiI90HSvZy6nA3h66c3g2pmWEm8UKpiL2iKaJVhx
         NkQcgEQKUSLlIUjVyTL6qpG+jM01LOCI1nelLpMvxtIe74/20oid3DpIoXiwt72ogCrP
         9mWRb7uTAlaxibqmQdqYbmeKbZVBF1L7MgBqn6glhtndQDg5tBdUdQCforrlZ1V2k92O
         h/2pSEdddDqm96zh31+r6sMJMrKgRFGYXW4nIBf7h+5NSAE7RLcrga19Pd8Cz5RA8k9g
         szU4aw/QzP74dbGeyvzX6AqKCQlCi18y3B9bonL4Nh40amOpXsktLka+b+cUR6Doo1hP
         1ftw==
X-Gm-Message-State: AOAM533mgsZIwLzBLwNVgwbay0jx5ZPoeIdbaQ6QVUX6QxmksSOFsqfu
        W0aK1ps9vYsnRzgCsIfpO5E=
X-Google-Smtp-Source: ABdhPJwxgxvvrt35fTMu0UGKa+p2JD9jAPLQg/KwN6/tSL7KAe2XRCKJt4tv6S6CQBj5jdKMW4bDqA==
X-Received: by 2002:a05:620a:241:b0:506:6be9:24b2 with SMTP id q1-20020a05620a024100b005066be924b2mr13911997qkn.575.1645497374275;
        Mon, 21 Feb 2022 18:36:14 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id y18sm31706406qtj.33.2022.02.21.18.36.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Feb 2022 18:36:13 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] stash: call reflog_delete from reflog.c
Date:   Mon, 21 Feb 2022 21:36:13 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <DAF4762E-6376-44BC-9E8C-B9C32B65D92B@gmail.com>
In-Reply-To: <220218.86o834gej9.gmgdl@evledraar.gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <bcc1eae053124f6e68f60a7a02cbee4744a022f0.1645209647.git.gitgitgadget@gmail.com>
 <220218.86o834gej9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On 18 Feb 2022, at 14:20, Ævar Arnfjörð Bjarmason wrote:

> On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> Now that cmd_reflog_delete has been libified an exported it into a new
>> reflog.c library so we can call it directly from builtin/stash.c. This
>> not only gives us a performance gain since we don't need to create a
>> subprocess, but it also allows us to use the ref transactions api in the
>> future.
>>
>> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>
> Very nicely done, and nice that despite the ~500 lines added/removed in
> the diffstat that the "actual" changes in this series are so small.q
>
>> @@ -635,18 +636,9 @@ static int reflog_is_empty(const char *refname)
>>  static int do_drop_stash(struct stash_info *info, int quiet)
>>  {
>>  	int ret;
>> -	struct child_process cp_reflog = CHILD_PROCESS_INIT;
>> -
>
> Nit: We usually separate variables decls with a \n\n, as is done in the
> pre-image, but you end up dropping that.
>
>> -	/*
>> -	 * reflog does not provide a simple function for deleting refs. One will
>> -	 * need to be added to avoid implementing too much reflog code here
>> -	 */
>> -
>> -	cp_reflog.git_cmd = 1;
>> -	strvec_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
>> -		     "--rewrite", NULL);
>> -	strvec_push(&cp_reflog.args, info->revision.buf);
>> -	ret = run_command(&cp_reflog);
>> +	ret = reflog_delete(info->revision.buf,
>> +			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
>> +			    0);
>>  	if (!ret) {
>>  		if (!quiet)
>>  			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
>
> I think per the above squashing this in would be nice, i.e. you get rid
> of the long line & it'sclear that "ret" is not used for anything now:
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index d0967b3d3c3..7b939576720 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -635,11 +635,9 @@ static int reflog_is_empty(const char *refname)
>
>  static int do_drop_stash(struct stash_info *info, int quiet)
>  {
> -	int ret;
> -	ret = reflog_delete(info->revision.buf,
> -			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
> -			    0);
> -	if (!ret) {
> +	unsigned int flags = EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE;
> +
> +	if (!reflog_delete(info->revision.buf, flags, 0)) {
>  		if (!quiet)
>  			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
>  				  oid_to_hex(&info->w_commit));
>
> But, having written that I notice that we have *_REWRITE twice there, so
> I almost just carried forward a new bug in 3/3 when composing this :)
>
> So one should be EXPIRE_REFLOGS_UPDATE_REF, presumably.
>
> And perhaps it's a big pain, but that suggests that the code isn't
> either used at all, or that we're missing a test for it.
>
> So adding a prep commit to this series where we either drop it, or add
> the missing test would be a very nice addition.
>
> See my quite recent 5ac15ad2509 (reflog tests: add --updateref tests,
> 2021-10-16) for adding such tests, but in that case I just covered "git
> reflog" itself, not "git stash". Maybe we can just add something to that
> for-loop in t1417 (or similar for a new stash test).

So I was trying to write a test to exercise the reflog --updateref and --rewrite
cases. --updateref is pretty straightforward, but with --rewrite I noticed that
it rewrites the old sha in the .git/log/refs/stash file. But, I was having
trouble finding somewhere that read this value. The test could reach into this file
and check the literal contents, but wondering if there is a better way. Any help appreciated!

>
> Also, a s/unsigned int flags/enum expire_reflog_flags/ while we're at it
> would be very nice here, but that could be done as another small prep
> commit. I.e. it's *not* a new issue since cmd_reflog_delete() had it
> before, but when converting this to a documented API it would be very
> nice to have it reflect the actual type we end up using.
