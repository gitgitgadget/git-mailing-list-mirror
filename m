X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Mon, 11 Dec 2006 22:49:04 +0200
Message-ID: <20061211204904.GC1003@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com> <20061208203230.GA9193@sashak.voltaire.com> <1165847230.13854.2.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 20:41:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <1165847230.13854.2.camel@systems03.lan.brontes3d.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 11 Dec 2006 20:41:08.0038 (UTC) FILETIME=[AF6C1660:01C71D64]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34033>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtrxd-0003Iu-3H for gcvg-git@gmane.org; Mon, 11 Dec
 2006 21:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763091AbWLKUlN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 15:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937501AbWLKUlN
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 15:41:13 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:7554 "EHLO
 taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1763091AbWLKUlL (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 15:41:11 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 11 Dec 2006 22:41:08 +0200
Received: by sashak (sSMTP sendmail emulation); Mon, 11 Dec 2006 22:49:04
 +0200
To: Daniel Drake <ddrake@brontes3d.com>
Sender: git-owner@vger.kernel.org

On 09:27 Mon 11 Dec     , Daniel Drake wrote:
> On Fri, 2006-12-08 at 22:32 +0200, Sasha Khapyorsky wrote:
> > > # git-svnimport -v -i -C repo -r https://server repo
> > 
> > Is this 'server' public? Can I rerun this git-svnimport?
> 
> Sorry, it is not.
> 
> > @@ -906,7 +912,7 @@ sub commit_all {
> >  	my ($changed_paths, $revision, $author, $date, $message, $pool) = @_;
> >  	my %p;
> >  	while(my($path,$action) = each %$changed_paths) {
> > -		$p{$path} = [ $action->action,$action->copyfrom_path, $action->copyfrom_rev, $path ];
> > +		$p{$path} = [ $action->action,$svn_dir$action->copyfrom_path, $action->copyfrom_rev, $svn_dir$path ];
> 
> This is not valid perl - I think you wanted $svn_dir . $path

Yes, sorry.

> 
> After making that modification it's not fixed though:
> 
> Fetching from 1 to 10742 ...
> Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> Committed change 1:/ 2004-12-22 22:53:27)
> Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> Commit ID 2614c05ac4c5f24eb89cea056a7d46c909084d8c
> Writing to refs/heads/origin
> DONE: 1 origin 2614c05ac4c5f24eb89cea056a7d46c909084d8c
> perl: subversion/libsvn_subr/path.c:377: svn_path_basename: Assertion
> `is_canonical (path, len)' failed.
> Aborted

Maybe I'm starting to understand. Your svn url (url which points to svn
repository) is https://server/repo and not just https://server, right?

If so, please remove the patch (you don't need it) and rerun:

  git-svnimport -v -i -C repo -r https://server/repo


