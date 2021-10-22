Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE13C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BA361213
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhJVWbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhJVWbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:31:03 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68630C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:28:45 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h2so5793022ili.11
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WbWELKze5F/DGAGUHOyBUtQF4jivpxwlqL0cazXAFrs=;
        b=sSWlb2R0jFZF6V+nY8AxnDHTLqBCgxHne+OZio7l6JsyvFHFLYeN8U86mf0PWtXKG/
         bQrJjpANJhKjKemL+VORxxij6aSNc5ogcdjEsQ7p3zHkNBGjJILye9i0jPxXOJNL/0mu
         maPMG3kWNIDjtw2Krf88Tj9F3Kfrx8v7FZ0ujFv5IQycm7Hj/0hAJoEx2Hda1ctv7hCP
         1gCmkxFlPz6JaVTJNiFjb9qYvCaKsqvhl0n6RP9u41paGIHIi6TsX18TjBisGcIdjbl3
         TFtsNZSlodY37wTE7CBt7B54h/OVgGXO4lOb8ban3N3LsOcLpMHf/q0ABsOs0+fOtEGB
         BNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WbWELKze5F/DGAGUHOyBUtQF4jivpxwlqL0cazXAFrs=;
        b=rPD7hKJahJ3B1QxmrqyIbObqrrHONAPbewYHlkn2KYcgiQpGszJEfgFI7ii7dUz6/X
         IlO/+nCk7uNYX66iS7jqwaHPA3C5Au2TneFIiem7LgcTC31CVlKIAy2tZowOEOSBqpkq
         x/AjeLs70X9j2IIq6pP9dLFBjeDew0+sTphjUqUNQmBlibkWw+dNr3AUbe2XCtBWxCZ+
         M20am/2bo/F2489la6CEc4VZVLPCUjwKEjIRcap1N+HV0oDcRkpUkVZjByts2bMZKYZC
         vmCETgXYXyLhxq6SIl29R2/Jrb5OK/ViD7Jp3us4ohX1wF8GP7xy0lH95zYPh1rwPw/g
         kJ6g==
X-Gm-Message-State: AOAM5323/X1Is7vjZkP045tmVkORLDUBJa2R1MkbHXKfocMa+0QrcD9j
        7dJqVsJwfQ995DVFSnEsEEGp2g==
X-Google-Smtp-Source: ABdhPJyDMKLbkWqLRnbjHHawGFvRDFYR+R/us42NG0PZW11r38nRe866XWUe9r5v9vfVubBtHBajFQ==
X-Received: by 2002:a05:6e02:1a86:: with SMTP id k6mr1620002ilv.192.1634941724848;
        Fri, 22 Oct 2021 15:28:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4sm4747464ild.52.2021.10.22.15.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:28:44 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:28:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 06/10] progress.c: call progress_interval() from
 progress_test_force_update()
Message-ID: <YXM7G22L+te1k3eV@nand.local>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-06.10-c7c3843564e-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-06.10-c7c3843564e-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:22AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Define the progress_test_force_update() function in terms of
> progress_interval(). For documentation purposes these two functions
> have the same body, but different names. Let's just define the test
> function by calling progress_interval() with SIGALRM ourselves.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  progress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/progress.c b/progress.c
> index 893cb0fe56f..7fcc513717a 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -216,7 +216,7 @@ static void progress_interval(int signum)
>   */
>  void progress_test_force_update(void)
>  {
> -	progress_update = 1;
> +	progress_interval(SIGALRM);
>  }

I agree that the pre- and post-image of this patch do the same thing.
(And not that it matters, but the value for 'signum' could have been
whatever you want, since progress_interval() ignores it).

Is there a reason to make this change other than to make clear that the
two do the same thing? It may be worth calling that out explicitly in
your patch message if so. You kind of do this, but I'd be as explicit
as:

  "To make it clear that progress_test_force_update() is a synonym for
  progress_interval(), define for the former in terms of a single call
  to the latter."

I think your second sentence says basically that, but it took me a few
attempts to discover.

Thanks,
Taylor
