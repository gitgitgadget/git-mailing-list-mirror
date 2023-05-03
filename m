Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9040AC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 14:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjECOB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjECOB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 10:01:56 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9A73C3C
        for <git@vger.kernel.org>; Wed,  3 May 2023 07:01:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso4290909276.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683122514; x=1685714514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggga3FmPTdEpwva8c3Zg30s7UB9sq+XCbuT6NIWpQrw=;
        b=GTg8B/rf+MaB0Bybc1RnsJBfqLUJH9UQTmSp95SLV97d50jZGD5/35oSjns8thmXGt
         qnboIuTLf9sRvKU681VkcUO+5JkcXiS7kloF7V4mdcBVVisT4F4mmUGPSTTPkTgvZXWl
         7Gdudu5KehsLPL0fU903YrnYzS6+MsLHXeGjcd1o93fbqORiBPVsjcM+7mjPTCsjGPmM
         N7ZbvtWixRFHeadcndynLVGpxBXwycFBWV7oUs1XVm5An7FkMvxz1q9Yz6iGQhpLw0A6
         aPT3wfHFA3bP8loXE3MnYExG1zBcFOIKm+6iH/pNbxhXw1wG5Q/Z+ko5a/8QrxuSEhmK
         6YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683122514; x=1685714514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggga3FmPTdEpwva8c3Zg30s7UB9sq+XCbuT6NIWpQrw=;
        b=jDAKi7agfIjD5YYqeD/nRrGuww0sW+vl9SmlAW4ZJiMGaU/UZXZjJS5/obbZ0cYn2M
         Jo+c6tO91XbmCirpQKPlBdmEsVGKa8PajStkBPeXFeyGiEUKaLBLnRLwC8Maea+8JnWB
         GwvmGCA0EDyz6etkw/p3TOUhkTVtvTTX3/bzCbnbN7cisgsRESNl71c2yj0sMukOYbwD
         +7KO036D2M9Hm/OM60HY4bta1BdMeoJW75lFOa7NwH1KjZ4C1tLbaPavSdJlDS91HEWD
         hv4jaqANHCYnx4T8HavYMo1f27Xpb0yGVxJ82vWYJOirXU98LIuiZ1/f1JB+MlxuswZy
         NH8g==
X-Gm-Message-State: AC+VfDxa4XeMuuBciStN2XrDdVrbAGO7Ksubk8AA5jcy9Txqw8zxupMD
        KFRyC2EFHsvoMnE8pQ7EnB8G
X-Google-Smtp-Source: ACHHUZ6i2/Xne0ak7RBGCB+5hx2gIeVDNxKS+/WGLAW/QhtYWcBPRuLVKjmP+XAkDEYeMD55zNKRmQ==
X-Received: by 2002:a25:2106:0:b0:b9e:6d2c:ce2 with SMTP id h6-20020a252106000000b00b9e6d2c0ce2mr5270499ybh.46.1683122513979;
        Wed, 03 May 2023 07:01:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b0dd:b183:de1f:7f32? ([2600:1700:e72:80a0:b0dd:b183:de1f:7f32])
        by smtp.gmail.com with ESMTPSA id q14-20020a25f40e000000b00b9e73d0dba5sm940614ybd.47.2023.05.03.07.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 07:01:53 -0700 (PDT)
Message-ID: <b29ff03e-5504-af04-72c6-f98abde1442f@github.com>
Date:   Wed, 3 May 2023 10:01:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/2/2023 8:09 PM, Taylor Blau wrote:
> This patch introduces a new multi-valued configuration option,
> `pack.extraCruftTips` as an alternative means to mark certain objects in
> the cruft pack as rescued, even if they would otherwise be pruned.

> Range-diff against v1:
> 1:  8af478ebe3 ! 1:  73ad7b90e1 builtin/pack-objects.c: introduce `pack.extraCruftTips`
>     @@ Commit message
>      
>            - to point a reference at them, which may be undesirable or
>              infeasible,
>     +      - to track them via the reflog, which may be undesirable since the
>     +        reflog's lifetime is limited to that of the reference it's tracking
>     +        (and callers may want to keep those unreachable objects around for
>     +        longer)
>            - to extend the grace period, which may keep around other objects that
>              the caller *does* want to discard,
>            - or, to force the caller to construct the pack of objects they want
>     @@ Documentation/config/pack.txt: pack.deltaCacheLimit::
>      ++
>      +Output must contain exactly one hex object ID per line, and nothing
>      +else. Objects which cannot be found in the repository are ignored.
>     ++Multiple hooks are supported, but all must exit successfully, else no
>     ++cruft pack will be generated.

Thanks for these updates.

>       pack.threads::
>       	Specifies the number of threads to spawn when searching for best
>     @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
>      +		add_pending_object(revs, obj, "");
>      +	}
>      +
>     ++	ret = finish_command(&cmd);
>     ++
>      +done:
>      +	if (out)
>      +		fclose(out);
>     @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
>      +	for (i = 0; i < programs->nr; i++) {
>      +		ret = enumerate_extra_cruft_tips_1(&revs,
>      +						   programs->items[i].string);
>     -+		if (!ret)
>     ++		if (ret)
>      +			break;
>      +	}

If we have a failure, then we stop immediately and report a failure
(from this bit outside the range-diff's context):

> +	if (ret)
> +		die(_("unable to enumerate additional cruft tips"));

>     @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
>      +		cruft_new="$(git rev-parse HEAD)" &&
>      +
>      +		git checkout main &&
>     -+		git branch -D old new &&
>     ++		git branch -D discard old new &&

Good update.

>      +		git reflog expire --all --expire=all &&
>      +
>      +		# mark cruft.old with an mtime that is many minutes
>     @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
>      +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
>      +		git show-index <${mtimes%.mtimes}.idx >cruft &&
>      +		cut -d" " -f2 cruft | sort >cruft.actual &&
>     -+		test_cmp cruft.expect cruft.actual
>     ++		test_cmp cruft.expect cruft.actual &&
>     ++
>     ++		# Ensure that the "old" objects are removed after
>     ++		# dropping the pack.extraCruftTips hook.
>     ++		git config --unset pack.extraCruftTips &&
>     ++		git repack --cruft --cruft-expiration=now -d &&

Double-checking that removing the tips correctly removes the objects
at this time is good, but...

>     ++		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
>     ++		git show-index <${mtimes%.mtimes}.idx >cruft &&
>     ++		cut -d" " -f2 cruft | sort >cruft.actual &&
>     ++
>     ++		git rev-list --objects --no-object-names $cruft_new >cruft.raw &&
>     ++		cp cruft.expect cruft.old &&
>     ++		sort cruft.raw >cruft.expect &&
>     ++		test_cmp cruft.expect cruft.actual &&
>     ++
>     ++		# ensure objects which are no longer in the cruft pack were
>     ++		# removed from the repository
>     ++		for object in $(comm -13 cruft.expect cruft.old)
>     ++		do
>     ++			test_must_fail git cat-file -t $object || return 1
>     ++		done

...it would be good to do this check before the removal of the hook
to be sure the objects from 'discard' are removed as part of the step
with the hook. I can imagine a world where the hook-based approach
erroneously keeps the 'discard' objects in the non-cruft pack only
for them to be deleted by the repack where hooks are disabled, and
having a test would help guarantee we don't live in that hypothetical
world.

I would also be satisfied with checking just the commits that were
previously referenced by 'discard' and 'old', but this more
thorough check is also good.

>     ++test_expect_success 'multi-valued pack.extraCruftTips' '
>     ++	git init repo &&
>     ++	test_when_finished "rm -fr repo" &&
>     ++	(
>     ++		cd repo &&
>     ++
>     ++		test_commit base &&
>     ++		git branch -M main &&
>     ++
>     ++		git checkout --orphan cruft.a &&
>     ++		git rm -fr . &&
>     ++		test_commit --no-tag cruft.a &&
>     ++		cruft_a="$(git rev-parse HEAD)" &&
>     ++
>     ++		git checkout --orphan cruft.b &&
>     ++		git rm -fr . &&
>     ++		test_commit --no-tag cruft.b &&
>     ++		cruft_b="$(git rev-parse HEAD)" &&
>     ++
>     ++		git checkout main &&
>     ++		git branch -D cruft.a cruft.b &&
>     ++		git reflog expire --all --expire=all &&
>     ++
>     ++		echo "echo $cruft_a" | write_script extra-tips.a &&
>     ++		echo "echo $cruft_b" | write_script extra-tips.b &&
>     ++		echo "false" | write_script extra-tips.c &&
>     ++
>     ++		git rev-list --objects --no-object-names $cruft_a $cruft_b \
>     ++			>cruft.raw &&
>     ++		sort cruft.raw >cruft.expect &&
>     ++
>     ++		# ensure that each extra cruft tip is saved by its
>     ++		# respective hook
>     ++		git config --add pack.extraCruftTips ./extra-tips.a &&
>     ++		git config --add pack.extraCruftTips ./extra-tips.b &&
>     ++		git repack --cruft --cruft-expiration=now -d &&
>     ++
>     ++		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
>     ++		git show-index <${mtimes%.mtimes}.idx >cruft &&
>     ++		cut -d" " -f2 cruft | sort >cruft.actual &&
>     ++		test_cmp cruft.expect cruft.actual &&
>     ++
>     ++		# ensure that a dirty exit halts cruft pack generation
>     ++		git config --add pack.extraCruftTips ./extra-tips.c &&
>     ++		test_must_fail git repack --cruft -d 2>err &&
>     ++		grep "unable to enumerate additional cruft tips" err &&
>     ++
>     ++		# and that the existing cruft pack is left alone
>     ++		test_path_is_file "$mtimes"
>      +	)

This new test looks good to me.

Thanks,
-Stolee
