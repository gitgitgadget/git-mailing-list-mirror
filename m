Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D911EC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 09:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31E520714
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 09:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFNJvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 05:51:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:29015 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNJvW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 05:51:22 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jkPIN-0002Tq-C8; Sun, 14 Jun 2020 10:51:20 +0100
Subject: Re: regenerating tags when cloning
To:     Will Holcomb <w@dhappy.org>, git@vger.kernel.org
References: <CAB8ffCD4jO6GxRohMpsyszdvi7dmz7HzE=2aNdqBG_zOGgOCoA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <2492579d-5104-1643-b3a9-c891a8aea045@iee.email>
Date:   Sun, 14 Jun 2020 10:51:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAB8ffCD4jO6GxRohMpsyszdvi7dmz7HzE=2aNdqBG_zOGgOCoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/06/2020 23:37, Will Holcomb wrote:
> I am working on a git remote
> (https://github.com/dhappy/git-remote-ipfs), and I am confused as to
> how to recreate signed tags when cloning.
>
> My remote serializes the commit chain to IPFS and back. It works
> correctly for branches, but I'm having difficulty with tags:
>  • If I recreate tags, I get the error: "fatal: BUG: initial ref
> transaction called with existing refs".
>  • If I don't create the tags, I get an error like: "Error: reference
> 'refs/tags/v0.3.4' not found".
>  • If I create the tags and remove the references, the clone will
> complete, but the resultant repo has a detached head and no tags.
>
> I created a minimum failing example when I posted to stackoverflow:
> https://stackoverflow.com/q/62360443/264008
>
> I can do a "git clone --tags" from Github, and it creates a clone with
> tags, so I know it can be done. I just don't understand what I need to
> change.
>
> It might be germane that I am translating the git objects into a
> CBOR-DAG: https://explore.ipld.io/#/explore/Qmcnzkb1YGyDWBqSaFz1k7qi3F1VDaHNsBWNF2SvRiYeL5/.git
> and relying on nodegit to reconstruct objects with the same SHA1
> hashes on fetch, so I can't directly insert things into the object
> database.
>
> Any suggestions would be greatly appreciated.
Thoughts that come to mind (I know nothing about IPFS..):

Are these annotated tags or lightweight tags?
https://stackoverflow.com/questions/11514075/what-is-the-difference-between-an-annotated-and-unannotated-tag

Can you be sure that the commits the tags reference have already been
recreated before you start tagging them?

Could the tags have already been implicitly recreated (being mistaken
for a commitish object), and so you are trying to create a duplicate.

Is the tag name meant to have 'fancy' symbols
https://explore.ipld.io/#/explore/Qmcnzkb1YGyDWBqSaFz1k7qi3F1VDaHNsBWNF2SvRiYeL5/.git/refs/tags/%E2%93%A5/%C2%BD
(does the clone work for similar symbols in the commit messages)?

The Git code is available at https://github.com/git/git (you probably
already knew that) if you want to search for the error messages and
hence code paths.

Philip


