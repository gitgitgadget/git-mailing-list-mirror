Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B3C1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 20:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2854F20753
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 20:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qZ6XBSj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgCQUjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:39:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44939 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCQUjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 16:39:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so12576820pfb.11
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=edYkysp6L/L7gQb/9QD/b7oqK2VIUV65C219GcW7aVc=;
        b=qZ6XBSj7ObWrLsiTKTokCVTI6GHje8BhcDfBCI56TrTBCkYLdfuAQCAaWus2+CSI6u
         e5IPWhTzbOolkABGrVUP1tkis0jTQnYmQE7sZMlHbifeU6taGdMaSo7oJJw2rp7Ocsvi
         AFrUbcZ0cj2UlLFumbb/HkLokgy/O+V0PRfs+0l38BBiWW4caIwxraK/sFNguTvDuvpR
         pgnY45WRaZAe5OE+qIYRZ33nPLCZ4lcdvQLLmyTJjAKMdM8x/93fDjDfYl72lcwv4vqS
         PQRo3idk93vBm9Ctx3cMkjlXpeMsNxs15CMAFv4jas4UfsSRulOGvJX0z9jD6KaNDuEZ
         n9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=edYkysp6L/L7gQb/9QD/b7oqK2VIUV65C219GcW7aVc=;
        b=VoJh7ObAw6RHhbxPz/hY48+HvyedeAmcFT94oe6bDH25/Q5sS2/Fz8OL77aX3HkiMF
         /GqLLubG129nNJvBxkP2iagDoWfCICBqvJJBcXyqmEMHiEjJM5diWZchngqrgv0Boc6g
         xW0A2D4lx+/YuoLxekgcnfbCVpAOeq28LxD1EnFUq2Ax958QXjOvZqkVVxBGyXttZo4n
         5pZ9QMXH/c7UwHqJE7oXOKN+9vQEycflVfwPuc3AWRy1hwrtSjNBkm0gontajgKoRz+L
         XpabmmCCp9nDzoGgnOYsDIuqXwnKM2gA8/18Uo0BTqpHyHwZoQRcJ+EOe3os0flgKJar
         zyDg==
X-Gm-Message-State: ANhLgQ2Invba7JXBlsboE7mEpSPfmGMpJJ8ptMVwVa5RD5+M9Zr9d/Vk
        ogEhv45LXdU3Kcr+r47gw2FnykFdGTs=
X-Google-Smtp-Source: ADFU+vt1xhCUqhNjOoBH0S6/vs1r/C9bxzgNdy7b+jIxcrIaNinTECnpvgO6BrX/PMy5p6kOsDqslA==
X-Received: by 2002:aa7:9f93:: with SMTP id z19mr610922pfr.187.1584477548155;
        Tue, 17 Mar 2020 13:39:08 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id p7sm265386pjp.1.2020.03.17.13.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:39:07 -0700 (PDT)
Date:   Tue, 17 Mar 2020 14:39:05 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, james@jramsay.com.au
Subject: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <cover.1584477196.git.me@ttaylorr.com>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Of course, I would be happy to send along our patches. They are included
in the series below, and correspond roughly to what we are running at
GitHub. (For us, there have been a few more clean-ups and additional
patches, but I squashed them into 2/2 below).

The approach is roughly that we have:

  - 'uploadpack.filter.allow' -> specifying the default for unspecified
    filter choices, itself defaulting to true in order to maintain
    backwards compatibility, and

  - 'uploadpack.filter.<filter>.allow' -> specifying whether or not each
    filter kind is allowed or not. (Originally this was given as 'git
    config uploadpack.filter=blob:none.allow true', but this '=' is
    ambiguous to configuration given over '-c', which itself uses an '='
    to separate keys from values.)

I noted in the second patch that there is the unfortunate possibility of
encountering a SIGPIPE when trying to write the ERR sideband back to a
client who requested a non-supported filter. Peff and I have had some
discussion off-list about resurrecting SZEDZER's work which makes room
in the buffer by reading one packet back from the client when the server
encounters a SIGPIPE. It is for this reason that I am marking the series
as 'RFC'.

For reference, our configuration at GitHub looks something like:

  [uploadpack]
    allowAnySHA1InWant = true
    allowFilter = true
  [uploadpack "filter"]
    allow = false
  [uploadpack "filter.blob:limit"]
    allow = true
  [uploadpack "filter.blob:none"]
    allow = true

with a few irrelevant details elided for the purposes of the list :-).

I'd be happy to take in any comments that you or others might have
before dropping the 'RFC' status.

Taylor Blau (2):
  list_objects_filter_options: introduce 'list_object_filter_config_name'
  upload-pack.c: allow banning certain object filter(s)

 Documentation/config/uploadpack.txt | 12 ++++++
 list-objects-filter-options.c       | 25 +++++++++++
 list-objects-filter-options.h       |  6 +++
 t/t5616-partial-clone.sh            | 23 ++++++++++
 upload-pack.c                       | 67 +++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+)

--
2.26.0.rc2.2.g888d9484cf
