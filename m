From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-svn, tree moves, and --no-stop-on-copy
Date: Wed, 8 Mar 2006 23:41:04 +0100
Message-ID: <20060308224104.GC27397@nowhere.earth>
References: <20060307220837.GB27397@nowhere.earth> <20060308014207.GA31137@localdomain> <20060308221524.GF12638@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 08 23:34:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH7EU-0007Mx-Om
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 23:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWCHWeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 17:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWCHWeM
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 17:34:12 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:25986 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751228AbWCHWeL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 17:34:11 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D363D222AC;
	Wed,  8 Mar 2006 23:34:10 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FH7L7-0005Qr-Nt; Wed, 08 Mar 2006 23:41:05 +0100
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060308221524.GF12638@nowhere.earth>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17387>

On Wed, Mar 08, 2006 at 11:15:24PM +0100, Yann Dirson wrote:
> OTOH, this does work:
> 
>  svn co -r1 https://svn.sourceforge.net/svnroot/ufoai/trunk@1

Let's go further:

@@ -224,12 +227,14 @@ sub fetch {
        unless (-d $SVN_WC) {
                my @svn_co = ('svn','co',"-r$base->{revision}");
                push @svn_co,'--ignore-externals' unless $_no_ignore_ext;
-               sys(@svn_co, $SVN_URL, $SVN_WC);
+               sys(@svn_co, $SVN_URL . "\@$base->{revision}", $SVN_WC);
                chdir $SVN_WC or croak $!;


That allows git-svn not to fail at r1 (or at r3 when checking out
trunk/src only), and the 1st fetch runs OK.

The second fetch runs OK as well, but it shows the following somewhat
scary stuff before starting the import:

Checked out revision 166.
refs/remotes/git-newsvn
fatal: 'refs/remotes/git-newsvn': No such file or directory
r166 = 38a6ba0e3db486c65a611c54c53f838210ce7551


The results looks fine.  I don't know if it is expected to have the
master head stuck at remotes/git-oldsvn, though.

Thanks much for your help!
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
