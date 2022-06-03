Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDA9C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 17:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbiFCRee (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344511AbiFCRed (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 13:34:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D952E72
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 10:34:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso4682815wma.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WSfZsQQHEQyTc+cUT0DfT7ANSvY2OWARF6hUpj8Z0LI=;
        b=VLtGJIweE759xT3shSbtW+fkUS67VA0P0K6QFjACmMTjXUNrPY6lE3PfgWshuNxqKu
         VXeaTgCkD5NzLNvZ3dup/DSrCIOjWxQn8/0LKq07hY/wLC69mnq5u6XfueMeurAceeDp
         zzEFquQNMPv/O9r+TqegqeMy41/fXCI73/MP4EaGlHHP5SGldcxbqKye4T6UxM44xPS2
         5FnTmaHvUT5NAR83j/vqyiX4i0cB2tCvseK1UMhyricJ5eE9D1CdsB/VOaHA6T5E2BLF
         sD2Ed2BeI7Mfbd9xWeiRGeLeE0wXyLa/tnXgPYnl+fQTNeNCf8bl8+e1USD7NDd5gk1v
         w0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WSfZsQQHEQyTc+cUT0DfT7ANSvY2OWARF6hUpj8Z0LI=;
        b=0burtTFqmMECAUaXnVdfSZTR3EFZPfuqVVhTdcSiXuRpqnCijcyhFj9Y+7HPuGAkBI
         ikxsI7hJnHt1mCLnGW+VLmLKl1sKrdXQSoQ7LfaY97MLJ68emNMLzzi4SeHDc+PTIkMJ
         e+4xdyCSK/hF3MGAKVUDvYYKNKc71lObv3AQZWAJ2SvmcmIUAlYym8ekA1VHt+P6Y52d
         fGrACPVg67eF6c1feVPp2Pix+W0vxgpOe/kyogvcHokkIpvPl3+1T1N8TeppA1cH1las
         cBknEibKX8065UQ9mkRJT2ydKzwag4GNC+zgWsYIdeSjOGt4GCurktSgp7em4wFS4711
         Mkww==
X-Gm-Message-State: AOAM533+GPOyUFxpBX1r4kG7pTIUWMKwlPzjlVxWTSAeRNL5Uu2xOIkC
        P6SeFc7oM5k9xdoeGo0bnk0=
X-Google-Smtp-Source: ABdhPJxOSk+2pY93IkDCQmnMn7T8nnqQX+o1fDnrU8kmTb11HVP4uTczTWDFasQ3DBwnCbmjCj8PbA==
X-Received: by 2002:a05:600c:20d:b0:397:3971:909e with SMTP id 13-20020a05600c020d00b003973971909emr9696339wmi.203.1654277669068;
        Fri, 03 Jun 2022 10:34:29 -0700 (PDT)
Received: from localhost (78-131-17-130.pool.digikabel.hu. [78.131.17.130])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b00210346cd0b7sm7877013wru.101.2022.06.03.10.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 10:34:28 -0700 (PDT)
Date:   Fri, 3 Jun 2022 19:34:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de, Guy Maurel <guy.j@maurel.de>,
        Randall Becker <rsbecker@nexbridge.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 2/4] git-compat-util: avoid failing dir ownership
 checks if running privileged
Message-ID: <20220603173427.GC1749@szeder.dev>
References: <20220510174616.18629-1-carenas@gmail.com>
 <20220513010020.55361-1-carenas@gmail.com>
 <20220513010020.55361-3-carenas@gmail.com>
 <20220603110507.GA1749@szeder.dev>
 <xmqqtu91helx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtu91helx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 03, 2022 at 09:54:34AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Unfortunately, I haven't been able to follow the discussion on this
> > patch series at all, but by a cursory look now I didn't notice any
> > discussion about what should happen if someone were to use 'sudo' to
> > access a repository owned by root.  I think it should work, and it did
> > in fact work in the past, even after bdc77d1d685, but this patch
> > broke it.
> 
> I thought 4/4 of the series was meant to discuss that?  Right now it
> is split out as Carlo was hesitant to push the step forward?
> 
> https://lore.kernel.org/git/20220519152344.ktrifm3pc42bjruh@Carlos-MacBook-Pro-2.local/
> 

Oh, indeed.  I only looked through my mailbox, not the ML archives,
and I wasn't on Cc for the last two patches of the series.  Thanks for
pointing it out.

I think we do need that additional fix as well, because we now break
at least one tool built around Git.

Though looking at patch 4/4, I'm not so keen about restructuring the
extract_id_from_env() helper function into id_from_env_matches(),
because I'd prefer to have a helper function for ID extraction and
nothing else, and to have all the uid matching inside one function.

