Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D1C43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 19:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860D421532
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 19:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="iBXnH0Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIGTpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 15:45:34 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47832 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbgIGTpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 15:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1599507930; bh=pCKSFzmbhHW7ZWeDqAW04cmS35sf1yUAXpTI1ymZR3k=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=iBXnH0Cszn+7A0XC4LrMkQmf0DrQhRTPgykuGg6E4wHNOT5VPcjKtzcBp7I0lCqFJ
         xvcYCBZAHccdwZ/fCp0d2jAkirYxrXwkJ40qVCf0b3S1CoeXmNcfGQjzRJVeIm9Z2O
         X/l7iJyrY1m0esxonCBp8lovKEQrC50uKA5eEttY=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: Proposal: server-advertised config options
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Mon, 07 Sep 2020 15:23:15 -0400
Message-Id: <C5HDRLX7ZPR5.1TFS72T7PBXSJ@homura>
In-Reply-To: <xmqqimcp1kvf.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Sep 7, 2020 at 2:51 PM EDT, Junio C Hamano wrote:
> Assuming I am among the guys (do you solicit opinions from gals, by
> the way?), here are a few unconnected random thoughts.

Guys is gender netural where I'm from, of course guys and gals and
anyone else are invited to comment :)

> I do not want to see this as a "server" thing. All the examples are
> "per project preference" and I do agree it would be nice to have a
> standardised way for projects to communicate their preference to
> their participants. Regardless of the hosting site I clone and
> fetch my project from, I'd want to see it communicated consistently
> to them.

The server I have in mind (git.sr.ht) is a little bit different in that
most of those examples I gave would be configured automatically on the
server side. My server software knows where your mailing list is, for
example. My goal is to try and make this as hands-off and "it just
works" as possible.

> In addition to your examples of "per project preference", there are
> projects' coding style guides, etc., that we do not enforce as git
> config at all, e.g. how wide your editors TAB and single level of
> indentation should be. It will unnecessarily narrow your view to
> assume that the kind of "per project preference" you convey from the
> project to its participants need to be the Git configuration and
> nothing else.

I think there's a difference between preferences regarding the contents
of the repository (e.g. style guide), and preferences regarding the
administration and usage of the repository itself (e.g. this feature I'm
proposing). I think the argument for integration with git is much
stronger for the latter.

> All of the above leads to a design to have a common convention
> widely shared among projects to express project preferences over
> different kind of tools, among which Git is one of them, and store
> it in a known location in the projects' trees. Most importantly,
> there must not be any Git protocol extension for doing this kind of
> thing.

Storing a file in your project tree to handle this configuration would
eliminate the "hands off" feature I was aiming for. We also have a
policy which forbids our software from making any automated changes to
the contents of your git repository - we just don't consider it
appropriate in the domain of our server software's responsibilities.

Some sort of common config file for this purpose, in-tree, would perhaps
be useful, but it would remove a lot of the value-add that I'm seeking
to provide. I already posess most of the necessary information
server-side and I can offer it to clients without any explicit
involvement from the project maintainers.

Also, the conventions for tooling-related files in-tree like this is
currently very disorganized within the ecosystem. Between .editorconfig,
.gitattributes, .github/funding.yml, a dozen CI systems, and who knows
what else, there's no common consensus on where to put files like this
or what they should look like. I think that securing consensus for this
would involve reaching out to these projects, and the scope of that
effort and the necessary follow-up developments and compatibility
planning on behalf of these projects would be...  astonishingly large.

And, ultimately, even with a common configuration, we'd end up having to
add vendor-specific extensions, for example to support the example of
push options given in the initial mail.

So, in summary, based on your suggestions this proposal could grow
10x-100x in scope and lose no small degree of the desired utility. Maybe
yours is a worthwhile idea, but it poorly solves the particular problem
I set out to solve and I lack the time/motivation to work on that
approach.
