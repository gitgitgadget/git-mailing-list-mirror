From: Yann Dirson <ydirson@altern.org>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 01:23:51 +0200
Message-ID: <20070803232351.GC30277@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1186163410.26110.55.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH6Vz-00017a-Di
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 01:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbXHCXY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 19:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbXHCXY7
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 19:24:59 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:42097 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbXHCXY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 19:24:58 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CB06A73AA;
	Sat,  4 Aug 2007 01:24:56 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A3B005DF0;
	Sat,  4 Aug 2007 01:24:56 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id B9BF01F070; Sat,  4 Aug 2007 01:23:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1186163410.26110.55.camel@dv>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54768>

On Fri, Aug 03, 2007 at 01:50:10PM -0400, Pavel Roskin wrote:
> One is to have a command opposite to "export".  It would read the files
> that "export" produces, replacing the existing patches.

This should be already possible (although I never used it), with "stg
pop -a && stg import --replace ..."

> Another approach would be to reexamine the patch after "stg refresh -es"
> and to apply it instead of the original patch.  If the patch doesn't
> apply, the options would be to discard the edits or to re-launch the
> editor.

Added to wishes: https://gna.org/bugs/index.php?9674


> Next issue is that it should be possible to create a patch in one
> operation.  StGIT follows quilt too closely here in requiring "new" and
> "refresh", instead of utilizing the advantage of the workflow that
> allows immediate editing of the sources without any commands.
> 
> Basically, I want one command that:
> 
> 1) shows user what was changed
> 2) allows user to name the patch
> 3) allows user to describe the patch
> 4) allows user to exclude files from the patch
> 5) doesn't require another command to put the changes to the patch
> 
> I think the most natural approach would be to enhance "stg new".

Sure, something like this could be done.  A syntax like the following
would IMHO fit in how things are done, but does not exactly address 4:

$ stg new <name> -m <msg> -s [--] <files> <to> <add>

Maybe another --exclude flag to reverse the meaning of the listed
files would be a solution, but I'm not thrilled by this idea...


>  I see
> "stg new -s" is supposed to show the changes, but it's currently broken.
> This is run in a clean StGIT repository with no patches:
> 
> $ stg new -s foo

Hm, I'm not sure what -s would be supposed to show here, since we're
asking for the creation of a patch, which currently always starts
empty.

Especially confusing is that if there are already applied patches, the
diff shown is the one of the previous top patch - and if there is no
applied patches, we get the exception you noticed.

I guess -s should be removed for 0.13.1.


> Another backtrace in "stg new", also run in a clean StGIT repository with no patches:

This appears to occur when there is no description file, or when it is
empty.  Thanks for the report.

I also tried with "stg refresh -m ''" to see if it caused the same
problem, but it appears to have another problem instead: it does not
refresh the patch description at all.

My guess is that we should not allow empty patch description (and
maybe fill it with provided patchname).  What did you want to acheieve
precisely with that command ?


> Finally, it would be great to have TLS support in the mail command.
> Mercurial has it, and looking at their mail.py, it doesn't seem to be
> much work.

Added to wishes: https://gna.org/bugs/index.php?9673

Thanks,
-- 
Yann
