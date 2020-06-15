Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC812C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA082068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgFOLEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:04:49 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:19584 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgFOLEs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 07:04:48 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jkmv0-0003DF-DS; Mon, 15 Jun 2020 12:04:46 +0100
Subject: Re: Collaborative conflict resolution feature request
To:     Sergey Organov <sorganov@gmail.com>
Cc:     "Curtin, Eric" <Eric.Curtin@dell.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email> <87zh943bda.fsf@osv.gnss.ru>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <39c45b18-194c-0ff1-4a6d-1db8dee788c7@iee.email>
Date:   Mon, 15 Jun 2020 12:04:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87zh943bda.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/2020 10:51, Sergey Organov wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>
> [...]
>
>> Also look at 'rerere'.
> 'rerere' is a superb feature, but isn't it local? If so, how could it
> help for collaboration? What's the idea? Is there a way to share
> 'rerere'?
I saw this (rerere) is two parts. First was to ensure Eric was aware of
it as a possible capability for use by the 'merge manager', and others,
so that they didn't loose sight of their conflict resolutions for the
time when the 'big merge window' came around. E.g. So a dev could do a
local fix based on their rerere database and then send a patch to the
merge manager indication their approach to the resolution.

Meanwhile, second, at the moment the rerere database is 'local', mainly,
as I understand it because of the number of context lines a local user
has chosen (hence not immediately portable).

I personally believe that it should be possible to some how exchange
resolutions without that pre-optimisation of the context line choice. I
had a look back at the old rerere script and that had small fingerprints
of each resolution stored in the database (at least as I read it).
However when I look at the modern rerere database it looks like it has
full pre & post images, rather than just the conflicts, so I'm not yet
sure what's really happening (i.e. I haven't dived into the c code).

A possibly more sensible approach (to exchanging resolutions) is simply
to do the merge, without commit, then save that merge as if it's a
single side commit (with the other merge parent listed in the commit
message), and that commit can then be pushed/pulled etc and a variant of
`rerere train` can be used to recreate the local database. In a sense
the fake merge (why not a proper merge) is a variant of a stash where
you aren't wanting to pollute the branch trees with this extra 'flotsam'.

Philip
>

