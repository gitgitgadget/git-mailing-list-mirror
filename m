From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Show html help with git-help --html
Date: Mon, 4 Jun 2007 09:29:22 -0400
Message-ID: <fcaeb9bf0706040629k489d4818sa291725cbbeead79@mail.gmail.com>
References: <20070602015341.GA26520@localhost.myhome.westell.com>
	 <7vps4cjg1w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 15:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvCcm-0007Na-65
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 15:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbXFDN3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 09:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbXFDN3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 09:29:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:33752 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbXFDN3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 09:29:24 -0400
Received: by wr-out-0506.google.com with SMTP id i21so730916wra
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 06:29:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sskIYcx7GwOwahpzh2U0RqcpY6uICAcysS4loSn0TzmrpiJpk0ENMnuEAHFWD5o2dEe3nI+Rupse8H9XNAz8simHc5VahKYfc11XLYGSLrXGzYYP8UiaSw8IhPjo1dQdO/c11696vBYAGw5bGVqqSjPDvTPxV5dhSC8EFSjvZ1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BeqytvxxV6Ndi27AUHAkeKXOVSdAslilcNapt1q2Iwj15rwzrC3qaLP1KVhaDA6OvS8D8iAdgqjCcSP7NHNATGUJRw1o+yJ61Gp3GcU2/YFbBoMASscRtzfYPphkwxET6RMNUqjqKuOFxVu+lbnj8NiZaja8vkeLDL0P5qn01yI=
Received: by 10.100.165.9 with SMTP id n9mr2572904ane.1180963762279;
        Mon, 04 Jun 2007 06:29:22 -0700 (PDT)
Received: by 10.100.127.18 with HTTP; Mon, 4 Jun 2007 06:29:22 -0700 (PDT)
In-Reply-To: <7vps4cjg1w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49100>

On 6/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 3d8f03d..2ec8545 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -261,6 +261,18 @@ core.excludeFile::
> > ...
> > +core.htmlprogram::
> > +     Specify the program used to open html help files when 'git-help'
> > +     is called with option --html or core.help is other than 'man'.
> > +     By default, xdg-open will be used.
>
> Is the program's calling convention something that needs to be
> customizable for this to be useful?

At first I thought xdg-open would be flexible enough for most Linux
systems because it will choose the best browser you have. But I now
recall that Git does not only run on Linux.  Will make it a parameter
in config.mak.in

>
> > diff --git a/Makefile b/Makefile
> > index cac0a4a..43e0d15 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -145,6 +145,7 @@ prefix = $(HOME)
> >  bindir = $(prefix)/bin
> >  gitexecdir = $(bindir)
> >  sharedir = $(prefix)/share/
> > +htmldir = $(sharedir)/html/
> >  template_dir = $(sharedir)/git-core/templates/
> >  ifeq ($(prefix),/usr)
> >  sysconfdir = /etc
>
> Is it customary to have HTMLized documentation material for
> different packages all together in a single .../share/html/
> directory, like manpages are placed in share/man/man1/
> directory?  I somehow had an impression that a layout to have
> html directory per package (i.e. share/doc/$pkg/html/) was more
> common.  I dunno.

The default value is not really useful. I would leave that for
distribution package mantainers to decide proper location because they
have to install html files separately anyway (at least in Gentoo).
However it's not convenient for compiling-from-source users. Will redo
the patch and add rules to install html files also.

>
> > diff --git a/help.c b/help.c
> > index 6a9af4d..e3e705b 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -183,6 +187,36 @@ static void show_man_page(const char *git_cmd)
> >       execlp("man", "man", page, NULL);
> >  }
> >
> > +static void show_html_page(const char *git_cmd)
> > +{
> > +     const char *html_dir;
> > +     int i,len,ret;
> > +     char *p;
> > +
> > +     html_dir = HTML_DIR;
> > +     if (!html_help_program)
> > +             html_help_program = "xdg-open";
> > +
> > +     /* html_help_program space html_dir git- git_cmd .html */
> > +     len = strlen(html_help_program) + 1 + strlen(html_dir) + 4 + strlen(git_cmd) + 5;
> > +     p = xmalloc(len + 1);
> > +
> > +     strcpy(p, html_help_program);
> > +     strcat(p," ");
> > +     strcat(p,html_dir);
> > +     if (prefixcmp(git_cmd, "git"))
> > +             strcat(p,"git-");
> > +     strcat(p,git_cmd);
> > +     strcat(p,".html");
> > +
> > +     ret = system(p);
>
> This is sloppy in the presense of potentially unsafe characters...

I personally think users will not shoot themselves with "git help
--html ';rm -rf'" but again scripts can. Thank you for pointing out.
Will add check for file existence before calling system().
-- 
Duy
