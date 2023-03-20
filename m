Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C0C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 07:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCTH3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCTH3O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 03:29:14 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CFC4202
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 00:29:10 -0700 (PDT)
Received: from [192.168.42.163] (8-99-142-46.pool.kielnet.net [46.142.99.8])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id BF4F03C135B;
        Mon, 20 Mar 2023 08:29:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1679297349;
        bh=YdE8ntuceERDpLIkKSq9VDBDlSeTC0amndf8O37u5Us=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=lk6n+yJuRqciLIUlKXT2ZD0L/VQ86VtAqUwXFP6WrgWHIfNKjaUiudxZI4tuUYaF3
         zewWj30WAvQk2GG48qaR3TmsvCLa25fkYeXSX4HJeD+6jAZ8rv6LcijlUvFLjpFfCO
         P5B5VWlO2GBcYlCNbJbxQn3vjLUdwPeW+sSM2T3cGQs6OpEwKV/OKkxoa4nf/gT55/
         BJs7et4ZBETd7RqNZl88VRfsjZfIwwIdwCCZVMSgLuP5BIWE3ssratvVnNZ8tiHMr8
         Y07Q2GhRl0jHcudufixb1sLBEOR1coMI9w2qmhwMLODN6DTz9hZe6AdPeIL6PZsm9C
         A47oWtwZS2d5Q==
Message-ID: <1e943dab-23c7-9eed-df4c-c89084d2387b@haller-berlin.de>
Date:   Mon, 20 Mar 2023 08:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
 <3ab454f1-2bb5-d990-4cc4-4e2fde2ba294@haller-berlin.de>
 <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
 <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
 <4d13d02a-ddaf-7b8f-7a27-c7a030816523@haller-berlin.de>
 <722659e9-02ac-a9d2-b0fd-b9a2a3d85753@dunelm.org.uk>
 <805626af-b147-d3cf-5257-a5b90b7cf1d9@haller-berlin.de>
 <f7577c57-f70d-cca3-3f25-18525d40d79b@dunelm.org.uk>
 <0eb3ed02-139a-b114-939a-d2ad286af743@dunelm.org.uk>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <0eb3ed02-139a-b114-939a-d2ad286af743@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.03.23 15:50, Phillip Wood wrote:
> Hmm, I think it is a bit complicated to do this reliably as if "pick B"
> has conflicts and git-rebase-todo contains
> 
>     exec make test
> 
> and done contains
> 
>     pick A
>     exec make test
>     pick B
> 
> it looks like "exec make test" has been rescheduled when in fact "pick
> B" failed with conflicts. If you look at the last three lines of "done"
> you can distinguish the two cases but it is a bit of a faff.

Ah, thanks for coming up with this tricky case. I'm leaning towards
simply ignoring it, since (at least for my usage of git) it's very
uncommon; if I use "-x make test" to check all commits, I almost always
do that in place, so I won't get conflicts.

But it's one more argument for adding the information to git status, I
suppose.

-Stefan
