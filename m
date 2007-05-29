From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH (tig)] Infrastructure for tig rpm builds.
Date: Tue, 29 May 2007 22:29:23 +0200
Message-ID: <20070529202923.GA6358@diku.dk>
References: <200705281054.05376.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 22:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht8K5-0001mL-81
	for gcvg-git@gmane.org; Tue, 29 May 2007 22:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbXE2U3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 16:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758374AbXE2U3c
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 16:29:32 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:40255 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbXE2U3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 16:29:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id EF64A77000D;
	Tue, 29 May 2007 22:29:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQ4FiQYNtVIr; Tue, 29 May 2007 22:29:27 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id F4232F000A;
	Tue, 29 May 2007 22:29:23 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B4FC76DF823; Tue, 29 May 2007 22:27:23 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D493262A5D; Tue, 29 May 2007 22:29:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705281054.05376.jnareb@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48709>

Hej Jakub,

Jakub Narebski <jnareb@gmail.com> wrote Mon, May 28, 2007:
> Adds RPM_VERSION to Makefile and new make targets: tig.spec, dist, and
> rpm. A simple 'make rpm' will build the rpm. Also adds tig.spec.in
> which is used to generate tig.spec.

Thank you. :)

> Accidentally VERSION (and adding -DVERSION=$(VERSION) to CFLAGS) is
> now defined always, even if we do not compile from the "live" tig
> repository.

Yeah, this is probably a good idea; the same goes for moving version
info to a file instead of having it in tig.c.

> Minimally tested (meaning "make rpm" from tig repository works).

Trying 'make rpm' on ubuntu 7.04 I get:

  $ rpmbuild -ta tig-0.6.g2463b4e.tar.gz
  error: Name field must be present in package: (main package)
  error: Version field must be present in package: (main package)
  error: Release field must be present in package: (main package)
  error: Summary field must be present in package: (main package)
  error: Group field must be present in package: (main package)
  error: License field must be present in package: (main package)
  $ ls -l /usr/src/rpm/SPECS/
  total 0
  -rw------- 1 root root 0 2007-05-29 21:46 tar: Pattern matching characters used in file names. Please,

Strange.

> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> 'tig.spec.in' is based on 'git.spec.in' from git repository.
> 
> This is the initial, minimal version.  For example it does not add
> TIG-VERSION-GEN file and the rest of versioning infrastructure that is
> used in git Makefile.

I would prefer to do without. ;)
 
> Commands used to get version string (in RPM_VERSION) suitable as a
> version field in the rpm can, most probably, be improved.  Perhaps
> (with the new git-describe output) we should put closest version tag
> as version of tig in rpm, and distance from the tag (perhaps plus 1)
> as release number (in the rpm sense).
> 
> TODO: Change '--without docs' to '--with rebuild-docs' and use
> pre-generated docs when creating rpm, instead of generating them (and
> requiring asciidoc, xmlto and docbook2pdf to build rpm if we want tig
> documentation).

Yeah, once the "official" tarballs contains the version info, this
sounds like a good idea.

> P.S. I have build tig-0.6.4.g9eded37-1.i386.rpm using "make rpm" from
> tig repository, and installed it without problems, but when trying to
> build it again _without network_ it failed on building
> manual.pdf. Error log attached.

Looks like some problems with the SGML catalogs info.
 
>   asciidoc-7.1.2-2.fc3.rf
>   docbook-dtds-1.0-26
>   docbook-style-dsssl-1.79-1
>   docbook-style-xsl-1.68.1-1
>   docbook-utils-0.6.14-4
>   docbook-utils-pdf-0.6.14-4
>   jadetex-3.12-13
>   openjade-1.3.2-16
> 
> I think we can skip generation of manual.pdf, and generate it only on
> request (e.g. "make doc-pdf"), or using doc-man and doc-html in place
> of doc in the spec file... but this is better left for the next
> commit.

Good idea, PDF is not essential and probably suboptimal to either of the
HTML versions of the manual.

> By the way, why do you use xmlto and docbook2pdf, instead of a2x from
> asciidoc package?

It is a fairly recent addition to the asciidoc. Besides, I just tried it
and it seems to be completely unusable on ubuntu because of the way it
has been packaged; it cannot find required files.

>  .gitignore  |    2 ++
>  Makefile    |   34 ++++++++++++++++++++++++++++++++--
>  tig.spec.in |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+), 2 deletions(-)
>  create mode 100644 tig.spec.in
> 
> diff --git a/.gitignore b/.gitignore
> index 8f6aa93..f7ab840 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,3 +2,5 @@ manual.html-chunked
>  manual.pdf
>  manual.toc
>  tig
> +tig.spec
> +tig-*.tar.gz
> diff --git a/Makefile b/Makefile
> index 06a5d6a..45c833b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -18,8 +18,16 @@ DOCS	= $(DOCS_MAN) $(DOCS_HTML) \
>  ifneq (,$(wildcard .git))
>  VERSION = $(shell git-describe)
>  WTDIRTY = $(shell git-diff-index --name-only HEAD 2>/dev/null)
> -CFLAGS += '-DVERSION="$(VERSION)$(if $(WTDIRTY),-dirty)"'
> +else
> +GEN_VER="tig-0.6.TIG"
> +VERSION = $(shell test -f version && cat version || echo "$(GEN_VER)")
>  endif
> +CFLAGS += '-DVERSION="$(VERSION)$(if $(WTDIRTY),-dirty)"'
> +RPM_VERSION  = $(subst tig-,,$(VERSION))
> +RPM_VERSION := $(subst -,.,$(RPM_VERSION))

I will probably try to simplify and clean this up a bit. 

> +
> +TARNAME=tig-$(RPM_VERSION)
> +
>  
>  all: $(PROGS)
>  all-debug: $(PROGS)
> @@ -57,6 +65,9 @@ install-doc: install-doc-man install-doc-html
>  clean:
>  	rm -rf manual.html-chunked
>  	rm -f $(PROGS) $(DOCS) core *.xml
> +	rm -f *.spec
> +	rm -rf $(TARNAME)
> +	rm -f $(TARNAME).tar.gz
>  
>  spell-check:
>  	aspell --lang=en --check tig.1.txt tigrc.5.txt manual.txt
> @@ -64,7 +75,7 @@ spell-check:
>  strip: all
>  	strip $(PROGS)
>  
> -.PHONY: all all-debug doc doc-man doc-html install install-doc install-doc-man install-doc-html clean spell-check
> +.PHONY: all all-debug doc doc-man doc-html install install-doc install-doc-man install-doc-html clean spell-check dist rpm
>  
>  manual.html: manual.toc
>  manual.toc: manual.txt
> @@ -119,3 +130,22 @@ sync-docs:
>  	make doc
>  	cg commit -m "Sync docs"
>  	cg switch master
> +
> +tig.spec: tig.spec.in
> +	sed -e 's/@@VERSION@@/$(RPM_VERSION)/g' < $< > $@+
> +	mv $@+ $@
> +
> +dist: tig.spec
> +	git-archive --format=tar \
> +		--prefix=$(TARNAME)/ HEAD^{tree} > $(TARNAME).tar
> +	@mkdir -p $(TARNAME)
> +	@cp tig.spec $(TARNAME)
> +	@echo $(VERSION) > $(TARNAME)/version
> +	tar rf $(TARNAME).tar \
> +	       $(TARNAME)/tig.spec \
> +	       $(TARNAME)/version
> +	@rm -rf $(TARNAME)
> +	gzip -f -9 $(TARNAME).tar

Does the .spec file need to be in the tarball for rpm to work? I mean,
if it can be generated from .spec.in, I would rather have the rpm target
create it?

> +rpm: dist
> +	rpmbuild -ta $(TARNAME).tar.gz
> diff --git a/tig.spec.in b/tig.spec.in
> new file mode 100644
> index 0000000..2ce6cdb
> --- /dev/null
> +++ b/tig.spec.in
> @@ -0,0 +1,56 @@
> +# -*- mode: rpm-spec-mode; encoding: utf-8; -*-
> +# Pass '--without docs' to rpmbuild if you don't want the documentation
> +
> +Summary: 	Tig: text-mode interface for git
> +Name: 		tig
> +Version: 	@@VERSION@@
> +Release: 	1%{?dist}
> +License: 	GPL
> +Group: 		Development/Tools
> +Vendor: 	Jonas Fonseca <fonseca@diku.dk>
> +URL: 		http://jonas.nitro.dk/tig/
> +Source: 	http://jonas.nitro.dk/tig/releases/%{name}-%{version}.tar.gz
> +BuildRequires: 	ncurses-devel%{!?_without_docs:, xmlto, asciidoc > 6.0.3, /usr/bin/docbook2pdf}

Is the last entry a shorthand for the doc dependencies you listed above?

> +BuildRoot: 	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
> +Requires: 	git-core, ncurses
> +
> +%description
> +Tig is a git repository browser that additionally can act as a pager
> +for output from various git commands.
> +
> +When browsing repositories, it uses the underlying git commands to
> +present the user with various views, such as summarized revision log
> +and showing the commit with the log message, diffstat, and the diff.
> +
> +Using it as a pager, it will display input from stdin and colorize it.
> +
> +%prep
> +%setup -q
> +
> +%build
> +CFLAGS="$RPM_OPT_FLAGS -DVERSION=tig-%{version}-%{release}"
> +%{__make} %{_smp_mflags} \
> +	prefix=%{_prefix} \
> +	all %{!?_without_docs: doc}
> +
> +%install
> +[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
> +CFLAGS="$RPM_OPT_FLAGS -DVERSION=tig-%{version}-%{release}"
> +%{__make} %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT \
> +	prefix=%{_prefix} bindir=%{_bindir} mandir=%{_mandir} \
> +	install %{!?_without_docs: install-doc-man}
> +
> +%clean
> +[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
> +
> +%files
> +%defattr(-,root,root)
> +%{_bindir}/*
> +%doc README COPYING INSTALL SITES BUGS TODO tigrc

I don't know if manual.txt should perhaps be included if
HTML and PDF files will not be generated.

> +%{!?_without_docs: %{_mandir}/man1/*.1*}
> +%{!?_without_docs: %{_mandir}/man5/*.5*}
> +%{!?_without_docs: %doc *.html *.pdf}
> +
> +%changelog
> +* Mon May 28 2007 Jakub Narebski <jnareb@gmail.com>
> +- Initial tig spec file

-- 
Jonas Fonseca
