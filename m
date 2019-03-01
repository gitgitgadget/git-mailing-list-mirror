Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75BB20248
	for <e@80x24.org>; Fri,  1 Mar 2019 14:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbfCAOvI (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 09:51:08 -0500
Received: from mail.javad.com ([54.86.164.124]:55583 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfCAOvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 09:51:08 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 3C6B83E97A;
        Fri,  1 Mar 2019 14:51:07 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=Ta03/vGh;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1551451867;
        bh=bcQFgafzUPaPEtmwCyXTxl+jvDWwlooJ1iPuIim2YIE=; l=1081;
        h=Received:From:To:Subject;
        b=Ta03/vGhsTRwJvfc3iNUzlMuj/+7J+pu6SgxNOzml2x80dMeQFgb/8Xsd0K6ZP2/2
         ZLWyM9t0NB4wBhMvpSc0xu+NBL66wyI3prSVEYXDBOjkTClmtQ7i39kRaGyfKIzGTe
         lAy/5mFZPtue1MabqYU51h7CRVx7j+PCibc7n5Bs=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gzjVA-0008NV-T0; Fri, 01 Mar 2019 17:51:04 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Tags from each remote in a separate "name-space"?
References: <87d0ncihkg.fsf@javad.com> <20190228081103.GA22075@dektop>
Date:   Fri, 01 Mar 2019 17:51:04 +0300
In-Reply-To: <20190228081103.GA22075@dektop> (Duy Nguyen's message of "Thu, 28
        Feb 2019 15:11:03 +0700")
Message-ID: <87wolizm07.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:
> On Thu, Feb 28, 2019 at 08:54:23AM +0300, Sergey Organov wrote:
>> Hello,
>> 
>> How do I configure git to handle tags from remotes in a manner similar
>> to branches?
>> 
>> Specifically, I want tag 'tag_name' from remote 'origin' to have local
>> name 'origin/tag_name', not 'tag_name', as it is by default. For a repo
>> with a lot of remotes[*] it would allow to keep track of what tag came from
>> where, as well as prevent name conflicts between tags from different
>> remotes (and/or local tags).
>
> On the fetch side, something like this in the config file (assuming
> "origin" remote here) probably would do
>
> [remote "origin"]
> 	fetch = +refs/tags/*:refs/tags/origin/*
> 	tagOpt = --no-tags

Thanks for the clue, Duy!

Just adding

	fetch = +refs/tags/*:refs/tags/origin/*

for each existing remote configuration seems to do the trick indeed.

Now I wonder if it would make sense to implement something like

  $ git remote add --separate-tags ...

to be able to auto-configure this.

-- 
Sergey
