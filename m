Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C99C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A3520888
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTs6gWqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbgE1MVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389213AbgE1MVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 08:21:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84866C05BD1E
        for <git@vger.kernel.org>; Thu, 28 May 2020 05:21:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y11so3211969plt.12
        for <git@vger.kernel.org>; Thu, 28 May 2020 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uqKuJXoIYZCIe38F7o8Q3bJDHZEd2zu63y8I1xHGub8=;
        b=DTs6gWqIrgf9fPjiwV71k9OBaYWzrR845AvvElKU9OXoP7UBTK94Cdu2dEtyKmXwfg
         pJoTYZ4rC4m8tOJQg8motbwe6GP8IwOciRoq30V4Uy/GY/lHIE8ehL+gqsn8hHu4xbaL
         YksvH/RRP16e3MUNCuv9d6gRgv9/qGSujzTj06A9qWAnP53kQ5ZNmfqMPjfoUDU28i1i
         +6iXevkob1A2D6x4GgKFQha63PDJ6SBvL6NvkyAQFRNR7oZmYtzS2VOR09zAQYlKCUnO
         YU014EDQRGThZ/zCSwnRdTzaCFLcmYU7PQaPyEEftZqJHP+EH664ENBasRrNqK1uzZfO
         zgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uqKuJXoIYZCIe38F7o8Q3bJDHZEd2zu63y8I1xHGub8=;
        b=hfvaS3TckZ2q3W7K1ykWJEcEk/pZkAWHhQd1S6t+tNQIGatWwbCI0IjHuCPn0qlMVr
         AgMoNMuRAWmMSTBhayJNt9uUfsz1DXJHPIEoIdGZAFtG/WmOT5UPRN7lJDkKj9tcF/es
         jrIxomyBmUSj73HNIg4fm24EkxvZQL1sANPvixqU2cKutM88WzPYABObGrqOEvqgf7W1
         q/c3eUbb6Z+Yt0EkS6NeQ6j89FMBkX6XevD7iB6b628PeYDWGlTsSBqYVtFIKwFEh3fL
         gT7S3LozMRTz12FdWXOFSsqG6acdKRW9tkW5+ft4k8gcX3JaTR03zUyuBGRjfEhI7QR6
         LuJQ==
X-Gm-Message-State: AOAM532fUXIKC+7LW5l+JtUaMp2kW5c4oIXIIGKxW6uUI2oTeOoGrOX0
        km9JGGQ/DAWRHWU+lOwM6vw=
X-Google-Smtp-Source: ABdhPJxnfKHCdtKzHunayf+q7SS4wbDwzjQVRyZ0msRUj+a2TJrMrSJ9WI9bIAublB4lLks4KWRdDQ==
X-Received: by 2002:a17:90a:c28c:: with SMTP id f12mr3183709pjt.152.1590668511020;
        Thu, 28 May 2020 05:21:51 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id q28sm4781604pfg.180.2020.05.28.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 05:21:50 -0700 (PDT)
Date:   Thu, 28 May 2020 19:21:47 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200528122147.GA1983@danh.dev>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
 <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <33127873-fb19-2bd5-3028-bcd1757e92e5@gmail.com>
 <20200527171358.GA22073@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527171358.GA22073@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-27 22:43:58+0530, Shourya Shukla <shouryashukla.oo@gmail.com> wrote:
> On 24/05 12:19, Kaartic Sivaraam wrote:
> > As '--quiet' in 'set-branch' is a no-op and is being accepted only for
> > uniformity, I think it makes sense to use OPT_NOOP_NOARG instead of
> > OPT__QUIET for specifying it, as suggested by Danh.
> > 
> > Also, the description "suppress output for setting default tracking branch"
> > doesn't seem to be valid anymore as we don't print anything when set-branch
> > succeeds.
> 
> I think it will all boil down to the consistency of all the subcommands.
> Changing this would require making changes in various places: the C code
> (obviously), the shell script (not only the cmd_set_branch() function
> but the part for accepting user input as well) and the Documentation (I
> might have maybe missed a couple of other changes to list here too). Its

I don't think this is a valid argument.

Using OPT_NOOP_NOARG doesn't require any change in shell script since
the binary still accepts -q|--quiet.

The documentation of --quiet is still valid (since it doesn't print
anything regardless)

The only necessary change in in that C code.

> not that I don't want to do this, but it would add unnecessary changes
> don't you think? I would love it if others could weigh in their opinions
> too about this.
> 
>  > +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"
> 
> > Danh questioned whether '$branch' needs to be quoted here. I too think it
> > needs to be quoted unless I'm missing something.
> 
> We want to do this because $branch is an argument right?

We want to do this because we don't want to whitespace-split "$branch"

Let's say, for some reason, this command was run:

	git submodule set-branch --branch "a-branch --branch another" a-submodule

This version will run:

	git submodule--helper --branch a-branch --branch another a-submodule

Which will success if there's a branch "another" in the "a-submodule".
While that command should fail because we don't accept refname with
space.

-- 
Danh
