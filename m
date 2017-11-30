Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C3920954
	for <e@80x24.org>; Thu, 30 Nov 2017 08:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbdK3IMo (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 03:12:44 -0500
Received: from fallback5.mail.ru ([94.100.181.253]:35416 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750866AbdK3IMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 03:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=gKAkn9rQLYNKBnPf6E3GGcy4RcEiCKB15ZtQBCQbJ8E=;
        b=pgJRYK/WvjZuYpTy7X3L9eqDQVzei3yX3CIQshG73Fz6xPRYUIwwmhwkHlqtBCbsl8nCNCoDxzb+jgvgm1lZnxnRzeif8Jzzy9HlspeB2O7Yubll1zP5KwiXRKloD15Ei6a4UQ/9qFL5ku5BaA7oZjmGdo306lJ8JI+ROmeoQug=;
Received: from [10.161.64.48] (port=38016 helo=smtp40.i.mail.ru)
        by fallback5.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
        id 1eKJxY-0002IF-Ae
        for git@vger.kernel.org; Thu, 30 Nov 2017 11:12:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=gKAkn9rQLYNKBnPf6E3GGcy4RcEiCKB15ZtQBCQbJ8E=;
        b=pgJRYK/WvjZuYpTy7X3L9eqDQVzei3yX3CIQshG73Fz6xPRYUIwwmhwkHlqtBCbsl8nCNCoDxzb+jgvgm1lZnxnRzeif8Jzzy9HlspeB2O7Yubll1zP5KwiXRKloD15Ei6a4UQ/9qFL5ku5BaA7oZjmGdo306lJ8JI+ROmeoQug=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1eKJxU-0001r8-JV; Thu, 30 Nov 2017 11:12:37 +0300
Date:   Thu, 30 Nov 2017 11:12:33 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     vit via Git for human beings <git-users@googlegroups.com>
Cc:     git@vger.kernel.org, Vitaly Arbuzov <vit@uber.com>
Subject: Re: [git-users] How hard would it be to implement sparse
 fetching/pulling?
Message-ID: <20171130081232.7hk73s5d62gmpqdz@tigra>
References: <bb89278c-9e79-489d-a19d-681b4e231d10@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb89278c-9e79-489d-a19d-681b4e231d10@googlegroups.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A5D4DF9EF0B89411EB69C18A0E8A2037EA235F49C1ED483E39725E5C173C3A84C30A3B31C63366F725F3177CFB087FC2673218473BE5707D41C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4616E8A81D98373804641BEEF00CF161044CC085085D1A849FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 06:42:54PM -0800, vit via Git for human beings wrote:

> I'm looking for ways to improve fetch/pull/clone time for large git 
> (mono)repositories with unrelated source trees (that span across multiple 
> services).
> I've found sparse checkout approach appealing and helpful for most of 
> client-side operations (e.g. status, reset, commit, add etc)
> The problem is that there is no feature like sparse fetch/pull in git, this 
> means that ALL objects in unrelated trees are always fetched.
> It takes a lot of time for large repositories and results in some practical 
> scalability limits for git.
> This forced some large companies like Facebook and Google to move to 
> Mercurial as they were unable to improve client-side experience with git 
> and Microsoft has developed GVFS which seems to be a step back to CVCS 
> world.
[...]

(To anyone interested, there's a cross-post to the main Git list which
Vitaly failed to mention: [1]. I think it could spark some interesting
discussion.)

As to the essence of the question, I think you blame GVFS for no real
reason. While Microsoft is being Microsoft — their implementation of
GVFS is written in .NET and *requires* Windows 10 (this one is beyond
me), it's based on an open protocol [2] which basically assumes the
presence of a RESTful HTTP endpoint at the "Git server side" and
apparently designed to work well with the repository format the current
stock Git uses which makes it implementable on both sides by anyone
interested.

The second hint I have is that the idea of fetching data lazily
is being circulated among the Git developers for some time already, and
something is really being done in this venue so you could check and see
what's there [3, 4] and maybe trial it and help out those who works on this
stuff.

1. https://public-inbox.org/git/CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com/
2. https://github.com/Microsoft/GVFS/blob/master/Protocol.md
3. https://public-inbox.org/git/?q=lazy+fetch
4. https://public-inbox.org/git/?q=partial+clone

