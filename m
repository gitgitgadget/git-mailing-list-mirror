Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5498DC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 19:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJDTsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 15:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJDTsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 15:48:06 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E659E5A800
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 12:48:05 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ofntb-00018y-8g;
        Tue, 04 Oct 2022 20:48:04 +0100
Message-ID: <fb8172a1-004c-1316-7a26-f030d377c141@iee.email>
Date:   Tue, 4 Oct 2022 20:48:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/2] docs: document bundle URI standard
Content-Language: en-GB
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
 <pull.1248.v4.git.1660050761.gitgitgadget@gmail.com>
 <1bfac1f492aa2c53dbe2a5b234cab3c5c6465ede.1660050761.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <1bfac1f492aa2c53dbe2a5b234cab3c5c6465ede.1660050761.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

While catching up with stuff I missed, I saw two minor nits for future
updates, when reading the docs on GfW.

On 09/08/2022 14:12, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> Introduce the idea of bundle URIs to the Git codebase through an
> aspirational design document. This document includes the full design
> intended to include the feature in its fully-implemented form. This will
> take several steps as detailed in the Implementation Plan section.
>
> By committing this document now, it can be used to motivate changes
> necessary to reach these final goals. The design can still be altered as
> new information is discovered.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  [...]
> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
> new file mode 100644
> index 00000000000..e6d63b868b8
> --- /dev/null
> +++ b/Documentation/technical/bundle-uri.txt
> @@ -0,0 +1,468 @@
> +Bundle URIs
> +===========
> +

[...]


> +
> +bundle.<id>.creationToken::
> +	This value is a nonnegative 64-bit integer used for sorting the bundles
> +	the list. 

s/the //   .. an extraneous 'the' ?

> This is used to download a subset of bundles during a fetch
> +	when `bundle.heuristic=creationToken`.
> +
> +bundle.<id>.location::
> +	This string value advertises a real-world location from where the bundle
> +	URI is served. This can be used to present the user with an option for
> +	which bundle URI to use or simply as an informative indicator of which
> +	bundle URI was selected by Git. This is only valuable when
> +	`bundle.mode` is `any`.
> +

[...]
> +Cloning with Bundle URIs
> +------------------------
> +
> +The primary need for bundle URIs is to speed up clones. The Git client
> +will interact with bundle URIs according to the following flow:
> +
> +1. The user specifies a bundle URI with the `--bundle-uri` command-line
> +   option _or_ the client discovers a bundle list advertised by the
> +   Git server.
> +
> +2. If the downloaded data from a bundle URI is a bundle, then the client
> +   inspects the bundle headers to check that the prerequisite commit OIDs
> +   are present in the client repository. If some are missing, then the
> +   client delays unbundling until other bundles have been unbundled,
> +   making those OIDs present. When all required OIDs are present, the
> +   client unbundles that data using a refspec. The default refspec is
> +   `+refs/heads/*:refs/bundles/*`, but this can be configured. These refs
> +   are stored so that later `git fetch` negotiations can communicate the
> +   bundled refs as `have`s, reducing the size of the fetch over the Git

s/ave`s/ave` 's/  .. 
The backtick is mistaken for an apostrophe and then is misformatted for
the Git for Windows HTML versions, e.g.
https://github.com/gitster/git-htmldocs/blob/master/technical/bundle-uri.html#L1056

> +   protocol. To allow pruning refs from this ref namespace, Git may
> +   introduce a numbered namespace (such as `refs/bundles/<i>/*`) such that
> +   stale bundle refs can be deleted.
> +

[...]

Quite readable. Thanks.

Philip
