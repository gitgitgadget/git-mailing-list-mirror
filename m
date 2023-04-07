Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4856C77B6F
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 18:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjDGStq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 14:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjDGStU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 14:49:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E330D508
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 11:48:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so2024096pjo.4
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680893287; x=1683485287;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVc0Go3myn9AyFoEYPasW+8wvD+XH6Ky9FbNkp7qmGA=;
        b=lnweWf09IL3CvOzXohBcCg0nFlVMnLmjT1aLWusaYnxHcCPMWCVDCjC6RV22eT5ICN
         Qu38dD7qHjwciiK75hihZD51Y1m0pz7rURV3HJmz/H9GHafTHttZ0P6OI4j5pj6iNbLJ
         PpscCQqs756U9UOXoso2eh0eQ/F3ZuH1M2/uNCGGwvjWTaICFouIVuHml6flpx405lbK
         TCV0ggRqe55HZKqxPu68wi9fEgi4d0F2EPGx17vkilaY1m2bzHunLcHbu9NXpONzjIHf
         UY9v3X3G4haJXXkWyJnPylZ3DWyC9S2W4BQNq7M0pyQoG98kY5I2H7MTcXXkYFQmKEM9
         G20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680893287; x=1683485287;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVc0Go3myn9AyFoEYPasW+8wvD+XH6Ky9FbNkp7qmGA=;
        b=561Pd4DOJhRMMSTqZ7b1mYoVcBdrzPHZAUBtOZoyQsRI6QM+oEdPhU9FMa/oLHF5AX
         +9LFcJW8vOpTESXrhAyryN2X/ebyrbV/gt35F5c4mW+bfBJ0a3DfRBj+xfyGX0RAzlCU
         AaYNvJlBVMh8MyULrFVIuEAJ3c0KaTOkqPxe16fu+L8kh6fPLCQIv+0GwlharJLTifK5
         9dXUNoGAVUvM2uo3Exb/8leABmTOxWpDIz14pFSLDlr02X0C3or63DWbNDtmGqF7jZM8
         zw7r/eLfSOHlUBbOW/YyRPc+imMAEHUFuLZ/qRrzsA4Uln6A34qY9V+tvTLlE78RvVg+
         +mOQ==
X-Gm-Message-State: AAQBX9caz694BNn6saeaMImVVHmb5bDXrMdB11DPLNmVdA3RBuHoLM22
        drK4OSX1IU/u91PtBv3sAwLRs8EQTus=
X-Google-Smtp-Source: AKy350ZPbiEsfeO2jSBGiSHNkdacF5iHYnRHcX9h2FekEoUAkqlMYK5WqeGbRWPUTKr9YgISk5OWWQ==
X-Received: by 2002:a17:902:eccd:b0:19c:da68:337a with SMTP id a13-20020a170902eccd00b0019cda68337amr4134477plh.31.1680893287264;
        Fri, 07 Apr 2023 11:48:07 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id m14-20020a170902bb8e00b001a51e2302f8sm756415pls.166.2023.04.07.11.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 11:48:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, phillip.wood123@gmail.com
Subject: Re: [PATCH v3] branch, for-each-ref, tag: add option to omit empty
 lines
References: <xmqqjzyoq35x.fsf@gitster.g>
        <20230407175316.6404-1-oystwa@gmail.com>
Date:   Fri, 07 Apr 2023 11:48:05 -0700
In-Reply-To: <20230407175316.6404-1-oystwa@gmail.com> (=?utf-8?Q?=22=C3=98?=
 =?utf-8?Q?ystein?= Walle"'s
        message of "Fri, 7 Apr 2023 19:53:16 +0200")
Message-ID: <xmqqile7jzq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> If the given format string expands to the empty string a newline is
> still printed it. This makes using the output linewise more tedious. For
> example, git update-ref --stdin does not accept empty lines.
>
> Add options to branch and for-each-ref to not print these empty lines.
> The default behavior remains the same.
>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> Dang, you're right. But yes, it was a near-identical patch to
> builtin/tag.c. Along with a test, of course.

There are small nits like "do not explicitly initialize statics to
0", which may not be big enough to warrant a reroll.  Other than
that, looking good.

Thanks, will replace.
