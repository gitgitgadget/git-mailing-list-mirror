Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0DF1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935559AbeF1QgS (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:36:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63878 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935507AbeF1QgK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:36:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B3D2F6B1A;
        Thu, 28 Jun 2018 12:36:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=I8odV5GCuoTTR9n8Hs/IWwy2xmg=; b=K2bcOqf
        gWDj/dwF4s6Ksb0NKE+8hwr71kLaeJBsF7zZ4fA2cKd8mydxjKhMoEQI5DA18qD6
        9ZJ+GCZi9B5vmhOW4+T0CW/VFTIDNzuQ5mApit7XBiLlCshXqdoUhTveLztLxydB
        ke+BEbwIU+PCxqjAf+riKS2qJIJ71wiYN9yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=H49MwC/q9sp55ZHahkEMA1jMSS4ufDZFo
        RUUOBuyF8tPtO+eZbTiz01fkpVRIdOiOf5q45RSFm1/hMcuNvj58ggkCeDblFowL
        vpY6QdfhcnWrjzYg7AePmEa4PBenpobRj4o3D9ej6Qkq/dL4eerb8GWItlvLwQTr
        vVIhHsHs+s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AFCAF6B19;
        Thu, 28 Jun 2018 12:36:09 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EC83F6B18;
        Thu, 28 Jun 2018 12:36:08 -0400 (EDT)
Date:   Thu, 28 Jun 2018 12:36:06 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180628163606.GP20217@zaya.teonanacatl.net>
References: <20180627045637.13818-1-tmz@pobox.com>
 <20180627141430.GA13904@sigill.intra.peff.net>
 <20180627150352.GJ20217@zaya.teonanacatl.net>
 <20180628141556.GA15799@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628141556.GA15799@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 5C17B8A0-7AF1-11E8-BDDC-0DFB1A68708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> We could get rid around that by using $(DOC_ETC_GITCONFIG) or something,
> with:
> 
>   DOC_ETC_GITCONFIG ?= $(ETC_GITCONFIG)
> 
> in the Makefile. But that still leaves the choice of which generic text
> to use up to the caller. Maybe we should provide more guidance.
> 
> I.e., provide a knob like DOC_GENERIC that fills in generic values for
> these values (and maybe some others; it sounds like we have some
> existing problem cases).

That sounds pretty reasonable.  I have something
implementing this below.

>> It might be enough if the default values are relatively sane
>> and consistent.  That would be a slight improvement over the
>> current situation still.
> 
> Yeah. Taking a step back from the implementation questions, I think
> "$(prefix)/etc/gitconfig" is not very helpful text. I'd be happy to see
> us come up with a generic way of saying that which is more
> comprehensible to end-users. Your patches side-step that by filling in
> the real value, but unfortunately we can't do that everywhere. :)
> 
> There may not be a good "token" value, though. I.e., we may need to have
> two sets of verbiage: the specific one, and the generic one.

Yeah.  About the best generic term I can come up with is
using '$sysconfdir'.  But I have no idea if that's something
most readers will recognize as a placeholder for something
like /etc.

A number of the path references are in the FILES sections of
the man pages.  It might not be much of an improvement if we
try to stuff too much text in those references.  Perhaps if
those used '$sysconfdir/gitconfig' a subsequent note could
expand on that?  It could even be wrapped in an ifdef
similar to that used for the default editor/pager.

I don't want to make the plain .txt files significantly less
readable in the process, of course.

>>> It's a shame we have to repeat this logic from the Makefile, though I
>>> guess we already do so for prefix, bindir, etc, so far.
>>> 
>>> Should we factor the path logic from the top-level Makefile into an
>>> include that can be used from either?
>> 
>> Yeah, maybe.  I didn't like the duplication either, but as
>> you noticed, we do it already for many of the other
>> variables.  I suspect we could put these defaults into
>> config.mak.uname which Documentation/Makefile includes and
>> then you could run 'make -C Documentation' in a fresh clone
>> or tarball and get docs built with the defaults set for each
>> platform.
> 
> I think it shouldn't go into config.mak.uname, since the idea there was
> to keep the long list of platform defaults separate from other logic
> (the Makefile is already long enough!). So I'm basically proposing the
> same thing but in its own file. :)

Ahh, something that the top-level Makefile would create and
then subdir Makefiles would include, perhaps similar to the
way GIT-VERSION-FILE is updated and included?  That could
prove useful to some of the tools in contrib which duplicate
logic.

Skipping that larger de-duplication cleanup, here's a stab
at implementing the DOC_GENERIC knob (and the DOC_ overrides
for ETC_GIT(CONFIG|ATTRIBUTES).  The defaults with
'/GENERIC-SYSCONFDIR' in them are just placeholders waiting
for a better name. :)

Similarly, the use of {etc-git(config|attributes)} as the
attribute for the replacements could likely be improved for
readers of the .txt files.  {system-wide-gitconfig} is
likely better.  Maybe the default for the generic paths
could be /system-wide/git(config|attributes) too (or in
CAPS to make it more obviously a placeholder)?

Thanks for thinking this through and providing some good
directions to work on!

-- >8 --
Subject: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated docs

Replace `$(prefix)/etc/gitconfig` and `$(prefix)/etc/gitattributes` in
generated documentation with the paths chosen when building.  Readers of
the documentation should not need to know how `$(prefix)` was defined.

It's also more consistent than sometimes using `$(prefix)/etc/gitconfig`
and other times using `/etc/gitconfig` to refer to the system-wide
config file.

Update the SYNOPSIS of gitattributes(5) to include the system-wide
config file as well.

Support building generic documentation with a DOC_GENERIC Makefile knob.
The default generic paths may be further customized via the
DOC_ETC_GITCONFIG and DOC_ETC_GITATTRIBUTES variables.

Define DOC_GENERIC in dist-doc make target to ensure generic paths are
used in the generated html and manpage tarballs.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/Makefile          | 22 ++++++++++++++++++++++
 Documentation/config.txt        |  4 ++--
 Documentation/git-config.txt    | 10 +++++-----
 Documentation/git.txt           |  4 ++--
 Documentation/gitattributes.txt |  4 ++--
 Makefile                        | 10 ++++++++--
 6 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d079d7c73..2b3540a6c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -95,6 +95,7 @@ DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
+sysconfdir ?= $(prefix)/etc
 htmldir ?= $(prefix)/share/doc/git-doc
 infodir ?= $(prefix)/share/info
 pdfdir ?= $(prefix)/share/doc/git-doc
@@ -205,6 +206,27 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
 ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
 endif
 
+ifndef ETC_GITCONFIG
+ETC_GITCONFIG = $(sysconfdir)/gitconfig
+endif
+ifndef ETC_GITATTRIBUTES
+ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
+endif
+
+ifndef DOC_GENERIC
+DOC_ETC_GITCONFIG ?= $(ETC_GITCONFIG)
+DOC_ETC_GITATTRIBUTES ?= $(ETC_GITATTRIBUTES)
+else
+DOC_ETC_GITCONFIG ?= /GENERIC-SYSCONFDIR/gitconfig
+DOC_ETC_GITATTRIBUTES ?= /GENERIC-SYSCONFDIR/gitattributes
+endif
+
+DOC_ETC_GITCONFIG_SQ = $(subst ','\'',$(DOC_ETC_GITCONFIG))
+ASCIIDOC_EXTRA += -a 'etc-gitconfig=$(DOC_ETC_GITCONFIG_SQ)'
+
+DOC_ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(DOC_ETC_GITATTRIBUTES))
+ASCIIDOC_EXTRA += -a 'etc-gitattributes=$(DOC_ETC_GITATTRIBUTES_SQ)'
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828..ed903b60b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -5,7 +5,7 @@ The Git configuration file contains a number of variables that affect
 the Git commands' behavior. The `.git/config` file in each repository
 is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
-fallback values for the `.git/config` file. The file `/etc/gitconfig`
+fallback values for the `.git/config` file. The file +{etc-gitconfig}+
 can be used to store a system-wide default configuration.
 
 The configuration variables are used by both the Git plumbing
@@ -2815,7 +2815,7 @@ configuration files (e.g. `$HOME/.gitconfig`).
 
 Example:
 
-/etc/gitconfig
+{etc-gitconfig}
   push.pushoption = a
   push.pushoption = b
 
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 18ddc78f4..0d5ea5b58 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -114,10 +114,10 @@ See also <<FILES>>.
 
 --system::
 	For writing options: write to system-wide
-	`$(prefix)/etc/gitconfig` rather than the repository
+	+{etc-gitconfig}+ rather than the repository
 	`.git/config`.
 +
-For reading options: read only from system-wide `$(prefix)/etc/gitconfig`
+For reading options: read only from system-wide +{etc-gitconfig}+
 rather than from all available files.
 +
 See also <<FILES>>.
@@ -263,7 +263,7 @@ FILES
 If not set explicitly with `--file`, there are four files where
 'git config' will search for configuration options:
 
-$(prefix)/etc/gitconfig::
+{etc-gitconfig}::
 	System-wide configuration file.
 
 $XDG_CONFIG_HOME/git/config::
@@ -310,11 +310,11 @@ ENVIRONMENT
 GIT_CONFIG::
 	Take the configuration from the given file instead of .git/config.
 	Using the "--global" option forces this to ~/.gitconfig. Using the
-	"--system" option forces this to $(prefix)/etc/gitconfig.
+	"--system" option forces this to {etc-gitconfig}.
 
 GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
-	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
+	{etc-gitconfig} file. See linkgit:git[1] for details.
 
 See also <<FILES>>.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index dba7f0c18..6a4646f99 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -567,10 +567,10 @@ for further details.
 
 `GIT_CONFIG_NOSYSTEM`::
 	Whether to skip reading settings from the system-wide
-	`$(prefix)/etc/gitconfig` file.  This environment variable can
+	+{etc-gitconfig}+ file.  This environment variable can
 	be used along with `$HOME` and `$XDG_CONFIG_HOME` to create a
 	predictable environment for a picky script, or you can set it
-	temporarily to avoid using a buggy `/etc/gitconfig` file while
+	temporarily to avoid using a buggy +{etc-gitconfig}+ file while
 	waiting for someone with sufficient permissions to fix it.
 
 `GIT_FLUSH`::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 92010b062..528de4259 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -7,7 +7,7 @@ gitattributes - Defining attributes per path
 
 SYNOPSIS
 --------
-$GIT_DIR/info/attributes, .gitattributes
+{etc-gitattributes}, $GIT_DIR/info/attributes, .gitattributes
 
 
 DESCRIPTION
@@ -93,7 +93,7 @@ for a single user should be placed in a file specified by the
 Its default value is $XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME
 is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
-`$(prefix)/etc/gitattributes` file.
++{etc-gitattributes}+ file.
 
 Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
diff --git a/Makefile b/Makefile
index 0cb6590f2..f476a6eb5 100644
--- a/Makefile
+++ b/Makefile
@@ -292,6 +292,11 @@ all::
 # Define ASCIIDOCTOR_EXTENSIONS_LAB to point to the location of the Asciidoctor
 # Extensions Lab if you have it available.
 #
+# Define DOC_GENERIC if you're building documentation for a general audience and
+# do not want paths such as ETC_GITCONFIG and ETC_GITATTRIBUTES to be expanded.
+# Define DOC_ETC_GITCONFIG and DOC_ETC_GITATTRIBUTES to override the generic
+# defaults used for those paths.
+#
 # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
@@ -2870,13 +2875,14 @@ manpages = git-manpages-$(GIT_VERSION)
 dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
-	$(MAKE) -C Documentation WEBDOC_DEST=../.doc-tmp-dir install-webdoc
+	$(MAKE) -C Documentation DOC_GENERIC=1 WEBDOC_DEST=../.doc-tmp-dir \
+		install-webdoc
 	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar .
 	gzip -n -9 -f $(htmldocs).tar
 	:
 	$(RM) -r .doc-tmp-dir
 	mkdir -p .doc-tmp-dir/man1 .doc-tmp-dir/man5 .doc-tmp-dir/man7
-	$(MAKE) -C Documentation DESTDIR=./ \
+	$(MAKE) -C Documentation DESTDIR=./ DOC_GENERIC=1 \
 		man1dir=../.doc-tmp-dir/man1 \
 		man5dir=../.doc-tmp-dir/man5 \
 		man7dir=../.doc-tmp-dir/man7 \

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Thanks, for a country where nobody is allowed to mind his own
business. Thanks, for a nation of finks.
    -- William S. Burroughs, A Thanksgiving Prayer

