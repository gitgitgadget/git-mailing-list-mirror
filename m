Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5665DC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 20:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFUsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 15:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBFUr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 15:47:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E1329173
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 12:47:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x9so4929880eds.12
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 12:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/8y+mGburF6W3WibiJ6cJUsf2hPrCqDsNbqm7eT0+s=;
        b=U1MYcaujyxJcLbaH76McuB9PpBpJlbA4Jrj23FbsztHroc4r93qsX4e35mlDqqCZRh
         4aX1UH1JrjCd4T9CDhHS683yqyzPILTnPfJ/gYOSfjEMgVNFhbFOBP6ir6mOrFJiddQL
         ubYsBejTif+5tB2bAFHsQGFOoZzj3kg/HxjCGdQQ1I1Sd+SKL9Yj7sg85sZ5RfORlY54
         uFYRuShicmE3nEIlew8L23uX595CYU5GZSV+OaKYt4hkY/5sGCG5BPHDcaqfWwT+8w/I
         k4KGO4y4uJ4QdQ/GZz2oddae//M32b66rema3YZbXmLXZNNSTd/Ep2Q/u41dk4HxOB0M
         S2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/8y+mGburF6W3WibiJ6cJUsf2hPrCqDsNbqm7eT0+s=;
        b=j7rXNWGWhEp9zRB5UM9VhPTcX/Q2omS1KLh3JvRwCZ3EKlcmUMxI2Y/mOxutVqJUHM
         z90+8jy1ygN9m1CKOWl38xrGXB4bKWm+NBhL5XnBB0lkLaYp5BtZNymixRIHV1T7tL+m
         ZGHqvGz4fJCmL26+azBum4HupYAux8OJ9yZK3cAe0FAywLAUV4QWBlhxIFZOEPGUImuI
         rVTJrFNID+GC61j8zR/r8pOscF5MKLSDVAt5P6mcl4/kJTxRXUED287BXLQhZEYm6joI
         RCPGtco++hPXjOam7nSu61qXbZuWXW1eu+drC40EIThqmZcRJatVs8eXXsX3W7ezeNRZ
         x6XQ==
X-Gm-Message-State: AO0yUKXsI5b6g42p6ajSDpRfFKfL86v6RSkhvP69XRyEvywJ5EZ0acJW
        gMSdAJ8W1t0BDx49y9Yfo1syBFQPp6ZVD5sc
X-Google-Smtp-Source: AK7set831sdrfB3rxi4D2yvbXLiAlEU/3SWBdeZ8azI5cMOfbc1dGv+8LU9xbxizpUwuyzIFMJ3Vng==
X-Received: by 2002:a50:d08c:0:b0:4aa:a36a:3e44 with SMTP id v12-20020a50d08c000000b004aaa36a3e44mr1012392edd.33.1675716474990;
        Mon, 06 Feb 2023 12:47:54 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id s3-20020a50ab03000000b004aacac472f7sm15161edc.27.2023.02.06.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:47:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP8P3-000VuW-26;
        Mon, 06 Feb 2023 21:47:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v8 3/3] credential: add WWW-Authenticate header to cred
 requests
Date:   Mon, 06 Feb 2023 21:45:49 +0100
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <149aedf55010718e22669575a148988eed0d8dcb.1675711789.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <149aedf55010718e22669575a148988eed0d8dcb.1675711789.git.gitgitgadget@gmail.com>
Message-ID: <230206.867cwu5xmu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>

> @@ -263,6 +263,16 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
>  	fprintf(fp, "%s=%s\n", key, value);
>  }
>  
> +static void credential_write_strvec(FILE *fp, const char *key,
> +				    const struct strvec *vec)
> +{
> +	char *full_key = xstrfmt("%s[]", key);

FWIW you could avoid this allocation if you just renamed the current
"credential_write_item()" to "credential_write_fmt()", and had it take a
format instead of its current hardcoded "%s=%s\n".

Then you could have two wrappers, credential_write_item() and
credential_write_items() (instead of "strvec"), the first passing
"%s=%s\n", the other "%s[]=%s\n".

Just a thought.

> +	for (size_t i = 0; i < vec->nr; i++) {
> +		credential_write_item(fp, full_key, vec->v[i], 0);

The {} here can be dropped in any case.

