Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B04C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BFE2071E
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfL3Tlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:41:37 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57795 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Tlh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 14:41:37 -0500
X-Originating-IP: 157.36.165.22
Received: from localhost (unknown [157.36.165.22])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id F38E61C0006;
        Mon, 30 Dec 2019 19:41:33 +0000 (UTC)
Date:   Tue, 31 Dec 2019 01:11:29 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Zoli =?utf-8?B?U3phYsOz?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Zoli =?utf-8?B?U3phYsOz?= <zoli.szabo@gmail.com>
Subject: Re: [PATCH v3 1/1] git-gui: allow opening currently selected file in
 default app
Message-ID: <20191230194129.kjmp6r5xuwmq4wum@yadavpratyush.com>
References: <pull.499.v2.git.1577647930.gitgitgadget@gmail.com>
 <pull.499.v3.git.1577721419.gitgitgadget@gmail.com>
 <1b2363be726c6d70746aec9fae62edaf857cd665.1577721419.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b2363be726c6d70746aec9fae62edaf857cd665.1577721419.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zoli,

On 30/12/19 03:56PM, Zoli Szabó via GitGitGadget wrote:
> From: =?UTF-8?q?Zoli=20Szab=C3=B3?= <zoli.szabo@gmail.com>
> 
> Many times there's the need to quickly open a source file (the one you're
> looking at in Git GUI) in the predefined text editor / IDE. Of course,
> the file can be searched for in your preferred file manager or directly
> in the text editor, but having the option to directly open the current
> file from Git GUI would be just faster. This change enables just that by:
>  - clicking the diff header path (which is now highlighted as a hyperlink)
>  - or diff header path context menu -> Open;

Semi-colon left in by mistake?

> 
> Note: executable files will be run and not opened for editing.
> 
> Signed-off-by: Zoli Szabó <zoli.szabo@gmail.com>
> ---
>  git-gui.sh | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index c1be733e3e..8920e4ddb0 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2259,9 +2258,23 @@ proc do_explore {} {
> +# Open file relative to the working tree by the default associated 
> app.
> +proc do_file_open {file} {
> +	global _gitworktree
> +	set explorer [get_explorer]
> +	set full_file_path [file join $_gitworktree $file]
> +	eval exec $explorer [list [file nativename $full_file_path]] &

IIUC, this line can be simplified to:

  exec $explorer [file nativename $full_file_path] &

It works fine for me including on files with spaces in their names, but 
a test on Windows would be appreciated just to rule out any hidden 
surprises.

No need to send a re-roll just for these two small things. I have 
updated the commit locally before pushing the new version out [0]. The 
rest of the patch looks good. Will merge. Thanks.

> +}
> +
>  set is_quitting 0
>  set ret_code    1
>  

[0] https://github.com/prati0100/git-gui/tree/zs/open-current-file

-- 
Regards,
Pratyush Yadav
