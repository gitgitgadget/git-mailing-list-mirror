Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ED5C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 00:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiK2AaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 19:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiK2AaV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 19:30:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532AA1834F
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 16:30:21 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so7454095pjm.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 16:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhrNnWAacKKMwu0MgT7dHzYKEBsC/wDHA1WFnMTP2Xc=;
        b=Wacb56/7UcUOp1aqsSFAssLngpbCjPeoIOj+QmgJOJKPHvjwKd4oZDGjbbG31U9tqc
         0gLnJ/8omXwMCwnCW2SicoXl2g3qyfjBX0n5S9uDBb5b1aoegKTc0oK2HIPvfK/xYKbC
         rJRDHyp5nd1EtRAvQx/5Ym08UkNLOx1oijW+BVMHKcqhwLojeg1TVEpKgJUOCE6cc3QQ
         jdJzkhCyXvtjtKWrq22z+9HoglJ4OFAU30Vtq5qaLLXJZ37oZkNLSaTSiG1Em8ykezuk
         JS6V1fohjanmeGv/abe/NdBQ9RGt8jZ9ZHRQL7ZJm2pRspOb8nafQn+uVyBj/QpsYsxr
         CdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhrNnWAacKKMwu0MgT7dHzYKEBsC/wDHA1WFnMTP2Xc=;
        b=MyDU0iKsRaAL7P0s2j3PMfU2u3URTr99KX4asYD0HwBCHUap9PfAnS1EtCv5+JxRNt
         jmBfuNjudP/PoY7/LaIg+MeAkIc6QShMPS5XbXV0t4GWCJYkaREnPwjN0NHh8fHf6Rpb
         8xfQJfqS+dnzakqqrQpmskIDEIq8OV+6/+nYFmCdwFpPe5IrNTBmTGLrUAkFinFRBiwW
         GjgTpgeob7H9Lxf0LW50F2EnxjlkDUAid9M0ylST1tbLklZGXobUTyQ4hJGy2MV/VS0c
         5f10EPKtzz9oTOuNwHxtlegZa3C5fV1XYXxpUTPqVAupI7oNfLABnQDwWlYTxHj+StPc
         dHfQ==
X-Gm-Message-State: ANoB5pmekqqS+xISrX0Fz41xf77XTbKk0lNYKbn27fR9m9KHcNpdYzHM
        xYoAbiZqsI9lb7GmEB0WNfE=
X-Google-Smtp-Source: AA0mqf5u5eixa3GFrQ9d3in/9yfdHgnWFBDhBvFXw1fJGTDXUeo3TqRKBFjNkrtX8PLlkuGDfP4Ilg==
X-Received: by 2002:a17:902:ba87:b0:189:1890:77c3 with SMTP id k7-20020a170902ba8700b00189189077c3mr42348387pls.138.1669681820688;
        Mon, 28 Nov 2022 16:30:20 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h11-20020a62830b000000b0056262811c5fsm8601451pfe.59.2022.11.28.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 16:30:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/3] t1301: do not change $CWD in "shared=all" test case
References: <20221127145130.16155-1-worldhello.net@gmail.com>
        <20221128130323.8914-4-worldhello.net@gmail.com>
        <221128.86ilizkybr.gmgdl@evledraar.gmail.com>
Date:   Tue, 29 Nov 2022 09:30:19 +0900
In-Reply-To: <221128.86ilizkybr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 28 Nov 2022 14:18:45 +0100")
Message-ID: <xmqq4jui61r8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think this approach goes against the effort to implicitly stop relying
> on templates.

... which I am perfectly OK with.  If you removed something that is
essential to the health of the respository from your templates, you
deserve the breakage you caused yourself and can keep both halves.
