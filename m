Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3675920179
	for <e@80x24.org>; Fri, 17 Jun 2016 13:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbcFQNDP (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 09:03:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35628 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbcFQNDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 09:03:14 -0400
Received: by mail-it0-f67.google.com with SMTP id e5so10676890ith.2
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 06:03:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mvi6TdQzfDW4YlJbyYmBdHWdIULUp3zul6s0ujq1al0=;
        b=rNTiD3L87E6mh+o5gWdOThzAbLJ5CVgvDYAxMcQGcAoKiLx5vJP45WiX8SH83WEJjM
         BWsu4GstO0xKtfKoAnqKuwAyuaY2RA91HM0OyL+wIkjfppCmvPHxNDi1DPMplYnzoIgo
         2cVQyO/lEj1BfjZ3lR5kXKUeNIrnA/On59QO/UAzPEeqX/ndpT3iyZHTD2XVJLd4aivo
         X4gsfIUIYcP2uWQozoNwEkqoJb38NIe6P0LOlpZ0v9NzzYYBzTlBnCFK6OA4+J/y9mze
         k3WuLqMtf5FIQ9oG4gzA4yfGnI/f82Wmp4LPQteKE7ozIP0HnJmaNnrP4j9Rb/zzFCGf
         kl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mvi6TdQzfDW4YlJbyYmBdHWdIULUp3zul6s0ujq1al0=;
        b=gisXSOoNYLNSXbGx+FoeOJrkG96li5WJB4hduO99wyPQnzQD9TRggztG1MlQVOQ4Yf
         6nnzVOuz8Li9Z7jXRNOyzPvpXLrg+oD2vicwO/6hhHT/MV6j+6aq/jD62s72DOZkGiEt
         HyhGFTqDR8gyJEVJkpxMXyU+r8nl5F8JU9WHFu2l+ZyW3TpZ8IfdC4J/pmQe47DZpgGu
         Lm+XsI78cjpZ6jOu2yvQUtJvnUwfOt6cNE0Vz2XCj/5E+CIab0LP6sW3bQVk0EyBmNHi
         uSCG+kCD3OwwsYQCD6499lcG1Z7aVxGXJDhjrZTvdL5wX4ZmAORO3DN7aEFC1wKCEx2I
         HOig==
X-Gm-Message-State: ALyK8tLnq6kUCZXNOTQL6G/mDjhwJv3MQNCFbgtow8KLIA5o9VqnZJEjkY0BHbLY8m5kchDSNGX2GLTzKzrvvw==
X-Received: by 10.36.80.139 with SMTP id m133mr3138780itb.63.1466168593456;
 Fri, 17 Jun 2016 06:03:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.173.167 with HTTP; Fri, 17 Jun 2016 06:02:43 -0700 (PDT)
In-Reply-To: <1463694357-6503-12-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-12-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 17 Jun 2016 20:02:43 +0700
Message-ID: <CACsJy8DzyvFOHU_8xoWUcjej=Ws7_v475=Q2iZmwKhkzYaZ7sg@mail.gmail.com>
Subject: Re: [PATCH v12 11/20] index-helper: use watchman to avoid refreshing
 index with lstat()
To:	David Turner <dturner@twopensource.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, May 20, 2016 at 4:45 AM, David Turner <dturner@twopensource.com> wrote:
> diff --git a/read-cache.c b/read-cache.c
> index 1719f5a..8ec4be3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1235,7 +1235,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>                 if (!new) {
>                         const char *fmt;
>
> -                       if (really && cache_errno == EINVAL) {
> +                       if (really || cache_errno == EINVAL) {
>                                 /* If we are doing --really-refresh that
>                                  * means the index is not valid anymore.
>                                  */

This looks really odd. I don't see why we would need this. It seems
first appeared in your "do not apply" patch [1]. Maybe leftover?

I found this while re-reading the series and I have not put much time
in studying this code yet. So I may be wrong. I'll post again if I
find that it's true after some more staring.

[1] http://article.gmane.org/gmane.comp.version-control.git/288567
-- 
Duy
