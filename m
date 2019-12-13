Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E26AC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80F421655
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFUiAON/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfLMAn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:27 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35373 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbfLMAn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:26 -0500
Received: by mail-pl1-f201.google.com with SMTP id x9so309192plv.2
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=i+Hwe+H8wRIWF5mJjfzCS80eM4vZa+VtdbdetKmgo3k=;
        b=TFUiAON/T4iwpHVySagBmy17xH+M0+YXIKPXlFu8ULZ7lU2COd6iN8oAPnpYFUviDV
         eLdEviAQYQt5t82xMDDlV9KUUvZR4uQlbMD7Xew1z9+IbKRHAW7hDOyvA+UT1IJD+Qn5
         4xWZ0dRaf9cSDVhukk6P2sCY3jCkPRCoumSUuvV6bGU4ektUIsDVOg1dPZSpugLNmZZw
         se/Pz74HCcw0S88B/u6HRQdgt/bBCcyxVrqvgnQfmRAY8BOxMC4XXqDBDSZdLWioXC0/
         iwYkTGxEQXuCluPyz5ubB+2hJIQjSdXclwoLf4p8sfLNTTUHGSEMJpvcOghUIN/sOpXY
         svkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=i+Hwe+H8wRIWF5mJjfzCS80eM4vZa+VtdbdetKmgo3k=;
        b=Xz0Ld1HXSFiwzH7JyhHltfjPWWYjafcOuFsZuL2qEtOjPAowOQH0kAgTjN0xfk/fTM
         4HammSJaQoZCuXgnKU4ff8f461lrI4Hk4mAw2N4/n8mMsjmZcxoM6oDWkil8ofc3WiJL
         J3mmwfOoJE5Czc11lpW0MwBEmQDyDMrnThbUBU1rUUCTLY7+VX2LSCQZEDI+ZFdmWvim
         5qFBNwx+1H8maJDlJB9wRmOpA5ost13NZ6iiAGDpIjSw+8hA0638VibwXsShudmgq17o
         D8yEpENgZ42uyjYrRuZDgnT+wdUhp+knGyX3eWOI83GijrN/JMo0NpR2PEc1+hurd36l
         rhMg==
X-Gm-Message-State: APjAAAWN0mMPr2ecNHt1+jkMncdErv+p8pcebpagd4XNEMw3XBjsji74
        6vOWLjBe3J8hTfGKAVt7m1Ry2s+rsx2Zrbb5sr4LVeeMme9JNJiiFv08KXiuFhNYSw0kiTM955Y
        sb+6p9WsatCCgXBfYQ/6gIrW7EzMf7gWXxLVD+vOCePvMfbcwzTi8JyfH4bcm5bXU9PNCZqD90g
        ==
X-Google-Smtp-Source: APXvYqxZgsYsa6KgSSaXyJyNCJ0l6ydq5lB7aOUoKbJtKTMCYQB3mRxeUNnums1vyqwENRgkly68HxMRteD+ad0v1n8=
X-Received: by 2002:a63:3404:: with SMTP id b4mr13679073pga.438.1576197804935;
 Thu, 12 Dec 2019 16:43:24 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:42:57 -0800
In-Reply-To: 20191025025129.250049-1-emilyshaffer@google.com
Message-Id: <20191213004312.169753-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 00/15] add git-bugreport tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic branch depends on the patch mailed in
lore.kernel.org/git/20191211233820.185153-1-emilyshaffer@google.com in orde=
r to
display scopes for configs gathered during "bugreport: add config values fr=
om
safelist".

Quite a few changes since v3. I'll try to summarize the big picture
stuff, plus highlight new changes and difference in patches inline in
the commit list. I'll also stick an interdiff since v3 at the bottom of
this cover letter.

Some overall changes:
- The entire command now exists in one file, bugreport.c, which is
  compiled as a standalone.
- static-ness of local functions has been cleaned up.
- strbuf lifetime management has been cleaned up.
- Mention of "whitelist" and "blacklist" has been changed to "safelist"
  and "blocklist" while dealing with Git-approved bugreportable configs.
  Thanks Dscho for pointing this out; "safelist" makes sense to me as
  these are configs we have deemed safe for public inspection.
- Inquiry into both Git's $SHELL_PATH and the user's $SHELL is new to
  v4.
- The 'man git bugreport' page which was lost from the script version of
  git-bugreport has been recovered, as have the "tests" (which only test
  whether it runs and doesn't crash).


Emily Shaffer (15):
  bugreport: add tool to generate debugging info
Moved from library + builtin to a standalone git-bugreport binary.

  help: move list_config_help to builtin/help
Resolves a circular dependency where using help.o required all builtins
to exist. This also moves generation of config-list.h into its own
script (it was previously roommates with command-list.h).

The following 4 commits were previously a single commit which used
run-command.h to call different processes; this has been removed except
for the cURL version.

  bugreport: gather git version and build info
Additionally capture the "--build-info" output from 'git version' where it
was not previously captured.

  help: add shell-path to --build-options
Adding $SHELL_PATH to 'git --version --build-options' gets it in the
bugreport for free. (This is the shell Git uses, determined at build
time.)

  bugreport: add uname info
Capture uname from the library instead of invoking a different process.

  bugreport: add glibc version
Capture glibc version info from the library instead of invoking the
'ldd' process.

  bugreport: add curl version
Capture the cURL version from git-http-fetch, and add a -V flag to that
binary for this purpose.


  bugreport: include user interactive shell
A new feature; check what $SHELL the user is using (at runtime)

  bugreport: generate config safelist based on docs
This commit squashes in suggestions both from Johannes Schindelin and
Martin =C3=85gren, hopefully resulting in Asciidoc(tor) not showing the
safelist macros, and a more portable safelist generation script. It also
puts the safelist, sorted, directly into a header instead of into a text
file, saving us a file read at runtime.

  bugreport: add config values from safelist
At Dscho's suggestion, now we put these into a map (based on khash and
oidset.h's example) for constant-time lookup during the config parse.

  bugreport: collect list of populated hooks
Only a minor change - now this works if 'git bugreport' is invoked
outside of a Git repo.

  bugreport: count loose objects
  bugreport: add packed object summary
  bugreport: list contents of $OBJDIR/info
For the above 3, the entire 'string_list' has been refactored out; now
the obj_info buffer is written to directly during the directory
traversal. Also paid more attention to when to free strbuf used for paths.

  bugreport: summarize contents of alternates file
Rather than printing the contents of the alternates file, now the number
of specified alternate stores are listed, and they are tested to check
whether they exist. This way we stop looking at user filepaths
(sensitive) and start learning whether they have a broken alternate (new
and useful info).

 .gitignore                              |   3 +
 Documentation/asciidoc.conf             |   8 +
 Documentation/asciidoctor-extensions.rb |   7 +
 Documentation/config/sendemail.txt      |  68 ++--
 Documentation/git-bugreport.txt         |  43 +++
 Documentation/git-http-fetch.txt        |   5 +
 Makefile                                |  31 +-
 bugreport.c                             | 434 ++++++++++++++++++++++++
 builtin/help.c                          |  86 +++++
 generate-bugreport-config-safelist.sh   |  22 ++
 generate-cmdlist.sh                     |  19 --
 generate-configlist.sh                  |  24 ++
 help.c                                  | 131 ++-----
 help.h                                  |   2 +-
 http-fetch.c                            |  13 +-
 t/t0091-bugreport.sh                    |  41 +++
 16 files changed, 774 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100755 generate-bugreport-config-safelist.sh
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

diff --git a/.gitignore b/.gitignore
index 055a84c4a8..30935621d9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -189,7 +189,9 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
+/config-list.h
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
index 69f3e4f219..92f5082013 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -1,63 +1,63 @@
-sendemail.identity:: // bugreport-exclude
+sendemail.identity bugreport:exclude[x] ::
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
 	the value of `sendemail.identity`.
=20
-sendemail.smtpEncryption:: // bugreport-include
+sendemail.smtpEncryption bugreport:include[x] ::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
=20
-sendemail.smtpssl (deprecated):: // bugreport-exclude
+sendemail.smtpssl (deprecated) bugreport:exclude[x] ::
 	Deprecated alias for 'sendemail.smtpEncryption =3D ssl'.
=20
-sendemail.smtpsslcertpath:: // bugreport-exclude
+sendemail.smtpsslcertpath bugreport:exclude[x] ::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
=20
-sendemail.<identity>.*:: // bugreport-exclude
+sendemail.<identity>.* bugreport:exclude[x] ::
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when this
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
=20
-sendemail.aliasesFile:: // bugreport-exclude
-sendemail.aliasFileType:: // bugreport-exclude
-sendemail.annotate:: // bugreport-include
-sendemail.bcc:: // bugreport-include
-sendemail.cc:: // bugreport-include
-sendemail.ccCmd:: // bugreport-include
-sendemail.chainReplyTo:: // bugreport-include
-sendemail.confirm:: // bugreport-include
-sendemail.envelopeSender:: // bugreport-include
-sendemail.from:: // bugreport-include
-sendemail.multiEdit:: // bugreport-include
-sendemail.signedoffbycc:: // bugreport-include
-sendemail.smtpPass:: // bugreport-exclude
-sendemail.suppresscc:: // bugreport-include
-sendemail.suppressFrom:: // bugreport-include
-sendemail.to:: // bugreport-include
-sendemail.tocmd:: // bugreport-include
-sendemail.smtpDomain:: // bugreport-include
-sendemail.smtpServer:: // bugreport-include
-sendemail.smtpServerPort:: // bugreport-include
-sendemail.smtpServerOption:: // bugreport-include
-sendemail.smtpUser:: // bugreport-exclude
-sendemail.thread:: // bugreport-include
-sendemail.transferEncoding:: // bugreport-include
-sendemail.validate:: // bugreport-include
-sendemail.xmailer:: // bugreport-include
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
-sendemail.signedoffcc (deprecated):: // bugreport-exclude
+sendemail.signedoffcc (deprecated) bugreport:exclude[x] ::
 	Deprecated alias for `sendemail.signedoffbycc`.
=20
-sendemail.smtpBatchSize:: // bugreport-include
+sendemail.smtpBatchSize bugreport:include[x] ::
 	Number of messages to be sent per connection, after that a relogin
 	will happen.  If the value is 0 or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
=20
-sendemail.smtpReloginDelay:: // bugreport-include
+sendemail.smtpReloginDelay bugreport:include[x] ::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.=
txt
new file mode 100644
index 0000000000..75f0c80acf
--- /dev/null
+++ b/Documentation/git-bugreport.txt
@@ -0,0 +1,43 @@
+git-bugreport(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-bugreport - Collect information for user to file a bug report
+
+SYNOPSIS
+--------
+[verse]
+'git bugreport' [-o | --output <path>]
+
+DESCRIPTION
+-----------
+Captures information about the user's machine, Git client, and repository =
state,
+as well as a form requesting information about the behavior the user obser=
ved,
+into a single text file which the user can then share, for example to the =
Git
+mailing list, in order to report an observed bug.
+
+The following information is requested from the user:
+
+ - Reproduction steps
+ - Expected behavior
+ - Actual behavior
+
+The following information is captured automatically:
+
+ - Git version (`git version --build-options`)
+ - Machine information (`uname -a`)
+ - Versions of various dependencies
+ - Git config contents (`git config --show-origin --list`)
+ - The names of all configured git-hooks in `.git/hooks/`
+
+OPTIONS
+-------
+-o [<path>]::
+--output [<path>]::
+	Place the resulting bug report file in <path> instead of the root of the
+	Git repository.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetc=
h.txt
index 666b042679..2894c5e82b 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--std=
in] <commit> <url>
+'git http-fetch' [-V]
=20
 DESCRIPTION
 -----------
@@ -30,6 +31,10 @@ commit-id::
 -v::
 	Report what is downloaded.
=20
+-V::
+	Report information about the version of git-http-fetch, including the
+	versions of its dependencies.
+
 -w <filename>::
         Writes the commit-id into the filename under $GIT_DIR/refs/<filena=
me> on
         the local end after the transfer is complete.
diff --git a/Makefile b/Makefile
index 6e361eed64..76dc51e2b1 100644
--- a/Makefile
+++ b/Makefile
@@ -634,10 +634,6 @@ SCRIPT_PYTHON +=3D git-p4.py
 SCRIPT_SH_GEN =3D $(patsubst %.sh,%,$(SCRIPT_SH))
 SCRIPT_PERL_GEN =3D $(patsubst %.perl,%,$(SCRIPT_PERL))
 SCRIPT_PYTHON_GEN =3D $(patsubst %.py,%,$(SCRIPT_PYTHON))
-SCRIPT_DEPENDENCIES =3D git-bugreport-config-whitelist
-
-$(SCRIPT_DEPENDENCIES): Documentation/config/*.txt
-	sh bugreport-generate-config-whitelist.sh
=20
 # Individual rules to allow e.g.
 # "make -C ../.. SCRIPT_PERL=3Dcontrib/foo/bar.perl build-perl-script"
@@ -662,13 +658,10 @@ clean-perl-script:
 	$(RM) $(SCRIPT_PERL_GEN)
 clean-python-script:
 	$(RM) $(SCRIPT_PYTHON_GEN)
-clean-script-dependencies:
-	$(RM) $(SCRIPT_DEPENDENCIES)
=20
 SCRIPTS =3D $(SCRIPT_SH_GEN) \
 	  $(SCRIPT_PERL_GEN) \
 	  $(SCRIPT_PYTHON_GEN) \
-	  $(SCRIPT_DEPENDENCIES) \
 	  git-instaweb
=20
 ETAGS_TARGET =3D TAGS
@@ -688,6 +681,7 @@ EXTRA_PROGRAMS =3D
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS +=3D $(EXTRA_PROGRAMS)
=20
+PROGRAM_OBJS +=3D bugreport.o
 PROGRAM_OBJS +=3D credential-store.o
 PROGRAM_OBJS +=3D daemon.o
 PROGRAM_OBJS +=3D fast-import.o
@@ -821,7 +815,9 @@ LIB_FILE =3D libgit.a
 XDIFF_LIB =3D xdiff/lib.a
 VCSSVN_LIB =3D vcs-svn/lib.a
=20
+GENERATED_H +=3D config-list.h
 GENERATED_H +=3D command-list.h
+GENERATED_H +=3D bugreport-config-safelist.h
=20
 LIB_H :=3D $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Do=
cumentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -846,7 +842,6 @@ LIB_OBJS +=3D bisect.o
 LIB_OBJS +=3D blame.o
 LIB_OBJS +=3D blob.o
 LIB_OBJS +=3D branch.o
-LIB_OBJS +=3D bugreport.o
 LIB_OBJS +=3D bulk-checkin.o
 LIB_OBJS +=3D bundle.o
 LIB_OBJS +=3D cache-tree.o
@@ -1049,7 +1044,6 @@ BUILTIN_OBJS +=3D builtin/archive.o
 BUILTIN_OBJS +=3D builtin/bisect--helper.o
 BUILTIN_OBJS +=3D builtin/blame.o
 BUILTIN_OBJS +=3D builtin/branch.o
-BUILTIN_OBJS +=3D builtin/bugreport.o
 BUILTIN_OBJS +=3D builtin/bundle.o
 BUILTIN_OBJS +=3D builtin/cat-file.o
 BUILTIN_OBJS +=3D builtin/check-attr.o
@@ -2135,7 +2129,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
=20
 help.sp help.s help.o: command-list.h
=20
-builtin/help.sp builtin/help.s builtin/help.o: command-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D \
 	'-DGIT_HTML_PATH=3D"$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH=3D"$(mandir_relative_SQ)"' \
@@ -2155,6 +2149,12 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
=20
+config-list.h: generate-configlist.sh
+
+config-list.h:
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
+		>$@+ && mv $@+ $@
+
 command-list.h: generate-cmdlist.sh command-list.txt
=20
 command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.t=
xt Documentation/config/*.txt
@@ -2162,6 +2162,12 @@ command-list.h: $(wildcard Documentation/git*.txt) D=
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
@@ -2457,6 +2463,10 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(=
LIBS)
=20
+git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS)
+
 git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
@@ -2788,7 +2798,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
=20
-GEN_HDRS :=3D command-list.h unicode-width.h
+GEN_HDRS :=3D config-list.h command-list.h unicode-width.h bugreport-confi=
g-safelist.h
 EXCEPT_HDRS :=3D $(GEN_HDRS) compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS +=3D sha256/gcrypt.h
@@ -2811,7 +2821,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
=20
-check: command-list.h
+check: config-list.h command-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
@@ -3114,7 +3124,9 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags csc=
ope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo
+	$(RM) config-list.h command-list.h bugreport-config-safelist.h
+	$(RM) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
diff --git a/bugreport-generate-config-whitelist.sh b/bugreport-generate-co=
nfig-whitelist.sh
deleted file mode 100755
index ca6b232024..0000000000
--- a/bugreport-generate-config-whitelist.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-
-grep -RhPo ".*(?=3D:: \/\/ bugreport-include)" Documentation/config \
-  >git-bugreport-config-whitelist
diff --git a/bugreport.c b/bugreport.c
index a7bdc72b7f..d2a3fb1f67 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -1,114 +1,128 @@
 #include "cache.h"
-
-#include "bugreport.h"
-#include "config.h"
-#include "exec-cmd.h"
+#include "parse-options.h"
+#include "stdio.h"
+#include "strbuf.h"
+#include "time.h"
 #include "help.h"
+#include <gnu/libc-version.h>
 #include "run-command.h"
-#include "strbuf.h"
-#include "string-list.h"
-#include "version.h"
-
-#include "dirent.h"
-
-/**
- * A sorted list of config options which we will add to the bugreport. Man=
aged
- * by 'gather_whitelist(...)'.
- */
-struct string_list whitelist =3D STRING_LIST_INIT_DUP;
-struct strbuf configs_and_values =3D STRBUF_INIT;
-
-// git version --build-options
-// uname -a
-// curl-config --version
-// ldd --version
-// echo $SHELL
-void get_system_info(struct strbuf *sys_info)
+#include "config.h"
+#include "bugreport-config-safelist.h"
+#include "khash.h"
+#include "run-command.h"
+
+static void get_http_version_info(struct strbuf *http_info)
 {
 	struct child_process cp =3D CHILD_PROCESS_INIT;
-	struct strbuf std_out =3D STRBUF_INIT;
=20
-	strbuf_reset(sys_info);
+	argv_array_push(&cp.args, "git");
+	argv_array_push(&cp.args, "http-fetch");
+	argv_array_push(&cp.args, "-V");
+	if (capture_command(&cp, http_info, 0))
+	    strbuf_addstr(http_info, "'git-http-fetch -V' not supported\n");
+}
=20
-	// get git version from native cmd
-	strbuf_addstr(sys_info, "git version: ");
-	strbuf_addstr(sys_info, git_version_string);
-	strbuf_complete_line(sys_info);
+KHASH_INIT(cfg_set, const char*, int, 0, kh_str_hash_func, kh_str_hash_equ=
al);
=20
-	// system call for other version info
-	argv_array_push(&cp.args, "uname");
-	argv_array_push(&cp.args, "-a");
-	capture_command(&cp, &std_out, 0);
+struct cfgset {
+	kh_cfg_set_t set;
+};
=20
-	strbuf_addstr(sys_info, "uname -a: ");
-	strbuf_addbuf(sys_info, &std_out);
-	strbuf_complete_line(sys_info);
-
-	argv_array_clear(&cp.args);
-	strbuf_reset(&std_out);
+struct cfgset safelist;
=20
+static void cfgset_init(struct cfgset *set, size_t initial_size)
+{
+	memset(&set->set, 0, sizeof(set->set));
+	if (initial_size)
+		kh_resize_cfg_set(&set->set, initial_size);
+}
=20
-	argv_array_push(&cp.args, "curl-config");
-	argv_array_push(&cp.args, "--version");
-	capture_command(&cp, &std_out, 0);
+static int cfgset_insert(struct cfgset *set, const char *cfg_key)
+{
+	int added;
+	kh_put_cfg_set(&set->set, cfg_key, &added);
+	printf("ESS: added %s\n", cfg_key);
+	return !added;
+}
=20
-	strbuf_addstr(sys_info, "curl-config --version: ");
-	strbuf_addbuf(sys_info, &std_out);
-	strbuf_complete_line(sys_info);
+static int cfgset_contains(struct cfgset *set, const char *cfg_key)
+{
+	khiter_t pos =3D kh_get_cfg_set(&set->set, cfg_key);
+	return pos !=3D kh_end(&set->set);
+}
=20
-	argv_array_clear(&cp.args);
-	strbuf_reset(&std_out);
+static void cfgset_clear(struct cfgset *set)
+{
+	kh_release_cfg_set(&set->set);
+	cfgset_init(set, 0);
+}
=20
+static void get_system_info(struct strbuf *sys_info)
+{
+	struct strbuf version_info =3D STRBUF_INIT;
+	struct utsname uname_info;
=20
-	argv_array_push(&cp.args, "ldd");
-	argv_array_push(&cp.args, "--version");
-	capture_command(&cp, &std_out, 0);
+	/* get git version from native cmd */
+	strbuf_addstr(sys_info, "git version:\n");
+	list_version_info(&version_info, 1);
+	strbuf_addbuf(sys_info, &version_info);
+	strbuf_complete_line(sys_info);
=20
-	strbuf_addstr(sys_info, "ldd --version: ");
-	strbuf_addbuf(sys_info, &std_out);
+	/* system call for other version info */
+	strbuf_addstr(sys_info, "uname -a: ");
+	if (uname(&uname_info))
+		strbuf_addf(sys_info, "uname() failed with code %d\n", errno);
+	else
+		strbuf_addf(sys_info, "%s %s %s %s %s\n",
+			    uname_info.sysname,
+			    uname_info.nodename,
+			    uname_info.release,
+			    uname_info.version,
+			    uname_info.machine);
+
+	strbuf_addstr(sys_info, "glibc version: ");
+	strbuf_addstr(sys_info, gnu_get_libc_version());
 	strbuf_complete_line(sys_info);
=20
-	argv_array_clear(&cp.args);
-	strbuf_reset(&std_out);
-}
+	strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
+		    getenv("SHELL"));
=20
-void gather_whitelist(struct strbuf *path)
-{
-	struct strbuf tmp =3D STRBUF_INIT;
-	strbuf_read_file(&tmp, path->buf, 0);
-	string_list_init(&whitelist, 1);
-	string_list_split(&whitelist, tmp.buf, '\n', -1);
-	string_list_sort(&whitelist);
+	strbuf_addstr(sys_info, "git-http-fetch -V:\n");
+	get_http_version_info(sys_info);
+	strbuf_complete_line(sys_info);
 }
=20
-int git_config_bugreport(const char *var, const char *value, void *cb)
+static void gather_safelist()
 {
-	if (string_list_has_string(&whitelist, var)) {
-		strbuf_addf(&configs_and_values,
-			    "%s : %s\n",
-			    var, value);
-	}
+	int index;
+	int safelist_len =3D sizeof(bugreport_config_safelist) / sizeof(const cha=
r *);
+	cfgset_init(&safelist, safelist_len);
+	for (index =3D 0; index < safelist_len; index++)
+		cfgset_insert(&safelist, bugreport_config_safelist[index]);
=20
-	return 0;
 }
=20
-void get_whitelisted_config(struct strbuf *config_info)
+static int git_config_bugreport(const char *var, const char *value, void *=
cb)
 {
-	struct strbuf path =3D STRBUF_INIT;
+	struct strbuf *config_info =3D (struct strbuf *)cb;
=20
-	strbuf_addstr(&path, git_exec_path());
-	strbuf_addstr(&path, "/git-bugreport-config-whitelist");
+	if (cfgset_contains(&safelist, var))
+		strbuf_addf(config_info,
+			    "%s (%s) : %s\n",
+			    var, config_scope_to_string(current_config_scope()),
+			    value);
=20
-	gather_whitelist(&path);
-	strbuf_init(&configs_and_values, whitelist.nr);
-
-	git_config(git_config_bugreport, NULL);
+	return 0;
+}
=20
-	strbuf_reset(config_info);
-	strbuf_addbuf(config_info, &configs_and_values);
+static void get_safelisted_config(struct strbuf *config_info)
+{
+	gather_safelist();
+	git_config(git_config_bugreport, config_info);
+	cfgset_clear(&safelist);
 }
=20
-void get_populated_hooks(struct strbuf *hook_info)
+static void get_populated_hooks(struct strbuf *hook_info)
 {
 	/*
 	 * Doesn't look like there is a list of all possible hooks; so below is
@@ -139,8 +153,15 @@ void get_populated_hooks(struct strbuf *hook_info)
 			    "post-index-changex";
 	struct string_list hooks_list =3D STRING_LIST_INIT_DUP;
 	struct string_list_item *iter =3D NULL;
+	int nongit_ok;
+
+	setup_git_directory_gently(&nongit_ok);
=20
-	strbuf_reset(hook_info);
+	if (nongit_ok) {
+		strbuf_addstr(hook_info,
+			"not run from a git repository - no hooks to show\n");
+		return;
+	}
=20
 	string_list_split(&hooks_list, hooks, ',', -1);
=20
@@ -152,163 +173,262 @@ void get_populated_hooks(struct strbuf *hook_info)
 	}
 }
=20
-/**
- * Fill 'contents' with the contents of the dir at 'dirpath'.
- * If 'filter' is nonzero, the contents are filtered on d_type as 'type' -=
 see
- * 'man readdir'. opendir() doesn't take string length as an arg, so don't
- * bother passing it in.
- */
-void list_contents_of_dir(struct string_list *contents, struct strbuf *dir=
path,
-			  int filter, unsigned char type)
+static int is_hex(const char *string, size_t count)
 {
-	struct dirent *dir =3D NULL;
-	DIR *dh =3D NULL;
-
-	dh =3D opendir(dirpath->buf);
-	while (dh && (dir =3D readdir(dh))) {
-		if (!filter || type =3D=3D dir->d_type) {
-			string_list_append(contents, dir->d_name);
-		}
+	for (; count; string++, count--) {
+		if (!isxdigit(*string))
+			return 0;
 	}
+	return 1;
 }
=20
-/**
- * Fills 'contents' with a list of all directories within the provided
- * directory, recursing into each directory.
- */
-void list_contents_of_dir_recursively(struct string_list *contents,
-				      struct strbuf *dirpath)
-{
-	struct string_list current_contents =3D STRING_LIST_INIT_DUP;
-	struct string_list current_subdirs =3D STRING_LIST_INIT_DUP;
-	struct string_list_item *it;
-	struct strbuf buf =3D STRBUF_INIT;
-
-	list_contents_of_dir(&current_contents, dirpath, 0, 0);
-	for_each_string_list_item(it, &current_contents) {
-		strbuf_reset(&buf);
-		strbuf_addbuf(&buf, dirpath);
-		strbuf_complete(&buf, '/');
-		strbuf_addstr(&buf, it->string);
-
-		string_list_append(contents, buf.buf);
-	}
+static void get_loose_object_summary(struct strbuf *obj_info) {
+	struct dirent *d =3D NULL;
+	DIR *dir, *subdir =3D NULL;
+	size_t dir_len;
+	struct strbuf dirpath =3D STRBUF_INIT;
=20
-	list_contents_of_dir(&current_subdirs, dirpath, 1, DT_DIR);
-	for_each_string_list_item(it, &current_subdirs) {
-		if (strcmp(it->string, ".") =3D=3D 0
-		    || strcmp(it->string, "..") =3D=3D 0)
-			continue;
-		strbuf_reset(&buf);
-		strbuf_addbuf(&buf, dirpath);
-		strbuf_complete(&buf, '/');
-		strbuf_addstr(&buf, it->string);
+	strbuf_addstr(&dirpath, get_object_directory());
+	strbuf_complete(&dirpath, '/');
=20
-		list_contents_of_dir_recursively(contents, &buf);
+	dir =3D opendir(dirpath.buf);
+	if (!dir) {
+		strbuf_addf(obj_info, "could not open object directory '%s'\n",
+			    dirpath.buf);
+		strbuf_release(&dirpath);
+		return;
 	}
-}
=20
-void get_object_counts(struct strbuf *obj_info)
-{
-	struct child_process cp =3D CHILD_PROCESS_INIT;
-	struct strbuf std_out =3D STRBUF_INIT;
-
-	argv_array_push(&cp.args, "count-objects");
-	argv_array_push(&cp.args, "-vH");
-	cp.git_cmd =3D 1;
-	capture_command(&cp, &std_out, 0);
+	dir_len =3D dirpath.len;
=20
-	strbuf_reset(obj_info);
-	strbuf_addstr(obj_info, "git-count-objects -vH:\n");
-	strbuf_addbuf(obj_info, &std_out);
-}
+	while ((d =3D readdir(dir))) {
+		int object_count =3D 0;
+		char subdir_name[3];
=20
-void get_loose_object_summary(struct strbuf *obj_info)
-{
-	struct strbuf dirpath =3D STRBUF_INIT;
-	struct string_list subdirs =3D STRING_LIST_INIT_DUP;
-	struct string_list_item *subdir;
-
-	strbuf_reset(obj_info);
+		if (d->d_type !=3D DT_DIR)
+			continue;
=20
-	strbuf_addstr(&dirpath, get_object_directory());
-	strbuf_complete(&dirpath, '/');
+		if ((strlen(d->d_name) !=3D 2) || (!is_hex(d->d_name, 2)))
+			continue;
=20
-	list_contents_of_dir(&subdirs, &dirpath, 1, DT_DIR);
+		/* copy directory name + \0 */
+		memcpy(subdir_name, d->d_name, 3);
=20
-	for_each_string_list_item(subdir, &subdirs)
-	{
-		struct strbuf subdir_buf =3D STRBUF_INIT;
-		struct string_list objects =3D STRING_LIST_INIT_DUP;
+		strbuf_setlen(&dirpath, dir_len);
+		strbuf_addstr(&dirpath, d->d_name);
=20
-		/*
-		 * Only interested in loose objects - so dirs named with the
-		 * first byte of the object ID
-		 */
-		if (strlen(subdir->string) !=3D 2 || !strcmp(subdir->string, ".."))
+		subdir =3D opendir(dirpath.buf);
+		if (!subdir)
 			continue;
+		while ((d =3D readdir(subdir)))
+			if (d->d_type =3D=3D DT_REG)
+				object_count++;
+
+		closedir(subdir);
=20
-		strbuf_addbuf(&subdir_buf, &dirpath);
-		strbuf_addstr(&subdir_buf, subdir->string);
-		list_contents_of_dir(&objects, &subdir_buf, 0, 0);
-		strbuf_addf(obj_info, "%s: %d objects\n", subdir->string,
-			    objects.nr);
+		strbuf_addf(obj_info, "%s: %d\n", subdir_name, object_count);
 	}
+
+
+	closedir(dir);
+	strbuf_release(&dirpath);
 }
=20
-void get_packed_object_summary(struct strbuf *obj_info)
+static void get_packed_object_summary(struct strbuf *obj_info)
 {
 	struct strbuf dirpath =3D STRBUF_INIT;
-	struct string_list contents =3D STRING_LIST_INIT_DUP;
-	struct string_list_item *entry;
-
-	strbuf_reset(obj_info);
+	struct dirent *d;
+	DIR *dir =3D NULL;
=20
 	strbuf_addstr(&dirpath, get_object_directory());
 	strbuf_complete(&dirpath, '/');
 	strbuf_addstr(&dirpath, "pack/");
-	list_contents_of_dir(&contents, &dirpath, 0, 0);
=20
-	// list full contents of $GIT_OBJECT_DIRECTORY/pack/
-	for_each_string_list_item(entry, &contents) {
+	dir =3D opendir(dirpath.buf);
+	if (!dir) {
+		strbuf_addf(obj_info, "could not open packed object directory '%s'\n",
+			    dirpath.buf);
+		strbuf_release(&dirpath);
+		return;
+	}
+
+	while ((d =3D readdir(dir))) {
 		strbuf_addbuf(obj_info, &dirpath);
-		strbuf_addstr(obj_info, entry->string);
+		strbuf_addstr(obj_info, d->d_name);
 		strbuf_complete_line(obj_info);
 	}
+
+	closedir(dir);
+	strbuf_release(&dirpath);
 }
=20
-void get_object_info_summary(struct strbuf *obj_info)
+static void list_contents_of_dir_recursively(struct strbuf *contents,
+				      	     struct strbuf *dirpath)
 {
-	// strbuf +=3D GITDIR/info/:
-	// recursively list contents of $GIT_OBJECT_DIRECTORY/info
-	struct strbuf dirpath =3D STRBUF_INIT;
-	struct string_list contents =3D STRING_LIST_INIT_DUP;
-	struct string_list_item *entry;
+	struct dirent *d;
+	DIR *dir;
+	size_t path_len;
=20
-	strbuf_reset(obj_info);
+	dir =3D opendir(dirpath->buf);
+	if (!dir)
+		return;
+
+	strbuf_complete(dirpath, '/');
+	path_len =3D dirpath->len;
+
+	while ((d =3D readdir(dir))) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+
+		strbuf_addbuf(contents, dirpath);
+		strbuf_addstr(contents, d->d_name);
+		strbuf_complete_line(contents);
+
+		if (d->d_type =3D=3D DT_DIR) {
+			strbuf_addstr(dirpath, d->d_name);
+			list_contents_of_dir_recursively(contents, dirpath);
+		}
+		strbuf_setlen(dirpath, path_len);
+	}
+
+	closedir(dir);
+}
+
+static void get_object_info_summary(struct strbuf *obj_info)
+{
+	struct strbuf dirpath =3D STRBUF_INIT;
=20
 	strbuf_addstr(&dirpath, get_object_directory());
 	strbuf_complete(&dirpath, '/');
 	strbuf_addstr(&dirpath, "info/");
=20
-	list_contents_of_dir_recursively(&contents, &dirpath);
+	list_contents_of_dir_recursively(obj_info, &dirpath);
=20
-	for_each_string_list_item(entry, &contents) {
-		strbuf_addstr(obj_info, entry->string);
-		strbuf_complete_line(obj_info);
-	}
+	strbuf_release(&dirpath);
 }
=20
-void get_alternates_file(struct strbuf *alternates_info)
+static void get_alternates_summary(struct strbuf *alternates_info)
 {
 	struct strbuf alternates_path =3D STRBUF_INIT;
+	struct strbuf alternate =3D STRBUF_INIT;
+	FILE *file;
+	size_t exists =3D 0, broken =3D 0;
=20
 	strbuf_addstr(&alternates_path, get_object_directory());
 	strbuf_complete(&alternates_path, '/');
 	strbuf_addstr(&alternates_path, "info/alternates");
=20
-	strbuf_reset(alternates_info);
-	strbuf_addbuf(alternates_info, &alternates_path);
-	strbuf_complete_line(alternates_info);
-	strbuf_read_file(alternates_info, alternates_path.buf, 0);
+	file =3D fopen(alternates_path.buf, "r");
+	if (!file) {
+		strbuf_addstr(alternates_info, "No alternates file found.\n");
+		strbuf_release(&alternates_path);
+		return;
+	}
+
+	while (strbuf_getline(&alternate, file) !=3D EOF) {
+		if (!access(alternate.buf, F_OK))
+			exists++;
+		else
+			broken++;
+	}
+
+	strbuf_addf(alternates_info,
+		    "%zd alternates found (%zd working, %zd broken)\n",
+		    exists + broken,
+		    exists,
+		    broken);
+
+	fclose(file);
+	strbuf_release(&alternate);
+	strbuf_release(&alternates_path);
+}
+
+static const char * const bugreport_usage[] =3D {
+	N_("git bugreport [-o|--output <file>]"),
+	NULL
+};
+
+static int get_bug_template(struct strbuf *template)
+{
+	const char template_text[] =3D N_(
+"Thank you for filling out a Git bug report!\n"
+"Please answer the following questions to help us understand your issue.\n=
"
+"\n"
+"What did you do before the bug happened? (Steps to reproduce your issue)\=
n"
+"\n"
+"What did you expect to happen? (Expected behavior)\n"
+"\n"
+"What happened instead? (Actual behavior)\n"
+"\n"
+"What's different between what you expected and what actually happened?\n"
+"\n"
+"Anything else you want to add:\n"
+"\n"
+"Please review the rest of the bug report below.\n"
+"You can delete any lines you don't wish to send.\n");
+
+	strbuf_addstr(template, template_text);
+	return 0;
+}
+
+static void get_header(struct strbuf *buf, const char *title)
+{
+	strbuf_addf(buf, "\n\n[%s]\n", title);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf buffer =3D STRBUF_INIT;
+	struct strbuf report_path =3D STRBUF_INIT;
+	FILE *report;
+	time_t now =3D time(NULL);
+	char *option_output =3D NULL;
+
+	const struct option bugreport_options[] =3D {
+		OPT_STRING('o', "output", &option_output, N_("path"),
+			   N_("specify a destination for the bugreport file")),
+		OPT_END()
+	};
+	argc =3D parse_options(argc, argv, "", bugreport_options,
+			     bugreport_usage, 0);
+
+	if (option_output) {
+		strbuf_addstr(&report_path, option_output);
+		strbuf_complete(&report_path, '/');
+	}
+
+	strbuf_addstr(&report_path, "git-bugreport-");
+	strbuf_addftime(&report_path, "%F", gmtime(&now), 0, 0);
+	strbuf_addstr(&report_path, ".txt");
+
+
+	get_bug_template(&buffer);
+
+	get_header(&buffer, "System Info");
+	get_system_info(&buffer);
+
+	get_header(&buffer, "Safelisted Config Info");
+	get_safelisted_config(&buffer);
+
+	get_header(&buffer, "Configured Hooks");
+	get_populated_hooks(&buffer);
+
+	get_header(&buffer, "Loose Object Counts");
+	get_loose_object_summary(&buffer);
+
+	get_header(&buffer, "Packed Object Summary");
+	get_packed_object_summary(&buffer);
+
+	get_header(&buffer, "Object Info Summary");
+	get_object_info_summary(&buffer);
+
+	get_header(&buffer, "Alternates");
+	get_alternates_summary(&buffer);
+
+	report =3D fopen_for_writing(report_path.buf);
+	strbuf_write(&buffer, report);
+	fclose(report);
+
+	launch_editor(report_path.buf, NULL, NULL);
+	return 0;
 }
diff --git a/bugreport.h b/bugreport.h
deleted file mode 100644
index 74d1f79960..0000000000
--- a/bugreport.h
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "strbuf.h"
-
-/**
- * Adds the Git version, `uname -a`, and `curl-config --version` to sys_in=
fo.
- * The previous contents of sys_info will be discarded.
- */
-void get_system_info(struct strbuf *sys_info);
-
-/**
- * Adds the values of the config items listed in
- * 'git-bugreport-config-whitelist' to config_info. The previous contents =
of
- * config_info will be discarded.
- */
-void get_whitelisted_config(struct strbuf *sys_info);
-
-/**
- * Adds the paths to all configured hooks (but not their contents). The pr=
evious
- * contents of hook_info will be discarded.
- */
-void get_populated_hooks(struct strbuf *hook_info);
-
-/**
- * Adds the output of `git count-object -vH`. The previous contents of hoo=
k_info
- * will be discarded.
- */
-void get_loose_object_summary(struct strbuf *obj_info);
-
-/**
- * Adds a list of the contents of '.git/objects/pack'. The previous conten=
ts of
- * hook_info will be discarded.
- */
-void get_packed_object_summary(struct strbuf *obj_info);
-
-/**
- * Adds a list of all contents (recursively) of '.git/objects/info'. The
- * previous contents of hook_info will be discarded.
- */
-void get_object_info_summary(struct strbuf *obj_info);
-
-/**
- * Adds the contents of '.git/info/alternates'. The previous contents of
- * alternates_info will be discarded.
- */
-void get_alternates_file(struct strbuf *alt_info);
diff --git a/builtin.h b/builtin.h
index c6373d3289..5cf5df69f7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -135,7 +135,6 @@ int cmd_archive(int argc, const char **argv, const char=
 *prefix);
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
-int cmd_bugreport(int argc, const char **argv, const char *prefix);
 int cmd_bundle(int argc, const char **argv, const char *prefix);
 int cmd_cat_file(int argc, const char **argv, const char *prefix);
 int cmd_checkout(int argc, const char **argv, const char *prefix);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
deleted file mode 100644
index 0784bdc42a..0000000000
--- a/builtin/bugreport.c
+++ /dev/null
@@ -1,90 +0,0 @@
-#include "builtin.h"
-#include "bugreport.h"
-#include "stdio.h"
-#include "strbuf.h"
-#include "time.h"
-
-int get_bug_template(struct strbuf *template)
-{
-	const char template_text[] =3D
-"Thank you for filling out a Git bug report!\n"
-"Please answer the following questions to help us understand your issue.\n=
"
-"\n"
-"What did you do before the bug happened? (Steps to reproduce your issue)\=
n"
-"\n"
-"What did you expect to happen? (Expected behavior)\n"
-"\n"
-"What happened instead? (Actual behavior)\n"
-"\n"
-"What's different between what you expected and what actually happened?\n"
-"\n"
-"Anything else you want to add:\n"
-"\n"
-"Please review the rest of the bug report below.\n"
-"You can delete any lines you don't wish to send.\n";
-
-	strbuf_reset(template);
-	strbuf_add(template, template_text, strlen(template_text));
-	return 0;
-}
-
-void add_header(FILE *report, const char *title)
-{
-	struct strbuf buffer =3D STRBUF_INIT;
-	strbuf_addf(&buffer, "\n\n[%s]\n", title);
-	strbuf_write(&buffer, report);
-}
-
-int cmd_bugreport(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf buffer =3D STRBUF_INIT;
-	struct strbuf report_path =3D STRBUF_INIT;
-	FILE *report;
-	time_t now =3D time(NULL);
-
-	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, "%F", gmtime(&now), 0, 0);
-	strbuf_addstr(&report_path, ".txt");
-
-	report =3D fopen_for_writing(report_path.buf);
-
-	get_bug_template(&buffer);
-	strbuf_write(&buffer, report);
-
-	// add other contents
-	add_header(report, "System Info");
-	get_system_info(&buffer);
-	strbuf_write(&buffer, report);
-
-	add_header(report, "Whitelisted Config");
-	get_whitelisted_config(&buffer);
-	strbuf_write(&buffer, report);
-
-	add_header(report, "Populated Hooks");
-	get_populated_hooks(&buffer);
-	strbuf_write(&buffer, report);
-
-	add_header(report, "Object Counts");
-	get_loose_object_summary(&buffer);
-	strbuf_write(&buffer, report);
-
-	add_header(report, "Packed Object Summary");
-	get_packed_object_summary(&buffer);
-	strbuf_write(&buffer, report);
-
-	add_header(report, "Object Info Data");
-	get_object_info_summary(&buffer);
-	strbuf_write(&buffer, report);
-
-	add_header(report, "Alternates File");
-	get_alternates_file(&buffer);
-	strbuf_write(&buffer, report);
-
-	// Close file
-	// open file in editor
-	launch_editor(report_path, NULL, NULL);
-	fclose(report);
-
-	launch_editor(report_path.buf, NULL, NULL);
-	return 0;
-}
diff --git a/builtin/help.c b/builtin/help.c
index e5590d7787..1c5f2b9255 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "column.h"
+#include "config-list.h"
 #include "help.h"
 #include "alias.h"
=20
@@ -62,6 +63,91 @@ static const char * const builtin_help_usage[] =3D {
 	NULL
 };
=20
+struct slot_expansion {
+	const char *prefix;
+	const char *placeholder;
+	void (*fn)(struct string_list *list, const char *prefix);
+	int found;
+};
+
+static void list_config_help(int for_human)
+{
+	struct slot_expansion slot_expansions[] =3D {
+		{ "advice", "*", list_config_advices },
+		{ "color.branch", "<slot>", list_config_color_branch_slots },
+		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
+		{ "color.diff", "<slot>", list_config_color_diff_slots },
+		{ "color.grep", "<slot>", list_config_color_grep_slots },
+		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
+		{ "color.remote", "<slot>", list_config_color_sideband_slots },
+		{ "color.status", "<slot>", list_config_color_status_slots },
+		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
+		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
+		{ NULL, NULL, NULL }
+	};
+	const char **p;
+	struct slot_expansion *e;
+	struct string_list keys =3D STRING_LIST_INIT_DUP;
+	int i;
+
+	for (p =3D config_name_list; *p; p++) {
+		const char *var =3D *p;
+		struct strbuf sb =3D STRBUF_INIT;
+
+		for (e =3D slot_expansions; e->prefix; e++) {
+
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
+			if (!strcasecmp(var, sb.buf)) {
+				e->fn(&keys, e->prefix);
+				e->found++;
+				break;
+			}
+		}
+		strbuf_release(&sb);
+		if (!e->prefix)
+			string_list_append(&keys, var);
+	}
+
+	for (e =3D slot_expansions; e->prefix; e++)
+		if (!e->found)
+			BUG("slot_expansion %s.%s is not used",
+			    e->prefix, e->placeholder);
+
+	string_list_sort(&keys);
+	for (i =3D 0; i < keys.nr; i++) {
+		const char *var =3D keys.items[i].string;
+		const char *wildcard, *tag, *cut;
+
+		if (for_human) {
+			puts(var);
+			continue;
+		}
+
+		wildcard =3D strchr(var, '*');
+		tag =3D strchr(var, '<');
+
+		if (!wildcard && !tag) {
+			puts(var);
+			continue;
+		}
+
+		if (wildcard && !tag)
+			cut =3D wildcard;
+		else if (!wildcard && tag)
+			cut =3D tag;
+		else
+			cut =3D wildcard < tag ? wildcard : tag;
+
+		/*
+		 * We may produce duplicates, but that's up to
+		 * git-completion.bash to handle
+		 */
+		printf("%.*s\n", (int)(cut - var), var);
+	}
+	string_list_clear(&keys, 0);
+}
+
 static enum help_format parse_help_format(const char *format)
 {
 	if (!strcmp(format, "man"))
diff --git a/config.c b/config.c
index e7052b3977..baab4a916e 100644
--- a/config.c
+++ b/config.c
@@ -3312,6 +3312,23 @@ enum config_scope current_config_scope(void)
 		return current_parsing_scope;
 }
=20
+const char *config_scope_to_string(enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_SYSTEM:
+		return "system";
+	case CONFIG_SCOPE_GLOBAL:
+		return "global";
+	case CONFIG_SCOPE_REPO:
+		return "repo";
+	case CONFIG_SCOPE_CMDLINE:
+		return "cmdline";
+	case CONFIG_SCOPE_UNKNOWN:
+	default:
+		return "unknown";
+	}
+}
+
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index 91fd4c5e96..c8bf296dcc 100644
--- a/config.h
+++ b/config.h
@@ -303,6 +303,7 @@ enum config_scope {
 };
=20
 enum config_scope current_config_scope(void);
+const char *config_scope_to_string(enum config_scope);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
=20
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
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 71158f7d8b..45fecf8bdf 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -76,23 +76,6 @@ print_command_list () {
 	echo "};"
 }
=20
-print_config_list () {
-	cat <<EOF
-static const char *config_name_list[] =3D {
-EOF
-	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/conf=
ig/*.txt |
-	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
-	sort |
-	while read line
-	do
-		echo "	\"$line\","
-	done
-	cat <<EOF
-	NULL,
-};
-EOF
-}
-
 exclude_programs=3D
 while test "--exclude-program" =3D "$1"
 do
@@ -113,5 +96,3 @@ echo
 define_category_names "$1"
 echo
 print_command_list "$1"
-echo
-print_config_list
diff --git a/generate-configlist.sh b/generate-configlist.sh
new file mode 100755
index 0000000000..eca6a00c30
--- /dev/null
+++ b/generate-configlist.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+echo "/* Automatically generated by generate-configlist.sh */"
+echo
+
+print_config_list () {
+	cat <<EOF
+static const char *config_name_list[] =3D {
+EOF
+	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/conf=
ig/*.txt |
+	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
+	sort |
+	while read line
+	do
+		echo "	\"$line\","
+	done
+	cat <<EOF
+	NULL,
+};
+EOF
+}
+
+echo
+print_config_list
diff --git a/git.c b/git.c
index 2d6a64f019..ce6ab0ece2 100644
--- a/git.c
+++ b/git.c
@@ -473,7 +473,6 @@ static struct cmd_struct commands[] =3D {
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
-	{ "bugreport", cmd_bugreport, RUN_SETUP },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
diff --git a/help.c b/help.c
index cf67624a94..6d1bd17971 100644
--- a/help.c
+++ b/help.c
@@ -407,91 +407,6 @@ void list_common_guides_help(void)
 	putchar('\n');
 }
=20
-struct slot_expansion {
-	const char *prefix;
-	const char *placeholder;
-	void (*fn)(struct string_list *list, const char *prefix);
-	int found;
-};
-
-void list_config_help(int for_human)
-{
-	struct slot_expansion slot_expansions[] =3D {
-		{ "advice", "*", list_config_advices },
-		{ "color.branch", "<slot>", list_config_color_branch_slots },
-		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
-		{ "color.diff", "<slot>", list_config_color_diff_slots },
-		{ "color.grep", "<slot>", list_config_color_grep_slots },
-		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
-		{ "color.remote", "<slot>", list_config_color_sideband_slots },
-		{ "color.status", "<slot>", list_config_color_status_slots },
-		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
-		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
-		{ NULL, NULL, NULL }
-	};
-	const char **p;
-	struct slot_expansion *e;
-	struct string_list keys =3D STRING_LIST_INIT_DUP;
-	int i;
-
-	for (p =3D config_name_list; *p; p++) {
-		const char *var =3D *p;
-		struct strbuf sb =3D STRBUF_INIT;
-
-		for (e =3D slot_expansions; e->prefix; e++) {
-
-			strbuf_reset(&sb);
-			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
-			if (!strcasecmp(var, sb.buf)) {
-				e->fn(&keys, e->prefix);
-				e->found++;
-				break;
-			}
-		}
-		strbuf_release(&sb);
-		if (!e->prefix)
-			string_list_append(&keys, var);
-	}
-
-	for (e =3D slot_expansions; e->prefix; e++)
-		if (!e->found)
-			BUG("slot_expansion %s.%s is not used",
-			    e->prefix, e->placeholder);
-
-	string_list_sort(&keys);
-	for (i =3D 0; i < keys.nr; i++) {
-		const char *var =3D keys.items[i].string;
-		const char *wildcard, *tag, *cut;
-
-		if (for_human) {
-			puts(var);
-			continue;
-		}
-
-		wildcard =3D strchr(var, '*');
-		tag =3D strchr(var, '<');
-
-		if (!wildcard && !tag) {
-			puts(var);
-			continue;
-		}
-
-		if (wildcard && !tag)
-			cut =3D wildcard;
-		else if (!wildcard && tag)
-			cut =3D tag;
-		else
-			cut =3D wildcard < tag ? wildcard : tag;
-
-		/*
-		 * We may produce duplicates, but that's up to
-		 * git-completion.bash to handle
-		 */
-		printf("%.*s\n", (int)(cut - var), var);
-	}
-	string_list_clear(&keys, 0);
-}
-
 static int get_alias(const char *var, const char *value, void *data)
 {
 	struct string_list *list =3D data;
@@ -707,8 +622,34 @@ const char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
=20
+void list_version_info(struct strbuf *buf, int build_options)
+{
+	strbuf_reset(buf);
+	/*
+	 * The format of this string should be kept stable for compatibility
+	 * with external projects that rely on the output of "git version".
+	 *
+	 * Always show the version, even if other options are given.
+	 */
+	strbuf_addf(buf, "git version %s\n", git_version_string);
+
+	if (build_options) {
+		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
+		if (git_built_from_commit_string[0])
+			strbuf_addf(buf, "built from commit: %s\n",
+			       git_built_from_commit_string);
+		else
+			strbuf_addf(buf, "no commit associated with this build\n");
+		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
+		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
+		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
+		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+	}
+}
+
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
+	struct strbuf buf =3D STRBUF_INIT;
 	int build_options =3D 0;
 	const char * const usage[] =3D {
 		N_("git version [<options>]"),
@@ -722,25 +663,9 @@ int cmd_version(int argc, const char **argv, const cha=
r *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
=20
-	/*
-	 * The format of this string should be kept stable for compatibility
-	 * with external projects that rely on the output of "git version".
-	 *
-	 * Always show the version, even if other options are given.
-	 */
-	printf("git version %s\n", git_version_string);
+	list_version_info(&buf, build_options);
+	printf("%s", buf.buf);
=20
-	if (build_options) {
-		printf("cpu: %s\n", GIT_HOST_CPU);
-		if (git_built_from_commit_string[0])
-			printf("built from commit: %s\n",
-			       git_built_from_commit_string);
-		else
-			printf("no commit associated with this build\n");
-		printf("sizeof-long: %d\n", (int)sizeof(long));
-		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
-		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
-	}
 	return 0;
 }
=20
diff --git a/help.h b/help.h
index 7a455beeb7..54f6b5f793 100644
--- a/help.h
+++ b/help.h
@@ -22,7 +22,6 @@ static inline void mput_char(char c, unsigned int num)
 void list_common_cmds_help(void);
 void list_all_cmds_help(void);
 void list_common_guides_help(void);
-void list_config_help(int for_human);
=20
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
@@ -38,6 +37,7 @@ void add_cmdname(struct cmdnames *cmds, const char *name,=
 int len);
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 int is_in_cmdlist(struct cmdnames *cmds, const char *name);
 void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struc=
t cmdnames *other_cmds);
+void list_version_info(struct strbuf *buf, int build_options);
=20
 /*
  * call this to die(), when it is suspected that the user mistyped a
diff --git a/http-fetch.c b/http-fetch.c
index a32ac118d9..31844812a1 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,9 +3,18 @@
 #include "exec-cmd.h"
 #include "http.h"
 #include "walker.h"
+#include "version.h"
=20
 static const char http_fetch_usage[] =3D "git http-fetch "
-"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+"[-c] [-t] [-a] [-v] [-V] [--recover] [-w ref] [--stdin] commit-id url";
+
+void NORETURN version_info()
+{
+	printf("git-http-fetch version: %s\n", git_version_string);
+	printf("built from commit: %s\n", git_built_from_commit_string);
+	printf("curl version: %s\n", curl_version());
+	exit(0);
+}
=20
 int cmd_main(int argc, const char **argv)
 {
@@ -26,6 +35,8 @@ int cmd_main(int argc, const char **argv)
 		} else if (argv[arg][1] =3D=3D 'a') {
 		} else if (argv[arg][1] =3D=3D 'v') {
 			get_verbosely =3D 1;
+		} else if (argv[arg][1] =3D=3D 'V') {
+			version_info();
 		} else if (argv[arg][1] =3D=3D 'w') {
 			write_ref =3D &argv[arg + 1];
 			arg++;
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
new file mode 100755
index 0000000000..6eb2ee4f66
--- /dev/null
+++ b/t/t0091-bugreport.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+
+test_description=3D'git bugreport'
+
+. ./test-lib.sh
+
+# Headers "[System Info]" will be followed by a non-empty line if we put s=
ome
+# information there; we can make sure all our headers were followed by som=
e
+# information to check if the command was successful.
+HEADER_PATTERN=3D"^\[.*\]$"
+check_all_headers_populated() {
+	while read -r line; do
+		if [$(grep $HEADER_PATTERN $line)]; then
+			read -r nextline
+			if [-z $nextline]; then
+				return 1;
+			fi
+		fi
+	done
+}
+
+test_expect_success 'creates a report with content in the right places' '
+	git bugreport &&
+	check_all_headers_populated <git-bugreport-* &&
+	rm git-bugreport-*
+'
+
+test_expect_success '--output puts the report in the provided dir' '
+	mkdir foo/ &&
+	git bugreport -o foo/ &&
+	test -f foo/git-bugreport-* &&
+	rm -fr foo/
+'
+
+test_expect_success 'incorrect arguments abort with usage' '
+	test_must_fail git bugreport --false 2>output &&
+	grep usage output &&
+	test ! -f git-bugreport-*
+'
+
+test_done

--=20
2.24.1.735.g03f4e72817-goog

