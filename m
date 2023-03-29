Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA3AC6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 04:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjC2ECq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 29 Mar 2023 00:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2ECo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 00:02:44 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017030E8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 21:02:43 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id fb38so9419790pfb.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 21:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680062562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIyKKOcUkrGBNkdsU3ZmdDLUNnGOKf8sKPQCFsAr7SU=;
        b=g2r5NgG9l2JaofGTEHFUoH07Q5DYXpuv3ARA0dcRxSxAuU+rPM8WoW+iGlNCl9ZiXD
         Mvu7y5VkPcrnP2ggyXUgbnSmolplQeiJz2c0KvJ15O2iUC3IJLNTCcjuUT5aE7rIGlHM
         IW6ZDAovDi9wK/uxl1cvDJRPkOW/Hq7YaHrwmHDDq+IT1etnwHTvgRboCfMgrluPONAN
         rwBMElQGphx91ZwIQGe2DT0DLKMUcDgVnTVMJSnj1dTj5LVvSSqcmrpNeWgBiMJpMwKS
         RnIfa3utVEtGkaNS3Uinhhd+06s7HDWCjSR3LYHdMK6BufB1HWdrgG7xdLGqo+iUmYjy
         +NUA==
X-Gm-Message-State: AAQBX9eIiBRVRiNKigEbvIuwG1yB1/9zheKnOsDOKDMa9J3+VXW+mvgM
        mpM/Tuw3RB5Nhs2FcjuQKIXRlWfpPKXeEEuQVIPTRTLC4sI=
X-Google-Smtp-Source: AKy350bbohxNDpa+IK/mce6obd3PZsTcgPLgRvgzo5xvQw7c1glL0NPfYLAvpSTa7VkJtzib/2VNRdGWWEP9TEjONdA=
X-Received: by 2002:a05:6a00:2d06:b0:625:c832:6a10 with SMTP id
 fa6-20020a056a002d0600b00625c8326a10mr9686557pfb.4.1680062562456; Tue, 28 Mar
 2023 21:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net> <xmqqzg7wczx7.fsf@gitster.g>
 <20230329023702.GA1793752@coredump.intra.peff.net> <20230329030432.GA1801645@coredump.intra.peff.net>
 <CAPig+cQexJ9s1f6tLLaq7baeVCKhazPBi_xQ6uybkQcJQ97geg@mail.gmail.com> <CAPig+cQiOGrDSUc34jHEBp87Rx-dnXNcPcF76bu0SJoOzD+1hw@mail.gmail.com>
In-Reply-To: <CAPig+cQiOGrDSUc34jHEBp87Rx-dnXNcPcF76bu0SJoOzD+1hw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Mar 2023 00:02:31 -0400
Message-ID: <CAPig+cRH8Ca+s9zpmEx4O2v4q2s2Mqr2Axm_ryMan742da-KmA@mail.gmail.com>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 11:46 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> The attached patch seems to do the job. Apologies for Gmail messing up
> the whitespace. It's also attached to the email.
>
>      $tag =~ s/['"\\]//g;
> -    push(@{$self->{heretags}}, $indented ? "\t$tag" : "$tag");
> +    $$token[0] = "\t$tag" if $indented;
> +    push(@{$self->{heretags}}, $token);
>      return "<<$indented$tag";

Bah, the `$$token[0] = ...` line is incorrect. It should be:

     $$token[0] = $indented ? "\t$tag" : "$tag";

which more correctly matches the original code. Without this fix,
$$token[0] only gets the cleaned tag name in the `<<-EOF` case but not
in the plain `<<EOF` case.
