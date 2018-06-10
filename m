Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099721F403
	for <e@80x24.org>; Sun, 10 Jun 2018 02:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeFJC2G (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 22:28:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57722 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753615AbeFJC2F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 22:28:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E71EFE826C;
        Sat,  9 Jun 2018 22:28:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=w421egcfomCo6
        9e54NWim3A9KEU=; b=RlqwGrKXz8Rdq19GwEcxnn0IeWqIIfUK4BSwN0z49ygei
        c4pT0FK4ztS7vHeTS/nGVwIv791SmUa23lp8Tx9YGhS91x63ZmIGcjyXCJ3Hwn/4
        WdCmxNltgl/5Br1GhhMCwZclkPsiulisWMFPmxaoJ+VzoBVCcMbqdMHyFBYajY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=suX6E0O
        iUJ5eOYX+6/vNnGVBWGoLEwri2Tw4H6wveIM6GSlYUvL6TGaUygzWNCwQKGuJS7a
        //t25xCkzVgqoOW5S/ReQb7q9IqYF5Zbo8vpwZL7Lu5iU6OF034auvt5qT9Zhiy5
        AQrdXu7GUX++ROE1O4PLCciI9Xvrz9hVAnHI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFA34E826B;
        Sat,  9 Jun 2018 22:28:04 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 518BBE826A;
        Sat,  9 Jun 2018 22:28:04 -0400 (EDT)
Date:   Sat, 9 Jun 2018 22:28:02 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Luis Marsano <luis.marsano@gmail.com>
Cc:     git@vger.kernel.org, Ted Zlatanov <tzz@lifelogs.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 0/2] contrib/credential/netrc Makefile & test
 improvements
Message-ID: <20180610022802.GX3094@zaya.teonanacatl.net>
References: <20180607051958.759-1-tmz@pobox.com>
 <CAHqJXRHGq9ofPcCzffUbTmuL6fuoB=33aZnwqNdqYy+nAVA_gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHqJXRHGq9ofPcCzffUbTmuL6fuoB=33aZnwqNdqYy+nAVA_gw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: E753DCD2-6C55-11E8-AEA3-67830C78B957-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luis,

Luis Marsano wrote:
> Thanks for looking into this and addressing these issues.

And thank you for digging further. :)

> On Thu, Jun 7, 2018 at 1:20 AM Todd Zullinger <tmz@pobox.com> wrote:
>> I noticed failures from the contrib/credential/netrc tests
>> while building 2.18.0 release candidates.  I was surprised
>> to see the tests being run when called with a simple 'make'
>> command.
>>
>> The first patch in the series adds an empty 'all::' make
>> target to match most of our other Makefiles and avoid the
>> surprise of running tests by default.  (When the netrc
>> helper was added to the fedora builds, it copied the same
>> 'make -C contrib/credential/...' pattern from other
>> credential helpers -- despite the lack of anything to
>> build.)
>=20
> I think this is a good idea.
>=20
>> The actual test failures were initially due to my build
>> environment lacking the perl autodie module, which was added
>> in 786ef50a23 ("git-credential-netrc: accept gpg option",
>> 2018-05-12).
>=20
> I added 'use autodie;' without realizing it had external dependencies.
> According to the documentation
> http://perldoc.perl.org/autodie.html
> it's a pragma since perl 5.10.1
> Removing 'use autodie;' should be fine: it's not critical.

I should clarify that part of why autodie isn't in my build
environment is that the Fedora and RHEL7+ perl packages
split out many modules which are shipped as part of the core
perl tarball.  So while all the platforms I care about have
perl >=3D 5.10.1, the Fedora and newer RHEL systems have the
autodie module in a separate package.

That said, the INSTALL docs still suggest that we only
require perl >=3D 5.8, so if autodie is easily removed, that
would probably be a good plan.

=C6var brought up bumping the minimum supported perl to 5.10.0
last December, in <20171223174400.26668-1-avarab@gmail.com>
(https://public-inbox.org/git/20171223174400.26668-1-avarab@gmail.com/).
The general consensus seemed positive, but I don't think
it's happened.  Even so, that was 5.10.0, not the 5.10.1
which added autodie.

>> After installing the autodie module, the failures were due
>> to the build environment lacking a git install (specifically
>> the perl Git module).  The tests needing a pre-installed
>> perl Git seemed odd and worth fixing.
>=20
> I mistakenly thought 'use lib (split(/:/, $ENV{GITPERLLIB}));' in
> test.pl handled this.
> Since it doesn't, and I was only following an example from
> t/t9700/test.pl that doesn't fit, this line should be removed and it
> might make more sense to set the environment from
> t-git-credential-netrc.sh near '. ./test-lib.sh', which also sets the
> environment.
> Something like
>=20
> diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh
> b/contrib/credential/netrc/t-git-credential-netrc.sh
> index 58191a6..9e18611 100755
> --- a/contrib/credential/netrc/t-git-credential-netrc.sh
> +++ b/contrib/credential/netrc/t-git-credential-netrc.sh
> @@ -23,5 +23,6 @@
>         # The external test will outputs its own plan
>         test_external_has_tap=3D1
>=20
> +       export PERL5LIB=3D"$GITPERLLIB"
>         test_external \
>      'git-credential-netrc' \
>=20
> Your solution, however, is reasonable, and I don't know which is prefer=
red.

I think your placement is better.  As you say, it could also
be placed closer to '. ./test-lib.sh'.

It doesn't come up very often, but I wonder if there's any
downside to having test-lib.sh export PERL5LIB?

> It looks like you found an issue with t/t9700/test.pl, too.
> When altered to fail, it first reports ok (then reports failed and
> returns non-0).
>=20
> not ok 46 - unquote simple quoted path
> not ok 47 - unquote escape sequences
> 1..47
> # test_external test Perl API was ok
> # test_external_without_stderr test no stderr: Perl API failed: perl
> /home/luism/project/git/t/t9700/test.pl:
> $ echo $?
> 1

Oops.  Nice catch.  At least that does exit non-zero I
guess.

> To make git-credential-netrc tests behave correctly, I ended up making
> the changes below.
> They might be okay, unless someone knows better.
>=20
> diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh
> b/contrib/credential/netrc/t-git-credential-netrc.sh
> index 58191a6..9e18611 100755
> --- a/contrib/credential/netrc/t-git-credential-netrc.sh
> +++ b/contrib/credential/netrc/t-git-credential-netrc.sh
> @@ -23,9 +23,10 @@
>         # The external test will outputs its own plan
>         test_external_has_tap=3D1
>=20
> +       export PERL5LIB=3D"$GITPERLLIB"
>         test_external \
>      'git-credential-netrc' \
> -    perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
> +    perl "$GIT_BUILD_DIR"/contrib/credential/netrc/test.pl
>=20
>         test_done
>  )

This reminds me, while we're here it might be worth adding a
whitespace cleanup commit to indent the lines following
test_expect_success and test_external with 2 tabs.

> diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netr=
c/test.pl
> index 1e10010..abc9081 100755
> --- a/contrib/credential/netrc/test.pl
> +++ b/contrib/credential/netrc/test.pl
> @@ -1,6 +1,4 @@
>  #!/usr/bin/perl
> -use lib (split(/:/, $ENV{GITPERLLIB}));
> -
>  use warnings;
>  use strict;
>  use Test::More qw(no_plan);
> @@ -12,7 +10,6 @@ BEGIN
>         # t-git-credential-netrc.sh kicks off our testing, so we have t=
o go
>         # from there.
>         Test::More->builder->current_test(1);
> -       Test::More->builder->no_ending(1);
>  }
>=20
>  my @global_credential_args =3D @ARGV;
> @@ -104,6 +101,9 @@ BEGIN
>=20
>  ok(scalar keys %$cred =3D=3D 2, 'Got keys decrypted by command option'=
);
>=20
> +my $is_passing =3D eval { Test::More->is_passing };
> +exit($is_passing ? 0 : 1) unless $@ =3D~ /Can't locate object method/;
> +
>  sub run_credential
>  {
>         my $args =3D shift @_;

I tested this and it worked well for my builds with and
without the autodie module (passing and failing
appropriately).

Thanks,

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A common mistake people make when trying to design something
completely foolproof is to underestimate the ingenuity of complete
fools.
    -- Douglas Adams

