From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn segmetation fault
Date: Sat, 2 Feb 2008 21:42:25 -0500
Message-ID: <20080203024225.GA23647@dervierte>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com> <20080202034258.GA27814@dervierte> <47A3E9A8.1060102@saville.com> <20080202160332.GA25945@dervierte> <47A4BCE8.5030308@saville.com> <20080202210348.GA11722@dervierte> <47A51737.7050905@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 03:43:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLUov-000072-V0
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 03:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbYBCCma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 21:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbYBCCma
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 21:42:30 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:5025 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075AbYBCCm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 21:42:29 -0500
Received: by an-out-0708.google.com with SMTP id d31so405031and.103
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 18:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=/bJad2S5rVzRPfMjDy/KM9dJ2BjVdqv62BICKYYTgMs=;
        b=af24sfajrb8k73QZ7YF8AMv0QG1ueDrOmxQ7oNCR8q5ZAUMWGhRPh/fK8Al3OnaMPRbl8jGvtl3t0XoN608Ybewvst9Qm8S2HomXbPnriwxdQTlFizGRKbVAcQwbT6kP2FUCJSeiRNuupcTbZKk8rLfrZWMwzN1uSwPbniCRBOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZOvq8iOl0wSx+3QlgWgR/iZFXVENLJ78qVmrn+5T5KZz+GHNAatmv+RBgaGMfPBNCfu22ZhFq24MiXiLkPxJ4xS31wGc6AJR9vU0woHyzSED/D/mLki0WqblUEHTMSxPBlZ4Hk0ah9hHMU62k8Y/g8iK+v+GmU22e0TTDPFjlbk=
Received: by 10.101.71.16 with SMTP id y16mr11422544ank.50.1202006548311;
        Sat, 02 Feb 2008 18:42:28 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 34sm9615439wra.23.2008.02.02.18.42.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 18:42:27 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id C1A713640F; Sat,  2 Feb 2008 21:42:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47A51737.7050905@saville.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72319>

On Sat, Feb 02, 2008 at 05:21:59PM -0800, Wink Saville wrote:
> What steps would be needed to recreate a "local git repo" from the
> "git repo on srvr" that I could use against the svn repo?
>
> I tried a little test, I cloned my git repo on srvr locally to amc-xx
> and added the [svn-remote "svn"] section to amc-xx/.git/config
> and then did a git-svn fetch. From what happened it looks like I
> just did a git svn clone and didn't save any time.

After adding the svn-remote section, you'll want to copy
.git/refs/remotes/origin/master to .git/refs/remotes/git-svn.  After
doing that, "git svn fetch" should see that you have all the needed
commits and do a quick rebuild of its metadata.

> Also, a follow up can I create an svn repo from a git repo.

I've not done it, but it should be possible.  You would create the new
svn repository with a single empty commit (as empty as SVN would allow).
Import that revision into your git repository with git-svn.  Then you
would either rebase or use grafts to make all of your git commits a
descendent of that single svn commit.  In that way, the next time you
run "git svn dcommit" it will see all your local git commits as new
commits to send to subversion.

No guarantees though, as I've not tried it.
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
