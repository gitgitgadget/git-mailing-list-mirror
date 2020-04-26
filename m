Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D84C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 20:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAB32070A
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 20:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgDZUEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:04:54 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:64992 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgDZUEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 16:04:54 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jSnWF-0002CU-AB; Sun, 26 Apr 2020 21:04:51 +0100
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
To:     Matt Rogers <mattr94@gmail.com>
Cc:     =?UTF-8?Q?Mateusz_Nowoty=c5=84ski?= <maxmati4@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, bwilliams.eng@gmail.com
References: <20200425235716.1822560-1-maxmati4@gmail.com>
 <CAOjrSZs33-CqV5m4wKROYJT8au1hup7bGZWiEaXMV7cU4p-J=Q@mail.gmail.com>
 <ff9a63d4-80e4-8090-c85c-03fd3ab43c55@iee.email>
 <CAOjrSZt7WJy1vv97Rw9MFJyTcB2Ehqq9BjGrXMtV95oB5p53SA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8992c1a7-a638-e823-1cb7-2c8f6b28d486@iee.email>
Date:   Sun, 26 Apr 2020 21:04:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOjrSZt7WJy1vv97Rw9MFJyTcB2Ehqq9BjGrXMtV95oB5p53SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matt,

On 26/04/2020 14:30, Matt Rogers wrote:
>> Given the extra config environment settings, could/should the
>> --show-scope (or complementary option) also show/clarify these
>> environment variable settings?
> I'm lukewarm either way on this one, I think it would be pretty trivial
> to write something that did this, so that only leaves the question of
> 'should' we do this, which I don't really have any particularly strong
> feelings about.  
My thought was that in some cases folks will feel they 'know' where
their system and global configs are located, but that 'git config'
command isn't showing them those contents.

> What would this even ultimately look like? perhaps
> something like this for a command of `git config --show-scope`:
>
> system var=option (currently ignored due to GIT_CONFIG_NOSYSTEM)
That's one option.

The other, non-programmatic way, it to mention the environment variable
in the 'git config' man page, at the --show-scope section, telling folk
that if those env variables are set there won't be any scope to show!
>
> Which kind of begs the question of how many people set that variable
> and then forget that they set it?  

The one that caught me was the test suit[1]. I was unable to replicate
results when I set up a test. This can be bad on Windows where some
settings need to be auto set (or are commonly set) and maybe result in
conflicts. Often what doesn't know what's been done on ones behalf.
There's plenty of spare configs to go round ;-)

> Although I can totally see why it would
> be nice to have some kind of config flag that's a big
> "Just show me everything that's going on option" which considering these
> variables would probably be a little bit more than the current next-best of
> `git config --list --show-scope --show-origin`.  Again though, I'm not
> exactly sure how useful such an option would be.

Mateusz's original problem was with discovery of these env variables, so
ended up with an XY-problem of proposing a patch to redirect the
~/.gitconfig file, because relevant the env variables weren't (for him,
and previously myself) discoverable.

If we go with a 'No one reads the manuals' developer view, then the
solution has to be more code... hence my wondering if there was an easy
win inside the code, or if it needs to be a subjective update to the man
pages (never 'easy').


The man page
The GIT_CONFIG_NOSYSTEM only gets its 1 mention as a heading, while
GIT_CONFIG  has two (+ a heading). Maybe we need to spread the love for
NOSYSTEM...
>
-- 
Philip

[1]
https://lore.kernel.org/git/8850d755-07ce-d8d2-6e5c-88393fce34de@iee.org/
