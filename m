Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C791C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 09:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKTJeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 04:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTJeI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 04:34:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA51EAD8
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 01:34:06 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e11so2842415wru.8
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 01:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAuDNy93jiPV/YpUoUkeW8PE+iX3QlDGyfzXs4B1Iy0=;
        b=hh6yREdQtSHuyjOSyNeZJDEUNzUjhC+7X4tQxDA9g61YFKv66qCW0zv9VB4Xxfnat0
         Mwz/QpC4SEwMxv7rtKuz7RX9rzbKYyI4LaJx0tW3HitLiS9Ofq1+qhVz9ANwv4Y9tTEU
         SH/QPJQ3n+Yfgs1rOW+48nWe3cUJBt4qU2iGh/2OXyQ8ozr92uM0kuevsb4f/Snb14Gg
         7rGEP3WDdS4l2oGvQefEhW1BFkDQMjvKp0DxovrjZxal0vFx+EbjyuOOtY3KpVBEY9f8
         ir/Fp0Vx48nHKSeCEAttC1aptPBP+AyM/A6CX1NuTfUh464XWYErE+TNKDoFVbQbev3R
         h6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAuDNy93jiPV/YpUoUkeW8PE+iX3QlDGyfzXs4B1Iy0=;
        b=O6j1vu5cR1vMPjLyG2kP897meNe9edkUnD02bhFpxFm1Ono5VEyxCuDBlvrcmbnSV6
         9A77DeRkSzWbEfrf2399N5Fub1zPCKLcBsepMR0IMaGGJWXRmuEp+F385oxzg+JC4QDY
         zCtdJ4pUFBSJXOr0Dpa6sMv3WdqD1TBao3JGbZo+hXK7FTPG0B0S4OK7Ugd9333GSTAa
         1O0foN22jqmAXJuSwDWJ64jMZTmo/xDDDlelE+BQHmHDRBKHxMWp0wi7I9CaGbAypddU
         hGGP34H6N/WHnEQ9VDqXq2QfetuGhZX47mZ4XWA61CN5jDFuhk6Bb6pu+nxloSMfIheQ
         hgeg==
X-Gm-Message-State: ANoB5pkQwKrJUE8/k4Wk6UkV2n7H4C9e4Bggcs2tu8aSWwOCo53LIIGf
        CCEZQp85amBsMtDCjwCPXgFj+bjJb9Y=
X-Google-Smtp-Source: AA0mqf5d5kSc36RWORn9FqhcNo4qVjgtUJFGtvJCIe2R3I8xYCg19skNsuDkk5wuA0zZ6fZIANonMQ==
X-Received: by 2002:a5d:438b:0:b0:236:711e:58b with SMTP id i11-20020a5d438b000000b00236711e058bmr7921717wrq.145.1668936844377;
        Sun, 20 Nov 2022 01:34:04 -0800 (PST)
Received: from [192.168.2.52] (104.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.104])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003c6c5a5a651sm9904230wmc.28.2022.11.20.01.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 01:34:03 -0800 (PST)
Subject: Re: [PATCH 1/2] branch: force-copy a branch to itself via @{-1} is a
 no-op
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <db182322-1383-4311-8baa-c4a9aeed3b4d@gmail.com>
 <221118.868rk8hpk4.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <b70d55e8-efb6-a69e-f568-e0d6aef48e61@gmail.com>
Date:   Sun, 20 Nov 2022 10:34:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <221118.868rk8hpk4.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18-nov-2022 04:58:54, Ævar Arnfjörð Bjarmason wrote:
> > @@ -584,13 +584,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
> >  	strbuf_release(&logmsg);
> >  
> >  	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> > -	strbuf_release(&oldref);
> >  	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> > -	strbuf_release(&newref);
> >  	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
> >  		die(_("Branch is renamed, but update of config-file failed"));
> > -	if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> > +	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> 
> We try to stay under 79 chars, see CodingGuidelines. The pre-image was
> already violating this, but the new one is really long. I think it would
> be good to just wrap this after the last && while at it.

Yeah, thought about that.  I preferred to not doing it mainly because my
plan is to move out that strcmp() from there, but also wrapping that
line induces to wrapping the previous one too, and there are many lines
in that file above 79... I already have a series[1] to follow the
CodingGuideLines in branch.c, currently focused in error messages but,
maybe this change makes more sense there.  Dunno.

> 
> >  		die(_("Branch is copied, but update of config-file failed"));
> > +	strbuf_release(&oldref);
> > +	strbuf_release(&newref);
> >  	strbuf_release(&oldsection);
> >  	strbuf_release(&newsection);
> 
> This moving around of destructors isn't needed, and is just some
> unrelated cleanup. Your change here only needs to be:
>
> 	-       if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> 	+       if (copy && strcmp(interpreted_oldname, interpreted_newname) &&
> 	+           git_config_copy_section(oldsection.buf, newsection.buf) < 0)

'interpreted_oldname' is a pointer to the 'oldref' buffer, and it is
used in the next comparison, so the release for 'oldref' needs to be
done later (same for interpreted_newname and newref).

Maybe you are thinking in another change... I also thought comparing
'{old,new}section.buf, the section names in the configuration, but I
preferred to use interpreted_{old,new}name.  It looks more clear what we
are doing and in future commits that section names might not be composed
at that point yet.

