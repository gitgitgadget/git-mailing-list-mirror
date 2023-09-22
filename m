Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2662CD4846
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 17:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjIVRio (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVRin (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 13:38:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DA102
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:38:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-417f872fb94so7091201cf.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1695404316; x=1696009116; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM0D12zQv4BFbbxSJJK/jFssJtAU4n7aCZ5HCCmU1wU=;
        b=fBeoWkjzqix5W+NDqJVf+3/bpbvgIZ0cM5PT7pk2pyeVZceyR5KXjzbFd0VctF8oZP
         Xcbz9uTvLsc1SSrBYAGKWjYJjEgthxQgn4MDIUkVVWhGxbmTLhGSIy40qqV0yYTLdj0x
         UWnemX19VP8vUIseGyx0kJbR145DoJHrmwf7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404316; x=1696009116;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM0D12zQv4BFbbxSJJK/jFssJtAU4n7aCZ5HCCmU1wU=;
        b=B0T73yZSdMQEpMbEqplcReFIXnCExknwdaefd7jCG/alM5a1Ti+9KjisqLaxjSiAyZ
         YP+zPJHpm0gyjqTsBnKlfPvf6H9ts/5APcv9Gd15swO7D/sAxqF4P0VV6FxB943K16LO
         CIgVRNvndCp9ATZNqnv7rsa8vRsxOJ4pjWrPEeLoUQaXWPxSiRr7pnSV5PIShLcWFjOM
         7k/woAhgAZBdOnXgEul4MCLJqulurlNKjHkNTJodvmtMKpTIcjltqGGuDvSG6YwHJ7HI
         IUw7OqbG+CjdxU9ot8BUdMLP05xdMaTs4LBQmTSp6xOqSJ2qLDkMgurY2LgKWqF1PQUF
         9HBQ==
X-Gm-Message-State: AOJu0Yyc1CaCHXlzvKJGFcd6D4u1W54IOwadUEgjCbT2dCQWNVx7ZgGa
        Dcze4yvVJoQeV61fVLK+POT0MgK+YiC3RDnaD3W0ag==
X-Google-Smtp-Source: AGHT+IGBNDz8Tm/52Zv1SZVGl62J1YPe8UwIqKVgWLohft5AbMIrRk8um2SRbqsTKOBf7Ty2dcRRow==
X-Received: by 2002:ac8:58c3:0:b0:412:7ba9:c7f6 with SMTP id u3-20020ac858c3000000b004127ba9c7f6mr173549qta.5.1695404316154;
        Fri, 22 Sep 2023 10:38:36 -0700 (PDT)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id vu17-20020a05620a561100b00767dba7a4d3sm1575210qkn.109.2023.09.22.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:38:35 -0700 (PDT)
Date:   Fri, 22 Sep 2023 13:38:34 -0400
From:   'Ben Boeckel' <ben.boeckel@kitware.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <ZQ3RGgEt8nPdTvv3@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe>
 <ZQ21NsLmp+xQU5g+@farprobe>
 <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
 <ZQ3GAJ/AHsM9e9a6@farprobe>
 <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 13:14:30 -0400, rsbecker@nexbridge.com wrote:
> On Friday, September 22, 2023 12:51 PM, Ben Boeckel wrote:
> >On Fri, Sep 22, 2023 at 12:13:00 -0400, rsbecker@nexbridge.com wrote:
> >> On Friday, September 22, 2023 11:40 AM, Ben Boeckel wrote:
> >> >On Sat, Aug 12, 2023 at 15:36:56 -0400, Ben Boeckel wrote:
> >> >> I found an issue where `git describe` doesn't find a "closer" tag
> >> >> than another tag as the correct one to base the description off of.
> >> >> I have a reproducer, but I'll first give details of the real world issue.
> >> >
> >> >Bump. Can anyone provide guidance as to what the best solution to this might be?
> >>
> >> Can you provide details? `git describe` is sensitive to --first-parent
> >> and whether the tag has annotations.
> >
> >I provided more details and a reproducer in the original email:
> >
> >    https://lore.kernel.org/git/ZNffWAgldUZdpQcr@farprobe/T/#u
> 
> As I indicated, the command is sensitive to --first-parent. For example:
> 
> $ git describe
> v9.3.0.rc0-520-g1339e86833
> $ git describe --first-parent
> v9.0.0.rc1-5143-g1339e86833

Sorry, but this is just even more confusing to me as neither tag is on
the first-parent history of `HEAD`.

> You have multiple parents in your tree of HEAD. This is probably
> confusing the interpretation. The most closely connected tag to HEAD
> is v9.3.0.rc0, from what I can read from your tree. Dates and times of
> the commit do not participate in this determination, to my knowledge.
> You can force selection of a subset of tags by specifying the
> --match=pattern argument.

I don't see how that is possible since v9.3.0.rc0 is v9.3.0.rc1~2. Note
the "not on the tag" commit count for the descriptions being wildly
different.

> There appears to be a merge at 446120fd88 which brings v9.3.0.rc0
> closer to HEAD than v9.3.0.rc1.

That is still giving an incorrect description as there are *fewer*
commits not on rc1 than rc0 relative to HEAD (as rc0 is an ancestor of
rc1).

Thanks,

--Ben
