Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9180C1F576
	for <e@80x24.org>; Fri, 23 Feb 2018 11:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeBWLXD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 06:23:03 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:40179 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBWLXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 06:23:02 -0500
Received: from [192.168.2.201] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id pBRKeiBw1LSHJpBRLezf0n; Fri, 23 Feb 2018 11:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519384979;
        bh=j7c6qSSyDuuT0Q0roC5noSkdBqdYosJwOaHwoc6a2Yg=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=ccaXzR27nmpwGj32/1IyifR0JYijBq8ETPa0o5v8v+Yqz1aZyrI4hh1NEqZuCD5KA
         TXghcpwCpgOCoJIFKnxEcSUPFntRggAAGsDov0RVAdr1DvhBRPi++i2dW6KRWJQRLG
         hFcpyJhxTkg4AERI07fJ0FurPMR3Y9afsoXODlNg=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=NqehS4VJ c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=3ynUh9etfZC-0S1kUlMA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git "branch properties"-- thoughts?
To:     paul@mad-scientist.net, Git mailing list <git@vger.kernel.org>
References: <1519324188.6391.156.camel@mad-scientist.net>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <2607f7e8-b680-50ac-0c08-7abc35499f1d@talktalk.net>
Date:   Fri, 23 Feb 2018 11:22:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519324188.6391.156.camel@mad-scientist.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfINwnbZH5NDSsGJ5iS7oUqazSZhPi+1MBmehbVXGGGv/CDNSPqNJa41Tu+GYv3e8nK/jD6nGMLDurb8M06XS8OACl21BkmJvy+/BSCsTBBTEqKWpey9R
 Rp7EdLBsZoiQfkHnv8PJySWoypMlbgszjHKiYVpi466i8aeRHsToGGP8Ch3ZFhYJ1G6Ao2ooUKYH00GPCTiDCU3btdoQBWDVGIE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/02/18 18:29, Paul Smith wrote:
> 
> Hi all.  I'm wondering if anyone has any thoughts about the best, or
> even any, way to have "branch properties": some extra information which
> is attached to a branch (that is, the actual branch name not the commit
> it currently points to).
> 
> My requirements are that the information needs to be pushed to the
> server, so that lets out branch descriptions for example.  Ideally the
> information would also be easily updated and available in all clones
> during normal fetch operations but this isn't a hard requirement: I
> could script it.
> 
> My immediate desire is to find a way to mark a branch as "frozen", that
> will control which pushes are allowed.  I use gitolite on my server and
> I can easily write a server hook that will handle the checking,
> rejecting, etc.  I already have such an infrastructure.  What I need is
> a way to know which branches are in that state, so my hook can see that
> and DTRT.  There are other "branch properties" I could envision, too,
> but don't have a real need right now.
> 
> Of course I could embed the frozen state into the gitolite repository
> configuration.  Indeed, I have already implemented "locks" for obsolete
> branches.  But "frozen" is a more ephemeral state and requiring access
> to the gitolite repository to manage it is just not what I want; it's a
> separate repository so the state is not visible, requires privileges I
> really don't want to hand out to everyone, and is generally difficult. 
> I want some users to be able to manage frozen branches relatively
> easily, and all users to be able to see the state of which branches are
> frozen, etc.
> 
> So then I thought about creating a "frozen" tag, like "frozen/v1.0" or
> something.  This is slightly weird because it is applied to a commit,
> which is not really right, but whatever: it's just a marker so I would
> just be checking to see if it exists or not.  The other problem is that
> Git tags are not intended to be transient/moveable.  While you CAN
> delete them and move them, when someone pulls the repository they won't
> get that update by default.  Since the hook is server-side the fact
> that the local repository has the wrong information doesn't matter for
> behavior, but it's confusing for people.  So, it's not ideal.
> 
> I thought about creating a branch, like "frozen/v1.0", rather than a
> tag.  I don't need a branch here, and no one would push to that branch
> (I'd have to disallow that in my hooks), and the commit associated with
> the branch would not be relevant most likely.  I would only check to
> see if the branch existed, or not.  Branches are nice because creating
> and deleting them is handled automatically (if you use prune
> consistently, which we do because we have tons of transient branches).
> 
> Then I looked into using notes, and they look interesting, but they're
> associated with a specific commit as well and I don't want that: a
> frozen branch can still have new commits pushed to it they just have
> meet certain criteria.  This makes them hard to translate into a branch
> name.
> 
> So far, using a special branch name seems the most "reasonable".  But,
> I wonder if I missed some cool aspect if Git that would work better, or
> if anyone else has other suggestions.
> 
> Cheers!
> 

Hi Paul

It would certainly be nice to be able to share branch descriptions so
that if I clone a repository I can get a bit more detail about the ideas
behind each branch. Shared descriptions could be displayed in web uis. I
sometimes find myself wanting something like notes for branches as well
to make a todo list for future commits. Maybe there could be a well
known refs (say refs/metadata) that contains public metadata for other
refs. In the same way that refs/notes/commits contains a tree of commit
ids refs/metadata would contain ref paths without the leaning ref/.
Under than directory there would be a subtree with the metadata - files
called description, frozen, a directory of notes etc. So for
refs/heads/master you'd have refs/metadata/heads/description containing
the description refs/metadata/heads/master/notes/... containing the
notes I want to share and refs/heads/metadata/master/frozen to indicate
if the branch was frozen.

Best Wishes

Phillip
