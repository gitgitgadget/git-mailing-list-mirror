Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06EBC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788952098B
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzlQTfDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgFXB2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbgFXB2l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 21:28:41 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA53CC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 18:28:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a6so491280qka.9
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 18:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=cbbZ03JAed4KSzxAWI1X2NwX3CIOsNSegF7JwVFCaO8=;
        b=fzlQTfDz7u9AuhKCNkOmtUe/JANV+4w3iaLOa2g5qHlHKWgzNA4DXAQOXmm+AlDqWu
         HUmf+ZmPHTigRX4D3+VmF96HNAEqYNUw/nPX0PKkbq8od9Y/eqwzvMCMDN6wFTof7Al5
         pq3jdKI1L7dR8WTBtTuOcfPE2cBDXmkIaF9gDzYiIqEr8PFZIcxYqrsW1gIt7vOANVig
         Ohf/+eXR339Sm217Vd/ezIKQoMTnx2U6hB3btZv8IV0YuhUc1ajNnEUq2UqLmoaawmAR
         EHwuyeSSwInq7hWUYEj/iTc75dOPWnhuaNGiXQ5qhOCwcF/05nMY4CyoSZAW3AMjfNKS
         IvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=cbbZ03JAed4KSzxAWI1X2NwX3CIOsNSegF7JwVFCaO8=;
        b=gej9DNRB4+XAEuzanQMw+jVDh8sdQiGM63kFkYr+Kt3JlMbB2BWqfJz+DblVMXF5mM
         5WEZS2Su6o95NrZM267/vVzf178lYugrr0bd6PNk0BmM2gU0qjfWXzPCbsIUoAfCJvN+
         DgQuCUC0s4kgjxFRbgA98aKy0roARcNtb5XOICMfRuvWOFTwEBXPmVADP9tx873n/oUP
         lTHen/Od6snW5uDOL3PtDmNl4Fv4PW+YYW3d48q0H49s49refKkyEXe/iCdhAU6Zp2Jq
         e+sIvD8CGoGiwAy+vSg2ZIrf3WbDAe2sYXvXDtUG43/CWgTdpYcd6CjDfnLlCOjgO5eZ
         4HiQ==
X-Gm-Message-State: AOAM531zFicZZ/01QS88j28tP3/gywLv72f2IkJVbS0NUmnvwZzwKcUT
        ISA7R24rYS91xUIOynw+PJ+RpudbuTgF9DOie4gns4luI9mTprDHFofF1yWzWQ80zE/pF5B0eRK
        G3oXIhn7VafGy44CIqTqmT5H2r13vP36BgSPS4hulOFAXaB09qGVa1ZhNCD7we5mlTY1ak47IGw
        ==
X-Google-Smtp-Source: ABdhPJxsLfy/TuRpbOZapdk0UCHNrvs1NFU0tKcAMCRRtKg+7sONYOaCOegZNa4LMaYIzDVQYnW00JQ2U+XRAer2vC8=
X-Received: by 2002:ad4:4a6e:: with SMTP id cn14mr27998479qvb.79.1592962118999;
 Tue, 23 Jun 2020 18:28:38 -0700 (PDT)
Date:   Tue, 23 Jun 2020 18:28:26 -0700
In-Reply-To: <20200624012827.34126-1-emilyshaffer@google.com>
Message-Id: <20200624012827.34126-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200624012827.34126-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH 1/2] bugreport: generate config safelist based on docs
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
their documentation in Documentation/config with the "annotate" macro,
which is a no-op in AsciiDoc and AsciiDoctor.

Some configs are private in nature, and can contain remote URLs,
passwords, or other sensitive information. In the event that a user
doesn't notice their information while reviewing a bugreport, that user
may leak their credentials to other individuals, mailing lists, or bug
tracking tools inadvertently. Heuristic blocklisting of configuration
keys is imperfect and prone to false negatives; given the nature of the
information which can be leaked, a safelist is more reliable.

However, it's possible that in some situations, an organization may be
less concerned with privacy of things like remote URLs and branch names,
and more concerned with ease of diagnosis for their support staff. In
those cases, it may make more sense for that organization to modify the
code to use a blocklist. To that end, we should try to mark configs which
are definitely safe, and configs which are definitely unsafe, and leave
blank configs which are somewhere in between. To mark a config as safe,
add "annotate:bugreport[include]" to the corresponding line in the
config documentation; to mark it as unsafe, add
"annotate:bugreport[exclude]" instead.

Generating bugreport-config-safelist.h at build time by grepping the
documentation for this new macro helps us prevent staleness. The macro
itself is a no-op and should not alter the appearance of the
documentation in either AsciiDoc or AsciiDoctor, confirmable by running:

  cd Documentation
  ./doc-diff --asciidoctor HEAD^ HEAD
  ./doc-diff --asciidoc HEAD^ HEAD

Diffing the rendered HTML shows that only inline comments were added,
which shouldn't be a problem.

Additionally, add annotations to the sendemail config documentation in
order to demonstrate a proof of concept.

Helped-by: Martin =C3=85gren <martin.agren@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 .gitignore                              |  1 +
 Documentation/asciidoc.conf             |  9 ++++
 Documentation/asciidoctor-extensions.rb |  7 ++++
 Documentation/config/sendemail.txt      | 56 ++++++++++++-------------
 Makefile                                |  7 ++++
 generate-bugreport-config-safelist.sh   | 18 ++++++++
 6 files changed, 70 insertions(+), 28 deletions(-)
 create mode 100755 generate-bugreport-config-safelist.sh

diff --git a/.gitignore b/.gitignore
index ee509a2ad2..0177839ae8 100644
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
index 3e4c13971b..fd225e30cc 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -6,9 +6,14 @@
 #
 # Show Git link as: <command>(<section>); if section is defined, else just=
 show
 # the command.
+#
+# The annotate macro does nothing as far as rendering is
+# concerned -- we just grep for it in the sources to populate
+# things like the bugreport safelist.
=20
 [macros]
 (?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=3D
+(?su)[\\]?(?P<name>annotate):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=3D
=20
 [attributes]
 asterisk=3D&#42;
@@ -28,6 +33,8 @@ ifdef::backend-docbook[]
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
 {0#</citerefentry>}
+[annotate-inlinemacro]
+{0#}
 endif::backend-docbook[]
=20
 ifdef::backend-docbook[]
@@ -75,4 +82,6 @@ ifdef::backend-xhtml11[]
 git-relative-html-prefix=3D
 [linkgit-inlinemacro]
 <a href=3D"{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
+[annotate-inlinemacro]
+<!-- -->
 endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciid=
octor-extensions.rb
index d906a00803..03c80af0e5 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -39,10 +39,17 @@ module Git
         output
       end
     end
+
+    class AnnotateProcessor < Asciidoctor::Extensions::InlineMacroProcesso=
r
+      def process(parent, target, attrs)
+        ""
+      end
+    end
   end
 end
=20
 Asciidoctor::Extensions.register do
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
   postprocessor Git::Documentation::DocumentPostProcessor
+  inline_macro Git::Documentation::AnnotateProcessor, :annotate
 end
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/send=
email.txt
index 0006faf800..fe27473e44 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -4,7 +4,7 @@ sendemail.identity::
 	values in the 'sendemail' section. The default identity is
 	the value of `sendemail.identity`.
=20
-sendemail.smtpEncryption::
+sendemail.smtpEncryption annotate:bugreport[include] ::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
=20
@@ -15,7 +15,7 @@ sendemail.smtpsslcertpath::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
=20
-sendemail.<identity>.*::
+sendemail.<identity>.* annotate:bugreport[exclude] ::
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when this
 	identity is selected, through either the command-line or
@@ -23,41 +23,41 @@ sendemail.<identity>.*::
=20
 sendemail.aliasesFile::
 sendemail.aliasFileType::
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
+sendemail.annotate annotate:bugreport[include] ::
+sendemail.bcc annotate:bugreport[include] ::
+sendemail.cc annotate:bugreport[include] ::
+sendemail.ccCmd annotate:bugreport[include] ::
+sendemail.chainReplyTo annotate:bugreport[include] ::
+sendemail.confirm annotate:bugreport[include] ::
+sendemail.envelopeSender annotate:bugreport[include] ::
+sendemail.from annotate:bugreport[include] ::
+sendemail.multiEdit annotate:bugreport[include] ::
+sendemail.signedoffbycc annotate:bugreport[include] ::
+sendemail.smtpPass annotate:bugreport[exclude] ::
+sendemail.suppresscc annotate:bugreport[include] ::
+sendemail.suppressFrom annotate:bugreport[include] ::
+sendemail.to annotate:bugreport[include] ::
+sendemail.tocmd annotate:bugreport[include] ::
+sendemail.smtpDomain annotate:bugreport[include] ::
+sendemail.smtpServer annotate:bugreport[include] ::
+sendemail.smtpServerPort annotate:bugreport[include] ::
+sendemail.smtpServerOption annotate:bugreport[include] ::
+sendemail.smtpUser annotate:bugreport[exclude] ::
+sendemail.thread annotate:bugreport[include] ::
+sendemail.transferEncoding annotate:bugreport[include] ::
+sendemail.validate annotate:bugreport[include] ::
+sendemail.xmailer annotate:bugreport[include] ::
 	See linkgit:git-send-email[1] for description.
=20
 sendemail.signedoffcc (deprecated)::
 	Deprecated alias for `sendemail.signedoffbycc`.
=20
-sendemail.smtpBatchSize::
+sendemail.smtpBatchSize annotate:bugreport[include] ::
 	Number of messages to be sent per connection, after that a relogin
 	will happen.  If the value is 0 or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
=20
-sendemail.smtpReloginDelay::
+sendemail.smtpReloginDelay annotate:bugreport[include] ::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
diff --git a/Makefile b/Makefile
index 372139f1f2..11d4029003 100644
--- a/Makefile
+++ b/Makefile
@@ -810,6 +810,7 @@ VCSSVN_LIB =3D vcs-svn/lib.a
=20
 GENERATED_H +=3D config-list.h
 GENERATED_H +=3D command-list.h
+GENERATED_H +=3D bugreport-config-safelist.h
=20
 LIB_H :=3D $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Do=
cumentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2164,6 +2165,12 @@ command-list.h: $(wildcard Documentation/git*.txt) D=
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
index 0000000000..5bf1f4ad82
--- /dev/null
+++ b/generate-bugreport-config-safelist.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+cat <<"EOF"
+/* Automatically generated by bugreport-generate-config-safelist.sh */
+
+
+static const char *bugreport_config_safelist[] =3D {
+EOF
+
+# cat all regular files in Documentation/config
+find Documentation/config -type f -exec cat {} \; |
+# print the command name which matches the annotate-bugreport macro
+sed -n 's/^\([^ ]*\)  *annotate:bugreport\[include\].* ::$/  "\1",/p' |
+	sort
+
+cat <<"EOF"
+};
+EOF
--=20
2.27.0.111.gc72c7da667-goog

