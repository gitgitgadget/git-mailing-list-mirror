From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Fri, 7 Sep 2007 01:55:16 +0200
Message-ID: <20070906235516.GC4538@xp.machine.xx>
References: <20070906075104.GA10192@hand.yhbt.net> <1189096669534-git-send-email-hjemli@gmail.com> <20070906210155.GA20938@soma> <20070906213556.GA21234@soma> <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 02:07:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITRNT-0002I0-1K
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 02:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbXIGAHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbXIGAHJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 20:07:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:32900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932513AbXIGAHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 20:07:07 -0400
Received: (qmail invoked by alias); 06 Sep 2007 23:55:19 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp031) with SMTP; 07 Sep 2007 01:55:19 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19XSS8zsgNXKfgJM9joXRWjpC+0Uu4vt6pz+v++rJ
	0XMoCRGPCnBvYC
Mail-Followup-To: Lars Hjemli <hjemli@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57952>

On Fri, Sep 07, 2007 at 12:14:30AM +0200, Lars Hjemli wrote:
> On 9/6/07, Eric Wong <normalperson@yhbt.net> wrote:
> > Wait, actually.  --upstream won't ever populate the refs array in
> > working_head_info for dcommit
> 
> Sorry, I didn't realize that working_head_info() collected commit-ids
> later used by dcommit.  But to implement --upstream we could maybe do
> something like this:
> 
> sub working_head_info {
>   my ($head, $refs) = @_;
> 
>   if (defined $_upstream) {
>     working_head_info_traverse($head, \$refs);
>     return working_head_info_traverse($_upstream, undef);
>   }
> 
>   return working_head_info_traverse($head, \$refs);
> }
> 
> sub working_head_info_traverse {
>   my ($head, $refs) = @_;
>   my ($fh, $ctx) = command_output_pipe('log', '--no-color',
> '--first-parent', $head);
>   ...
> 
> 
> (This was written straight into firefox, late at night, by a perl
> illiterate. Please be gentle...)
> 

Sorry, but isn't --upstream just the wrong way to do what you want?
Why should I specify a GIT commit to leat git-svn figure out on what
upstream SVN branch I want to commit? To me, this seems a little
backwards. Wouldn't it be much more pleasant to say something like

	git-svn dcommit --on the_branch

whereas 'the_branch' is the name of the upstream branch as specified
in the fetch/branch section in the git config? If I do a dcommit I know
*exactly* on which svn branch it should go, so why can't I specify it on
the cmdline? ...  or did I miss something obvious?

-Peter
