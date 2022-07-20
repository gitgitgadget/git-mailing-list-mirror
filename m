Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B3C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 22:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiGTWKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGTWKb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 18:10:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C615A26
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 15:10:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KMAK8v031000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 18:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658355023; bh=EWSXfcwm2S4YXaYhShMrZ2fT4mQEDn5jpVbK2sWcHhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=A9wou3qVrMfvGt2QtCZtkFNrxQKAYgDrZdnpVgLSk5T26B7pWXyNxuyezdfPAAbUL
         e9udfeQHC0JPFYv2wXgoV30cA0Ipc55Oa9pokGQTAzD8nGuv44CwxGVxL9TJXklO2o
         ke1DoLrEy/7JLUC2MZnVyAfU6NfbRGFsPJrEBD6Ltlr+/rUYrzzyt63usU4ydjXty6
         oMJaggG7UXLAsukz4/TrewlVHlgwICuTtwKN0OTnUvd42SIFnmFPMTCPdD0wjRfNEi
         bYBewt6CC+vJQifbuNqTTVoaZl5waEzSnrG7omF4MnsnnCtfdXG3l7GuB2olQUw5wp
         P4tn1KntcK/Eg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 252A515C3EBF; Wed, 20 Jul 2022 18:10:20 -0400 (EDT)
Date:   Wed, 20 Jul 2022 18:10:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Glen Choo <chooglen@google.com>,
        Stephen Finucane <stephen@that.guru>, git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <Yth9TCCEXfmagaaw@mit.edu>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <20220718173511.rje43peodwdprsid@meerkat.local>
 <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220720192144.mxdemgcdjxb2klgl@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720192144.mxdemgcdjxb2klgl@nitro.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 03:21:44PM -0400, Konstantin Ryabitsev wrote:
> The kernel community has repeatedly rejected per-patch Change-id trailers
> because they carry no meaningful information outside of the gerrit system on
> which they were created. Seeing a Change-Id trailer in a commit tells you
> nothing about the history of that commit unless you know the gerrit system on
> which this patch was reviewed (and have access to it, which is not a given).

The "no meaningful information outside of the gerrit system" is the
key.  This was extensively discussed in the
ksummit-discuss@lists.linux-foundation.org mailing list in late August
2019, subject line "Allowing something Change-Id (or something like
it) in kernel commits".  Quoting from Linus Torvalds:

    From: Linus Torvalds
    Date: Thu, 22 Aug 2019 17:17:05 -0700
    Message-Id: CAHk-=whFbgy4RXG11c_=S7O-248oWmwB_aZOcWzWMVh3w7=RCw@mail.gmail.com

    No. That's not it at all. It's not "dislike gerrit".

    It's "dislike pointless garbage".

    If the gerrit database is public and searchable using the uuid, then
    that would make the uuid useful to outsiders. And instead of just
    putting a UUID (which is hard to look up unless you know where it came
    from), make it be that "Link:" that gives not just the UUID, but also
    gives you the metadata for that UUID to be looked up.

    But so far, in every single case the uuid's I've ever seen have been
    pointless garbage, that aren't useful in general to public open source
    developers, and as such shouldn't be in the git tree.

    See the difference?

    So if you guys make the gerrit database actually public, and then
    start adding "Link: ..." tags so that we can see what they point to, I
    think people will be more than supportive of it.

    But if it's some stupid and pointless UUID that is useful to nobody
    outside of google (or special magical groups of people associated with
    it), then I will personally continue to be very much against it.

So....  imagine if we had some kind of search service, maybe homed at
lore.kernel.org, where given a particular "Change Id" --- and it could
look either like a Gerrit-style Change-Id or something else like a URL
or URL-like (it matters not) the search service could give you a list
of:

  * All mailing list threads where the body contained the "Change-Id:
    XXX" id, so we could find the previous versions of the commit, and
    the reviews that took place on a mailing list.  (And this could be
    either a pointer to lore.kernel.org and/or a patchwork URL.)

  * All URL's to public gerrit servers where that patch may have been reviewed.

  * A list of git Commit ID's from a set of "interesting" git trees
    (e.g., the upstream Linux tree, the Long Term Stable trees, maybe
    some other interesting trees ala Android Common, etc.

If we had such a thing, as opposed to something that only worked in a
closed private garden like an internal Gerrit server sitting behind a
corporate firewall, even if the patch initially was developed in a
closed private Gerrit ecosystem --- if the moment it was published for
external upstream review, it would get captured by this search
service, then the Change ID would be useful.  And if that Change ID
could also be used to find out how the patch was ported to various
stable or productg trees, then it would be even more useful --- and
then people would probably find it to be useful, and resistance to
having a per-commit Change-ID would probably drop, or perhaps, even
enthusiastically embraced, because people could actually see the
*value* behind it.

To do this, we would need to have various tools, such as Patchwork,
Gerrit, Git, public-inbox, etc., treat Change-ID as a first-class
indexed object, so that you could quickly map from a Change-ID to a
git commit in a particular git tree (if present), or to set of
public-inbox URL's, or a set of patchwork URL's, etc.

And then we would need some kind of aggregation service which would
aggregate the information from all of the various sources
(public-inbox, git, Gerrit, Patchwork, etc.) and then gave users a
single "front door" where they could submit a Change-Id, and find all
the patch history, patch review comments, and later, patch backports
and forward ports.

The question is ---- is this doable?   And who will do the work?   :-)

    	     	     	     	       - Ted
