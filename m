From: "Thomas Riboulet" <riboulet@gmail.com>
Subject: Re: [PATCH] Convert the git faq to asciidoc
Date: Mon, 20 Feb 2006 12:14:38 +0100
Message-ID: <22e91bb0602200314g6a84c868i1d2616fdb1a398da@mail.gmail.com>
References: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
	 <20060220014539.GA8759@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 12:15:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB906-0003ES-Vq
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 12:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWBTLOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 06:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWBTLOj
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 06:14:39 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:32132 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932285AbWBTLOj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 06:14:39 -0500
Received: by zproxy.gmail.com with SMTP id 8so857006nzo
        for <git@vger.kernel.org>; Mon, 20 Feb 2006 03:14:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VuCjh7F5XXBKEwZ5QwuZ34CY2j5lx1DxtZELSp+ipvpzfE6yLSUZ35i/u1gMrybwlQ7i380y/8SIs5KlTe+vVB0JtB+K3lyEJT7qZolZKChsA9rRg62Hy4yYYMgIOzLW7RmiW0gXQs+K99V+KD7XuqPLR/LsEcoQG8JUzkHEceE=
Received: by 10.36.22.11 with SMTP id 11mr2800259nzv;
        Mon, 20 Feb 2006 03:14:38 -0800 (PST)
Received: by 10.36.159.4 with HTTP; Mon, 20 Feb 2006 03:14:38 -0800 (PST)
To: "Jonas Fonseca" <fonseca@diku.dk>
In-Reply-To: <20060220014539.GA8759@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16479>

On 2/20/06, Jonas Fonseca <fonseca@diku.dk> wrote:
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>
> ---
>
> Thomas Riboulet <riboulet@gmail.com> wrote Thu, Feb 16, 2006:
> > Comments and suggestions are welcome (on the content, the form, format, etc ...)
> > I'll try to add questions from the archives of this ml, I'm also open
> > to any suggestions.
>
> As promissed on the #git channel this patch converts the faq to asciidoc
> format, with a few enhancements such as links to manpages and a TOC.
>
> Previews at
> http://www.diku.dk/hjemmesider/studerende/fonseca/git/git-faq.{html,txt,xml}.
>
> ---
>
>  Makefile |   23 ++++++++
>  faq.conf |   19 +++++++
>  faq.txt  |  175 ++++++++++++++++++++++++++++++++++++++++++--------------------
>  3 files changed, 161 insertions(+), 56 deletions(-)
>
> diff --git a/Makefile b/Makefile
> new file mode 100644
> index 0000000..09f6978
> --- /dev/null
> +++ b/Makefile
> @@ -0,0 +1,23 @@
> +all: git-faq.html git-faq.xml git-faq.txt
> +
> +clean:
> +       rm -f git-faq.html git-faq.xml git-faq.txt faq-toc.txt
> +
> +git-faq.html git-faq.xml git-faq.txt: faq.txt faq-toc.txt
> +
> +git-faq.xml:
> +       asciidoc -f faq.conf -b docbook -d article -o $@ faq.txt
> +
> +git-faq.html: faq.txt faq-toc.txt
> +       asciidoc -f faq.conf -b xhtml11 -d article -o $@ faq.txt
> +
> +git-faq.txt: git-faq.html
> +       elinks --no-numbering --no-references --dump $< > $@
> +
> +faq-toc.txt: faq.txt
> +       sed -n '/^\[\[/,/--/p' < $< | while read line; do \
> +               case "$$line" in \
> +               "[["*"]]") echo -n ". <<$$line, " | sed 's/\[\[\(.*\)\]\]/\1/' ;; \
> +               --*)       echo    ">>" ;; \
> +               *)         echo -n "$$line " ;; \
> +               esac; done > $@
> diff --git a/faq.conf b/faq.conf
> new file mode 100644
> index 0000000..fa16ad6
> --- /dev/null
> +++ b/faq.conf
> @@ -0,0 +1,19 @@
> +# AsciiDoc FAQ definitions
> +
> +[attributes]
> +gitdoc-base=http://kernel.org/pub/software/scm/git/docs/
> +cgdoc-base=http://kernel.org/pub/software/scm/cogito/docs/
> +
> +ifdef::backend-docbook[]
> +[gitdoc-inlinemacro]
> +<ulink url="{gitdoc-base}{target}.html">{0}</ulink>
> +[cgdoc-inlinemacro]
> +<ulink url="{cgdoc-base}{target}.html">{0}</ulink>
> +endif::backend-docbook[]
> +
> +ifdef::backend-xhtml11[]
> +[gitdoc-inlinemacro]
> +<a href="{gitdoc-base}{target}.html">{0}</a>
> +[cgdoc-inlinemacro]
> +<a href="{cgdoc-base}{target}.html">{0}</a>
> +endif::backend-xhtml11[]
> diff --git a/faq.txt b/faq.txt
> index e719d04..9c7baa0 100644
> --- a/faq.txt
> +++ b/faq.txt
> @@ -1,68 +1,131 @@
> -Why the 'git' name ?
> -
> -As Linus' own words as the inventor of git : "git" can mean anything, depending on your mood.
> -
> -* random three-letter combination that is pronounceable, and not actually used by any common UNIX command. The fact that it is a mispronunciation of "get" may or may not be relevant.
> -*  stupid. contemptible and despicable. simple. Take your pick from the dictionary of slang.
> -* global information tracker": you're in a good mood, and it actually works for you. Angels sing, and a light suddenly fills the room.
> -* "goddamn idiotic truckload of sh*t": when it breaks
> -
> -
> -Can I share a git public repository and use it in a CVS way ?
> -
> -Use cg-admin-setuprepo -g or do git-init-db --shared and some additional stuff. It's ok that refs aren't group writable, it's enough the directory is. See Cogito README or GIT's cvs-migration doc, "Emulating the CVS Development Model" for details.
> -
> -
> -Git commit is dying telling me "fatal : empty ident <user@myhost> not allowed" , what's wrong ?
> -
> -Make sure your Full Name is not empty in chsh or the 5th field of your user line in /etc/passwd isn't empty. You can also set the GIT_AUTHOR_NAME environment variable. If you @myhost is empty make sure your hostname is correctly set.
> -What's the difference between fetch and pull ?
> -
> -Fetch : download objects and a head from another repository.
> -Pull : fetch (as defined above) and merge with the current development.
> -See man git-fetch and git-pull or the tutorials for more details.
> -
> -
> -
> -Can I tell git to ignore files ?
> -
> -Yes. If you want to ignore files localy (only for you in your local work copy) put the files path in the repository in the .git/info/exclude file.
> -
> -If you want to make the ignore matters for all and everyone who checkouts the project you have to put the files path in the .gitignore in the tree itself.
> -
> -
> -Can I import from cvs ?
> -
> -Yes. Use git-cvsimport. See the cvs-migration doc for more details.
> -
> -
> -Can I import from svn ?
> -
> -Yes. Use git-svnimport. See the svn-import doc for more details.
> +The git FAQ
> +===========
> +:Author:       Thomas Riboulet
> +:CorpAuthor:   git mailing list
> +
> +//////////////////////////////////////////////////////////////////////////////
> +A note about required info for FAQ entries. Please use the following template:
> +
> +       [[question-id]]
> +       question?
> +       ---------
> +       answer.
> +
> +The question-id + question will be used for generating a table of contents.
> +//////////////////////////////////////////////////////////////////////////////
> +
> +// DocBook derived output will (hopefully) have it's own TOC
> +ifdef::backend-xhtml11[]
> +include::faq-toc.txt[]
> +endif::backend-xhtml11[]
> +
> +[[git-name]]
> +Why the 'git' name?
> +-------------------
> +In Linus' own words as the inventor of git: "git" can mean anything, depending
> +on your mood:
> +
> + - random three-letter combination that is pronounceable, and not actually
> +   used by any common UNIX command. The fact that it is a mispronunciation of
> +   "get" may or may not be relevant.
> + - stupid. contemptible and despicable. simple. Take your pick from the
> +   dictionary of slang.
> + - global information tracker": you're in a good mood, and it actually works
> +   for you. Angels sing, and a light suddenly fills the room.
> + - "goddamn idiotic truckload of sh*t": when it breaks
> +
> +
> +[[repo-sharing]]]
> +Can I share a git public repository and use it in a CVS way?
> +------------------------------------------------------------
> +Use cg-admin-setuprepo -g or do git-init-db --shared and some additional
> +stuff. It's ok that refs aren't group writable, it's enough the directory is.
> +See Cogito README or GIT's cvs-migration doc, "Emulating the CVS Development
> +Model" for details.
> +
> +
> +[[empty-ident]]
> +Git commit is dying telling me "fatal: empty ident <user@myhost> not allowed", what's wrong?
> +--------------------------------------------------------------------------------------------
> +Make sure your Full Name is not empty in chsh or the 5th field of your user
> +line in `/etc/passwd` isn't empty. You can also set the `GIT_AUTHOR_NAME`
> +environment variable. If your @myhost is empty make sure your hostname is
> +correctly set. Use gitdoc:git-var[`git-var -l`] to make git display user
> +identity variables.
> +
> +
> +[[fetch-vs-pull]]
> +What's the difference between fetch and pull?
> +---------------------------------------------
> +The short definition is:
> +
> +Fetch::        Download objects and a head from another repository.
> +Pull:: Fetch (as defined above) and merge with the current development.
> +
> +See the gitdoc:git-fetch[git-fetch(1)] and gitdoc:git-pull[git-pull(1)]
> +manpages or the tutorials for more details.
> +
> +
> +[[gitignore]]
> +Can I tell git to ignore files?
> +-------------------------------
> +Yes. If you want to ignore files localy (only for you in your local work copy)
> +put the files path in the repository in the `.git/info/exclude` file.
> +
> +If you want to make the ignore matters for all and everyone who checkouts the
> +project you have to put the files path in the `.gitignore` in the tree itself.
> +
> +
> +[[import-cvs]]
> +Can I import from CVS?
> +----------------------
> +Yes. Use git-cvsimport. See the gitdoc:git-cvsimport[git-cvsimport(1)] or
> +gitdoc:cvs-migration[the CVS migration doc] for more detail.
> +
> +
> +[[import-svn]]
> +Can I import from svn?
> +----------------------
> +Yes. Use git-svnimport. See gitdoc:git-svnimport[git-svnimport(1)] for more
> +details.
>
>
> +[[import-arch]]
>  Can I import from arch/baz/tla?
> -
> -Yes. Use git-archimport.
> +-------------------------------
> +Yes. Use git-svnimport. See gitdoc:git-archimport[git-archimport(1)] for more
> +details.
>
>
> +[[import-others]]
>  Can I import from others?
> +-------------------------
> +Maybe -- check if http://www.darcs.net/DarcsWiki/Tailor[tailor.py] can do it.
>
> -Maybe -- check if tailor.py can do it. Check http://www.darcs.net/DarcsWiki/Tailor.
> -
> -
> -How old linus bk repos have been import to git ?
>
> +[[linux-bk]]
> +How was the old Linux BitKeeper repository imported into git?
> +-------------------------------------------------------------
>  Using the CVS gateway, via git-cvsimport.
>
>
> -What can I use to setup a public repository ?
> -
> -A ssh server, an http server, or the git-daemon. See the tutorial for more details.
> -
> -
> -Why won't git let me change to a different branch using "git checkout <branch>" or "git checkout -b <branch>"?
> -
> -Instead it just says: fatal: Entry 'foo.c' not uptodate. Cannot merge.
> +[[public-repo]]
> +What can I use to setup a public repository?
> +--------------------------------------------
> +A SSH server, an HTTP server, or the gitdoc:git-daemon[git-daemon]. See the
> +tutorial for more details.
> +
> +
> +[[change-branch]]
> +Why won't git let me change to a different branch?
> +--------------------------------------------------
> +Using "git checkout <branch>" or "git checkout -b <branch>" it just says:
> +
> +       fatal: Entry 'foo.c' not uptodate. Cannot merge.
> +
> +You have changes to files in your working directory that will be overwritten,
> +removed or otherwise lost if the checkout and change to the new branch were to
> +proceed. To fix this you may either check your changes in, create a patch of
> +your changes and revert your files, or use the "-m" flag like this:
>
> -You have changes to files in your working directory that will be overwritten, removed or otherwise lost if the checkout and change to the new branch were to proceed. To fix this you may either check your changes in, create a patch of your changes and revert your files, or use the "-m" flag like this: git checkout -m -b my-branch
> +       git checkout -m -b my-branch
>
> --
> Jonas Fonseca
>

hi,

ok seems much easier than docbook to write, I've commited your
changes, I'll push them when I'll be back home.

I've tested the docbook file generated, works fine

thanks

--
Thom/ange
http://ange.librium.org
