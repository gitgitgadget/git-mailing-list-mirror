Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8343DC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjEHQjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjEHQjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:39:45 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A8B6EAE
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:39:13 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1960e7fe45dso543154fac.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683563929; x=1686155929;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eVq80kKebKQqY7hIpbrI6lTmV6KOd2FdZaU7pLqYn0=;
        b=hBu+qy9/04R2tewAXgJcnMWD4UlVLyUNE0K41jD8jAyM2b8AZJXnejyrvlHhPepw8B
         sVc8UDasG9QegMELrDAvuGuW41cXDV3TLUOgddQRMIjGA+ckQg2Yi+rk2r0rvPepoVZ5
         4L1eTdGvwAFwoblEWTmYNU/5KR0gy3eBhQfzRlDrFCGhWktkg9wAP0nLGlTJbm3pIRTl
         CMJ8fUXm4NCwoSSRTikair+oqwtLm4Ps2zbygN91t5JOAvYOwPnVZeIKyL1bkertF+lD
         wOP+jaq/fpoiRUfJH1E4IWt06X980cYjg9G6Qdjf2CzYUdNimRSuO3ckF3e0BFKqJzV4
         vD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683563929; x=1686155929;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eVq80kKebKQqY7hIpbrI6lTmV6KOd2FdZaU7pLqYn0=;
        b=OAoT/hlePSzBu87op7GkDlBq/I1XzpCy2vLqGsqi6FXHgBHAhL2h9tVjx5aB99StVA
         casxcbUtmlh6Lx/SRKgl8BRGE3bqPaOfOJZb4ALJzsNFuW5QBnF1LPexCtyN2PkV1MOz
         Ca5jOTJOUCmtXOrKkExmGRCjh/Vr2tB0TCUKpqjObKfzHu9j+JfiaKu5ZYkcaSKHq4nc
         zsdjP3P5pHN6AAgVzYAY1PckH/JpXOTOLmDfekbUWjEQ8ncpXFiNk48Cvkx7xGPXEQNv
         DSNJclz803kPxUDwQ+0HL3DWI6A/jlC+ZTXMPLjnYzULhvGo3wBjJC73A6L4dY+J4xL3
         q03w==
X-Gm-Message-State: AC+VfDxN0pd8P2TnTvftAE5Gz54MMvdSuxvCkfjwKn78DFSTt319mzc+
        U0KF9YY7ydV8yTNo6S+E2N0+wsaLWGE=
X-Google-Smtp-Source: ACHHUZ4wqJ7PogofuIrpuPYgJE2TED+oACUv4KfCTlNr4I/ATLCsI9Rou79E9T6puWfWAtqagt6aCA==
X-Received: by 2002:a05:6870:a485:b0:187:88ff:3b82 with SMTP id j5-20020a056870a48500b0018788ff3b82mr5284113oal.59.1683563929543;
        Mon, 08 May 2023 09:38:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w3-20020a056870948300b0017b21991355sm5061421oal.20.2023.05.08.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:38:48 -0700 (PDT)
Date:   Mon, 08 May 2023 10:38:48 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <6459259847ace_7c68294a0@chronos.notmuch>
In-Reply-To: <xmqqmt2ibcq2.fsf@gitster.g>
References: <xmqqmt2ibcq2.fsf@gitster.g>
Subject: Re: What's cooking in git.git (May 2023, #02; Fri, 5)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * fc/doc-man-lift-title-length-limit (2023-05-03) 1 commit
>   (merged to 'next' on 2023-05-04 at d048eb1ef8)
>  + doc: manpage: remove maximum title length
> 
>  The titles of manual pages (formatted with AsciiDoc) used to be
>  chomped at unreasonably short limit, which has been removed; this
>  makes the formatted output match that of asciidoctor.

That description is not accurate.

The documentation built with and without USE_ASCIIDOCTOR uses
docbook-xsl, so in both cases (asciidoc.py and asciidoctor) titles are
trimmed.

My USE_ASCIIDOCTOR_MANPAGE proposal was never merged, so we can't build
the documentation with asciidoctor's manpage backend, it's always using
the docbook backend, so it's always trimmed.

-- 
Felipe Contreras
