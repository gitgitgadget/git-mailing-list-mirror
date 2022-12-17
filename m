Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED20CC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 17:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLQRiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 12:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLQRiN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 12:38:13 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AF1144B
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 09:38:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v8so7718297edi.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 09:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npPBBahI7V8wLM86WE/we797cQH56qDJQ9Wd84gp4iM=;
        b=XFSOx4YGd9H9t4GOh6i+HtR+s5lKSBMvOGtGJC7s1+NT5pZdtMPYnHaaTlO3/NLmMB
         dmH/04sPXuP6/ZbCQ2HFCKhWhAY1Yyo0FNYwySJ0q8169sHFnQqzuUdfEE3zKMKHQRRt
         BFg2gODpHknsVkNK2qmfwROT/fhmiE7BgK0RdG4cyY/8j3ZAir4M/mS7fVc32zaouZfK
         yFQlfNGwuwjxNl44C1eCz+ogMXSzJmmj+HbJLdG361Qppoh3+TIO/jYgNyrT9oS5o0Yj
         ItRL4xyep35Tmr2F2eAuDn4xGidS7k4RztyU2h9UrmnP3k1zeCmInO9kToUvt3rqgXgd
         DcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npPBBahI7V8wLM86WE/we797cQH56qDJQ9Wd84gp4iM=;
        b=NAnM/Pf6dXNsVGQsNY7JY5erxkJupgrLB+4P1gnKsO9t3pHjOP4GBqVox79bJDq77y
         ULrOWDGQHVUN28O+1Pn+Dnm7SYhWz7S+F9nckQ5+SFEa/plQpkoy3FkNZ+/29NBteFFK
         +ws6FQ07FtxLbQBqOTsvdIdr15dIVPqSR3G+ZVNixhQMb4HA7k56Xa1pVFIic01xhBQC
         Fi0tTCWCME9UCjsz9JkQJ9SQkUrO0A5JNa1Y9x7neqv9RrCRQGg8MFi/mkVDnsZsrenQ
         R4wpFrctZcbs6qKvsSie8YvXMl7xfrmsupqhR0dF6AWdZgHeADUl3qX5lprYJDS5Q1Wa
         7Bcg==
X-Gm-Message-State: ANoB5plpmE7au8q7HcmQbplsl5nXRBXYo4t1HNIYNB4/f82W2DUZ4nA6
        M3x4hGljbcXZW9Bqul4oQ1SqHJ9ov50=
X-Google-Smtp-Source: AA0mqf7joVc2qJcAoV8GFj9qHoH844uD3CMwMFWStyLVleVGmck172BBcHPRZPGgFGxZG8ip4ee7TQ==
X-Received: by 2002:a05:6402:3889:b0:462:9baa:e3ad with SMTP id fd9-20020a056402388900b004629baae3admr28400192edb.10.1671298689972;
        Sat, 17 Dec 2022 09:38:09 -0800 (PST)
Received: from localhost (78-131-14-113.pool.digikabel.hu. [78.131.14.113])
        by smtp.gmail.com with ESMTPSA id kx22-20020a170907775600b007c17b3a4163sm2263142ejc.15.2022.12.17.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 09:38:09 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:37:58 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/4] test-lib-functions: add helper for trailing hash
Message-ID: <20221217173758.GB3411@szeder.dev>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
 <813e81a058227bd373cec802e443fcd677042fb4.1670862677.git.gitgitgadget@gmail.com>
 <20221212181438.GA3411@szeder.dev>
 <xmqqh6y0qfzg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh6y0qfzg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2022 at 09:55:47AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> +	test_trailing_hash .git/index >hash &&
> >> +	echo $(test_oid zero) >expect &&
> >
> > Nit: test_oid zero >expect
> >
> >> +	test_cmp expect hash &&
> 
> Unfortunately they are not equivalent.
> 
> Usually we write these helpers to terminate their output with LF,
> relying on the fact that terminating LF will be dropped when used in
> a command substition, e.g. VAR=$(HELPER), but test_oid deviates from
> the pattern and does not give the terminating LF to its output.

Oh, indeed.  But why does it omit the trailing LF?!  Alas, 2c02b110da
(t: add test functions to translate hash-related values, 2018-09-13)
doesn't seem to mention anything about it.  However, skimming through
the output of

  git grep 'test_oid ' -- ':/t/*.sh'

it appears that all but three uses of 'test_oid' are in command
substitutions, and those three exceptions are in t0000 checking that
'test_oid' actually works.  So I don't see any benefit of omitting
that trailing LF, but this and similar cases show its drawbacks.

  $ git grep 'echo $(test_oid ' -- ':/t/*.sh'
  t/t1302-repo-version.sh:        echo $(test_oid version) >expect &&
  t/t5313-pack-bounds-checks.sh:  echo $(test_oid oidfff) >file &&


