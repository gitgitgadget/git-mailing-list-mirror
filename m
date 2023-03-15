Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A8C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjCOQEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjCOQE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:04:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E329432
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:03:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so12673534pll.8
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678896219;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhOuIUAoFTCbIBl/9rQr9W/icRONAM5zBbPqtEBOAgs=;
        b=b3Ni3hcHGvaQgxGO/DwqKl98lZqCFwSQpRE/dwHiyQv/cojPc+lhyog/uSA0dgVoeh
         Cp91b6SBWlL6/OWXyYHGkTNxK4+cPWKy6GGzW5LF4xllryqOUnYRDvk/ycXU1fkh9v7v
         q1HDNOhk8W9mizsfGTCrLqqJr4zLcgReAiJNnEOSD+KVKnG/a8HuYFWXaFozgyCqp0pY
         JkbSHWYnvi2ECXN2qf5vMSsc3cl1GxJVT5zW2PAydHX0dt3iYRunhijmOGUruRWRjT7L
         0OPmv9T9rKphdX8hAeJEaeyQVLHi9LCPbZHrl0U3JCW9TCRCDsCv+KCFwBTnOvg3EmZR
         1i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896219;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhOuIUAoFTCbIBl/9rQr9W/icRONAM5zBbPqtEBOAgs=;
        b=eSbhg8EtA6q9tD0zUtZaAM8FTKenSQ8vqHQJJ9frHdpazbF2zIX6QEL2oXu5HL3j0z
         hB2rlJtsW9v4uUz/RtgjZ9tNG/qh1c/DbuvwWZerHNLzmjUpTK5V0Qtd5Nn+zB1Zpctx
         5V8gTnp/xtw5+740lFen/pVEGvjg+zUlnsuRXoYoi+uApCbnpnZL2shI3vz6U0+RS1B1
         JhDyEhIlLxt8Fp6Z5etlkmVOwVbNuLTfqzpG+yXgQ6GGAAVkSSc79/Wg1trjnGXlR0SK
         eX747mmmJUtUOKN5sxCyk7I7ORyAjmbfaEBTTgo4dGcp2/holCacLGSZJt01n/GC+vLj
         dOZQ==
X-Gm-Message-State: AO0yUKU4d1Ze2Ls/8FxJoYoMHpH0poezGYTgXmePTIqZXO2qP0+ezOyy
        16RhzE1Q8dtG2W2rNKJc3aI=
X-Google-Smtp-Source: AK7set8Ut5defVL0QN4RvMjYS26QrOzugkQm60d9z4TUGKlQPXDHCI1kzI5LyID0fu357jBMqWWvfQ==
X-Received: by 2002:a17:903:124e:b0:19d:1871:3bfa with SMTP id u14-20020a170903124e00b0019d18713bfamr54138plh.27.1678896219565;
        Wed, 15 Mar 2023 09:03:39 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id lt24-20020a17090b355800b0023d267736b4sm1587194pjb.33.2023.03.15.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:03:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 6/8] commit-reach: implement ahead_behind() logic
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <9831c23eadbcd990ca09628e5846056e4879ee3d.1678468864.git.gitgitgadget@gmail.com>
        <230315.86cz5axgny.gmgdl@evledraar.gmail.com>
Date:   Wed, 15 Mar 2023 09:03:37 -0700
In-Reply-To: <230315.86cz5axgny.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 15 Mar 2023 14:50:03 +0100")
Message-ID: <xmqqcz5aovc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +	/**
>> +	 * These values store the computed counts for each side of the
>> +	 * symmetric difference:
>> +	 *
>> +	 * 'ahead' stores the number of commits reachable from the tip
>> +	 * and not reachable from the base.
>> +	 *
>> +	 * 'behind' stores the number of commits reachable from the base
>> +	 * and not reachable from the tip.
>> +	 */
>> +	unsigned int ahead;
>> +	unsigned int behind;
>
> Even though this is the tip of the iceberg in terms of our codebase
> overall, can't we just use "size_t" for counts in new APIs?

I personally do not see a point in becoming so dogmatic.  Plain
(possibly) 32-bit integers have their places in the code.
