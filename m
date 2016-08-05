Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95DF72018E
	for <e@80x24.org>; Fri,  5 Aug 2016 19:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938976AbcHETIv (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 15:08:51 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35591 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762069AbcHETIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 15:08:47 -0400
Received: by mail-io0-f172.google.com with SMTP id m101so308040976ioi.2
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 12:08:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nA+I5Ruh3YccIBBZb6W7mhsysxISXzCYWsT3ogQoJEU=;
        b=KCzfVphq19LDD5PED1MfnSh2U+3KeW7sWyHw3rrEdhmywxpGqV2TVPnPWSYjMDK91n
         i8ewdbgP0AtZaAftMmcbGa6+hJMpccL7nPh3dZEkbBmarG5YMRSuVZojSuY3UM3NiP6W
         eW0EAYdEB2kAMTpRs8CqfxFQy+nfsPbeiFnxMmVpo4pKB0MYKfaOExETC8sn2hOv38h1
         iS3Boen5BLfgS5aDwAF62P9kMCgF9hsWbNTPxQWWdTWe3iSWFTFTLboREKTFkhSPc/eE
         Vy9NQu0ORSH1g0Y8KIag719+8qm7EzT9HXBerZVCPYZDfMjVQSIcDv9at448xbtSJyUd
         DOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nA+I5Ruh3YccIBBZb6W7mhsysxISXzCYWsT3ogQoJEU=;
        b=dv53RGvjkEqiEBba+6gfmDWAa9iFq185mrxarXGU9Y7g3gAMmVfy4Cj8g5lNavXyU4
         F28AioCf8KGJ7iSeSdQVEn+UvFjtraKE63niHhDrjoD8P46RHesYskjAXkCfzi0OnW6B
         PckiQz5W9/vkdPL2ybVcVR8tAh82FavizVQEi40wPTxshssiD2JCwmJjTFOnUIxlFIN5
         89ypoDqa/R6k50IQbCdm2bdw4AjzOx3TmxFhBk1GQOuGuX5KaGWS32BXGA2ZQ0aY27Jh
         vNaEhHXmiXoReY0cnmHS3n08FgPcJ+R8OBqjQ6OkOQsjmq/OuCXp2vL3TsQqGwYGmdDV
         bTsg==
X-Gm-Message-State: AEkoouuoCwTTtuZ3GFDsLBuvtfHpIV02SqOqrTlfl7BsMHGu3rpdr6iBmMfLQ3i2541h3qceno+dkNvn1Yuf/IRI
X-Received: by 10.107.178.129 with SMTP id b123mr81956057iof.83.1470424126710;
 Fri, 05 Aug 2016 12:08:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 12:08:46 -0700 (PDT)
In-Reply-To: <20160804195159.7788-5-sbeller@google.com>
References: <20160804195159.7788-1-sbeller@google.com> <20160804195159.7788-5-sbeller@google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 12:08:46 -0700
Message-ID: <CAGZ79kY4YxftihTP_cNqLrVTn0wrfNd5_mb40AB-t2beyzvdLA@mail.gmail.com>
Subject: Re: [PATCH 4/6] submodule--helper update-clone: allow multiple references
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> -               ${reference:+--reference "$reference"} \
> +               ${reference:+"$reference"} \

Note how this changed the API of the submodule--helper.
Currently we pass in --reference $reference
and $reference consists of the string "--reference" and the actual
reference. So it looked like '--reference' '--reference=foo'

That is why we can pass the argument unseen to clone in the helper
via

    argv_array_push(&child->args, suc->reference);

This is fixed now.
