From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Fix relative built-in paths to be relative to the command invocation
Date: Mon, 14 Jul 2008 20:54:34 +0200
Message-ID: <200807142054.35027.johannes.sixt@telecom.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org> <1216018557.487af87d7bd28@webmail.eunet.at> <alpine.DEB.1.00.0807141319420.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 20:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITDA-0004Gz-HX
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 20:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbYGNSyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 14:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYGNSyt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 14:54:49 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:57934 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbYGNSys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 14:54:48 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 44DB297F4A;
	Mon, 14 Jul 2008 20:54:36 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2513C16FC9;
	Mon, 14 Jul 2008 20:54:35 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807141319420.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88447>

On Montag, 14. Juli 2008, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 14 Jul 2008, Johannes Sixt wrote:
> > Zitat von Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > > On Sun, 13 Jul 2008, Johannes Sixt wrote:
> > > > @@ -84,7 +90,7 @@ static void add_path(struct strbuf *out, const char
> > > > *path)
> > > >  	}
> > > >  }
> > > >
> > > > -void setup_path(const char *cmd_path)
> > > > +void setup_path(void)
> > >
> > > It seems to me that this patch would not do anything different, but
> > > with less code change, if setup_path() would set argv0_path, and not a
> > > new function was introduced.
> >
> > This is just to play a safe game. I had it that way, but I decided to
> > have the call to the new git_set_argv0_path() early in git.c because the
> > call to setup_path() in git.c is very late, and it could happen that we
> > call system_path() (which needs argv0_path) before that. Although I
> > didn't audit the code whether this really happens.
>
> Well, okay... I would have rather seen it not change (since there was no
> bug to fix), or as a separate patch, but it's Junio's call.

I investigated this, and, yes, there indeed are calls to system_path() before 
setup_path(), for example:

 commit_pager_choice
   setup_pager
     git_config
       git_etc_gitconfig
         system_path(ETC_GITCONFIG)

Junio, do you want git_set_argv0_path() in a separate patch?

-- Hannes
