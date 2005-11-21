From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 21 Nov 2005 17:25:21 +0100
Message-ID: <200511211725.21642.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de> <200511211644.16789.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0511211653420.2569@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 21 17:36:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeEZ9-00055U-T9
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 17:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVKUQas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 11:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKUQas
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 11:30:48 -0500
Received: from mail.gmx.de ([213.165.64.20]:59013 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932387AbVKUQas (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 11:30:48 -0500
Received: (qmail invoked by alias); 21 Nov 2005 16:30:46 -0000
Received: from fauia100.informatik.uni-erlangen.de (EHLO fauia100.informatik.uni-erlangen.de) [131.188.67.100]
  by mail.gmx.net (mp035) with SMTP; 21 Nov 2005 17:30:46 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.63.0511211653420.2569@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12455>

On Monday 21 November 2005 16:57, Johannes Schindelin wrote:
> > The part about .git/branches has to be sent to Pasky, not Junio. 
> 
> I was aware that .git/branches was introduced by Pasky, but as it is 
> handled in git-parse-remote.sh, I thought that it may be a bit more 
> general than just cogito.

AFAIK, Cogito introduced it, and Git used it in the wrong way. All files
in .git/branches map 1:1 to a local head (perhaps not really existing).
Git misused this information by using a head name as shortcut for a
remote repository - which still leads to quite some confusion:
In repositories cloned by Cogito you now have a "origin" head, and
automatically have a repository shortcut "origin", too. The same name is
used for different kinds of objects - IMHO quite bad.

The best thing is to simply remove .git/branches parsing in git at all.
 
> Anyways, I sent this out as an *RFC*, but the "C" obviously stands for 
> "Comments"...

I think that putting .git/remotes info into .git/config is nice.
And I also think that putting .git/branches info into .git/config is a nice
thing.
If .git/branches/origin contains "http://www.kernel.org/pub/scm/git/git.git#todo",
this should map to

[head.origin]
  fetchurl = http://www.kernel.org/pub/scm/git/git.git
  fetchhead = todo

The problem here is that heads can have spaces, "." and "/" in their name.

> What do people say? Is it useless to move that information into the 
> config, where it can be queried/replaced/set/removed by the config "API", 
> or should we continue with two incompatible ad-hoc formats? (If that 
> sounds biased, it was not meant to be.)

Cogito does not have per-repository configuration (e.g. like this "shortcut"
thing), but only about per-head configuration. In this way, the information
in .git/branches is quite different from the one in .git/remotes.

Josef

> 
> Ciao,
> Dscho
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
