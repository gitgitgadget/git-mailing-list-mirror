Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285C2C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D592601FE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhHQJAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 05:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhHQJAu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 05:00:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A929C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:00:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n5so10566338pjt.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LpQn6M6gi+krFRwxNdZJzJmegLDprqEgJlW8mDVdXh8=;
        b=skaxlZpen3faB9jyWhe1rH0qBc7RICJAiXJDAHxlnNlyyw8lL9hdlLejpe9VOBLjC7
         khCDRS+64hINpkGov18DJXIwxMYOuFegjxln5VNRrhAOuCi7IwFIhKBeEicZ0eSFSzUw
         dm54GkGAdYBO2gphRc+tweDul7URHDKorYPK2rdoPLodSyLRjytaHA8k0Kv30v9rySA1
         UsE5jh4hj3NuCmHgiRFuhSq+wUy+zdvShGpyhaaydorAWaQckJZg8q6fzClFN5xwpAVf
         p0mnyKNOz3qHWAjH+hl3YEPEjHGc9pGRjs87zR8E8IFDUfO6ICsVP9cw5abs6ubfbjwW
         awlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LpQn6M6gi+krFRwxNdZJzJmegLDprqEgJlW8mDVdXh8=;
        b=CXtjLXX25Pw1Kg9tWwd5/W5MF0wjRvEyfnggnYhj/Eva7BPiZzDY7tH/hgCAbAsjtt
         zN77I9e28sY8DIUjvhpTxo2j3vo1ikr/68nSImOPIYkHzMowouXL64xklzZQZXZ4109y
         kgUlYbPuY3O8AbHcHPSlqWegM0/soJdy/YFh6HYBJYEPEted6wJwVSB6wX3mbBk/wNbM
         sLZ0aL8/wB2A7YnB237fYqkCqeLppn1/EulekcIyYMEsAJEgv7aWwPKHizkKbchUR8S9
         vSNKKw1WNBxJJXvVjJ6qv9MMa5OSrdGd0otLTMMAnxsoGP4N2nniMfSrMdbqtU0clY9/
         ijdA==
X-Gm-Message-State: AOAM533f2orBJ2XVo+bcElZ8OBtbz+CXPDEbMesxwY+EUkmPFuMR+1FE
        Q+qb/DZHCa/OP0tDdQP8rn+Phki6e70=
X-Google-Smtp-Source: ABdhPJwlJ7r+Wt0fzgEC3dMHgPfyGxDQlPueG90nyb+L77In13fR2AVGdqkNfo3HzPtOFbJ79DFNxA==
X-Received: by 2002:aa7:8484:0:b029:3e0:805e:9f67 with SMTP id u4-20020aa784840000b02903e0805e9f67mr2667901pfn.73.1629190817529;
        Tue, 17 Aug 2021 02:00:17 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-1.three.co.id. [180.214.233.1])
        by smtp.gmail.com with ESMTPSA id z3sm1552526pjn.43.2021.08.17.02.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 02:00:17 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] t6030-bisect-porcelain: add tests to control
 bisect run exit cases
To:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
References: <20210817081458.53136-1-mirucam@gmail.com>
 <20210817081458.53136-2-mirucam@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3dcf28af-1e75-0934-4663-3691b0efde1d@gmail.com>
Date:   Tue, 17 Aug 2021 16:00:14 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817081458.53136-2-mirucam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/21 15.14, Miriam Rubio wrote:

> +test_expect_success 'bisect run fails with exit code equals or greater than 128' '
> +	write_script test_script.sh <<-\EOF &&
> +	exit 128 >/dev/null
> +	EOF
> +	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt
> +'

This only checks for exit code equals to 128. You should also check for 
exit code greater than 128, for example 255.

> +
> +test_expect_success 'bisect run fails with exit code smaller than 0' '
> +	write_script test_script.sh <<-\EOF &&
> +	exit -1 >/dev/null
> +	EOF
> +	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt
> +'

This test looks OK, using -1 as representative of negative exit code. 
However, wording of test name can also be 'bisect run fails with 
negative exit code'.

Thanks for reviewing.

-- 
An old man doll... just what I always wanted! - Clara
