Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE0C83027
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1997F6023F
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbhIBQfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346385AbhIBQfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:35:42 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152FFC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:34:44 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id e18so1512703qvo.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JiQAheRISQma1bVvqDiN8/Ogo+UJLZ1yhnLXe0a9zwo=;
        b=eC+SznVgHbRIwv+av4zlddbSceo/cZsngEGJELxT5fhGUs4GOomzh+0I/cCaIMF9Dv
         2JrsamDHNzr+F3HMkmXVY60J4kSzT9sj4Hh9Q2cs4n4CocpK7d4D5ovg+yChaPFKcVOr
         B1HJvz+NJnXTfLGawMMMTRNVrm97c5buEt984PdgN4ruw++qh1HZyrz0E7i7T0+Jn/3h
         9TVHVJdhnXFTgdCl+VJDL+WKyHnRTfyaSUNq/qyDUha+t1yz3I1cK76Ae+wiMZwKn/bd
         5gh3vZgmb9DfpUnzirk4k+zD+FUm3r+tvqv/iy/Znc2kyrLzTZDdrnE/3qEU5JB7DcyE
         lCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JiQAheRISQma1bVvqDiN8/Ogo+UJLZ1yhnLXe0a9zwo=;
        b=U8faBGUSPMOdqiGI9tsuIjheuHaaJVW8Z4sOXGXMJ7B6bJJ5bL0bz6xvEXVAIHoaAq
         DzfsSrzvLSAz0oPejXvi16oFQhOG+BDpaPyo382JxmNCotoambJJ5xjretUjRMlXHbNW
         Qe17ctLfzz8bcKU6HcQjCU04xJQDqW7SIEKI91t/mxphkNHUMaTOP0WG2C7WKLlNN6Mh
         zY/8FdNrDFq6F7JBBlxWHy1moKtTg5+fRCEtqN+uR879iBxR5kEOsmA0QoxsrVvZBxgL
         s2WOkPsv3prfx8ZUlU/Ph7xrseZjUIz5U7MKjNDN6vmwKP1Y6WClKaIvfdyKhhkGZL9B
         JS1w==
X-Gm-Message-State: AOAM533s6Rxlb633YLp0/oW4QDHLLKPZEAhISovxlj6HfshYiH/aXIbS
        DATF2Bxn4XSkfcAtrGrGv7U=
X-Google-Smtp-Source: ABdhPJxZb3t/s2XJuIEjmXfdBy0kuQNyTMqo8dZT78iN4Jh8QxfVXRk3JlFizgfWu2F1A2hb6T/6AA==
X-Received: by 2002:a0c:9103:: with SMTP id q3mr4066854qvq.36.1630600483308;
        Thu, 02 Sep 2021 09:34:43 -0700 (PDT)
Received: from [192.168.66.137] ([142.46.68.231])
        by smtp.gmail.com with ESMTPSA id h9sm1783444qkl.4.2021.09.02.09.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:34:42 -0700 (PDT)
Subject: Re: [PATCH 3/9] git-sh-setup: remove unused git_pager() function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
 <patch-3.9-73e540896fc-20210902T155758Z-avarab@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <503e0203-90ce-ff81-4d6d-46088d6ca850@gmail.com>
Date:   Thu, 2 Sep 2021 12:34:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-3.9-73e540896fc-20210902T155758Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Le 2021-09-02 à 12:01, Ævar Arnfjörð Bjarmason a écrit :
> Remove the git_editor() function last referenced by non-test code code
> in 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).
> 

s/code code/code/

Thanks,

Philippe.
