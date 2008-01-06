From: Sean <seanlkml@sympatico.ca>
Subject: Re: how to use git merge -s subtree?
Date: Sat, 5 Jan 2008 20:17:40 -0500
Message-ID: <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
References: <20080105230004.GY29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 02:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBK9c-0005iO-TE
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 02:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYAFBRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 20:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYAFBRr
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 20:17:47 -0500
Received: from bay0-omc2-s12.bay0.hotmail.com ([65.54.246.148]:47807 "EHLO
	bay0-omc2-s12.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752590AbYAFBRq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2008 20:17:46 -0500
Received: from BAYC1-PASMTP12 ([65.54.191.185]) by bay0-omc2-s12.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 5 Jan 2008 17:17:42 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP12.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 5 Jan 2008 17:17:42 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JBK8r-0006GH-Je; Sat, 05 Jan 2008 20:17:33 -0500
In-Reply-To: <20080105230004.GY29972@genesis.frugalware.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 06 Jan 2008 01:17:42.0532 (UTC) FILETIME=[EF9D6C40:01C85001]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69696>

On Sun, 6 Jan 2008 00:00:04 +0100
Miklos Vajna <vmiklos@frugalware.org> wrote:

> i recently noticed that the subtree merge strategy is missing from
> merge-strategies.txt an i tried to first figure out how it works. i got
> it to work, but i'm not 100% sure about i'm using it the way i'm
> supposed to.
> 
> here is what i do:
> 
> 1) git remote add B /path/to/B.git
> 2) git fetch
> 3) mkdir B
> 4) touch B/.gitignore
> 5) git add B/.gitignore
> 6) git commit -m "add empty B directory"
> 7) git merge -s subtree B/master
> 
> and yes, it works pretty well, but is this the right way? or is it
> possible to somehow avoid steps 3..6?
> 

Hi Miklos,

Here's another way that is perhaps a little cleaner:

$ git remote add -f B /path/to/B
$ git merge -s ours --no-commit B/master
$ git read-tree --prefix=sub/ -u B/master 
$ git commit -m "subtree merged B"

The first line creates and fetches the remote.  The second line initiates a merge, but
stops before committing it.  The third line reads B/master into the subdirectory "sub",
at which point all that remains is committing the completed merge.

HTH,
Sean
 
