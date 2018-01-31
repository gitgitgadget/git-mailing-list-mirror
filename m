Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0E31F404
	for <e@80x24.org>; Wed, 31 Jan 2018 02:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeAaCWw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 21:22:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38276 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbeAaCWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 21:22:51 -0500
Received: by mail-wm0-f67.google.com with SMTP id 141so4902095wme.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 18:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5m7T1Hu3LmIBYquZCwl7nEG9imsHzkogUUULwGUCl24=;
        b=aKu9QMPnhK79wkUpd4Gxmp3m+2cG7TMz8++tmsgZB+bTHIYCQddLxpj0OpI6YOVSp1
         A2eULbDXLpauaJZMICtHwyVEtiTbZnLhO/ndQK1EJmgkQsI05VnuW1MJ2AdZcmAymXX+
         0CrkLdCCffsvWbkMeS82XVcQjRNIEjJW7klLX/49g12ExIgY9jo2hHrcNcyjw9WowHrw
         Alo5EeC0z/Fm43uSVV++8+V9Co0+dm0uJ9kWFEgt2+qSBQ8fb95LenxR1pzsxdNNeD+x
         CnLtPoeFqTbiTmB9PFESJu6MpsRtMzub8ShHowcib0314j+UjDrreElQqiO8DS30xmo5
         zVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5m7T1Hu3LmIBYquZCwl7nEG9imsHzkogUUULwGUCl24=;
        b=Bha4nmNFZBzKRapAmDxurs82C+l4iyXBttPuXkD8pqouQ1vlOvtdvuXNfWYPrcNg7v
         cholD0WOJi6wb4D8OvqkaL36u4kF4PPHnMTl6JwR6dsbi7VirXiU6PyNQXa32QD6kSVk
         IMQREs3DnNvsnc5X0tibiTlgirpgDNRI+ub5xfzmdjUNftCNBhh5Nq7CWFUQEuqacgXC
         oiwFqC7OUaO/MdL/4yv0GnMzYKzLsAySAl/ixmhHi9LuVXtTt+W8RH14HMEfjWn0s/pK
         moFJfe/IH9VHkPpb3QOt+spY7ydBLOP4UKP0Hg7D2seU8s7CJKRL49Zqnjq8SaOojBgj
         OMoQ==
X-Gm-Message-State: AKwxyteRmf10k3GcSEeig0ExadhCE9Mj7/PtuKI4u32rQFyd/0daVAOl
        P03+un3528SyNRdBTTuKPMI/o67MJ0KUZX266TpgQ2K4
X-Google-Smtp-Source: AH8x2273jL8/FD+nNCyE7a4pubnsI0av4we8mIQdyhxKiyo5QEpR6oClfk14Y7oC9QjzOX4IOjLuoU07i9/qIra8mS4=
X-Received: by 10.28.167.5 with SMTP id q5mr24393350wme.90.1517365369984; Tue,
 30 Jan 2018 18:22:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.182.69 with HTTP; Tue, 30 Jan 2018 18:22:49 -0800 (PST)
In-Reply-To: <1517348383-112294-7-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-7-git-send-email-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 18:22:49 -0800
Message-ID: <CAGZ79kbt3+MLvw-UsigNq7mf7kxK3KhjJ-pEqFe1R03bNFMhKQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] commit-graph: implement git-commit-graph --read
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static void free_commit_graph(struct commit_graph **g)
> +{
> +       if (!g || !*g)
> +               return;
> +
> +       close_commit_graph(*g);
> +
> +       free(*g);
> +       *g = NULL;

nit: You may want to use FREE_AND_NULL(*g) instead.
