Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8CC420248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfCASHM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 1 Mar 2019 13:07:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35086 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfCASHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:07:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id y15so13129454wma.0
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 10:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FcwBsJxP4Zo6PSN1aihfUzXPyAI/AFsTqCom01MbNgU=;
        b=HL/sSVnztuD0V4OfGrbk9+EyBKNLgujkU9pZofrUCvtIxfWAj58fdVFYRE05MVkI5g
         xwJN4TAuZ+hoRDe5zGXZeBwi7yqYnS4SyRB4zVBtJdq+/3c5exuuhCM2wm3k9MUQCfbX
         b+sbNW+fYq6+6FuCVGQk3n111I/cS5RgxPm/ZrcEsiwSNTD+4UvVapEamoXJv19tLe+K
         gs3r71FeWKlvJ3i+Uby0arTKFZpEYqW4Tl/gCbPL3sNLRFdGkz/GnUqm+9IW7HufysnB
         uWpC6uluz7/QC9z6ON7Gu4jtLt6bAmetYqEybz2U4k3hBkn175ehNk0kPPoA+gx1mpy3
         /Z5w==
X-Gm-Message-State: AHQUAubgSkrT1gX9DqikNt0xq08Fi0F//p6vKVFlVEbhklkyKxroHm18
        l3eCxEQDz0SlKTzSucN/MzioMHK7Riae5lxWhif4F2kA
X-Google-Smtp-Source: APXvYqwobfeH4cw7V0tzu4gXaeO2hcOFEIXUMf8dYw6MVqVHqjW0CizTeXpj3HKy/9OI5G9+3uQDtjzf3mdMWsKjfZ8=
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr3944741wmj.71.1551463630608;
 Fri, 01 Mar 2019 10:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20190301175024.17337-1-alban.gruin@gmail.com> <20190301175024.17337-5-alban.gruin@gmail.com>
In-Reply-To: <20190301175024.17337-5-alban.gruin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Mar 2019 13:07:01 -0500
Message-ID: <CAPig+cRCSauOKjkEVmyBYdSjXW2215muvC1DqpGAS2hU9x-04w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC_PATCH_4=2F4=5D_name=2Drev=3A_avoid_naming_from_a_re?=
        =?UTF-8?Q?f_if_it=E2=80=99s_not_a_descendant_of_any_commit?=
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 12:50 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> A ref may not be the descendant of all of the commits mentionned in
> stdin.  In this case, we want to avoid naming its parents.

s/mentionned/mentioned/

>
> To do this, find_commits_in_strbuf() is created.  It returns a raw list
> of all the commits that have been found in the input buffer.  ishex() is
> converted to an inlined function.  Then, we add a raw list of commits in
> the name_ref_data structure, and call find_commits_in_strbuf() before
> for_each_ref() if the user wants name-ref to process stdin.  Then, for
> each ref, we check if the reachable subset of this commit list is empty
> or not.  If it is, we do not call name_rev(), so we don’t name its
> parents.
>
> The code dealing with stdin after calling for_each_ref() is no longer
> needed as we already read it.  name_rev_line() is renamed name_rev_buf()
> to reflect its new role better.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
