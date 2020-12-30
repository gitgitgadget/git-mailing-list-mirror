Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1941C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D8C2229C
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 18:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgL3SAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgL3SAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 13:00:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66AAC061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 10:00:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a12so18102864wrv.8
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 10:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MBtDwhJrcfIBPm8ODUvsUJnuj1zIFaqrtH8Mc4/ubVo=;
        b=fk8rdwmpw84S8iTO3lcW5bpBmPCSaYllFqrQL/CCy5vG/L5ATRX+rG2Fpb5yN0rVQR
         uaFodGd80QTsisThkNDLCrBXSa3VGZrc7erVYffGhQDF+CVeYh8Mzvst/7AHiufKM6D2
         FLQzSwExJovLgtKXoUslx4YmMKOpwEFszc8HAuuzW04ySfdcu8a4Cv020eeyUucD/5z+
         R9lMzQ2sQlWGMLUVHP6ovA8if8nhR+vLerOGfIfOFwSkwyxNTqUQvfzNSujbNo6SjJCP
         JvfEfqXCYVeG3gc/3xF0XS8/G0vOIQrcz93ZjJk4QRm2OiYdAWSVJ6KqMlB89DM+c4bx
         aFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MBtDwhJrcfIBPm8ODUvsUJnuj1zIFaqrtH8Mc4/ubVo=;
        b=U46qIVFbt26GKxtjYlAtmi4iungh6MaWo0SVBF+Qg//cEulJpaLFGUvG8EpekKGT3Y
         p0tt5i9Vymh9GvOeeetNtv/YVTsqcGeIMktgzIUjs+ylUQWGQ6IWq27lWGabFcelvVVL
         AeOnx75iAZeF+ytmEcL/ojpIL8vG0SPvUKCE046ib+smnTIb6x7C4zqszbUIA+Dz4Vn6
         0U7VsUB70mU5goFlrYU1xHk9KeCMXJqoPrK2yf09CHDLNp5pJDIsJ5cKdJNFPSBVfDb/
         XHDMuK4lCrL/+uZPBKWSrpXU15uVY8GahoNOu92vyoiGCuXQ0X3Z8GQQWt3tT/p1XT0H
         1kdw==
X-Gm-Message-State: AOAM532DxXMXPXI3C5tms+EcPWkW8OmfzemAn6oWC6QTGxYV1zVkAyZd
        pgoVykCR8sAr9Ulv1xv5dvM=
X-Google-Smtp-Source: ABdhPJwpoQc/VR7K07jHr9/Pt+DNHENQ+WECOkYWtwg3LuI9GaI0ysvlzHg5Mxab+LtYk8JTHYtYMg==
X-Received: by 2002:a05:6000:85:: with SMTP id m5mr60516633wrx.378.1609351210693;
        Wed, 30 Dec 2020 10:00:10 -0800 (PST)
Received: from szeder.dev (62-165-236-23.pool.digikabel.hu. [62.165.236.23])
        by smtp.gmail.com with ESMTPSA id n12sm71609413wrg.76.2020.12.30.10.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2020 10:00:10 -0800 (PST)
Date:   Wed, 30 Dec 2020 19:00:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/3] completion: bash: add __git_have_func helper
Message-ID: <20201230180008.GL8396@szeder.dev>
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
 <20201229170837.297857-2-felipe.contreras@gmail.com>
 <1402dabd-089d-616a-ef79-ff1ae3fcb438@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1402dabd-089d-616a-ef79-ff1ae3fcb438@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 06:17:52PM +0100, René Scharfe wrote:
> > +__git_have_func () {
> > +	declare -f $1 >/dev/null 2>/dev/null

> And then I wondered why use declare -f, which prints the function's
> body, when there is -F, which just prints the function's name.  And why
> repeat /dev/null when redirecting stderr when the more shorter 2>&1
> would do the same?  None of hat was introduced by you patch, of course.
> Anyway, this seems to work for me:
> 
> 	__git_have_func () {
> 		case "$1" in
> 		-*) return 1 ;;
> 		esac
> 		declare -F "$1" >/dev/null 2>&1
> 	}

The Bash completion script should be usable from Zsh as well, and Zsh
only supports 'declare -f' but not '-F', see 06f44c3cc5 (completion:
make compatible with zsh, 2010-09-06).  The Zsh version included in
the 16.04 based LTS setup that I have at hand doesn't yet seem to have
a (for us) usable 'declare -F' yet.

