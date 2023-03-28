Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258DC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjC1OyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjC1Ox7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:53:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F95DCC16
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680015234; i=johannes.schindelin@gmx.de;
        bh=ZatHaRPaZ20S1c9CrJwHivHWfk8noxrsMG4/Dfq1StU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JovANRfUB/ZK23TyCK43AY8ko7YItookJ5wlGcBh5VULhK8m78RrQFqWLRt+/I2PX
         V/TL563Sy0B8g8hSXFhAB8vT4AyEeeTqJqs7QWSOWQYefRc/SUx+2WuVM48/SAc0HB
         fgMAb3rHMqdE40IJLU43b+KfNhZ9im4tgPbY5YEGMunL00IpXb93Qx0KgXb9Q/rhjQ
         FNPOGLrWwjHRmfNVaUK7YWrBaddy5O5407E0yisXl7Uv/jT9h1vEKEPQSwN/ZrnU9k
         t0IYpumTEc1QSktpKDS28WFOaElkr5gT1/y5iBHbaYK/+4AQh1LywPVH6V6KDrY8Hf
         MjFfz/umSPSXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5QF-1pdXQD10cB-00FALd; Tue, 28
 Mar 2023 16:53:54 +0200
Date:   Tue, 28 Mar 2023 16:53:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rebase: implement --rewind
In-Reply-To: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
Message-ID: <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de>
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1HTh9KMg4oS1mhIbnzNrHlvDHvZ+K1Bv4kAKaI2bulSLD8+89Ko
 VA566Hu4A60PQ0x1tbJKJbEgSB1R4SwASluGUKrGsOAqMPxRZ8owovw2Ym/oPwisrWzfMa9
 Lfszg6N5Q3v2TaIX7+eVZDu/T357/6+6/8ElkibavsatIYLmXkVZS73fl4mLnIO72VijWME
 HksatH+nb8JOek9MZjs2g==
UI-OutboundReport: notjunk:1;M01:P0:xp+Rznf52sU=;aTvKqXRMXIFMx1881IycG9kN8Yp
 7/fQGK1cH2QQXEDJmlgiRWwLVakvEyXCZdpe5ZgNcxwHCZOzSjLFjkBqiTLHm1vIqWWZKe+ab
 4fNbwOY/5T7GV8nFTD4lW1W6dnPMCq7nHetGmI2ejE0+kt6uOmKTYD3xXlex8+wPLp7xaf6Rb
 1ihjLdLSPf1gDe3GMGt+VS4LRPUG91mc7Rr+zQgPgMB3GnvARx2PlaKrQ9jpcFXyFqsZixRSS
 OwhD1irvzNqquqKUt2lyUUf/dLyTr8C8ufROi/PMQoIqmNNRoAp7KXnTToEX+1ri2sZiYnSUG
 UMveOwm7/K+TbCIMDLzgSZYFDPdVFIpwQ9vsGLcfgasFUhiGgSMwtl9X4uegG85APZx1xcr1l
 gPAizoi7ngYidC3Og7K8BdFV3UVysq7ZEBXLY2Qkb3jLSrdklIAWQOyXYfD0WmmOUHoLfcFTc
 CJRIAL3tSlKauY9zuRRNrNtzzOZax6+g82AqmdFx5V+6DnmbytUAux6xq8N3KIvrOxpE5OEui
 /FmaBmh4W8gK7p7jjD+yt3+0Z+OrvWGnHy3EmqYOsBDBA7Zqef8+UUUQX4exbtAmRm3n0V8Eo
 S+qZHaIZH3vuG+9caYpNQx1rhhdhnqd3MYBqpeP9vVmmEfwDuEUmeu2NxLLkzEnrCppdSecgA
 5bQe7no1ywMNTeal/T6F7n3VBEcd9nuroQ3Shw2QY6P4nS5gtRF3HZz9yfDw9eJeWXL19II0J
 fUvJSZDGDcU8456g8XVjXKlhepDfDDTkdqjJ11vTy4cnkpbh5/5pzTREOMMkbx2OddFayzU17
 icyYx/oK/tHOJ5H0clDizO7+qWnFq1CUle7YFgrQMT9bwnzleovuAikwZuSUCOIGYt+Io/Mln
 WpmZw/dXXtsQ4Duo1YCHRfC0M521tLu5o6GTQltA0maQcwjiAlF3/vPHKEkM1QtJK/p/NuArm
 LmhGo9SmawukURZZ3Yr17Y6PAgA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald,

On Thu, 23 Mar 2023, Oswald Buddenhagen wrote:

> This is fundamentally --edit-todo, except that we first prepend the
> already applied commits and reset back to `onto`. This is useful when
> one finds that a prior change needs (further) modifications.
>
> This patch implements "flat" rewind, that is, once the todo edit has
> been committed, one can abort only the complete rebase. The pre-rewind
> position is marked with a `break` command (these pile up when rewinding
> multiple times; the user is expected to clean them up as necessary).
>
> An alternative to that would be "nested" rewind, where one can return to
> the pre-rewind state even after committing the todo edit. However, this:
> - would add somewhat significant complexity due to having to maintain a
>   stack of todos and HEADs
> - would be mildly confusing to use due to needing to track the state of
>   the stack. One could simplify this somewhat by hiding the rest of the
>   previous todo before nesting, but this would be somewhat limiting in
>   turn (one might want to defer a factored out hunk, and stashing it is
>   not necessarily the most elegant way to do it).
> - would be of somewhat limited usefulness, speaking from experience
>
> This patch leaves transitive resolution of rewritten-list to the
> consumer. This is probably a bad idea.
> Somewhat related to that, --update-refs isn't properly handled yet.

This is an interesting idea but I do not think that the concept in its
current form mixes well with being in the middle of a `--rebase-merges`
run. Which is what I would want to see supported because I find myself
wishing for _something_ like this [*1*].

On the other hand, it might often be good enough to redo only the commits
between `onto` and `HEAD`, not the complete rebase script that's now in
`done`. But then it does not strike me so much as "rewinding" but as
"nesting.

In other words, I would then prefer to see support for `git rebase -i
=2D-nested` be added. I wrote up my thoughts about this in
https://github.com/gitgitgadget/git/issues/211 and was tempted several
times to start implementing it already, only for other, more pressing
things to come up and take my attention.

What do you think, would you be amenable to combine efforts?

Ciao,
Johannes

Footnote *1*: I usually find myself adding a temporary worktree with a
detached `HEAD`, performing the nested rebase, and then resetting the
original worktree to the output of `rev-parse HEAD` in the temporary
worktree. Cumbersome, yes, and it works, but yes, I dearly want something
that works without requiring _me_ to keep tabs on the state.
