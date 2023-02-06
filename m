Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082ABC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBFXKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBFXKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:10:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8834C3C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:09:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g6so3965338wrv.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b12SzrgVAxBLVVuecv4K6cf5ymMIBobYTKEy44vY9TU=;
        b=iR77A0uObvM7At8eWk4sJHnTQQkVNGToSUUfhm6Y20ygtnQ9wxSjUgxzk/+mQ27App
         jD4EiAEIluWEB7LA/f3Fc+1pASFcWF4kPcY7zTTOOkSQwcqO7wZFsfOgDGCLLQLZyAGb
         2lXw2SKzox7haUapNU8h98a9LPxF/RFFkE5tPf/nTcxul5Pts+2MozMaPN1Ywjegykxm
         iSn7yc9UElw2h+XlLBmS09E+jWD1jNVJ91HPSSSN40QkrSDJoNDL/ao459fg0+HpyR77
         mGGtp6T9M4rapbcPbWvIoVKOMlmL1nSHRewV0hfF3PkBW5Kr+qhBAaJbEkm4OZIrTxRF
         iIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b12SzrgVAxBLVVuecv4K6cf5ymMIBobYTKEy44vY9TU=;
        b=TABgwnzdb1Ao+wfTzpB3yaTifYhsTlEasasp8sR71iz/PrqLr+FCh9s8EoqCI2qeWA
         LJWsc0Cbks0aE97Zdw3RPj+ELftwrCdJF/q6tuow9UWljgDk15LOsgwixHKTyLX+X1la
         kGAyEUUqUe6EJfolpqQ1kIPb2BTGgnE+okPRqxQEPYOrrHDdwLXNnQs97cYaEk/65j4Q
         Y2Z0mD7qGiW1HPAvx29wI59kpt85y9Z0c53KVxEmuNBc3TKoSjWleaoSNhvr2P8njRXc
         CoxUZf8PP396JqWAF6b9TIm95E/en40f/tc1SlaU2D89aQO1kwR0bPSDFOjnj0hmmvUU
         wYLQ==
X-Gm-Message-State: AO0yUKV4PbuTYmswR+ykPalj3aVM5VBkV03hA2+W+K/EhQMUNL/l4wab
        eFe73KdKjCa5NMg3U1qJk6XRh15jO7w=
X-Google-Smtp-Source: AK7set9RUJHxOZv9KsEqHeVVuOa8j80hLANXFgwGJqmzVLN5+IO7hxDE/gFddG+wxcqVt9byFLKLOg==
X-Received: by 2002:a05:6000:12cb:b0:2be:b07:d411 with SMTP id l11-20020a05600012cb00b002be0b07d411mr563999wrx.3.1675724957234;
        Mon, 06 Feb 2023 15:09:17 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id u2-20020adfdd42000000b002c3ec1fbc0bsm2686199wrm.94.2023.02.06.15.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 15:09:16 -0800 (PST)
Subject: Re: [PATCH v3 2/4] branch: fix die_if_checked_out() when
 ignore_current_worktree
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <8670d6c6-b5cd-a1e3-8fbf-b948cb687388@gmail.com>
 <230206.861qn27mt9.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <ab032813-39dd-2b45-0e3a-84fb6babe89c@gmail.com>
Date:   Tue, 7 Feb 2023 00:09:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <230206.861qn27mt9.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06-feb-2023 17:56:55, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Feb 05 2023, Rubén Justo wrote:
> 
> > -	wt = find_shared_symref(worktrees, "HEAD", branch);
> > -	if (wt && (!ignore_current_worktree || !wt->is_current)) {
> > -		skip_prefix(branch, "refs/heads/", &branch);
> > -		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
> > +	for (int i = 0; worktrees[i]; i++) {
> 
> I see that there are existing "int i" for counting worktrees in
> worktree.c, FWIW for new code I wouldn't mind if it's "size_t i"
> instead, to make it future proof (and to eventually get rid of cast
> warnings as we move more things from "int" to "size_t").

OK.

> > @@ -435,10 +435,9 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
> >  					  const char *target)
> >  {
> >  
> > -	for (int i = 0; worktrees[i]; i++) {
> > +	for (int i = 0; worktrees[i]; i++)
> >  		if (is_shared_symref(worktrees[i], symref, target))
> >  			return worktrees[i];
> > -	}
> 
> You added this function in the last commit, let's just skip adding the
> braces to begin with, rather than this style-fix after the fact.

OK. Thanks.
