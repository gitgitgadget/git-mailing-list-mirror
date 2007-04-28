From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn failure when symlink added in svn
Date: Sat, 28 Apr 2007 09:54:55 -0700
Message-ID: <m2tzv0fnhc.fsf@ziti.fhcrc.org>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle>
	<m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Alexander Klink <ak-git@cynops.de>
X-From: git-owner@vger.kernel.org Sat Apr 28 18:55:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhqCc-00061t-0J
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 18:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031562AbXD1QzO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 12:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031564AbXD1QzN
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 12:55:13 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:16792 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031562AbXD1QzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 12:55:05 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1500229nzf
        for <git@vger.kernel.org>; Sat, 28 Apr 2007 09:55:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:in-reply-to:user-agent:date:message-id:mime-version:content-type;
        b=B1n3pabdlLdRXeaTulpbNvK6ZZ0jtdO1PwALYpRmR0Y9rkmfhF4xQarS/Wdv8jApXRmSE0XFt/LO7tI7/AuuKuO42MS6l4LMRGZdunFBIqgvi4+Y8chBMssPOIMi6kpH0f69b2jMcHUyz0bLobL5OVTcDc2PhsUo2WSbmJSd5HU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:in-reply-to:user-agent:date:message-id:mime-version:content-type;
        b=WDwnymDt6jbGGzAp3b7ARtqSXS9pRbRFVb5sB72edV81Z/JHVUAJwjbXgnygHCReVMLxs3OPMaJ+Ona7Y4VfrR2voWfUGPNXGuuY5JNNfVkvTQnDKwpx/9Xqshcszl3l0678WksyI0lWVBXJLnzB0XqY2K+wsbwc+CEIgY4xjNQ=
Received: by 10.115.108.1 with SMTP id k1mr1419538wam.1177779304967;
        Sat, 28 Apr 2007 09:55:04 -0700 (PDT)
Received: from ziti.fhcrc.org ( [24.19.44.95])
        by mx.google.com with ESMTP id z15sm2139157pod.2007.04.28.09.55.03;
        Sat, 28 Apr 2007 09:55:04 -0700 (PDT)
In-Reply-To: <loom.20070428T144858-521@post.gmane.org> (Alexander Klink's message of "Sat, 28 Apr 2007 13:02:01 +0000 (UTC)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45781>

Hi Alex,

Alexander Klink <ak-git@cynops.de> writes:
> The SHA1 hashes are generated in the close_file() function in
> git-svn.perl by forking git-hash-object -w --stdin and redirecting
> STDIN to the passed filehandle. This is what goes wrong (for some
> perl-internal reason?) on Mac OS X. Here is a patch that works
> around that by putting the data to be hashed in a temporary file
> and calling git-hash-object with a filename.

I tested your patch and it works for me as well.  Eric's test case now
passes and I was able to create a fresh clone of the problem svn
repository that contains the removal + symlink revisions [*1*].  I'm
not an OS X or Perl expert so it isn't obvious to me why the pipe
approach isn't working.

Thanks much,

+ seth

[*1*] I can't seem to fix the git repository where this problem first
appeared for me.  I tried creating a branch starting before the
removal and symlink creation and then running git-svn rebase, but that
didn't work -- maybe because git-svn already stored the commits in
garbled form.  Hence re-cloning was required.

Also: when I cloned the repository, I got a bus error when running git
svn fetch.  Rerunning git svn fetch completed.  Perhaps this is
related to the other bug report that is in progress?  Sorry that I
don't have more details...
