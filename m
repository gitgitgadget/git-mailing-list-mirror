Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB8C12018F
	for <e@80x24.org>; Sat, 16 Jul 2016 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbcGPNsw (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 09:48:52 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33230 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbcGPNsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 09:48:50 -0400
Received: by mail-io0-f173.google.com with SMTP id 38so126869516iol.0
        for <git@vger.kernel.org>; Sat, 16 Jul 2016 06:48:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=j/q3pL2DGjyo5MOcZAJ6RMrdFNR5IfXz6F9FiJKpPqg=;
        b=vaJxNe/C/FgvSQZj/afzsOwkW8sUV5X0h4LGTd3NDrVq5nS2mY5wgt7ZxRnCbKKFu0
         RgGX0whKTOgZPyM5IdMwnskqPaX1FA51gYnd9gmF+HjDneKBL6kpV17UppkA/zVslbZ4
         tOaiPOeN6k1hgs0q5dNsfMb1FAV7fB6Ov94DnfXAr9En4HxuQ8bM+Bc2XRcPwr62awMk
         gwG7RB7RWn7K0mxxCkBYvJLA8caaA8mTR/lJVG5W6bkhIlgmdvoFwnupeEzZgxIgDSAI
         t6isDH4ElrMnkMNMD95HjK6BKcVn7P/n8Uplb3mSpu/mvgcADHV52Yg1oatP4mdR2DSI
         GWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j/q3pL2DGjyo5MOcZAJ6RMrdFNR5IfXz6F9FiJKpPqg=;
        b=HqbGXp41SJqqERdgnGnsEUc6qJmxfRLh4iJ/ywrTZfHmsf3AKoTW/NSHHbJEtvjpN0
         tnxQjIUz4FRoFes93igJAee1lsKYThgkErlFEWpfWN+HpP2R7PGwlnylPjUg/47rvurZ
         ivUT49RvgHTj2sRjP4fCW51JfBVNUJVKJGXziiIBJl0TsHbz9KR8I6s6Tm2v3qooyDDV
         DPRmU4DMMGXynkPypMnLZTnpVGNTq4HRSUzBQzSOhvdPZFv8Xkg9Ujdvw2KhJfu4IjMj
         HIdafbeFVmDkzPhAVLpaBbWAS0qoYOvN3o3JPmMUPsfdFnSVzF5XC+/SfAV7tAEUBmxj
         vFmw==
X-Gm-Message-State: ALyK8tLNCsGKj/+IXKcbkZZhhfcX4cmRbI0/A5qG9VrBFkejPhVmgGtxh5jxcm7aOabPjQjqKn+O1laYZB0dGA==
X-Received: by 10.107.130.39 with SMTP id e39mr10818090iod.66.1468676929584;
 Sat, 16 Jul 2016 06:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.4 with HTTP; Sat, 16 Jul 2016 06:48:49 -0700 (PDT)
From:	Herczeg Zsolt <zsolt94@gmail.com>
Date:	Sat, 16 Jul 2016 15:48:49 +0200
Message-ID: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
Subject: Git and SHA-1 security (again)
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Dear List Members, Git Developers,

I would like to discuss an old topic from 2006. I understand it was
already discussed. The only reason i'm sending this e-mail is to talk
about a possible solution which didn't show up on this list before.

I think we all understand that SHA-1 is broken. It still works perfect
as a storage key, but it's not cryptographically secure anymore. Git
is not moving away from SHA-1 because it would break too many
projects, and cryptographic security is not needed but git if you have
your own repository.

However I would like to show some big problems caused by SHA-1:
 - Git signed tags and signed commits are cryptographically insecure,
they're useless at the moment.
 - Git Torrent (https://github.com/cjb/GitTorrent) is also
cryptographically broken, however it would be an awesome experiment.
 - Linus said: "You only need to know the SHA-1 of the top of your
tree, and if you know that, you can trust your tree." That's not true
anymore. You have to trust your computer, you servers, your git
provider in a way that no-one can maliciously modify your data.

I understand that git is perfect for a work flow, where you have your
very own repository and you double-check any commits or diffs you
accepting to it. But that's not everybody's work flow. For example: if
I want to blindly trust my college, I could just include all commits
he signed without review. Currently I can't do that. There are
workarounds of course: signing the e-mail he sends me, or signing the
entire git repository's tarball, etc... But that's not the right way
to do things.

As a final thought on this, I would like to say: Git is a great tool,
but it can be so much better with a safe hash.


I would like to propose a solution for changing git's hash algorithm:
It would be a breaking change, bit I think it can be done pretty
painless. (If you read the discussion back in 2006 the problems of
moving are clear.)

In git, every data has to have one and only one key - so a hybrid hash
is a no-go. That means changing hash algo involves re-hashing every
data in a git repository, but it's not that bad. On a git clone, we
actually re-hash everything to check integrity. Changing all the keys
shouldn't be worth than that.

But - and that's the main idea i'm writing here - changing the storage
keys does not mean you should drop your old hashes out. If you change
the git data structure in a way, that it can keep multiple hashes for
the same "link" in each objects (trees, commits, etc) you can keep the
old ones right next to the new one. If you want to look up the
referenced object, you must use the newest hash - which is the key.
But if you want to verify some old hash, it's still possible! Just
look up the objects by the new key, remove all the newer generation
keys, and verify the old hash on that.

A storage structure like this would allow a very great flexibility:
 - You can change your hash algorithm in the future. If SHA-256
becomes broken, it's not a problem. Just re-hash the storage, and
append the new hashes the git objects.
 - You can still verify your old hashes after a hash change - removing
the new hashes from the objects before hashing should give you back
the old objects, thus giving you the same hash as before.
 - That makes possible for signed tags, and commits to keep their
validity after hash change! With a clever-enough new format, you can
even keep the validity of current hashes and signs. (To be able to do
that, you should be able to calculate back the current format from the
new format.)

Moving git forward to a format like this would solve the weak-key
problem in git forever. You would be able to configure your key algo
on a per repository basis, you - and git - can do the daily work on
the newest hashes, while still carrying the old hashes and signatures,
in case you ever want to verify them. That would allow repositories to
gracefully change hashes in case they need to, and to only
compatibility limitation is that you must use a new enough git to
understand the new storage format.

What are your thoughts on this approach? Will git ever reach a release
with exchangeable hash algorithm? Or should someone look for
alternatives if there's a need for cryptographic security?

Thank you for your time reading this.

References:
SHA-256 discussion in 2006:
http://www.gelato.unsw.edu.au/archives/git/0608/26446.html
Discussion about git signatures in 2014
https://www.mail-archive.com/git%40vger.kernel.org/msg61087.html
Linus's talk on git
https://www.youtube.com/watch?v=4XpnKHJAok8&t=56m20s

Kind regards,
Zsolt Herczeg
