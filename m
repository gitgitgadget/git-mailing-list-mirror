Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F0C1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 04:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966559AbeBOExI (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 23:53:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51629 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966421AbeBOExH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 23:53:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78265D5145;
        Wed, 14 Feb 2018 23:53:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=zPVmYLH7DlNqG
        Tx2A0atzai4Ork=; b=uXaiK6ogKos53tMu+Xm4pcL1SyWe08rJLwluQz18LCWbT
        UVTUSXoU5aCvKNHKjB9CufpgDMF+td6CXjQSLtvcqxblqoSXdYT22fagWT3WPWQp
        4+LT3Xc6WtpUUrSg0G2Itm2EU8Oo1xPdBqJehf6hMLFlyb+EdEsy3v+fENpAnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=GIqt4Jh
        LWPZIkNRNm51X8Y1Ikt0ex1GEpxk9UrVjdna3MyQvfN7LZ8eThkVk2fzqzrJH++i
        PXzh/KjscgN5mZQ/V+pRpQf8h18Bl5pRFiRbN7Sk1yxs4nDlea2Pr81ODO0ro7R5
        f4A5PVpSnU7zmVS1J/SGrBiAmQXaaulSC4lo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F0CBD5144;
        Wed, 14 Feb 2018 23:53:04 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA36BD5143;
        Wed, 14 Feb 2018 23:53:03 -0500 (EST)
Date:   Wed, 14 Feb 2018 23:53:02 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
Message-ID: <20180215045301.GC27038@zaya.teonanacatl.net>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180214222146.10655-4-avarab@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Pobox-Relay-ID: 1B315B14-120C-11E8-AAD4-692D1A68708C-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C6var,

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> +Git::LoadCPAN - Wrapper for loading modules from the CPAN (OS) or Git'=
s own copy
> +
> +=3Dhead1 DESCRIPTION
> +
> +The Perl code in Git depends on some modules from the CPAN, but we
> +don't want to make those a hard requirement for anyone building from
> +source.
> +
> +Therefore the L<Git::LoadCPAN> namespace shipped with Git contains
> +wrapper modules like C<Git::LoadCPAN::Module::Name> that will first
> +attempt to load C<Module::Name> from the OS, and if that doesn't work
> +will fall back on C<Git::FromCPAN::Module::Name> shipped with Git
> +itself.
> +
> +Usually OS's will not ship with Git's Git::FromCPAN tree at all,
> +preferring to use their own packaging of CPAN modules instead.

This is something I wondered about.  What's the recommended
method to ensure git packaged for an OS/distribution doesn't
ever use the fallbacks?  Remove $perllibdir/Git/FromCPAN
after make install?

If so, would it be useful to add a Makefile knob to not
install the FromCPAN bits, which may be generally useful to
packagers?

Something like the following, perhaps?

(I'd feel bad suggesting this without a patch, after all the
work you've already done to simplify and improve the perl
bits.)

---- 8< ----
From: Todd Zullinger <tmz@pobox.com>
Date: Wed, 14 Feb 2018 23:00:30 -0500
Subject: [PATCH] Makefile: add NO_PERL_CPAN to disable fallback module in=
stall

As noted in perl/Git/LoadCPAN.pm, operating system packages often don't
want to ship Git::FromCPAN tree at all, preferring to use their own
packaging of CPAN modules instead.  Allow such packagers to set
NO_PERL_CPAN to easily avoid installing these fallback perl CPAN
modules.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 5bcd83ddf3..c4e035e5bf 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,9 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define NO_PERL_CPAN if you do not want to install fallbacks for perl C=
PAN
+# modules.
+#
 # Define PYTHON_PATH to the path of your Python binary (often /usr/bin/p=
ython
 # but /usr/bin/python2.7 on some platforms).
 #
@@ -2572,6 +2575,7 @@ ifndef NO_GETTEXT
 endif
 ifndef NO_PERL
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perllibdir_SQ)'
+	test -z "$(NO_PERL_CPAN)" || rm -rf perl/build/lib/Git/FromCPAN
 	(cd perl/build/lib && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
 	$(MAKE) -C gitweb install
--=20
2.16.1

I don't particularly like NO_PERL_CPAN, but I'm confident
someone else will suggest an obviously better name.

I thought about moving the 'rm -rf Git/FromCPAN' after the
tar/untar, to keep the files in place for the tests.  No
tests seem to rely on those local files, so I stuck with
removing them before.  That diff was:

--- a/Makefile
+++ b/Makefile
@@ -2574,6 +2574,7 @@
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perllibdir_SQ)'
 	(cd perl/build/lib && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
+	test -n "$(NO_PERL_CPAN)" && rm -rf '$(DESTDIR_SQ)$(perllibdir_SQ)'/Git=
/FromCPAN
 	$(MAKE) -C gitweb install
 endif
 ifndef NO_TCLTK

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Man has made use of his intelligence, he invented stupidity.
    -- Remy De Gourmant

