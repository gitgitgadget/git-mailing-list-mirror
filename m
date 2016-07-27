Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D97F203EA
	for <e@80x24.org>; Wed, 27 Jul 2016 04:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699AbcG0ESS (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 00:18:18 -0400
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:45242
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955AbcG0ESR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 00:18:17 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jul 2016 00:18:17 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id PgAy1t00D5B68XE01gB4af; Tue, 26 Jul 2016 21:11:06 -0700
Date:	Wed, 27 Jul 2016 07:10:58 +0300
From:	Max Kirillov <max@max630.net>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	larsxschneider@gmail.com, sbeller@google.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree
 setup
Message-ID: <20160727041058.GA9015@wheezy.local>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com>
 <20160720172419.25473-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160720172419.25473-4-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi.

On Wed, Jul 20, 2016 at 07:24:18PM +0200, Nguyễn Thái Ngọc Duy wrote:
> + - `remote.*` added by submodules may be per working directory as
> +   well, unless you are sure remotes from all possible submodules in
> +   history are consistent.
...
> @@ -1114,7 +1114,7 @@ cmd_sync()
>  				sanitize_submodule_env
>  				cd "$sm_path"
>  				remote=$(get_default_remote)
> -				git config remote."$remote".url "$sub_origin_url"
> +				git config --worktree remote."$remote".url "$sub_origin_url"
>  
>  				if test -n "$recursive"
>  				then

I don't think remote.* should be per-worktree. 

* note that it is sumodule repository, not superproject. It
  does not even have to have multiple worktrees.
* it is quite bad to have it different in worktree, because
  git fetch then results in different ref updates depending
  on where it was called. So whatever issue it was intended
  to solve, it hardly made things better.
* I'm not sure I know all use cases of "submodule sync",
  but as far as I understand, it should be called when the
  submodule repository stays the "same" (however user
  defines the "same"), but older url does not work for some
  reason. Then I think it is correct to change the remote
  url for all worktrees.

-- 
Max
