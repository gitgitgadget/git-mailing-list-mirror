From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (tig)] Infrastructure for tig rpm builds.
Date: Mon, 28 May 2007 10:54:04 +0200
Message-ID: <200705281054.05376.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tipWGgj1y4wxW5/"
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon May 28 12:17:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HscI6-00032w-BY
	for gcvg-git@gmane.org; Mon, 28 May 2007 12:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762030AbXE1KQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 06:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761632AbXE1KQm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 06:16:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:12004 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbXE1KQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 06:16:40 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1594289ugf
        for <git@vger.kernel.org>; Mon, 28 May 2007 03:16:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:message-id:content-type;
        b=I8q1AIfGJnUgChDI6hIyuwkid5yjsQzHovANLQp2/lqcnxJ2hiGw6adKvliBnEnm7q1n3keJT7EVsRNwUtQtwDfzaFx97DwR17LC4GW++e0lin9XMbUZsqnTIKkrrIyhkWpak0wyy+1g3d5x+upizZYnBNmXH6quUdXhx0F/wow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:message-id:content-type;
        b=iZtwWd1S72Mcqc+QlhPAfsMMG4YxEOPpDjyg7E3dyqLcUjeFdl3bhLZhuuzmv8+rKHXPWO/FVkW01Jfvd/61l08IYeE1/lEvmll3+k0UCujxqr8OAE8gjInVsVIAqUmsGhvB7iW9izSmSvIRFAYZ6MQqgQevV/FVbx2S2/5sCGg=
Received: by 10.67.116.3 with SMTP id t3mr5158512ugm.1180347398329;
        Mon, 28 May 2007 03:16:38 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id m1sm7761725ugc.2007.05.28.03.16.35;
        Mon, 28 May 2007 03:16:36 -0700 (PDT)
User-Agent: KMail/1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48611>

--Boundary-00=_tipWGgj1y4wxW5/
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adds RPM_VERSION to Makefile and new make targets: tig.spec, dist, and
rpm. A simple 'make rpm' will build the rpm. Also adds tig.spec.in
which is used to generate tig.spec.

Accidentally VERSION (and adding -DVERSION=$(VERSION) to CFLAGS) is
now defined always, even if we do not compile from the "live" tig
repository.

Minimally tested (meaning "make rpm" from tig repository works).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
'tig.spec.in' is based on 'git.spec.in' from git repository.

This is the initial, minimal version.  For example it does not add
TIG-VERSION-GEN file and the rest of versioning infrastructure that is
used in git Makefile.

Commands used to get version string (in RPM_VERSION) suitable as a
version field in the rpm can, most probably, be improved.  Perhaps
(with the new git-describe output) we should put closest version tag
as version of tig in rpm, and distance from the tag (perhaps plus 1)
as release number (in the rpm sense).

TODO: Change '--without docs' to '--with rebuild-docs' and use
pre-generated docs when creating rpm, instead of generating them (and
requiring asciidoc, xmlto and docbook2pdf to build rpm if we want tig
documentation).


P.S. I have build tig-0.6.4.g9eded37-1.i386.rpm using "make rpm" from
tig repository, and installed it without problems, but when trying to
build it again _without network_ it failed on building
manual.pdf. Error log attached.

  asciidoc-7.1.2-2.fc3.rf
  docbook-dtds-1.0-26
  docbook-style-dsssl-1.79-1
  docbook-style-xsl-1.68.1-1
  docbook-utils-0.6.14-4
  docbook-utils-pdf-0.6.14-4
  jadetex-3.12-13
  openjade-1.3.2-16

I think we can skip generation of manual.pdf, and generate it only on
request (e.g. "make doc-pdf"), or using doc-man and doc-html in place
of doc in the spec file... but this is better left for the next
commit.

By the way, why do you use xmlto and docbook2pdf, instead of a2x from
asciidoc package?

 .gitignore  |    2 ++
 Makefile    |   34 ++++++++++++++++++++++++++++++++--
 tig.spec.in |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 tig.spec.in

diff --git a/.gitignore b/.gitignore
index 8f6aa93..f7ab840 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,3 +2,5 @@ manual.html-chunked
 manual.pdf
 manual.toc
 tig
+tig.spec
+tig-*.tar.gz
diff --git a/Makefile b/Makefile
index 06a5d6a..45c833b 100644
--- a/Makefile
+++ b/Makefile
@@ -18,8 +18,16 @@ DOCS	= $(DOCS_MAN) $(DOCS_HTML) \
 ifneq (,$(wildcard .git))
 VERSION = $(shell git-describe)
 WTDIRTY = $(shell git-diff-index --name-only HEAD 2>/dev/null)
-CFLAGS += '-DVERSION="$(VERSION)$(if $(WTDIRTY),-dirty)"'
+else
+GEN_VER="tig-0.6.TIG"
+VERSION = $(shell test -f version && cat version || echo "$(GEN_VER)")
 endif
+CFLAGS += '-DVERSION="$(VERSION)$(if $(WTDIRTY),-dirty)"'
+RPM_VERSION  = $(subst tig-,,$(VERSION))
+RPM_VERSION := $(subst -,.,$(RPM_VERSION))
+
+TARNAME=tig-$(RPM_VERSION)
+
 
 all: $(PROGS)
 all-debug: $(PROGS)
@@ -57,6 +65,9 @@ install-doc: install-doc-man install-doc-html
 clean:
 	rm -rf manual.html-chunked
 	rm -f $(PROGS) $(DOCS) core *.xml
+	rm -f *.spec
+	rm -rf $(TARNAME)
+	rm -f $(TARNAME).tar.gz
 
 spell-check:
 	aspell --lang=en --check tig.1.txt tigrc.5.txt manual.txt
@@ -64,7 +75,7 @@ spell-check:
 strip: all
 	strip $(PROGS)
 
-.PHONY: all all-debug doc doc-man doc-html install install-doc install-doc-man install-doc-html clean spell-check
+.PHONY: all all-debug doc doc-man doc-html install install-doc install-doc-man install-doc-html clean spell-check dist rpm
 
 manual.html: manual.toc
 manual.toc: manual.txt
@@ -119,3 +130,22 @@ sync-docs:
 	make doc
 	cg commit -m "Sync docs"
 	cg switch master
+
+tig.spec: tig.spec.in
+	sed -e 's/@@VERSION@@/$(RPM_VERSION)/g' < $< > $@+
+	mv $@+ $@
+
+dist: tig.spec
+	git-archive --format=tar \
+		--prefix=$(TARNAME)/ HEAD^{tree} > $(TARNAME).tar
+	@mkdir -p $(TARNAME)
+	@cp tig.spec $(TARNAME)
+	@echo $(VERSION) > $(TARNAME)/version
+	tar rf $(TARNAME).tar \
+	       $(TARNAME)/tig.spec \
+	       $(TARNAME)/version
+	@rm -rf $(TARNAME)
+	gzip -f -9 $(TARNAME).tar
+
+rpm: dist
+	rpmbuild -ta $(TARNAME).tar.gz
diff --git a/tig.spec.in b/tig.spec.in
new file mode 100644
index 0000000..2ce6cdb
--- /dev/null
+++ b/tig.spec.in
@@ -0,0 +1,56 @@
+# -*- mode: rpm-spec-mode; encoding: utf-8; -*-
+# Pass '--without docs' to rpmbuild if you don't want the documentation
+
+Summary: 	Tig: text-mode interface for git
+Name: 		tig
+Version: 	@@VERSION@@
+Release: 	1%{?dist}
+License: 	GPL
+Group: 		Development/Tools
+Vendor: 	Jonas Fonseca <fonseca@diku.dk>
+URL: 		http://jonas.nitro.dk/tig/
+Source: 	http://jonas.nitro.dk/tig/releases/%{name}-%{version}.tar.gz
+BuildRequires: 	ncurses-devel%{!?_without_docs:, xmlto, asciidoc > 6.0.3, /usr/bin/docbook2pdf}
+BuildRoot: 	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
+Requires: 	git-core, ncurses
+
+%description
+Tig is a git repository browser that additionally can act as a pager
+for output from various git commands.
+
+When browsing repositories, it uses the underlying git commands to
+present the user with various views, such as summarized revision log
+and showing the commit with the log message, diffstat, and the diff.
+
+Using it as a pager, it will display input from stdin and colorize it.
+
+%prep
+%setup -q
+
+%build
+CFLAGS="$RPM_OPT_FLAGS -DVERSION=tig-%{version}-%{release}"
+%{__make} %{_smp_mflags} \
+	prefix=%{_prefix} \
+	all %{!?_without_docs: doc}
+
+%install
+[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
+CFLAGS="$RPM_OPT_FLAGS -DVERSION=tig-%{version}-%{release}"
+%{__make} %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT \
+	prefix=%{_prefix} bindir=%{_bindir} mandir=%{_mandir} \
+	install %{!?_without_docs: install-doc-man}
+
+%clean
+[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
+
+%files
+%defattr(-,root,root)
+%{_bindir}/*
+%doc README COPYING INSTALL SITES BUGS TODO tigrc
+%{!?_without_docs: %{_mandir}/man1/*.1*}
+%{!?_without_docs: %{_mandir}/man5/*.5*}
+%{!?_without_docs: %doc *.html *.pdf}
+
+%changelog
+* Mon May 28 2007 Jakub Narebski <jnareb@gmail.com>
+- Initial tig spec file
-- 
1.5.2


--Boundary-00=_tipWGgj1y4wxW5/
Content-Type: text/plain;
  charset="iso-8859-2";
  name="tig-rpmbuild.log"
Content-Transfer-Encoding: 8bit
Content-Description: Selected parts of error log for "make rpm"
Content-Disposition: attachment;
	filename="tig-rpmbuild.log"

docbook2pdf manual.xml
Using catalogs: /etc/sgml/xml-docbook-4.2-1.0-26.cat
Using stylesheet: /usr/share/sgml/docbook/utils-0.6.14/docbook-utils.dsl#print
Working on: /home/local/builddir/BUILD/tig-0.6.4.g9eded37/manual.xml
jade:/home/local/builddir/BUILD/tig-0.6.4.g9eded37/manual.xml:2:118:E: could not resolve host "www.oasis-open.org" (try again later)
jade:/home/local/builddir/BUILD/tig-0.6.4.g9eded37/manual.xml:2:118:E: DTD did not contain element declaration for document type name
jade:/home/local/builddir/BUILD/tig-0.6.4.g9eded37/manual.xml:4:14:E: there is no attribute "lang"
jade:/home/local/builddir/BUILD/tig-0.6.4.g9eded37/manual.xml:4:18:E: element "article" undefined

[...]

jade:/home/local/builddir/BUILD/tig-0.6.4.g9eded37/manual.xml:400:10:E: element "entry" undefined
jade:/home/local/builddir/BUILD/tig-0.6.4.g9eded37/manual.xml:401:172:E: element "emphasis" undefined
jade:/home/local/builddir/BUILD/tig-0.6.4.g9eded37/manual.xml:404:6:E: element "row" undefined
jade:I: maximum number of errors (200) reached; change with -E option
jade:/usr/share/sgml/docbook/dsssl-stylesheets-1.79/print/../common/dbtable.dsl:224:13:E: 2nd argument for primitive "ancestor" of wrong type: "#<unknown object 152549536>" not a singleton node list
jade:/usr/share/sgml/docbook/dsssl-stylesheets-1.79/print/../common/dbtable.dsl:224:13:E: 2nd argument for primitive "ancestor" of wrong type: "#<unknown object 152549536>" not a singleton node list
jade:/usr/share/sgml/docbook/dsssl-stylesheets-1.79/print/../common/dbtable.dsl:224:13:E: 2nd argument for primitive "ancestor" of wrong type: "#<unknown object 152549536>" not a singleton node list

[...]

jade:/usr/share/sgml/docbook/dsssl-stylesheets-1.79/print/../common/dbtable.dsl:224:13:E: 2nd argument for primitive "ancestor" of wrong type: "#<unknown object 152549536>" not a singleton node list
jade:/usr/share/sgml/docbook/dsssl-stylesheets-1.79/print/../common/dbtable.dsl:224:13:E: 2nd argument for primitive "ancestor" of wrong type: "#<unknown object 152549536>" not a singleton node list
make[1]: *** [manual.pdf] B³±d 8
rm manual.xml tigrc.5.xml tig.1.xml
make[1]: Leaving directory `/home/local/builddir/BUILD/tig-0.6.4.g9eded37'

--Boundary-00=_tipWGgj1y4wxW5/--
