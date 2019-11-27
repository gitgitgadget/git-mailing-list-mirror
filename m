Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9082C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 22:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7F520637
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 22:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfK0WD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:03:27 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51563 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfK0WD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 17:03:27 -0500
X-Originating-IP: 1.186.12.45
Received: from localhost (unknown [1.186.12.45])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BAE8D20004;
        Wed, 27 Nov 2019 22:03:24 +0000 (UTC)
Date:   Thu, 28 Nov 2019 03:33:22 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH v5 3/3] git-gui: revert untracked files by deleting them
Message-ID: <20191127220322.hcmn3kcb2vj7jf7p@yadavpratyush.com>
References: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
 <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
 <d0d6593b421609445e8f2c794e1d3ca46ebed068.1574627876.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d6593b421609445e8f2c794e1d3ca46ebed068.1574627876.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On 24/11/19 08:37PM, Jonathan Gilbert via GitGitGadget wrote:
> From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> 
> Update the revert_helper proc to check for untracked files as well as
> changes, and then handle changes to be reverted and untracked files with
> independent blocks of code. Prompt the user independently for untracked
> files, since the underlying action is fundamentally different (rm -f).
> If after deleting untracked files, the directory containing them becomes
> empty, then remove the directory as well. Migrate unlocking of the index
> out of _close_updateindex to a responsibility of the caller, to permit
> paths that don't directly unlock the index, and refactor the error
> handling added in d4e890e5 so that callers can make flow control
> decisions in the event of errors. Update Tcl/Tk dependency from 8.4 to
> 8.6 in git-gui.sh.
> 
> A new proc delete_files takes care of actually deleting the files in
> batches, using the Tcler's Wiki recommended approach for keeping the UI
> responsive.
> 
> Since the checkout_index and delete_files calls are both asynchronous
> and could potentially complete in any order, a "chord" is used to
> coordinate unlocking the index and returning the UI to a usable state
> only after both operations are complete. The `SimpleChord` class,
> based on TclOO (Tcl/Tk 8.6), is added in this commit.
> 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> ---
>  git-gui.sh    |   4 +-
>  lib/chord.tcl | 160 +++++++++++++++++++
>  lib/index.tcl | 422 ++++++++++++++++++++++++++++++++++++++++----------
>  3 files changed, 502 insertions(+), 84 deletions(-)
>  create mode 100644 lib/chord.tcl

From what I can tell, this re-roll of the patch only has minor changes 
all of which look good. Thanks.

-- 
Regards,
Pratyush Yadav
