Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F70EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 15:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbjFNP4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbjFNP4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 11:56:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF1170E
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:56:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b3c578c602so25949065ad.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686758161; x=1689350161;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xqF6/LQvtjqk5/M5Owyd4Utnwhs+jTCRxLSZAfrK2w=;
        b=Qwd6tG1Ys74Myx/DD00XadN2Iratq3QPpyoMySXCdQCbrXfeJVy7n6vrnkDZVGqJIY
         vft3evOMXtV6K207/ONPXuUUyMISM61/Zbk/+m3M5A2HbOleziUcp6gmsk2XvM3Pj+S4
         wOd/6PXcPXe9U4VUmzOEYkmKy5ta3kgfSsuqBi+7k1HKyWe+U/+TzHRREOB8TVknJ0IG
         aYzbbPxQlc00GXPAEbWpc5jhqcKYrJ115YOGaoN1t42GSQwv9jo0MhHYJWAogfhVVLQX
         Xaknib1V0oi5NX3K3cZK7hA8T5wS9j0kWHDNWyJZ1w2HgScTgZuWo+Be8DF0nrtXzF1V
         DV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758161; x=1689350161;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0xqF6/LQvtjqk5/M5Owyd4Utnwhs+jTCRxLSZAfrK2w=;
        b=C+VlhB6fmfEDweVt8DLOVUActn5ukVn0AxiqzUOLiY1bjw4ZERZCjQ5mgTlhYtPbC7
         D83S8bIau1iiw3DSpa1jM5wCU84XU96Dk/BPynP57rubeJw0w+THEln/72J1rcspr9iH
         Zf9/9JoQ0CdONczkg6ve8gWjENO/v3DuRkw2xkrsGCgkAknhCjEMI3Xs2LuxIpn+l5E3
         pfpcjS7CBn9tswG83deaXfjwetemHEsBdyCixaxxJkOztuzAR6gHqYJhPt0XCuNxeaiq
         UVekhdt3ZkAm/Lo2tbGpdNqe+zs+rSe1DFBrGiLU1fWdemfa9CvOP/P+M+p2aqOZ/wHL
         GX1A==
X-Gm-Message-State: AC+VfDw46ce6RU0H+6OPyeQYO/F6U9UszCl8WQnGgbwZVP6bY8vWyNYf
        uevAyOEMt5OZndYREoXu3Tc=
X-Google-Smtp-Source: ACHHUZ5fapwlmQHUWtPfAfFfGgsPaI5bHMPIhlnlqN0h6I+ECvabQW9KvsjLe2Sl9ajnggdAbFE2vA==
X-Received: by 2002:a17:903:248:b0:1ae:6290:26d with SMTP id j8-20020a170903024800b001ae6290026dmr13250694plh.7.1686758161192;
        Wed, 14 Jun 2023 08:56:01 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902748400b001b0218651a6sm12325103pll.178.2023.06.14.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:56:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] revision: handle pseudo-opts in `--stdin` mode
References: <cover.1686744685.git.ps@pks.im>
        <457591712799719f23fa47e59d5a3c1cd497e802.1686744685.git.ps@pks.im>
Date:   Wed, 14 Jun 2023 08:56:00 -0700
In-Reply-To: <457591712799719f23fa47e59d5a3c1cd497e802.1686744685.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 14 Jun 2023 14:18:42 +0200")
Message-ID: <xmqq352uyr5b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>  		if (sb.buf[0] == '-') {
> +			const char *argv[2] = { sb.buf, NULL };
> +
>  			if (!strcmp(sb.buf, "--")) {
>  				seen_dashdash = 1;
>  				break;
>  			}
>  
> -			die("options not supported in --stdin mode");
> +			if (handle_revision_pseudo_opt(revs, argv, flags))
> +				continue;
> +
> +			die(_("option '%s' not supported in --stdin mode"), sb.buf);
>  		}

The reason why we had the double-dash checking inside this block is
because we rejected any dashed options other than double-dash, but
with this step, that is no longer true, so it may make more sense to
move the "seen_dashdash" code outside the block.  Also unlike the
command line options that allows "--end-of-options" marker to allow
tweaking how a failing handle_revision_arg() call is handled, this
codepath does not seem to have any matching provision.  In the
original code, which did not accept any options, it was perfectly
understandable that it was unaware of "--end-of-options", but now we
do allow dashed options, shouldn't we be supporting it here, too?

Thanks.
