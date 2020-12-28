Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802CDC433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 01:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD982084D
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 01:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgL1BT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 20:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgL1BT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 20:19:28 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61382C061794
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 17:18:48 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id d8so8022448otq.6
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 17:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pwB3cf6jOiHBXRywem/MEargDiOINmjJCwehLL8QwS8=;
        b=meXAzXnSyUqLdtUYgZZQjJ0Actv+L9t5chXCoIH2JnwnxGJTLMv5eiHdqpfBENIVPt
         LmGO3B9HjhomewO/oQzReHKyoKelTPwNvCe7XUkbwyHC2rsSmjcjWIWypKOukdkBEqgt
         4qka3rkpOrFFWzaqWNC0ADh+Ws8vVSz/rqmDG8aIve6wtj/S2oBJFhrMlHV8UzsAQT0N
         sqttHgZMeTBOK9MvKNJ8MHbUxLrS5uYP2BaZ0oLppP5InzWSlqJ0/0owGxfDdH3MpdAP
         o9AxeRZ/UPghOKI30Hwg0kAn/siXOktrXJhZiH/AvlwhqkIqpqMYHurpHqJjoZf47OZc
         9I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pwB3cf6jOiHBXRywem/MEargDiOINmjJCwehLL8QwS8=;
        b=WS77oafUY3auXcQN5lBZlYY1KRwbmECZ479ax8A9IIHVefIKfHq8/UBlQ8+uSNwJBv
         5pWu8odobO4AwBNU//M711QtHx4bHhJ855ybW3m1SJXkniy0sU5xUMhIoidY1U3Ldq+r
         9WIxWDPjvhzwWizvvf0gqhRfNvOe/lkUkBBzwMe81Y6XJeYlanRj0qRbZCpZzK8A9J1X
         N0ZuX7p0k9iWSb0X+IF58N7lUe5StYnyS0d/qsvJtMkhdGf17yZAositM357zy8sHYJX
         5+X2yYMfU2eOyMTGYGKcMO9o91PT/Nj77Udf2ULvlvzgFehWcNN37s0IiKwgJnaDcTeO
         6+XA==
X-Gm-Message-State: AOAM531J2nkUZx+FCfAOTGOw8Bq2Nag+vGBnYNsQ988ZhFiAxpYd/k7z
        tRYqa/GtQEWEpMNcwF17R+aIi4+3XKBGjQ==
X-Google-Smtp-Source: ABdhPJz+Gkr6om/SaQcSBHKi0eu7GkTTKIoPjhFlJNdAmBFEP8v69VmjukOkKfoezVoj1Mw7iZmMyg==
X-Received: by 2002:a9d:711b:: with SMTP id n27mr31593778otj.221.1609118326936;
        Sun, 27 Dec 2020 17:18:46 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 63sm8918685otx.2.2020.12.27.17.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 17:18:46 -0800 (PST)
Date:   Sun, 27 Dec 2020 19:18:45 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>, git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Message-ID: <5fe93275963c_10e652085f@natae.notmuch>
In-Reply-To: <20201228004152.522421-3-seth@eseth.com>
References: <20201227205835.502556-1-seth@eseth.com>
 <20201228004152.522421-1-seth@eseth.com>
 <20201228004152.522421-3-seth@eseth.com>
Subject: RE: [PATCH v7 2/2] mergetool: Add per-tool support for the autoMerge
 flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index f4db0cac8d..e3c7d78d1d 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -334,7 +334,10 @@ merge_file () {
>  	checkout_staged_file 2 "$MERGED" "$LOCAL"
>  	checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
> -	if test "$(git config --bool mergetool.autoMerge)" != "false"
> +	if test "$(
> +		git config --get --bool "mergetool.$merge_tool.automerge" ||
> +		git config --get --bool "mergetool.automerge" ||
> +		echo true)" = true

This is a per-tool user configuration.

Wasn't your argument that some tools would want to disable this flag?
That is; the tool, not the user.

For example, the author of diffconflicts might want to disable this flag
for all its users, or at least disable it by default.

How can the winmerge difftool disable this flag?

>  	then
>  		auto_merge
>  	fi

-- 
Felipe Contreras
