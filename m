Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC2DC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 05:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F372071A
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 05:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGgtJHCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgCaF2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:28:50 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:42940 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCaF2t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 01:28:49 -0400
Received: by mail-lj1-f169.google.com with SMTP id q19so20539092ljp.9
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rkRcf055BNqLPdHDg9avJJQQfNeJ9Eo9oWgfRhO/2YY=;
        b=ZGgtJHCWflMelvOTHa1OGXfRUVwYoy4xS8zHfQf0dqZHxNwwB9HqVbOBNVpajflssy
         +04WnBeNwcfXt+EM/H1Gsc8TvZgv3yJJSfXUXwhgO+Mym7OKlqy0O2gAqs/c0bWLdvKm
         NTX5fRxPCWalbiHBBtZihEtDx9pW65yEYVWFOYmOFR2vm+whLwUC6WmIOoZfks6jKdX2
         nv8L+zYr7kxit1Vk2M5nRAq4QrJlBppnTqbZPEtjOR55mIepXuRGoEA9PtvYemzUyKRG
         gltXkB4Rij/JduWZl18Hwjcp/aD1ZQm7hvVhGFt76LM/sp/OAL+p4DqgKwqtLh5WrOQl
         zVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rkRcf055BNqLPdHDg9avJJQQfNeJ9Eo9oWgfRhO/2YY=;
        b=DWEF0V8YL3KZiT9/uTyg8hhQ21Og7/z6+Yem3qd+Yb5Oyp/XmkaF4+8WfRSFNn/oR4
         sIYBC3/yOfQAb69mXsKRGxEQCkcPAqCGcfKYgWAormf/r/3P4kPRYXa9bCsNSANt3a2I
         VmtWRNYe3QBeKjJWSgZZtkyEbOwaQn8YgIvKAc3NLZSI/J3lWKcRAwrWVSIvU4BI75xx
         RUHzPmaqQKRp6DAg9AUIvGneyxrJh7C65nBxrmnnPCTL8n4fsoeJyfWk2Yro7TYl+rBi
         cjihBC2LImtmbx38f6NSV8T8IShokvbHjsbXuy2ucW72+W9xPJuddEoocq5zkokbvbI1
         +FSA==
X-Gm-Message-State: AGi0Pub0SSyNCCz/wU3wEbmbuk3/c0zmMCbtU+VNRSgkKMlMtc4OstMc
        cxtqGJtkd40aku0KXXyHHp5cqLBZ8E+pEcoU/VAT5YNJlHk=
X-Google-Smtp-Source: APiQypJ6WJsSQFleRuvAs2nsNbSrR5Nm0taDIPN0iU2i/HRoatHAIYQHevj7/LxsFBN4ZfT8YvH7w6uW3USu+8xqIoI=
X-Received: by 2002:a2e:86c6:: with SMTP id n6mr5068890ljj.11.1585632525643;
 Mon, 30 Mar 2020 22:28:45 -0700 (PDT)
MIME-Version: 1.0
From:   Thibault Delor <delor.thibault@gmail.com>
Date:   Tue, 31 Mar 2020 16:28:34 +1100
Message-ID: <CAM+dguao5CtTUp1Fxc+BXnhYzTqU_0oWrsaK0RiwUcM10iq3hg@mail.gmail.com>
Subject: [BUG] log --follow ignore files renamed in a merge commit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I have raised my initial issue on Stack Overflow:
https://stackoverflow.com/questions/60927159/merging-repo-with-git-subtree-prefix-break-the-history

After reading the code, it's definitely a bug with git log.
The actual issue is that if a file has been renamed inside a commit
with 2+ parents `git log --follow` won't show it and loose track of
the file. On the other side, running `git log -m --follow ...` is
working as expected.

I would be really keen to submit a patch in the next couple of days.

I am planning to tweak the method `log_tree_diff` in log_tree.c as I
feel that's where the error coming from. I am guess I will have to
force somehow the evaluation of the diff (even if the diff isn't
displayed) so the method `try_to_follow_renames` gets a chance to be
evaluated.

I have never contributed to git source code, I'll the doc
"SubmittingPatches" but feel free to give any guidance.

Thanks
Tibo
