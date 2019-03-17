Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC46C20248
	for <e@80x24.org>; Sun, 17 Mar 2019 19:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCQTol (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 15:44:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64263 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfCQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 15:44:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD6251446D1;
        Sun, 17 Mar 2019 15:44:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=ObXJtee1wSCnl
        OZ65VOgJg+JGbU=; b=yErcJg0OxNcEiYNX9ZDbPhJPUT0ZGOs2JK8AgNaJJKwav
        GBxTLbWWjWTfZ5ykR0Rz91aheE/rQgEpq/m5OVH9Pzx60Nq5eTPdYmgaWvk2Qv7X
        W3d9zYDWoWT0j9lRTyJGsXb6DZDP05q/8ZRtd3L5vt07diLsRfB43E8/8dEXMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=J4+BNTh
        N8pEawUgq+NUqh/EB9cBRX5UNhMq66C65Z9ycOLZkuN9DrHRHwwWo+AKs8/ZBR/Z
        lXTgwnnfO86n9PhV/xX203vFQt27TgkyECbmOZ47bYc23RUha9dvA8UhVH3GAxVq
        Uk/axzpSPRR4Q9BzlMugcXgicTlBYZhx1W70=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D59811446D0;
        Sun, 17 Mar 2019 15:44:33 -0400 (EDT)
Received: from pobox.com (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58B8C1446CF;
        Sun, 17 Mar 2019 15:44:33 -0400 (EDT)
Date:   Sun, 17 Mar 2019 15:44:31 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190317194431.GY31362@pobox.com>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190317144747.2418514-1-martin.agren@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 168C0A78-48ED-11E9-A8D4-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

Martin =C5gren wrote:
> When we build with AsciiDoc, asciidoc.conf ensures that each xml-file w=
e
> generate contains some meta-information which `xmlto` can act on, based
> on the following template:
>=20
>   <refmeta>
>   <refentrytitle>{mantitle}</refentrytitle>
>   <manvolnum>{manvolnum}</manvolnum>
>   <refmiscinfo class=3D"source">Git</refmiscinfo>
>   <refmiscinfo class=3D"version">{git_version}</refmiscinfo>
>   <refmiscinfo class=3D"manual">Git Manual</refmiscinfo>
>   </refmeta>
>=20
> When we build with Asciidoctor, it does not honor this configuration fi=
le
> and we end up with only this (for a hypothetical git-foo.xml):
>=20
>   <refmeta>
>   <refentrytitle>git-foo</refentrytitle>
>   <manvolnum>1</manvolnum>
>   </refmeta>
>=20
> That is, we miss out on the `<refmiscinfo/>` tags. As a result, the
> header of each man page doesn't say "Git Manual", but "git-foo(1)"
> instead. Worse, the footers don't give the Git version number and
> instead provide the fairly ugly "[FIXME: source]".
>=20
> That Asciidoctor ignores asciidoc.conf is nothing new. This is why we
> implement the `linkgit:` macro in asciidoc.conf *and* in
> asciidoctor-extensions.rb. Follow suit and provide these tags in
> asciidoctor-extensions.rb, using a "postprocessor" extension.

Nice!  I looked at this a long time ago and didn't figure
out how to use a postprocessor extension.  From my notes, I
found discussions about using ruby's tilt for templating and
it all seemed way too convoluted.

Your method looks quite simple and elegant.

> We may consider a few alternatives:
>=20
>   * Provide the `mansource` attribute to Asciidoctor. This attribute
>     looks promising until one realizes that it can only be given inside
>     the source file (the .txt file in our case), *not* on the command
>     line using `-a mansource=3Dfoobar`. I toyed with the idea of inject=
ing
>     this attribute while feeding Asciidoctor the input on stdin, but it
>     didn't feel like it was worth the complexity in the Makefile.

I played with this direction before.  Using Asciidoctor we
can convert directly from .txt to man without docbook
and xmlto.  That does have some other issues which need to
be worked out though.  Here's what I had as a start:

-- 8< --
Subject: [PATCH] WIP: doc: improve asciidoctor manpage generation

Avoid 'FIXME: Source' by setting mansource.  Skip xmlto step and render
manpages directly with asciidoctor.

TODO:
    - apply to all man pages
    - fix links to html docs, like user-manual.html in git.1 (currently
      it is listed in brackets inline rather than as a footnote)

Reference:
https://lore.kernel.org/lkml/20180424150456.17353-1-tiwai@suse.de/
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/Makefile                  | 8 ++++++++
 Documentation/asciidoctor-extensions.rb | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a9697f5146..494f8c9464 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -197,6 +197,7 @@ ASCIIDOC_DOCBOOK =3D docbook45
 ASCIIDOC_EXTRA +=3D -acompat-mode -atabsize=3D8
 ASCIIDOC_EXTRA +=3D -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA +=3D -alitdd=3D'&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA +=3D -a mansource=3D"Git $(GIT_VERSION)" -a manmanual=3D"=
Git Manual"
 DBLATEX_COMMON =3D
 endif
=20
@@ -354,9 +355,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
=20
+ifndef USE_ASCIIDOCTOR
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+else
+%.1 %.5 %.7 : %.txt
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(ASCIIDOC_COMMON) -b manpage -d manpage -o $@+ $< && \
+	mv $@+ $@
+endif
=20
 %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asci=
idoctor-extensions.rb
index f7a5982f8b..ebb078807a 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -12,6 +12,8 @@ module Git
         if parent.document.basebackend? 'html'
           prefix =3D parent.document.attr('git-relative-html-prefix')
           %(<a href=3D"#{prefix}#{target}.html">#{target}(#{attrs[1]})</=
a>\n)
+        elsif parent.document.basebackend? 'manpage'
+          "#{target}(#{attrs[1]})"
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
-- 8< --

That was based on ma/asciidoctor-extensions, but it may be
missing other recent improvements you've made to the make
targets.  It's been a month or so since I worked on it.

I munged up doc-diff to set MANDWIDTH=3D1000 and set one
branch to default to asciidoctor to compare.  (Your other
recent series looks like it'll make doing asciidoc and
asciidoctor comparisons easier.)

There were a number of differences that I didn't work
through though.  Most importantly was the change in the
links noted in the commit message.

Thanks for working on asciidoctor.  I've been trying to poke
it off and on to help ensure the docs can be built if
asciidoc ever gets dropped from Fedora.

--=20
Todd
