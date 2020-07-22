Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227BC433E1
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 09:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BF1206D7
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 09:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUyYHZTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgGVJVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVJVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 05:21:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3228C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 02:21:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so1249597wmi.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W75sYla/AIFaa/u7fWi6qNwu9vbEHWvLL1OZJTTbL7Y=;
        b=OUyYHZTE7Ftf3NEmiOyRkJ4s8YlK5AI6FBdSIKzCtrgaQ9cdzZUm4569Tbr5MoAjmZ
         lSYawv3+bm5p0vnI4wzWZrS7mlVUjfHnF12lYUf4hDgy0TGn9NMK4mix1DYebhCT6ujs
         +GwlpRGbm4OVKqyYyypYZFH3GBr075Jc+x1Ms2+9JeuasIEtoiKK31qrwIS1pPXCNyj7
         e88XbszdCIFYqaEQkg5BepcXqSday30eR/ma6G+vLp6sQvrzMdTX5BMQ50HptILVct5G
         NPqbqCAMcru+Oz5UiD4NXYjqbkpxR1kQ1Uo23kvR/lFrG3ssGR1/W5uWrG3djHCg6y1q
         ug8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W75sYla/AIFaa/u7fWi6qNwu9vbEHWvLL1OZJTTbL7Y=;
        b=iPMdCvQ0YeU0kNr0rhZXJ6PRXY+XnI8fPiiMYOF2rKzZi06TzY4EERQIF4Sz/skbC+
         RZAj4fLrfxiumP3yAsATizlnP9iNs7xUchwLds14rVnuQXHW9bVquLLna+tKVK1z75Nn
         3Bfjqv6jYDIvsoNuDLgCkN6QSG1x+PdASqsys4pJEgW6oxB223fTg+epIt4YkwxoekL3
         1IwFkeQxrX8f0mmYA/mxtQyL9h4gEmN3Lp74SylR8U1JztR3FF9gDyuPFPpWZh3iDRRL
         g85gMgynr+zazommr9P5ySW+GE45CFOsiGJ3LxtIPF4MFUI0x+gTtSdA5GeysHouXEQD
         aOyQ==
X-Gm-Message-State: AOAM531R5oi4ab6dq1HwjD7BxYsQXqnYAjlFyrZhdRFthrd9XNAvvLFa
        51KfMm2PUuxtfC918CpR3JF4IiZ6
X-Google-Smtp-Source: ABdhPJzkJN0YLRTzWJOEL2trjaljcjJM0feeVEw/S68qdPIOWx82LUZZBjBE8aYvzAtDOUwEGNXE7A==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr8253176wmb.151.1595409691539;
        Wed, 22 Jul 2020 02:21:31 -0700 (PDT)
Received: from szeder.dev (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id l18sm41715257wrm.52.2020.07.22.02.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:21:30 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:21:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200722092129.GK11341@szeder.dev>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 02, 2020 at 04:06:32PM -0400, Taylor Blau wrote:
> +static void die_if_using_banned_filter(struct upload_pack_data *data)
> +{
> +	struct list_objects_filter_options *banned = banned_filter(data,
> +								   &data->filter_options);
> +	if (!banned)
> +		return;
> +
> +	packet_writer_error(&data->writer, _("filter '%s' not supported\n"),

Should we really translate the content of the ERR packet?

> +			    list_object_filter_config_name(banned->choice));
> +	die(_("git upload-pack: banned object filter requested"));
> +}
> +
>  static void receive_needs(struct upload_pack_data *data,
>  			  struct packet_reader *reader)
>  {
