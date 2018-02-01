Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428181F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeBACWp (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:22:45 -0500
Received: from mezzogiorno.tim-landscheidt.de ([78.47.87.37]:49501 "EHLO
        mezzogiorno.tim-landscheidt.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753547AbeBACWo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:22:44 -0500
X-Greylist: delayed 951 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jan 2018 21:22:44 EST
Received: from dslb-092-076-023-076.092.076.pools.vodafone-ip.de ([92.76.23.76]:47688 helo=passepartout.tim-landscheidt.de)
        by mezzogiorno.tim-landscheidt.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <tim@tim-landscheidt.de>)
        id 1eh4H5-0004fx-PC; Thu, 01 Feb 2018 02:06:51 +0000
From:   Tim Landscheidt <tim@tim-landscheidt.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add "git rebase --show-patch"
Organization: http://www.tim-landscheidt.de/
References: <20180126095520.919-1-pclouds@gmail.com>
        <nycvar.QRO.7.76.6.1801291609060.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CACsJy8AH+xg3AB3qaqnFud4B8HHeyaO=8DqHL+p4HTTeSx6uYg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1801301331410.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqqshant7ys.fsf@gitster-ct.c.googlers.com>
Mail-Copies-To: never
Date:   Thu, 01 Feb 2018 02:06:51 +0000
In-Reply-To: <xmqqshant7ys.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 30 Jan 2018 12:19:55 -0800")
Message-ID: <87inbhbgzo.fsf@passepartout.tim-landscheidt.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

>> The pseudo ref certainly has an appeal. For people very familiar with
>> Git's peculiarities such as FETCH_HEAD. Such as myself.

>> For users, it is probably substantially worse an experience than having a
>> cmdmode like --show-patch in the very command they were just running.

> I tend to agree with that assessment.  FETCH_HEAD was a required
> mechanism for commands in the toolchain to communicate and wasn't
> meant as a mechanism for end-users.  I do not think it is a good
> idea to add to the pile to these special files the users would need
> to look at, when we do not need to.

> Even if the internal implementation uses such a file, wrapping it
> with a documented command mode would make a better UI.

I disagree with that as I had:

| [alias]
|         original-commit = !git show $(cat .git/rebase-apply/original-commit)

for a long time in my ~/.gitconfig :-) (until I realized
that Git accepted "rebase-apply/original-commit" everywhere;
for single-commit branches I always just used ORIG_HEAD).

This meant that whenever I wanted to look at the lay of the
land upon which the original commit was built, I had to do
"git original-commit" and copy & paste the SHA1 (without my
alias, I had to "git log ORIG_HEAD", pick hopefully the cor-
rect commit and copy & paste its SHA1).  Only with this SHA1
I could then run "git diff", "git show", "git grep", "git
blame", etc., etc., etc. because in my use cases looking at
the patch alone was usually not sufficient: I needed to know
why there was a conflict, i. e. how the file(s) the patch
changed looked before they had been altered upstream.

To me, this type of "algebra" is what makes Git so powerful:
I do not have to build a pipe that gets the SHA1 of a
branch's tip and xargs it to "git show", I can just say "git
show $branch".  Having a SHA1 with a special meaning that
has no easy way to access it by "git rev-parse" breaks this
UI IMHO.

Tim
