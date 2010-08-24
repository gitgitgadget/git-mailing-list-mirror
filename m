From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [feature request] git: tags instead of commit IDs in blame
 output
Date: Tue, 24 Aug 2010 14:54:26 +0200
Message-ID: <20100824145426.38b1fb15@hyperion.delvare>
References: <20100821095352.604a2b85@hyperion.delvare>
	<201008211210.23280.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 24 14:54:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ont1X-0000pn-0r
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 14:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab0HXMyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 08:54:38 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:30747 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab0HXMyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 08:54:37 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1Ont0R-0005lJ-7A
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Tue, 24 Aug 2010 14:53:35 +0200
In-Reply-To: <201008211210.23280.johan@herland.net>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154311>

Hi Johan,

On Sat, 21 Aug 2010 12:10:22 +0200, Johan Herland wrote:
> On Saturday 21 August 2010, Jean Delvare wrote:
> > Hi there,
> > 
> > I have a feature request for git. In the output of "git blame", I would
> > like to be able to see tags instead of commit IDs in front of each
> > line. Basically, I would like to know the first tag which was added
> > after the last change of every line. Icing on the cake would be the
> > possibility to filter out some tags (for example to ignore release
> > candidate tags) but I could easily live without that.
> > 
> > Does it make sense?
> > Would it be difficult to implement?
> 
> To me, it seems what you want to do is convert the commit ID in front of 
> every blame-line into the result of running 'git name-rev' (or 'git 
> describe') on that line.
> 
> To that effect something like this should work:
> 
>   git blame <file> |
>   while read sha1 rest
>   do
>       tag=$(git name-rev --tags --name-only $sha1) &&
>       echo "$tag $rest"
>   done
> 
> Of course, if you're doing this at a bigger scale, you want to wrap this in 
> a script that (1) caches commitID -> tag mappings, and that (2) runs 'git 
> name-rev in its --stdin mode'.

Thanks for the very valuable suggestion. Obviously, the fact that the
above command took over an hour to complete on a 1000-line file as kind
of an issue ;) I did suspect this performance issue originally, which is
why I thought it would be better if git itself would implement the
feature. That being said... git name-rev's --stdin option seems to be
doing all the hard caching work already:

git blame -l <file> | git name-rev --tags --name-only --stdin

does almost what I want, and is reasonably fast (13 seconds for the
same file.) I'll need to do some reformatting work to extract the tag
from the symbolic names (which in turn should almost fix the
alignment), but this is nothing a few lines of shell scripting can't do.

So, thanks a lot again!

-- 
Jean Delvare
