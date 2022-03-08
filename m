Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8548CC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 18:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349746AbiCHS4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiCHS4C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 13:56:02 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E779329A2
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 10:55:06 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 132so17253900pga.5
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h5SrtRoM9JQdHHPU6GPo1412mZ2vC4QewMzBQEUiGyk=;
        b=OBHqIwcbwdkRvbmVCmyHKo6n3y7pgrehFN/okXc4CabQgvmFpLDFUa9N97m5jrZVcR
         zlE+lKpiFaV7ZrjGtkyujWR7OJS2OtttxeV2ivA9dsSTuL4a4AAkAJiEaJLKWlwuyOOo
         cs9Q9UbvuvwCEFk/QD/VDnuTy3751mbPtVGLuyPwchXeTSSUhNcgHNYoPCxNQOHisdBR
         WKiDWVe6M0HFS1zOLT6scccQgkvq1GpvAgBe6EZxeUATNO0JP1/v5Z6R5tpfnIDIkQVa
         /3QCrC8NA0pL7WN6n1rWCHv/HI1LToIoUT3/zWRkzN/pMoaNXVl0OFxYt4i+b79j6Yhb
         EU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h5SrtRoM9JQdHHPU6GPo1412mZ2vC4QewMzBQEUiGyk=;
        b=FVx2SFM/z3pQr+JuKUlm6TutMVdR/sDJzGHkBo0lYebDDoPEqKTkdBWlqRFIbdozDw
         JARTWFXV8LyoJSCIrYNFYLqe4Z7ourE4xDbjdPxy2409Aurbd98cumSlUHdoP4di7MBA
         jYrg4PbS1gAUtC1+wQuJZ4Cj02IdAQffjqnchOEmygSBxUZHPhmZrQvKfioilujFsue9
         /Z4nt+URj8GEZQpNDCHBxtdx6CEKMoOKD40QpmRdtKFTQfJyPOno1jfMmyGeUWAlceb1
         ubvQQz72p7qVOQ5N3aGHcyhLRVAsU2HIvgYN5DmxuKQswUirT+7fgocEcoiVFVRLBCPq
         zUkA==
X-Gm-Message-State: AOAM530FWL3yxNqj6ZL/o9ColcR4sSnpaP2PJ2lI86pD91ytn8EkiSQh
        TVuGfDMqSUtcKQFTHKTnKzBq0Q==
X-Google-Smtp-Source: ABdhPJzyrTWfOgUwRSXPM7tV8Qt8qbr8Z2/qkEavf+G04u4vuukEyvg0sbJbJFuR4DLIuXbO/zSWpA==
X-Received: by 2002:a63:5b42:0:b0:378:66ca:74ab with SMTP id l2-20020a635b42000000b0037866ca74abmr15199419pgm.63.1646765705331;
        Tue, 08 Mar 2022 10:55:05 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:7bb4:8168:2ecc:faea])
        by smtp.gmail.com with ESMTPSA id gb5-20020a17090b060500b001bd312f7396sm3752013pjb.45.2022.03.08.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:55:04 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:54:58 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v8 0/3] teach submodules to know they're submodules
Message-ID: <YiemguagkDdoUkp2@google.com>
References: <20220203215914.683922-1-emilyshaffer@google.com>
 <20220301002613.1459916-1-emilyshaffer@google.com>
 <xmqq7d9ewerw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7d9ewerw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 07:08:35PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > One thing I'm not sure about: in the tests, I check whether the config
> > is set, but not what the boolean value of it is. Is there a better way
> > to do that?
> 
> Are you looking for value normalization during both setting and
> retrieving, i.e.
> 
> 	$ git config vari.able 0 ;# or "no" or "off"
> 	$ git config --type=bool vari.abble
> 	false
> 	$ git config vari.able 1 ;# or "yes" or "on"
> 	$ git config --type=bool vari.abble
> 	true
> 
> 	$ git config --type=bool vari.able yes ;# or "1" or "on"
> 	$ git config vari.able
> 	true
> 

Ah, thanks! This helps. But that means I still need to check the return
value, and associate "didn't find anything" (1) with the default as
documented in Docs/config/submodule.txt, right?

Either way, this is useful. Thanks!

 - Emily
