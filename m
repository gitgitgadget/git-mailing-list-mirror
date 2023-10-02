Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9712E784BC
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjJBPVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbjJBPVH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:21:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA6FA9
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:21:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3af609c4dfeso3586705b6e.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696260064; x=1696864864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8gccuF8Nu2YvavIEoT/JeDASATPJmn9aU891bFWU50=;
        b=EC8sPpjYKr+edzaOEyZFQrKhLNkiN4TvEgidG5IhpBqF60twt+4VoOd0FGM9JpcBur
         f1f7BkbW3WYkpn6h2Sm4H9KpeZ+NRdjAu95ksbjBaNDlfJLqnDtoUam/zv4mfiC0yac0
         F+j4gRCJGFtaP08A2uGJn7tRj0Lu+idKo0/7099wZDbwCn1Dm6Cc96N2lpuDUmxm2Tzp
         oFxDqzwCR8wDeYbziVPlnlPSrmnWDpVst/2MMbKtx6O3e0IIPp7iBkkQpJwvVErPoFtJ
         A15E0LsmPkk+ZTemxUPm42obVhtmsXfKFHEfgwtXoVBWr0RjbLVEr+2N1+g429poBd7E
         ThAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260064; x=1696864864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8gccuF8Nu2YvavIEoT/JeDASATPJmn9aU891bFWU50=;
        b=Ic9ZJgJgsSeMqjwqKoMqsHE0/2nU0pjh1JOtihGSmoKIy7UbyKa18GvDLYvyMZ802e
         rvXRHqesLMgcV45U93aphsDBVGNnKdDvUvsjxln2cGfgCK14ZxNYBHSoDLpj30e4rSGj
         SXBtCQ7TwJt4AGlzGrP0cXJmqakFTMTICwG7GU7IjdE0V2d1ZuUKuHWb/s67Img3o/T/
         JQzfh6QwZuXry5bvMK6mS2Lu5QTAwb1MdoP11uUMh13GdEumKFYnIHm0/xHWAKFYARke
         u3eDAvPN9XnVNRMXn+A/wqisQfxalzHVdol8P4BM78OEAkyAAURuZUwntu38KtSOvSLp
         GFDg==
X-Gm-Message-State: AOJu0Yy2tTs18XMeKRP7UsSGmqyNDctx/O8tkoBHByxVLkfRhSeSIRSg
        QUkE8h5qdylRDeEgoRIF+/ZfMfRbB//gNfX8u4fXRQ==
X-Google-Smtp-Source: AGHT+IFgBXNpTedYOxMeVv3dVofQdDXqA5dORTCHnMQH1fMugt6NaVPdqRU1eyCOu3acWDXDeyXyng==
X-Received: by 2002:a05:6808:d49:b0:3a8:74bf:8977 with SMTP id w9-20020a0568080d4900b003a874bf8977mr14041740oik.56.1696260063779;
        Mon, 02 Oct 2023 08:21:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x9-20020a0ce0c9000000b0065d051fc445sm3968116qvk.55.2023.10.02.08.21.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:21:03 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:21:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 7/12] Authentication to new hosts without setup
Message-ID: <ZRrf3ntvh8y0VkYy@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: M Hickford, Notetaker: Lessley Dennington)
(Slides: https://docs.google.com/presentation/d/127xue1Sr19J1m6wk1KwY9-5G1lPxbyHOgaIi2Ro12ts/edit?usp=sharing)

* (Hickford) I interact with many Git "hosts" (GitHub, GitLab,
  gitlab.freedesktop.org, etc.). I had 15 Personal Access Tokens (PATs) around,
  which was tedious. I was using Git Credential Manager, which has an option to
  authenticate via web browser which creates a token. I released
  git-credential-oauth with this feature which you can use with a storage
  helper. I'm going to show an example of authenticating to a host I've never
  used before (Gitea). Demonstrates signing into Gitea via web browser and
  cloning his fork of project xorm/xorm. Since the repo is public, no
  authentication is necessary. Makes a commit and pushes. Auth flow is
  triggered, provides consent. Authentication was successful. There was no need
  for PATs or shell keys. Git-credential-oauth supports GitHub, GitLab, Gitea,
  and Gitee out of the box. Works using new(ish) password_expiry_utc attribute
  and wwwauth[] headers.
* (brian) Thinks it's a great idea because it's convenient. github.com/github
  requires SAML/SSO and the browser, and this should work just fine. It wouldn't
  be great to have in C, but as a helper it's super convenient.
* (Hickford) Ruled out a C implementation due to the challenges. Goal was to
  remove a barrier to entry for contributors to OSS trying to make bug fixes and
  having to set up/deal with PATs/SSH keys.
* (Jakub) Still work to do with creating a fork, pushing.
* (brian) GCM does this but represents a greater barrier to entry for less Git
  literate users. Less beneficial for Git power users.
   * Edit: Lessley and brian spoke after the meeting, and Lessley realized the
     above was not recorded correctly. git-credential-oauth and GCM both remove
     the need for users to manually set up PATs/SSH keys (which was what was
     being considered as the high barrier to entry).
