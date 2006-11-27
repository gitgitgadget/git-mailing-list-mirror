X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: Show remote branches on gitweb
Date: Mon, 27 Nov 2006 19:20:05 +0000 (UTC)
Message-ID: <loom.20061127T200958-750@post.gmane.org>
References: <loom.20061124T210559-701@post.gmane.org> <ek7jsp$j83$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 19:20:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 44
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.99.93 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32440>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gom1x-0005F7-EL for gcvg-git@gmane.org; Mon, 27 Nov
 2006 20:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933330AbWK0TUi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 14:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbWK0TUi
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 14:20:38 -0500
Received: from main.gmane.org ([80.91.229.2]:37293 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933330AbWK0TUh (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 14:20:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gom1m-0005CD-QR for git@vger.kernel.org; Mon, 27 Nov 2006 20:20:31 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 20:20:30 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 27 Nov 2006
 20:20:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb <at> gmail.com> writes:

> > Is there any way to do it? I'm using git-svn to track a remote
> > subversion repository, and it would be very nice to browse the
> > history for a remote branch for which I didn't start a local
> >branch yet.
> 
> Planned, not implemented yet.

Probably not a technically correct solution, but the following changes did the
trick for me.


--- a/gitweb.cgi	2006-11-23 11:02:34.000000000 -0200
+++ b/gitweb.cgi	2006-11-27 10:09:56.000000000 -0200
@@ -1428,8 +1431,7 @@
 
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
-		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads'
+		'--format=%(objectname) %(refname) %(subject)%00%(committer)'
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
@@ -1440,6 +1442,7 @@
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$name =~ s!^refs/heads/!!;
+		$name =~ s!^refs/remotes/!!;
 
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;



I've just changed the git_get_heads_list function to let 'for-each-ref'
return all top refs instead of just those in refs/heads, and added a line to
remove 'refs/remotes/' from the remote branch names.

Again, probably not the right solution, but now I have remote branches listed
under "heads", and that's all I really need.

-- Pazu
