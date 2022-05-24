Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864AEC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbiEXUQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEXUQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:16:42 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FDC17E18
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:16:41 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-f16a3e0529so23683474fac.2
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S2Gf6kpK9seCoOm8LuIWsunh8V8+UGloEvSUGPGNNIU=;
        b=Cgk+M8/coFqbtVY9zGwV2k/zjqksxXCt6YFOooGCV8GBu9MMuSyoV02iznVvoJ7HWD
         4T2FmrRRpQXuk7bf8qH4egZBidn3DBPPthEDn2W4mS8ZOB4SEAiCAuLKA6/+8he6L7/f
         ZWywxcIMF8DMwYYVKjHEJGh5ROYh3fLyhuXfSd+3h82WvbxsMR8OKXQscpBvG1Y+RSac
         TiAPptj23IVY3CIU8ObYc000sRBKf8ZHJJP1Jzwy8uz1d2fqIXZhaRMx89GrlBwuddB9
         mRCYQB1iAZhmbu8wumL1TXd8Fl5Zsa1OWgR5B1bRgSKFNR+jgUXGf5Zp+OhkVHQFiBws
         qxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S2Gf6kpK9seCoOm8LuIWsunh8V8+UGloEvSUGPGNNIU=;
        b=qAETLU6ddkUwvKMKEvbdGgJxqYb5KQU8garV2/gqO4LGvr7fLurNMU5LrvtrHDUv3P
         GfP5dsBtLtZ4ItQb8B52DB9wnckm5hcwlXu5m/lL7dN452PEI6X9RYAwXtOjPgUPKgTp
         WdSFWFHuLsBN8e5Sjn7DSyxfUaYpOfiXG56tuh3MEdBbOZbU+Kll9nwgpm/LKcRBHx2J
         qr0nhRpQTCMj6IHlFg14DKSTmll81Ng2PElwKKM7pT2mINCdSdnDwODRFGCiL7guDe6R
         ZcYeowKB8uQ0EEguQ+ebmSnaUQzvrNXVYTi0gzvgd1P41ENELtvuUGbxH16PQTHMK+/q
         fR4A==
X-Gm-Message-State: AOAM533DQotXnCMuQSkREjBeskPJEpaHPYQTrZUAMNu/sFkSLM6TxrZc
        ObdXayfNmtFpoEwi8KpZ7lY=
X-Google-Smtp-Source: ABdhPJxTPYce6w9UZsSy+2W64ZD5b4m4vMs6U/In0+RSNp0PfYeRd/C55BQGm38hVmJDx8vOYOyGRA==
X-Received: by 2002:a05:6870:889d:b0:e6:170e:a37b with SMTP id m29-20020a056870889d00b000e6170ea37bmr3535383oam.38.1653423400591;
        Tue, 24 May 2022 13:16:40 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q3-20020a9d6643000000b0060b128b935csm2595481otm.39.2022.05.24.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:16:40 -0700 (PDT)
Date:   Tue, 24 May 2022 13:16:39 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
Message-ID: <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan>
References: <cover.1651859773.git.git@grubix.eu>
 <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
 <xmqqtua2jtr0.fsf@gitster.g>
 <xmqqczgqjr8y.fsf_-_@gitster.g>
 <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
 <xmqqr14jluu4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
 <xmqqa6b7lrw6.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
 <xmqqleuqj1gy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqleuqj1gy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 10:15:57AM -0700, Junio C Hamano wrote:
> 
> I _think_ we can even get away by not doing anything to
> slot->finished at the end of run_active_slot(), as we are not
> multi-threaded and the callee only returns to the caller, but if it
> helps pleasing the warning compiler, I'd prefer the simplest
> workaround, perhaps with an unconditional clearing there?

Assuming that some overly clever compiler might optimize that out (either
because it might think it is Undefined Behaviour or for other unknown
reasons) then Ævar's version would be better for clearing the "warning".

But your patch fixed the "bug" that a probably overeager compiler was
"detecting".

> What did I miss?  I must be missing something, as I can explain how
> the current "(*slot->finished) = 1" with "while (finished)"
> correctly works, but I cannot quite explain why the original "while
> (slot->in_use)" would not, which is annoying.

My guess is that there is a curl version somewhere that is patched to use
threads more extensible than upstream and where this code is stil needed.
I think it is also safe to assume (like you did) that this is a 16 year bug
that was already fixed and reverting that code would be an alternative too.

Carlo
