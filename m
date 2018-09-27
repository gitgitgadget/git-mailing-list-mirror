Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395C41F453
	for <e@80x24.org>; Thu, 27 Sep 2018 14:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeI0VCy (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:02:54 -0400
Received: from ao2.it ([92.243.12.208]:34399 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeI0VCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=u+r0hbYh27rnabjUVPnc9za15ypp43zUkIG8NaXrKgQ=;
        b=Y+glVz6cXWPA9BposEr3nW7fzviWturTxvcT4Jg5A0fsCrrfuOoLlwYK6cF8SmCj+Kk+TC9TnNc+MNuNiqXA/QINgixgY38xPXdVwcSwsrpaaY5hfROqhESNsgPe8qA6nVIDFgOOAI9GOKZHL6NyJYNj3G8xSmeAkFKYmMR1f6coXsnYDhNDGhj+sq9EkLwY8ahnlujqug6Q9TUHqToo3mo3VM8NjcqlLO2KPGdOjZsB2m5noJjm57Kg2/tTPcCm8esW4k+6lEOsEIbKcsYkCObv0nVI0eX+zAC4wGn9mHUSSF6xzEh5zikqsY+xMrfJZJXoBTEAGbf4mzqj6aFfPA==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g5XUF-0006JR-6p; Thu, 27 Sep 2018 16:41:51 +0200
Date:   Thu, 27 Sep 2018 16:44:15 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's
 not in the working tree
Message-Id: <20180927164415.44b1d00ee5f8e582afdaa933@ao2.it>
In-Reply-To: <CAGZ79kZaomuE3p1puznM1x+hu-w4O+ZqeGUODBDj=-R3Z1hDzg@mail.gmail.com>
References: <20180917140940.3839-1-ao2@ao2.it>
        <20180917140940.3839-10-ao2@ao2.it>
        <20180918171257.GC27036@localhost>
        <20180924122031.9dbec6b4c2e2a8c1bff3365b@ao2.it>
        <CAGZ79kZaomuE3p1puznM1x+hu-w4O+ZqeGUODBDj=-R3Z1hDzg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 24 Sep 2018 14:00:50 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Mon, Sep 24, 2018 at 3:20 AM Antonio Ospite <ao2@ao2.it> wrote:
>=20
[...]
> > This is a limitation of the object store in git, there is no equivalent
> > of get_oid() to get the oid from a specific repository and this affects
> > config_with_options too when the config source is a blob.
>=20
> Not yet, as there is a big push to pass-through an object-store object
> or similar recently and rely less on global variables.
> I am not sure I get to this code, though.
>

If you end up touching get_oid() please CC me.

> > This does not affect commands called via "git -C submodule_dir cmd"
> > because in that case the chdir happens before the_repository is set up,
> > for instance "git-submodule $SOMETHING --recursive" commands seem to
> > change the working directory before the recursion.
>=20
> For this it may be worth looking into the option
>        --super-prefix=3D<path>
>   Currently for internal use only. Set a prefix which gives a
>   path from above a repository down to its root. One use is
>   to give submodules context about the superproject that
>   invoked it.
>

My comment wanted to highlight that there are NO problems in the
mentioned cases:

  - git -C submodule_dir cmd
  - git submodule cmd --recursive

Are you suggesting to look into super-prefix for any reason in
particular?

[...]
> > The test suite passes even after removing repo_read_gitmodules()
> > entirely from builtin/grep.c, but I am still not confident that I get
> > all the implication of why that call was originally added in commit
> > f9ee2fcdfa (grep: recurse in-process using 'struct repository',
> > 2017-08-02).
>=20
> If you checkout that commit and remove the call to repo_read_gitmodules
> and then call git-grep in a superproject with nested submodules, you
> get a segfault.
>=20
> On master (and deleting out that line) you do not get the segfault,
> I think praise goes to ff6f1f564c4 (submodule-config: lazy-load a
> repository's .gitmodules file, 2017-08-03) which happened shortly
> after f9ee2fcdfa.
>=20
> It showcased that it worked by converting ls-files, but left out grep.
>=20
> So I think based on ff6f1f564c4 it is safe to remove all calls to
> repo_read_gitmodules.
>

Thanks for confirming.

> > Anyways, even if we removed the call we would prevent the problem from
> > happening in the test suite, but not in the real world, in case non-leaf
> > submodules without .gitmodules in their working tree.
>=20
> Quite frankly I think grep was just overlooked in review of
> https://public-inbox.org/git/20170803182000.179328-14-bmwill@google.com/
>=20

OK, so the plan for v6 is:

  - avoid the corruption issues spotted by G=E1bor by removing the call
    to repo_read_gitmodules in builtin/grep.c (this still does not fix
    the potential problem with nested submodules).

  - add a new test-tool which better exercises the new
    config_from_gitmodules code,

  - add also a test_expect_failure test to document the use case that
    cannot be supported yet: nested submodules without .gitmodules in
    their working tree.

Thanks,
   Antonio

--=20
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
