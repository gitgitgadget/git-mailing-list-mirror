Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F8D2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 01:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbcJ0Bwg (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 21:52:36 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:46531 "EHLO
        homiemail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932707AbcJ0Bwf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Oct 2016 21:52:35 -0400
X-Greylist: delayed 9905 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Oct 2016 21:52:35 EDT
Received: from homiemail-a9.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTP id CE7BE5BE06B;
        Wed, 26 Oct 2016 18:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=japGXY0QV8EH5MuB2sAIYiACvEI=; b=o/Orlcro2t
        5X+kUtS2V/8BSSBIB2H76xOE8Jljsbh++iP806WBvSEcxp1ok0xfwLGHn8BiKfPR
        xjaggNw27R8VDsuXio4ntM+wwDjIMrwBQ6JuSrGTqctlC2OueA+HCp1d6OZxr/lx
        78q19z8TKMuh4mTSm16pNZyxEkkG0m9bI=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTPSA id 5D0CE5BE066;
        Wed, 26 Oct 2016 18:52:34 -0700 (PDT)
Message-ID: <1477533150.2764.147.camel@mattmccutchen.net>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and
 rebase
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Date:   Wed, 26 Oct 2016 21:52:30 -0400
In-Reply-To: <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
References: <1477523244.2764.114.camel@mattmccutchen.net>
         <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

I appreciate the effort to remove obstacles to the use of submodules!
=C2=A0It looks like a custom tool is probably still our best option at th=
is
time, though we can always switch back to submodules later.

On Wed, 2016-10-26 at 16:23 -0700, Stefan Beller wrote:
> On Wed, Oct 26, 2016 at 4:07 PM, Matt McCutchen <matt@mattmccutchen.net=
> wrote:
> > - We have to make separate commits and manage corresponding topic
> > branches for the superproject and subprojects.
>=20
> Well yeah, that is how submodule work on a conceptual level.
> While having multiple commits may seem like overhead, note
> the subtle difference for these commits. One if deep down in the
> stack patching one of the submodules, the other is a high level
> commit advancing the submodule pointer.
>=20
> Note that the target audience of these two commit messages
> might be vastly different, hence can be worded differently.
> (The submodule describing how you fixed e.g. a memleak or race conditio=
n
> and the superproject describes on why you needed to include that submod=
ule,
> e.g. because you switched your toplevel application to use threads.)

I understand one can adhere to that philosophy, but I don't see the
practical benefit of doing so in our case compared to using a "git
subtree"-like approach and making a single commit. =C2=A0It would just be=
 us
looking at both commits. =C2=A0If we do upstream any of the library chang=
es,
we'll probably have to rework them anyway.

> > - A diff of the superproject doesn't include the content of
> > subprojects.

> Although this is just Git, you probably also have a code review system =
that
> would need that change as well.

Indeed. =C2=A0We currently use Bitbucket. =C2=A0I'd be open to switching,=
 though
maybe not just for this.

> Is there anything else besides these 3 points that encourages you to
> switch away from submodules?

Those 3 are the ongoing pain points I can think of. =C2=A0There are a few
other drawbacks compared to "git subtree" that come up less often:

1b. On another project, I was working with a teammate who was new to
version control and not very careful, who forgot to run "git submodule
update" and ended up committing back the old submodule pointer.
=C2=A0Thankfully, this hasn't happened yet on my current project.

4. I pushed several dangling submodule pointers before I learned I
could set push.recurseSubmodules =3D check. =C2=A0This isn't the default;=
 each
developer has to do it manually. =C2=A0(In theory, I could put such thing=
s
in a setup script for them to run if they trust me.)

5. Stashing changes to both the superproject and the subproject takes
more steps.

6. I use multiple worktrees (with "git worktree") because of #5 and
also so that I can run two versions of the application at the same time
and compare the behavior. =C2=A0Using "git worktree" with submodules is
officially unsupported, though I was able to get things working by
manually editing some files.

7. We have to set up a repository for each subproject on our hosting
service. =C2=A0Anyone who forks our application and modifies a subproject
has to set up a subproject repository and carry a change to .gitmodules
to point to their repository. =C2=A0If we use relative URLs in .gitmodule=
s,
it's even worse: anyone who forks our application has to set up
repositories for all the subprojects, even if they don't modify them.

Matt
