Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64421F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfBUNvA (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:51:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:37268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfBUNvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:51:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D257AF81;
        Thu, 21 Feb 2019 13:50:59 +0000 (UTC)
Date:   Thu, 21 Feb 2019 14:50:56 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is
 deleted.
Message-ID: <20190221145056.53b98b2a@kitsune.suse.cz>
In-Reply-To: <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
References: <cover.1550508544.git.msuchanek@suse.de>
        <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
        <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Feb 2019 17:50:38 +0700
Duy Nguyen <pclouds@gmail.com> wrote:

> On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > When adding wotktrees git can die in get_common_dir_noenv while
> > examining existing worktrees because the commondir file does not exist.
> > Rather than testing if the file exists before reading it handle ENOENT.  
> 
> I don't think we could go around fixing every access to incomplete
> worktrees like this. If this is because of racy 'worktree add', then
> perhaps a better solution is make it absolutely clear it's not ready
> for anybody to access.
> 
> For example, we can suffix the worktree directory name with ".lock"
> and make sure get_worktrees() ignores entries ending with ".lock".
> That should protect other commands while 'worktree add' is still
> running. Only when the worktree is complete that 'worktree add' should
> rename the directory to lose ".lock" and run external commands like
> git-checkout to populate the worktree.

The problem is we don't forbid worktree names ending with ".lock".
Which means that if we start to forbid them now existing worktrees
might become inaccessible.

Thanks

Michal
