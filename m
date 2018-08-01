Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4906A1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbeHAQ5D (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 12:57:03 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56062 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389462AbeHAQ5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 12:57:02 -0400
Received: by mail-it0-f66.google.com with SMTP id p7-v6so10077795itf.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdevODqjuqGNAzz2Kk8IUxS3Eic0wlcTVY3zmN04Gjw=;
        b=JuNH/ojnTLyzU8rdm1izoRtTMNbt1ithfnWSsVb6EfJbrh0wn2bSp3Iv8TBde4uHjB
         aEIOD4hTYdTes9kkBN0Gk/8wNF58UE0fQ7fyIoRkoI0PYv8FsZlO064c9CowdafQEAS1
         7SxgHZyZYLltZV4qaQ1J/oIqWo438t/b5FolA6faQErhZbhDhwt18IF1u+JEJEz7SAza
         aa6fOL0e6zU1NB2mcvNuifrb3dUxRaZxui9k21TfTOzkXv7pqLw14XKU6CvaXGHMwZ7t
         VEvjDLCebigZKm5VXTR/ApogRCAOaLZGiaT3Hi3HThAc+KYFAmyX5k3J/c7vAZIFPJPv
         W45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdevODqjuqGNAzz2Kk8IUxS3Eic0wlcTVY3zmN04Gjw=;
        b=O4SJCC+8x/Zj3fD3sjgTcxSdwjsUCO6E2/xezmCrLkh2iMAcRh+fe9I8hDFE1Dek2t
         fP1b0aaHlhvv0EkaiulP2aRWyay93AslBgj0mEfmXWzPCEoRSpLnf+dvzv6nnsWGZg/Q
         GZdZwoOwKKAObbe2VMSoB81eWBYC49wKPjm1Lf4VrZOIayRU6lbqCfpIgVik6x+cKiJB
         vbbW10gTNE8fAeWQjxAf354cxHdMWArtwwQ+P1PNFJSgoh71nsp87zMEACBOQ/cPf6Xd
         uCIQdkOUSSplduOCmThuvS1+JLA6531C33wODr50yTL0U7tRGZphye8K1e362oH2qh6D
         9aqQ==
X-Gm-Message-State: AOUpUlGb3YoPVYgUss5ZR25xE1NT1uwpVgpEqoZSgSRmxBnhX2f2A2O9
        7qk2O8x3kq0sHhDwPE2JIBfEaZq/hTmEaF6g4II=
X-Google-Smtp-Source: AAOMgpdPjB2w6QvlH+vlnY1mKdSoAAFgun3NqX5tT4m/213Iu5Pu1i9GCaUlvD5RIIiE/PYt83E5fouJ+XuWggSPhiE=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr3870254itc.68.1533136252885;
 Wed, 01 Aug 2018 08:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com> <20180731163909.19004-1-benpeart@microsoft.com>
In-Reply-To: <20180731163909.19004-1-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 Aug 2018 17:10:25 +0200
Message-ID: <CACsJy8DMEMsDnKZc65K-0EJcm2udXZ7OKY=xoFmX4COM0dSH=g@mail.gmail.com>
Subject: Re: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 7:03 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
>
> From: Ben Peart <Ben.Peart@microsoft.com>
>
> Skip merging the commit, updating the index and working directory if and
> only if we are creating a new branch via "git checkout -b <new_branch>."
> Any other checkout options will still go through the former code path.

I'd like to see this giant list of checks broken down and pushed down
to smaller areas so that chances of new things being added but checks
not updated become much smaller. And ideally there should just be no
behavior change (I think with your change, "checkout -b" will not
report local changes, but it's not mentioned in the config document;
more things like that can easily slip).

So. I assume this reason for this patch is because on super large worktrees

 - 2-way merge is too slow
 - applying spare checkout patterns on a huge worktree is also slow
 - writing index is, again, slow
 - show_local_changes() slow

For 2-way merge, I believe we can detect inside unpack_trees() that
it's a 2-way merge (fn == twoway_merge), from HEAD to HEAD (simple
enough check), then from the 2-way merge table we know for sure
nothing is going to change and we can just skip traverse_trees() call
in unpack_trees().

On the sparse checkout application. This only needs to be done when
there are new files added, or the spare-checkout file has been updated
since the last time it's been used. We can keep track of these things
(sparse-checkout file change could be kept track with just stat info
maybe as an index extension) then we can skip applying sparse checkout
not for this particular case for but general checkouts as well. Spare
checkout file rarely changes. Big win overall.

And if all go according to plan, there will be no changes made in the
index (by either 2-way merge or sparse checkout stuff) we should be
able to just skip writing down the index, if we haven't done that
already.

show_local_changes() should be sped up significantly with the new
cache-tree optimization I'm working on in another thread.

If I have not made any mistake in my analysis so far, we achieve a big
speedup without adding a new config knob and can still fall back to
slower-but-same-behavior when things are not in the right condition. I
know it will not be the same speedup as this patch because when facing
thousands of items, even counting them takes time. But I think it's a
reasonable speedup without making the code base more fragile.
-- 
Duy
