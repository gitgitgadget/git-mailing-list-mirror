Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C3A1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfJASAK (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:00:10 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33669 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJASAK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:00:10 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E18A8C0004;
        Tue,  1 Oct 2019 18:00:07 +0000 (UTC)
Date:   Tue, 1 Oct 2019 23:30:05 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: disable the "loose objects popup" dialog?
Message-ID: <20191001180005.iemqmlbn7ncv3dav@yadavpratyush.com>
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
 <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
 <9d77189d-a357-ab0a-6cb5-e87ecdeffb91@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d77189d-a357-ab0a-6cb5-e87ecdeffb91@kdbg.org>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/19 11:13PM, Johannes Sixt wrote:
> Am 26.09.19 um 21:15 schrieb Pratyush Yadav:
> > Reading the Stackoverflow link, it seems this is already possible via an 
> > undocumented config variable "gui.gcwarning". I haven't tried using it 
> > though, but I see no reason for it to not work (looking at 
> > git-gui.sh:4141).
> 
> Ah! That explains why I don't see the message on one of my computers,
> but I do see on others. I must have reset gui.gcwarning there a decade
> ago, and forgot about it.
> 
> > Maybe we should add this variable in the options dialog, so people at 
> > least know it exists?
> 
> That may be the most reasonable thing to do, IMO.
> 
> >> What about a configurable limit, but still show the dialog?
> > 
> > Do people really care that much about configuring this limit to warrant 
> > something like this? 
> 
> Never mind. We don't need it if there is a simple switch.
> 
> > Talking about auto compression, would it be a better idea to let users 
> > disable the dialog, and then if they do want auto compression, they can 
> > just run a cron job (or the Windows equivalent) to do this on their 
> > repos? What reasons do people have to have this feature in git-gui, 
> > instead of running cron jobs?
> 
> This is a GUI. It was intended for people with a dislike of the command
> line. If you avoid the command line as much as possible, you never get
> to see any object statistics; yet, all operations would slow down
> gradually due to object bloat with no way out. Remember that this
> feature was invented long before auto-gc came to existence. Not to
> mention that git-gui uses plumbing mostly where auto-gc would not
> trigger anyway.

Marc's reply to this thread seems to suggest he has had a great 
experience with this feature disabled, because "the rest of git's 
auto-gc machinery is now working quite well (compared to when git-gui 
was first introduced)".

I personally am not very familiar with the details of Git's auto-gc, and 
Googling around didn't really give out any promising results.

What I gather from reading the man page is that "some commands" run 
git-gc automatically. There isn't much mention of which those commands 
are. But you say that plumbing does not trigger auto-gc, so it would not 
get triggered by people using git-gui.

So here's what I propose: why don't we try to do something similar? What 
about running `git-gc --auto` in the background when the user makes a 
commit (which I assume is the most common operation in git-gui). This 
would be disabled when the user sets gc.auto to 0.

This way, we keep a similar experience to the command line in case of 
auto-gc, and we get rid of the prompt. People who don't want 
auto-compression can just set gc.auto to 0, which they should do anyway.

Thoughts?

-- 
Regards,
Pratyush Yadav
