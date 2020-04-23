Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AA8C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 18:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9732076C
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 18:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgDWSMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:12:34 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:53318 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgDWSMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 14:12:33 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 4178960067;
        Thu, 23 Apr 2020 18:12:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id rQfQENU4xNAM; Thu, 23 Apr 2020 18:12:29 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-88-217-42-14.dynamic.mnet-online.de [88.217.42.14])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Thu, 23 Apr 2020 18:12:28 +0000 (UTC)
Message-ID: <6661ea6546fc02583959f00a99736cc110792ab9.camel@scientia.net>
Subject: Re: how to (integrity) verify a whole git repo
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Date:   Thu, 23 Apr 2020 20:12:28 +0200
In-Reply-To: <20200421161956.45slynbgkkom3qc3@chatter.i7.local>
References: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
         <20200421065301.GH96152@google.com>
         <be69ed1bade98cb7e414c2713fe0d6b5cadd7172.camel@scientia.net>
         <20200421161956.45slynbgkkom3qc3@chatter.i7.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2020-04-21 at 12:19 -0400, Konstantin Ryabitsev wrote:
> > So from my understanding, to use only commits that are authentic by
> > the
> > kernel upstream developers, I'd need verify all these tips.. and
> > throw
> > away everything which is not reachable by one of them.
> > 
> > Is that somehow possible?
> 
> You probably don't care about commits that arrive between releases, 

No, I guess not.


> so 
> effectively you are already doing that? Even if you have loose
> objects 
> that aren't reachable from your current tip (e.g. you only care
> about 
> objects in the stable branch linux-5.6.y), it's not like they are
> going 
> to "poison" your tree, so removing them is just a garbage collection 
> operation at best.

Well it's clear that any "loose" objects (in the sense of "not part of
the history by something that is signed and that I trust") don't poison
the tree before whatever I trust... but of course only if one never
accidentally uses anything of them.

For the Linus' kernel and Gerg's stable kernel repos this is probably
rather unlikely, since the do not contain much which is not signed by
one of the two.
But for other projects one might have many development branches or
other stuff which might not be signed at all.

When one then "works" on such a repo one doesn't always want to check
whether the current stuff one uses is signed and trusted or not.


> I would argue that your premise of "authenticity" is wrong. The best 
> that we are currently able to offer is a guarantee that, at the
> point 
> where the tag was signed, the tree is bit-for-bit exact to the tree
> the 
> way it exists on Linus Torvalds' (or Greg KH's) workstation.

And isn't that already something? :-D

It means to the least, that no simple MitM was possible in contrast to
when I just git clone git://whatever .


> However, both Linus and Greg merge code from tens of thousands of
> other 
> contributors and it's important to keep in mind that their tag 
> signatures do not offer any kind of attestation proof of the code's 
> actual authorship or origin.

Sure... but this is anyway the case... and nothing which one could
easily change or improve.

The best thing in terms of authenticity on can possibly get is being
able to have the repo exactly the same as it considered correct at it's
canonical upstream.

Everything better would require full trust paths and mutual signing
between all participating developers - which would surely be nice to
have, but is probably a completely other question.


Also, there are many much smaller projects, where things would be much
easier.



> 
> - Submaintainers don't put much trust into *who* wrote the code and 
>   review all submissions they receive as potentially containing
> security 
>   bugs (intentional or not); their job is to review the code and pass
> it 
>   up the chain to maintainers.
> - if maintainers receive pull requests from submaintainers, then
> they 
>   *may* check cryptographic signatures on the trees they pull. I am 
>   trying to encourage all maintainers to do this, and I've been
> working 
>   to introduce patch attestation so that maintainers preferring to
> work 
>   with patch series as opposed to pull requests can have similar 
>   functionality.
> - Linus checks all signatures on trees he pulls from non-kernel.org 
>   locations. Unfortunately, I've not been able to convince him that
> he 
>   should check them on stuff he pulls from kernel.org as well (and
> he 
>   has his own reasons for that).

But all this gives already quite some trust into the whole thing.


> So, all of this is to say that as the person cloning linux.git you
> are 
> merely the last link in the chain of "trusting the maintainer before 
> you." In your case that maintainer is Linus (or Greg KH), and you
> have 
> to agree that, in the end, "having a tree that is bit-for-bit
> identical 
> with what Linus has" is a pretty good assurance that it's as
> "authentic 
> Linux" as it gets.

Exactly... it's at least not much worse (if at all) than taking e.g. my
pre-compiled distro kernel, for which the sources are like not better
checked or more securely retrieved than when I clone Linus' git and
verify the tags.

My main concern was really to ideally "throw away" everything which
wasn't protected by a set of certain keys,... so that I wouldn't
accidentally use it.



Thanks,
Chris.

