From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: P4 Sync problem
Date: Wed, 11 Nov 2009 12:39:09 +0000 (UTC)
Message-ID: <loom.20091111T131837-901@post.gmane.org>
References: <loom.20091110T145046-137@post.gmane.org>  <1a6be5fa0911110043i63b5c032s7924f9f1cdfe32ee@mail.gmail.com>  <loom.20091111T100646-406@post.gmane.org> <1a6be5fa0911110400l1fe931afmbb53ceba8704e029@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 13:39:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8CU4-000091-2J
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 13:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbZKKMjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 07:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbZKKMjY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 07:39:24 -0500
Received: from lo.gmane.org ([80.91.229.12]:54346 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbZKKMjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 07:39:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N8CTv-00005D-Sa
	for git@vger.kernel.org; Wed, 11 Nov 2009 13:39:27 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 13:39:27 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 13:39:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132647>

Tor Arvid Lund <torarvid <at> gmail.com> writes:


> Well, I see what you're trying to do, but I would not want to see that
> patch in the official script, because some (most?) people (myself, at
> least) use git-p4 to clone single projects out of a perforce depot
> that may contain many projects. I do this myself by doing:
> 
> git p4 clone //depot/path/to/projectX <at> all
> 
> I usually use one clientspec in perforce, and I do not want to change
> that... With your patch, I would be in trouble since my clientspec
> contains "//depot/..." (followed by a lot of lines starting with '-')

Well, does this mean that if you try to sync the client in perforce (visual or 
command line), you will sync all the projects?

In that case, git p4 will require significant effort to satisfy both of us :-) 
Unfortunatly, it seems I'm in minory group of git-p4 users...

i would propose to use both command-line arguments and a client spec 
to create a correct filter of what should be synced/cloned.
BTW, it looks this script does not honor neither the order of paths 
in the spec (which can be important) nor mapping of the files to a local tree.
 

> If you want to fix it, you might want to rename clientSpecDirs to
> clientSpecEntries or something like that.

For now, I just commented out two lines in the run() procedure:
            #if not p.endswith("/"):
            #    p += "/"

> Btw... Am I understanding correctly what it is you wish to accomplish?
> I'm guessing that you have a perforce server with a client spec set
> up, and you want to sync everything on the entire server according to
> that client spec?

yes. Client spec completely defines the project layout for me. 
It contains paths to some components that are mapped to the 
client working tree.
Just if your CS contain 

//depot/path/to/projectX/... //CLIENT/...
