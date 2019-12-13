Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B41C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6DA2253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoCIIyBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfLMAnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:50 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:48574 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbfLMAnt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:49 -0500
Received: by mail-pj1-f73.google.com with SMTP id o34so410511pjb.15
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=P6t6vuXoq++8zpknfpe5SgYeYCpkHgEzkrCEfNje28I=;
        b=EoCIIyBDKXmiYspEkkNjXoZOuXMMDtEnLlowINrs8llgs15+je6o/dhCnNIKy6bWnu
         Yv95sufL5d0lggmLr7H3PgyA4yJqIhQvCWXS4goJ6abrd61xmvO/TjhTfxlInEYFFUH7
         Q3QK8MZ+yk8I8e0lwH6iMiizYEc+n3/bGEt9MewxwFVzlajj8dr20odGITjZoT6usLAl
         ygnLB/cDUwvpkEzsk65xyFQvLoKUEHxXWLDXj0DAU/zHrXKgctNTHUl34W7zxDWUPbt8
         n/IRaj/FPD+/oNdhwQiY7Bs17KLdvqFhxIHPimlEMQg5CgZJfNOpl9stQUhXu2dgPIbZ
         4F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=P6t6vuXoq++8zpknfpe5SgYeYCpkHgEzkrCEfNje28I=;
        b=FQEkeO5uYBRl/61/vLHZ159+oaCQoG8oIHXRRj4ABVcfhCqfYwn5CqsNoL8XaUezDJ
         nc0L5iV67N2GPLbkqvvYiQGBH3y9qWE03QDTVS3xPV+GyhPSplFkHi0N2fgiV6xSkgGD
         uhyFViKFkQ/OgucFSEn597STuJyeHT+kDt2dPbu4BwvBvlQ0DEpaoVtGnk/y3OYIhn8T
         t1G0/0hZyY+4w1s9YKqhpexN/E9zLklH19p4dNe6NHbvt1+os85CDjuaV6LDUyM/Oukh
         hIgMxA6/luH5VeTTWlArRGBm1I3moJiKrLosDqG91qS/N/RJaO60GJ0wmE9Z1Q+JcuuF
         hcrA==
X-Gm-Message-State: APjAAAUigsFjXXRGrouQDfko3EJX+20wJ7VlhH+crImVPXjWEmD7a3Qo
        OgWYOINO755cGS10p7+WcMV5TOZdnNN8vGR66ffdMIavopDwu0gpEWYyUf1fqZZ0qi4BuS0FI1w
        ICQ91GfgdEYzBwbv8vullEu06rd8z7H94UGjk6ZN1uxV393r3WVHIdXHaOTTZv/W0OdlFjSqBAA
        ==
X-Google-Smtp-Source: APXvYqx33aB8Ks/8RSQ0D6TXMgiM5L+7Y5koN0BPYvwU0oRlsCfgBa9cBCXnLDiivrTGdFu6NuB986Hujqj4vuNF6HU=
X-Received: by 2002:a63:1447:: with SMTP id 7mr13748743pgu.22.1576197828631;
 Thu, 12 Dec 2019 16:43:48 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:06 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 09/15] bugreport: generate config safelist based on docs
From:   Emily Shaffer <emilyshaffer@google.com>
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
 Makefile                                | 14 +++--
 generate-bugreport-config-safelist.sh   | 22 ++++++++
 6 files changed, 83 insertions(+), 37 deletions(-)
 create mode 100755 generate-bugreport-config-safelist.sh

diff --git a/.gitignore b/.gitignore
index 5dde2cc4c8..30935621d9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -191,6 +191,7 @@
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
index c49f55a521..76dc51e2b1 100644
--- a/Makefile
+++ b/Makefile
@@ -651,7 +651,7 @@ install-perl-script: $(SCRIPT_PERL_GEN)
 install-python-script: $(SCRIPT_PYTHON_GEN)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
=20
-.PHONY: clean-perl-script clean-sh-script clean-python-script
+.PHONY: clean-perl-script clean-sh-script clean-python-script clean-script=
-dependencies
 clean-sh-script:
 	$(RM) $(SCRIPT_SH_GEN)
 clean-perl-script:
@@ -817,6 +817,7 @@ VCSSVN_LIB =3D vcs-svn/lib.a
=20
 GENERATED_H +=3D config-list.h
 GENERATED_H +=3D command-list.h
+GENERATED_H +=3D bugreport-config-safelist.h
=20
 LIB_H :=3D $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Do=
cumentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2161,6 +2162,12 @@ command-list.h: $(wildcard Documentation/git*.txt) D=
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
@@ -2791,7 +2798,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
=20
-GEN_HDRS :=3D config-list.h command-list.h unicode-width.h
+GEN_HDRS :=3D config-list.h command-list.h unicode-width.h bugreport-confi=
g-safelist.h
 EXCEPT_HDRS :=3D $(GEN_HDRS) compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS +=3D sha256/gcrypt.h
@@ -3117,7 +3124,8 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo config-list.h command-list.h
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo
+	$(RM) config-list.h command-list.h bugreport-config-safelist.h
 	$(RM) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
diff --git a/generate-bugreport-config-safelist.sh b/generate-bugreport-con=
fig-safelist.sh
new file mode 100755
index 0000000000..06b8e0c3c4
--- /dev/null
+++ b/generate-bugreport-config-safelist.sh
@@ -0,0 +1,22 @@
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
+sed -n 's/^\(.*\) \+bugreport:include.* ::$/\1/p' |
+sort |
+while read line
+do
+	echo "	\"$line\","
+done
+
+cat <<EOF
+};
+EOF
--=20
2.24.1.735.g03f4e72817-goog

