Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DAFC35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8043D22522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ufj1LBnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgAXDfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:33 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33421 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAXDfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:32 -0500
Received: by mail-pg1-f201.google.com with SMTP id s23so592297pgg.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=w0zOxSADVL7WmpZIfCipAStf9CMvWfwy2JdFqBYJ0XM=;
        b=Ufj1LBnOXACvK9V+04fnAh2cPeG8Ah1u7nRBs7vCZ8zEM7b+wYww5DPJQpvltC+i3l
         nU+rSpgbF6uxH+yRBI5s8fp5rr7gluKRKI2mgQ0xGvhqYd87vsEUQhYPzt7liXUoCxHg
         eYFZbZFr2HiH5R0YK/rBiQjR0OcVfFZkbyrly0Kq5eb87Fej60sJZCZEJrXS/Ds9zSBS
         4qSX3mbo7pCU1TbuLnEDkt+dP4+HKunuT0i90E09ILdXIJEnDWBaODoncqwJbbrAhY1R
         EyF/4hLSmDnfcZm2Yw38OhrWDEbjEU2rgemx3MppvvITdq5eZPAyzj368IbpSCyT18LT
         3xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=w0zOxSADVL7WmpZIfCipAStf9CMvWfwy2JdFqBYJ0XM=;
        b=R46mLc+6L27Cg9Ohb76o2qO9kh/nAYOnI6TsNjjaFHVM/tw7vpX5UDYrxPdFEblh5R
         BaWiYQ5am33mcuxUBzgukxPbVbUhvslFUy+8Sw1KvHnfNvCWHoqz3C/Pew2LWWUwY9jT
         Iq9XbhWsR09dpLBoPNhmYjYkk2Phn57YTDGF91I5BjqhVKEVptRW5gw9xENBlh+mHle+
         V2azUxARwukuk9X2nQPWkt+ZYL17gi8fA7StA8MHtODq834lXqEuvah+esUxi0Z4z8WH
         uZOBYnVIlDXZgnmIGWIU+i6koebyGQqZapL2n4lqwyLDwOWORd+oaejRrthT4R3+PTQl
         9z4w==
X-Gm-Message-State: APjAAAVVV34oxzHXVMEnZN7APRxAXdhq+4+ShREn6dYIouUJw796l8f2
        uqc7P7nCZ/QMu18V8vW9nu+mX20zQZ1ym0+fBs6w+HsA4pdZ9lCfy92rnOIsQyx7qGMpurij+lM
        CxPCxEtUHw3jJ2EaYfMnNrwV+OAKKfkl5JjhKRtAZHQuTd/gJ/iVVTEyvxwkLRdlyjgETy+ktzg
        ==
X-Google-Smtp-Source: APXvYqyvg6WSdkZ+Gjqi4bCgS5gr50tjg4f1yhjSiTT1/F1PkKZ5chkMYwux3CkkDFNaSFUYRJQH/Q8epsI+44vvc4Q=
X-Received: by 2002:a63:4723:: with SMTP id u35mr1733480pga.194.1579836931676;
 Thu, 23 Jan 2020 19:35:31 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:30 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 09/15] bugreport: generate config safelist based on docs
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Add a new step to the build to generate a safelist of git-config
variables which are appropriate to include in the output of
git-bugreport. New variables can be added to the safelist by annotating
their documentation in Documentation/config with the
"bugreport" macro, which is recognized by AsciiDoc and
AsciiDoctor.

Some configs are private in nature, and can contain remote URLs,
passwords, or other sensitive information. In the event that a user
doesn't notice their information while reviewing a bugreport, that user
may leak their credentials to other individuals, mailing lists, or bug
tracking tools inadvertently. Heuristic blocklisting of configuration
keys is imperfect and prone to false negatives; given the nature of the
information which can be leaked, a safelist is more reliable.

In order to prevent staleness of the safelist, add a mechanism to
generate the safelist from annotations in the config documentation,
where contributors are already used to documenting their new config
keys.

Implement a new no-op "bugreport" macro for use as
"bugreport:include[x]" to annotate the config keys that should be
included in the automatically generated safelist. Use "exclude" for the
others.

With Asciidoctor, it's ok to say "bugreport:include[]", but AsciiDoc
seems to want something between the brackets. A bit unfortunate, but
not a huge problem -- we'll just provide an "x".

"doc-diff" reports that this macro doesn't render at all. That is,
these are both empty after this commit:

  cd Documentation
  ./doc-diff --asciidoctor :/"bugreport: add tool" HEAD
  ./doc-diff --asciidoc    :/"bugreport: add tool" HEAD

Diffing the rendered HTML shows that there is some small amount of
whitespace and comments added. That shouldn't be a problem.

We could perhaps let the implementation verify that the "action" is one
of "include" and "exclude". For the Asciidoctor implementation that
should be straightforward, but for AsciiDoc I don't immediately know how
to do it. Anyway, if someone stumbles on the keyboard and writes
"bugreport:icndule", they'll "only" miss out on the config key being
included in the safelist. If this were a blocklist, the consequences of
a misspelled target could be a lot more severe.

Additionally, add annotations to the sendemail config documentation in
order to demonstrate a proof of concept.

Helped-by: Martin =C3=85gren <martin.agren@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 .gitignore                              |  1 +
 Documentation/asciidoc.conf             |  8 +++
 Documentation/asciidoctor-extensions.rb |  7 +++
 Documentation/config/sendemail.txt      | 68 ++++++++++++-------------
 Makefile                                |  7 +++
 generate-bugreport-config-safelist.sh   | 17 +++++++
 6 files changed, 74 insertions(+), 34 deletions(-)
 create mode 100755 generate-bugreport-config-safelist.sh

diff --git a/.gitignore b/.gitignore
index d89bf9e11e..bd2f49b996 100644
--- a/.gitignore
+++ b/.gitignore
@@ -192,6 +192,7 @@
 /gitweb/static/gitweb.min.*
 /config-list.h
 /command-list.h
+/bugreport-config-safelist.h
 *.tar.gz
 *.dsc
 *.deb
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 8fc4b67081..5d5359fcf9 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -6,9 +6,13 @@
 #
 # Show Git link as: <command>(<section>); if section is defined, else just=
 show
 # the command.
+#
+# The bugreport macro does nothing as far as rendering is
+# concerned -- we just grep for it in the sources.
=20
 [macros]
 (?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=3D
+(?su)[\\]?(?P<name>bugreport):(?P<action>\S*?)\[(?P<attrlist>.*?)\]=3D
=20
 [attributes]
 asterisk=3D&#42;
@@ -28,6 +32,8 @@ ifdef::backend-docbook[]
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
 {0#</citerefentry>}
+[bugreport-inlinemacro]
+{0#}
 endif::backend-docbook[]
=20
 ifdef::backend-docbook[]
@@ -94,4 +100,6 @@ ifdef::backend-xhtml11[]
 git-relative-html-prefix=3D
 [linkgit-inlinemacro]
 <a href=3D"{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
+[bugreport-inlinemacro]
+<!-- -->
 endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciid=
octor-extensions.rb
index d906a00803..750bdff9af 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -37,6 +37,10 @@ module Git
           output =3D output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
         end
         output
+
+    class BugReportProcessor < Asciidoctor::Extensions::InlineMacroProcess=
or
+      def process(parent, action, attrs)
+        ""
       end
     end
   end
@@ -45,4 +49,7 @@ end
 Asciidoctor::Extensions.register do
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
   postprocessor Git::Documentation::DocumentPostProcessor
+  # The bugreport macro does nothing as far as rendering is
+  # concerned -- we just grep for it in the sources.
+  inline_macro Git::Documentation::BugReportProcessor, :bugreport
 end
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/send=
email.txt
index 0006faf800..92f5082013 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -1,63 +1,63 @@
-sendemail.identity::
+sendemail.identity bugreport:exclude[x] ::
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
 	the value of `sendemail.identity`.
=20
-sendemail.smtpEncryption::
+sendemail.smtpEncryption bugreport:include[x] ::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
=20
-sendemail.smtpssl (deprecated)::
+sendemail.smtpssl (deprecated) bugreport:exclude[x] ::
 	Deprecated alias for 'sendemail.smtpEncryption =3D ssl'.
=20
-sendemail.smtpsslcertpath::
+sendemail.smtpsslcertpath bugreport:exclude[x] ::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
=20
-sendemail.<identity>.*::
+sendemail.<identity>.* bugreport:exclude[x] ::
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when this
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
=20
-sendemail.aliasesFile::
-sendemail.aliasFileType::
-sendemail.annotate::
-sendemail.bcc::
-sendemail.cc::
-sendemail.ccCmd::
-sendemail.chainReplyTo::
-sendemail.confirm::
-sendemail.envelopeSender::
-sendemail.from::
-sendemail.multiEdit::
-sendemail.signedoffbycc::
-sendemail.smtpPass::
-sendemail.suppresscc::
-sendemail.suppressFrom::
-sendemail.to::
-sendemail.tocmd::
-sendemail.smtpDomain::
-sendemail.smtpServer::
-sendemail.smtpServerPort::
-sendemail.smtpServerOption::
-sendemail.smtpUser::
-sendemail.thread::
-sendemail.transferEncoding::
-sendemail.validate::
-sendemail.xmailer::
+sendemail.aliasesFile bugreport:exclude[x] ::
+sendemail.aliasFileType bugreport:exclude[x] ::
+sendemail.annotate bugreport:include[x] ::
+sendemail.bcc bugreport:include[x] ::
+sendemail.cc bugreport:include[x] ::
+sendemail.ccCmd bugreport:include[x] ::
+sendemail.chainReplyTo bugreport:include[x] ::
+sendemail.confirm bugreport:include[x] ::
+sendemail.envelopeSender bugreport:include[x] ::
+sendemail.from bugreport:include[x] ::
+sendemail.multiEdit bugreport:include[x] ::
+sendemail.signedoffbycc bugreport:include[x] ::
+sendemail.smtpPass bugreport:exclude[x] ::
+sendemail.suppresscc bugreport:include[x] ::
+sendemail.suppressFrom bugreport:include[x] ::
+sendemail.to bugreport:include[x] ::
+sendemail.tocmd bugreport:include[x] ::
+sendemail.smtpDomain bugreport:include[x] ::
+sendemail.smtpServer bugreport:include[x] ::
+sendemail.smtpServerPort bugreport:include[x] ::
+sendemail.smtpServerOption bugreport:include[x] ::
+sendemail.smtpUser bugreport:exclude[x] ::
+sendemail.thread bugreport:include[x] ::
+sendemail.transferEncoding bugreport:include[x] ::
+sendemail.validate bugreport:include[x] ::
+sendemail.xmailer bugreport:include[x] ::
 	See linkgit:git-send-email[1] for description.
=20
-sendemail.signedoffcc (deprecated)::
+sendemail.signedoffcc (deprecated) bugreport:exclude[x] ::
 	Deprecated alias for `sendemail.signedoffbycc`.
=20
-sendemail.smtpBatchSize::
+sendemail.smtpBatchSize bugreport:include[x] ::
 	Number of messages to be sent per connection, after that a relogin
 	will happen.  If the value is 0 or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
=20
-sendemail.smtpReloginDelay::
+sendemail.smtpReloginDelay bugreport:include[x] ::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
diff --git a/Makefile b/Makefile
index a01a050aa3..2bc9f112ea 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,7 @@ VCSSVN_LIB =3D vcs-svn/lib.a
=20
 GENERATED_H +=3D config-list.h
 GENERATED_H +=3D command-list.h
+GENERATED_H +=3D bugreport-config-safelist.h
=20
 LIB_H :=3D $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Do=
cumentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2163,6 +2164,12 @@ command-list.h: $(wildcard Documentation/git*.txt) D=
ocumentation/*config.txt Doc
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		command-list.txt >$@+ && mv $@+ $@
=20
+bugreport-config-safelist.h: generate-bugreport-config-safelist.sh
+
+bugreport-config-safelist.h: Documentation/config/*.txt
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-bugreport-config-safelist.sh \
+		>$@+ && mv $@+ $@
+
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
diff --git a/generate-bugreport-config-safelist.sh b/generate-bugreport-con=
fig-safelist.sh
new file mode 100755
index 0000000000..44612d5538
--- /dev/null
+++ b/generate-bugreport-config-safelist.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+cat <<EOF
+/* Automatically generated by bugreport-generate-config-safelist.sh */
+
+
+static const char *bugreport_config_safelist[] =3D {
+EOF
+
+# cat all regular files in Documentation/config
+find Documentation/config -type f -exec cat {} \; |
+# print the command name which matches the bugreport-include macro
+sed -n 's/^\(.*\) \+bugreport:include.* ::$/  "\1",/p' | sort
+
+cat <<EOF
+};
+EOF
--=20
2.25.0.341.g760bfbb309-goog

