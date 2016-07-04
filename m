Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD33F2101D
	for <e@80x24.org>; Mon,  4 Jul 2016 22:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbcGDWeo (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 18:34:44 -0400
Received: from hermes.apache.org ([140.211.11.3]:54640 "HELO mail.apache.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753490AbcGDWem convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2016 18:34:42 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jul 2016 18:34:42 EDT
Received: (qmail 45983 invoked by uid 99); 4 Jul 2016 22:28:02 -0000
Received: from mail-relay.apache.org (HELO mail-relay.apache.org) (140.211.11.15)
    by apache.org (qpsmtpd/0.29) with ESMTP; Mon, 04 Jul 2016 22:28:02 +0000
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com [209.85.223.179])
	by mail-relay.apache.org (ASF Mail Server at mail-relay.apache.org) with ESMTPSA id 3AEEC1A05F1
	for <git@vger.kernel.org>; Mon,  4 Jul 2016 22:28:02 +0000 (UTC)
Received: by mail-io0-f179.google.com with SMTP id g13so159742277ioj.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 15:28:02 -0700 (PDT)
X-Gm-Message-State: ALyK8tK0fNTOxjopI6Z+9R9br9/JUkjNiqFL82Pzq9bzL/1hpS/qjsIo6c/9ommgLdtTTWrdYwDjxRNf1R6SPQ==
X-Received: by 10.107.58.65 with SMTP id h62mr11859941ioa.172.1467671281162;
 Mon, 04 Jul 2016 15:28:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.137.6 with HTTP; Mon, 4 Jul 2016 15:27:31 -0700 (PDT)
From:	Alexandru Zbarcea <alexz@apache.org>
Date:	Mon, 4 Jul 2016 18:27:31 -0400
X-Gmail-Original-Message-ID: <CAGycqjyzXg-FNrp8n9QFE8-uF=OecMyXgHerk_RERiMkpdoz9A@mail.gmail.com>
Message-ID: <CAGycqjyzXg-FNrp8n9QFE8-uF=OecMyXgHerk_RERiMkpdoz9A@mail.gmail.com>
Subject: [PATCH] add documentation to mw-to-git
To:	git@vger.kernel.org
Cc:	Benoit Person <benoit.person@gmail.com>,
	=?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	David Aguilar <davvid@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Jeff King <peff@peff.net>,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Masanari Iida <standby24x7@gmail.com>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	Simon Cathebras <simon.cathebras@ensimag.imag.fr>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Alexandru Zbarcea <alexz@apache.org>
---
 contrib/mw-to-git/Makefile                 |  44 ++++++++++++-
 contrib/mw-to-git/git-mediawiki.txt        | 100 +++++++++++++++++++++++++++++
 contrib/mw-to-git/git-remote-mediawiki.txt |   7 --
 3 files changed, 142 insertions(+), 9 deletions(-)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index a4b6f7a..a2b5ed8 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -12,13 +12,25 @@
 #
 #   make install

+prefix ?= /usr/local
+mandir ?= $(prefix)/share/man
+man1dir ?= $(mandir)/man1
+htmldir ?= $(prefix)/share/doc/git-doc
+
 GIT_MEDIAWIKI_PM=Git/Mediawiki.pm
 SCRIPT_PERL=git-remote-mediawiki.perl
 SCRIPT_PERL+=git-mw.perl
 GIT_ROOT_DIR=../..
 HERE=contrib/mw-to-git/

-INSTALL = install
+INSTALL  ?= install
+RM       ?= rm -f
+
+ASCIIDOC = asciidoc
+XMLTO    = xmlto
+
+ASCIIDOC_CONF = ../../Documentation/asciidoc.conf
+MANPAGE_XSL   = ../../Documentation/manpage-normal.xsl

 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
 INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
@@ -26,8 +38,36 @@ INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 INSTLIBDIR_SQ = $(subst ','\'',$(INSTLIBDIR))

+GIT_MEDIAWIKI_DOC := git-mediawiki.1
+GIT_MEDIAWIKI_XML := git-mediawiki.xml
+GIT_MEDIAWIKI_TXT := git-mediawiki.txt
+GIT_MEDIAWIKI_HTML := git-mediawiki.html
+
 all: build

+doc: $(GIT_MEDIAWIKI_DOC) $(GIT_MEDIAWIKI_HTML)
+
+install-doc: install-man install-html
+
+install-man: $(GIT_MEDIAWIKI_DOC)
+ $(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
+ $(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
+
+install-html: $(GIT_MEDIAWIKI_HTML)
+ $(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
+ $(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
+
+$(GIT_MEDIAWIKI_DOC): $(GIT_MEDIAWIKI_XML)
+ $(XMLTO) -m $(MANPAGE_XSL) man $^
+
+$(GIT_MEDIAWIKI_XML): $(GIT_MEDIAWIKI_TXT)
+ $(ASCIIDOC) -b docbook -d manpage -f $(ASCIIDOC_CONF) \
+ -agit_version=$(GIT_VERSION) $^
+
+$(GIT_MEDIAWIKI_HTML): $(GIT_MEDIAWIKI_TXT)
+ $(ASCIIDOC) -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
+ -agit_version=$(GIT_VERSION) $^
+
 test: all
  $(MAKE) -C t

@@ -54,4 +94,4 @@ perlcritic:
  perlcritic -5 $(SCRIPT_PERL)
  -perlcritic -2 $(SCRIPT_PERL)

-.PHONY: all test check install_pm install clean perlcritic
+.PHONY: all doc test check install_pm install install-doc install-man
install-html clean perlcritic
diff --git a/contrib/mw-to-git/git-mediawiki.txt
b/contrib/mw-to-git/git-mediawiki.txt
new file mode 100644
index 0000000..421fbae
--- /dev/null
+++ b/contrib/mw-to-git/git-mediawiki.txt
@@ -0,0 +1,100 @@
+git-mediawiki(1)
+==============
+
+NAME
+----
+git-mediawiki - Abstracts a Mediawiki as a git repository.
+
+
+SYNOPSIS
+--------
+[verse]
+'git clone' -c <name>=<value> mediawiki::<repository>
+'git fetch' -c <name>=<value>
+'git mw' help
+'git mw' preview
+
+DESCRIPTION
+-----------
+Git-Mediawiki is a project which aims the creation of a gate
+between git and mediawiki, allowing git users to push and pull
+objects from mediawiki just as one would do with a classic git
+repository thanks to 'remote-helpers'.
+
+[TIP]
+For more information, visit the wiki at
+https://github.com/moy/Git-Mediawiki/wiki
+
+[TIP]
+Limit the pages to be imported. If you don't want to clone the
+whole wiki, you can import only some pages with:
+
+ $ git clone -c remote.origin.pages='A_page Another_page' \
+        mediawiki::http://yourwikiadress.com
+
+and/or select the content of MediaWiki Categories with:
+
+    $ git clone -c remote.origin.categories='First Second' \
+        mediawiki::http://yourwikiadress.com
+
+
+COMMANDS
+--------
+help::
+    Display help information about git mw.
+
+preview::
+    Parse and render local file into HTML. Preview a page without
actually pushing it to the wiki.
+
+OPTIONS FOR git
+-----------------
+
+remote.<name>.pages::
+    Imports only the page specified.
+
+remote.<name>.categories::
+    Imports only the category page specified.
+
+remote.<name>.shallow::
+    Imports only the last revision of a wiki
+
+remote.<name>.mwLogin::
+    Login username for the wiki
+
+remote.<name>.mwDomain::
+    If your wiki requires specifying a domain when logging in (if you
use LDAP authentication for instance), this value represents the
domain for your 'remote.<name>.mwLogin'.
+
+remote.<name>.mwPassword::
+    Login password for the wiki
+
+remote.<name>.dumbPush::
+    If 'true', then 'git push' will not touch the MediaWiki metadata,
and will ask you to reimport history after a successful push,
typically with 'git pull --rebase'. For those who know 'git svn', in
this mode, 'git push; git pull --rebase' is the equivalent of 'git svn
dcommit'.
+
+remote.<name>.fetchStrategy::
+    by_page::
+        This is the most efficient method when cloning a small subset
of a very active wiki. On the other hand, fetching from a wiki with
little activity but many pages is long (the tool has to query every
page even to say "Everything up to date").
+
+    by_rev::
+        Then, git-remote-mediawiki will query the whole wiki for new
revisions, and will filter-out revisions that should not be fetched
because they do not touch tracked pages. In this case, for example,
fetching from an up-to-date wiki is done in constant time (not
O(number of pages)).
+
+AUTHOR
+------
+The authors from the git log (alphabetic)::
+    Benoit Person <benoit.person@gmail.com>
+    Célestin Matte <celestin.matte@ensimag.fr>
+    David Aguilar <davvid@gmail.com>
+    Elia Pinto <gitter.spiros@gmail.com>
+    Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+    Jeff King <peff@peff.net>
+    Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
+    Jonathan Nieder <jrnieder@gmail.com>
+    Junio C Hamano <gitster@pobox.com>
+    Masanari Iida <standby24x7@gmail.com>
+    NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
+    Pavel Volek <Pavel.Volek@ensimag.imag.fr>
+    Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+    Stefano Lattarini <stefano.lattarini@gmail.com>
+
+GIT
+---
+Part of the linkgit:git[1] suite
\ No newline at end of file
diff --git a/contrib/mw-to-git/git-remote-mediawiki.txt
b/contrib/mw-to-git/git-remote-mediawiki.txt
deleted file mode 100644
index 23b7ef9..0000000
--- a/contrib/mw-to-git/git-remote-mediawiki.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Git-Mediawiki is a project which aims the creation of a gate
-between git and mediawiki, allowing git users to push and pull
-objects from mediawiki just as one would do with a classic git
-repository thanks to remote-helpers.
-
-For more information, visit the wiki at
-https://github.com/moy/Git-Mediawiki/wiki
-- 
2.9.0
