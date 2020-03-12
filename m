Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF786C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AC3206B1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA6o2EAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCLRvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:51:55 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38971 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLRvz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:51:55 -0400
Received: by mail-pf1-f182.google.com with SMTP id w65so3617488pfb.6
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zOye7mNh+mi/Ag5h5ryyY55OX9RihSdnEKtJjBmJqs0=;
        b=AA6o2EAJaMjQB61ZskZUF75OBFcXBIb9KuQIg+ZgBUzBh+5Zb471e3TS4WeF9VTng6
         YVp+iFquF0cTALFm8QYxokGI91KQ96mM3aE1ELYNto3Wonxbh+1YX/UaYvgnWXesISat
         r5ZUYaVgdxPQYq4YBuOz7h9nAR0wUHlU+Fj2LoiotBVN7MH50BQ/VktR4TPR/eL6VUIm
         cA0opujFavUNM02mDiaoKcgm0YO2RLdSP/LsipSJogZoZt5osQAJ1e991gK6jlw81hdo
         OqLxEG5guaGZGGYSqifiBZePuP9LC264VLQd39ufpEvtrfddfppoqZgIz9XGgjjEcb+e
         TGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zOye7mNh+mi/Ag5h5ryyY55OX9RihSdnEKtJjBmJqs0=;
        b=RYtIeuSRl8RC1WTPnjeh4kmTqM1LCvsl/9sytryJKsn+PPS3/3o6jcgrcKU0IXU6UM
         WKYwgoXOwPee1b/DTQGfySSaIcw90vzdIX2/IWekuNTf0vcD7Xdx79aWjutlITpmtlCs
         9BCOpe3KA8hmxAK6CCKOCc7Hv9PkPAIUUKa1IHQqNMp83HQHGnYl5us9X8EoaKWzsTq7
         afVWnFulVuc4vJ5xjfSmrc16BvYYd2xx3DCv2i3y/UoxbwAq4l05AHqVxJtTNDGfx/8e
         /ycn5T/xQZQi3J01Jr1ZZRog2TJBoMRh0J5rdjEdVwJoGtwkdP9vVn2sUONT4yvf5GTA
         CEhA==
X-Gm-Message-State: ANhLgQ1/1orKhGHtn6zamyIFTxnnw5vJJGwvIne6cAx8PSh88sE8NzrX
        HG8PToh/0VmWczx/lFH4Vc048n/W
X-Google-Smtp-Source: ADFU+vuyEUO0xItzYKANlNgPIP8ECiki8w3lRNEA3r8YBwWJV0MtsJ7rCp08uXOSrOlR8bbC0yLKgg==
X-Received: by 2002:a63:2542:: with SMTP id l63mr8760718pgl.312.1584035514050;
        Thu, 12 Mar 2020 10:51:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z17sm7405824pff.12.2020.03.12.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:51:53 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:51:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     stolee@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        christian.couder@gmail.com
Subject: Re: [Question] Is extensions.partialClone defunct?
Message-ID: <20200312175151.GB120942@google.com>
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
 <20200312170714.180996-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312170714.180996-1-jonathantanmy@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:
> Derrick Stolee wrote:

>> but it appears that we rely on the "remote.<name>.promisor = true"
>> setting instead of this extension.
>
> Hmm...besides giving the name of the promisor remote, the
> extensions.partialClone setting is there to prevent old versions of Git
> (that do not know this extension) from manipulating the repo.

Yes, so the lack of setting is a bug.

Christian, what would your prefered way be to fix this?  Should
extensions.partialclone specify a particular "default" promisor
remote, or should we use a new repository extension for multiple
promisors?

[...]
> I cloned and indeed it is as Stolee describes. Git still works as
> expected if I remove "promisor = true" and add
> "[extensions]\npartialclone=origin", so at least extensions.partialClone
> is still supported, even if not written by default.

Thanks for investigating.

Sincerely,
Jonathan
