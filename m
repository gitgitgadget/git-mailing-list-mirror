Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E52312018B
	for <e@80x24.org>; Mon, 18 Jul 2016 20:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbcGRUH1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 16:07:27 -0400
Received: from lang.hm ([66.167.227.134]:53176 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbcGRUH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 16:07:26 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jul 2016 16:07:26 EDT
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id u6IK1s4c022899;
	Mon, 18 Jul 2016 13:01:54 -0700
Date:	Mon, 18 Jul 2016 13:01:54 -0700 (PDT)
From:	David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:	Herczeg Zsolt <zsolt94@gmail.com>
cc:	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git <git@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <CAPp-Vra5ri7V03SSkU6=UnWrsq-jk0XcNpQuzGH8kQxE-TkPjA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1607181258160.25425@nftneq.ynat.uz>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <CACBZZX5wjhYosupW=-n7UbbXAQug+sgSNS+jm_uUn6QwC8p6Aw@mail.gmail.com> <CAPp-Vra5ri7V03SSkU6=UnWrsq-jk0XcNpQuzGH8kQxE-TkPjA@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 18 Jul 2016, Herczeg Zsolt wrote:

>> In particular, as far as I know and as Theodore Ts'o's post describes
>> better than I could[1], you seem to be confusing preimage attacks with
>> collision attacks, and then concluding that because SHA1 is vulnerable
>> to collision attacks that use-cases that would need a preimage attack
>> to be compromised (which as far is I can tell, includes all your
>> examples) are also "broken".
>
> I understand the differences between the collision and preimage
> attacks. A collision attack is not that bad for git in a typical
> use-case. But I think that it's important to note that there are many
> use-cases which do need a hash safe from collision attack. Some
> examples:
>
> You maintain a repository with gittorrent with signed commits Others
> can use these signatures to verify it's original. Let's say you
> include some safe file (potentially binary) from a third-party
> contributor. That would be fine if the hash algo is safe. Currently
> there is the possibility that you received a (safe) file which was
> made to collide with another malicious one. Once you committed (and
> signed) that file, the attacker joins the gittorrent network and
> starts to distribute the malicious file. Suddenly most of your clients
> pulling are infected however your signature is correct.
>
> Or, you would like to make a continuous delivery system, where you use
> signed tags. The delivery happens only when signature is right, and
> the signer is responsible for it. Your colleague makes a collision,
> pushes the good-file. You make all the tests, everything is fine, sign
> and push and wait for the delivery to happen. Your colleague changes
> the file on the server. The delivery makes a huge mass, and you're
> fired.
>
> Or, let's say you use a service like github, which is nice enough to
> make a repository for you, with .gitignore, licenses and everything.
> Likely, you'll never change dose files. Let's say that service made
> one of those initial files to collide something bad. That means, they
> can "infect" anyone, who is pulling your repo.
>
> Do you need more hypothetical stories? There are a lot. Of course they
> need a lot of work, and they're unlikely to happen. But it's possible.
> If you need trust, and gpg signatures that means you need ultimate
> trust. What's the point in making GPG signatures anyway if you cannot
> ultimately trust them? You could just as well say: well that's
> repository is only reachable by trustworthy persons, everything here
> is just fine and really made by the person named in the "author
> field".

All of your examples are actually preimage attacks. If the bad guy can tamper 
with the both the 'safe' and 'malicious' versions of the file, they don't 
actually need the malicious version, they can attack you through the one you 
think is 'safe'

The 'collision' attack isn't that there is some increased chance of a random 
file colliding with your safe file, it's that if you are manipulating the 
contents of both files, you can create two that collide. This won't hurt a Git 
repository unless one of these manipulated files is able to be introduced as a 
legitimate part of the repo you are dealing with.

David Lang
