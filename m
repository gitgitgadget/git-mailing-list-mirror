Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C39AC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbjEKRPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbjEKRPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:15:40 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0A65A7
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:15:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ab1e0420e8so1420593a34.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683825338; x=1686417338;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR0cugBh5j9QpsvWZa39da+wfkUnnU7ZmoYyQ1lG5YY=;
        b=iZ+z0TJseuxXG0qy5wS3e9FauopKCsljX4p0iLsxZv6GcYv4kGnhasNxnUHk6NNvwO
         BtIbes2lus+WOTxzVvNym9mkG2YzRW5/zQcaYuquD0Ipn86697wmd9RDuSmpwCf29At7
         4EwQNROVgAUO9HStJyo0YnTqPbhCfhXR7CqRsJVSCbtrEePYZEsAvDGwjc7L5tiR/zRB
         yKiojQMIc0q0XHC1dUiCyFq+tKo7hdhf7Gs8iO4ctqOCiuC6Fj3mUSm18/w5nqb9pOge
         YaiVDKOsV6m+CNUgpZXyryOZITy9Fc2+0pzO8jeAKOAaD2AWXN6zswx38s7Hj8O2PfZO
         XThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825338; x=1686417338;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SR0cugBh5j9QpsvWZa39da+wfkUnnU7ZmoYyQ1lG5YY=;
        b=FX6A1zzpQpHwnU/5LxUvInaRw2bJssh+LJeoggwp457DlYgxJCyDaqQHT26MV4ESu4
         Ymc3LDVtnNSLbIzMfCe6vofY8aq9WvUJZXkLXAgNPpwNtL+SqkmVfnQQOqKf0/gm4vR+
         ErXME0lGilYEFC9VVwB9v0VFN3HOdrCr1UnC3wPuVyFZ9CKhoqtL2Bw/dZoe5TPTdBGg
         rM9CjcwraU0FkJA7W7I/VRjn3WXvvUrgy8JQOBYTnde2DvaVvsaTfC4e+CDoQcT8Rm0u
         e1lbjfLVswvQprsaSsLlMZZa3nDkaOtX03MYgcnCWsSwfLnKTm/FP1sc7KPlDEwY+024
         Dakw==
X-Gm-Message-State: AC+VfDyadzJWTkHMPnYv1zMhLjS/eb0e4NylQJgRJwmnB1ZGGM0c+4HZ
        oxPsmkWyFSxOBB+YJb+hhso=
X-Google-Smtp-Source: ACHHUZ7Zr0tRbrkdGgBJyEKS172Y7lLuKmdpaMcdn+WZGsFxcsp3+iMPFVfdX6/LV/VRuKpueFI1vA==
X-Received: by 2002:a05:6830:1e1b:b0:6a4:3e49:9eb2 with SMTP id s27-20020a0568301e1b00b006a43e499eb2mr4757793otr.19.1683825337918;
        Thu, 11 May 2023 10:15:37 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i3-20020a9d6503000000b006a44a70beafsm7542619otl.25.2023.05.11.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:15:37 -0700 (PDT)
Date:   Thu, 11 May 2023 11:15:36 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <645d22b8c6346_26011a29478@chronos.notmuch>
In-Reply-To: <xmqq5y8z3jif.fsf@gitster.g>
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <xmqq5y8z3jif.fsf@gitster.g>
Subject: Re: [PATCH] merge-tree: load default git config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > The fix is simple: load the default Git config in cmd_merge_tree().
> > This may also fix other behaviors that are effected by reading default
> > config. The only possible downside is a little extra computation time
> > spent reading config. The config parsing is placed after basic argument
> > parsing so it does not slow down usage errors.
> 
> Presumably merge-tree wants to serve a low-level machinery that
> gives reliable reproducible result, we may want to keep the
> configuration variables we read as narrow as practical.  The
> default_config() callback may still be wider than desirable from
> that point of view, but I guess that is the most reasonable choice?

If you want `git merge-tree` to not call git_xmerge_config, then why did you
merge 1f0c3a29da (merge-tree: implement real merges, 2022-06-18) which
introduces a call to init_merge_options, which calls merge_recursive_config,
which calls git_xmerge_config?

And BTW, the way merge_recursive_config is implemented is completely different
to how the rest of the config infraestructure works.

-- 
Felipe Contreras
