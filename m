From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 00:05:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040002360.9822@pacific.mpi-cbg.de>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>  <alpine.DEB.1.00.0902032350130.9822@pacific.mpi-cbg.de> <94a0d4530902031456u1e1753e2rc34786ebdce6e774@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 00:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUULu-0000vB-9T
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbZBCXFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbZBCXFU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:05:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:48581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751880AbZBCXFU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:05:20 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:05:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 04 Feb 2009 00:05:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BsYhrMJ9BCc7r5xtKuTvQN1m0XfsPESV/cZckEb
	N7O0H6GT734LTw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530902031456u1e1753e2rc34786ebdce6e774@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108262>

Hi,

On Wed, 4 Feb 2009, Felipe Contreras wrote:

> On Wed, Feb 4, 2009 at 12:53 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 4 Feb 2009, Felipe Contreras wrote:
> >
> >>  static const char git_config_set_usage[] =
> >> -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
> >> +"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
> >
> > This line is getting way too long...  (Not nit-picking your current patch,
> > but maybe you could provide another patch to break the line, while you're
> > at builtin-config.c already.  Maybe even parseopt'ifying it... ;-)
> 
> Yeah, I'll send another patch to clean that string. Is there any
> example of that parseopt thing?

Yep... test-parse-options.c ;-)

> >> @@ -362,6 +362,15 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >>                       return get_color(argc-2, argv+2);
> >>               } else if (!strcmp(argv[1], "--get-colorbool")) {
> >>                       return get_colorbool(argc-2, argv+2);
> >> +             } else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
> >> +                     char *config_filename;
> >> +                     if (config_exclusive_filename)
> >> +                             config_filename = xstrdup(config_exclusive_filename);
> >> +                     else
> >> +                             config_filename = git_pathdup("config");
> >> +                     launch_editor(config_filename, NULL, NULL);
> >> +                     free(config_filename);
> >> +                     return 0;
> >
> > Does launch_editor() not take a 'const char *' on purpose?  IOW you do not
> > need to xstrdup() the filename.  You do not even need git_pathdup(), as
> > launch_editor() does not use git_path() itself.
> 
> So, s/git_pathdup/git_path/ ?

And s/xstrdup(\(.*\))/\1/.

> > However, a test case would be nice...
> 
> What would the the test case check?

That 'GIT_CONFIG=bla GIT_EDITOR=echo git config -e' and 'GIT_DIR=blub 
GIT_EDITOR=echo git config -e' do the right thing.  Maybe even --global, 
but that would also be a good test that "git config --global -e" does not 
fail when there is no original file.

Ciao,
Dscho
