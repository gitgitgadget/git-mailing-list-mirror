From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Tue, 18 Sep 2007 11:29:09 +0200
Message-ID: <20070918092909.GU31176@kiste.smurf.noris.de>
References: <200709161857.06065.danda@osc.co.cr> <20070917070303.GI31176@kiste.smurf.noris.de> <200709171333.48331.danda@osc.co.cr> <20070918074753.GQ31176@kiste.smurf.noris.de> <7vlkb4wdzq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Libby <danda@osc.co.cr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:29:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZOk-00049A-B6
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbXIRJ3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbXIRJ3d
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:29:33 -0400
Received: from smurf.noris.de ([192.109.102.42]:51212 "EHLO smurf.noris.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077AbXIRJ3c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:29:32 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35])
	by smurf.noris.de with smtp (Exim 4.63)
	(envelope-from <smurf@smurf.noris.de>)
	id 1IXZOM-0003ci-Na; Tue, 18 Sep 2007 11:29:15 +0200
Received: (nullmailer pid 27755 invoked by uid 501);
	Tue, 18 Sep 2007 09:29:09 -0000
Content-Disposition: inline
In-Reply-To: <7vlkb4wdzq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58563>

Some people seem to create SVN branch names with spaces
or other shell metacharacters.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
---
Junio C Hamano:
> > -		open(H,"git-rev-parse --verify $parent |");
> > +		open(H,'-|',"git-rev-parse","--verify",$parent);
> 
> I seem to be missing the context, but please describe what
> problem this fixes in the commit log message.  I guess some
> people use shell metacharacters and/or SP in their branch names
> and this is about that problem?

Exactly. Sorry; it seems that the original question hasn't been posted
to the mailing list.

diff --git a/git-svnimport.perl b/git-svnimport.perl
index d3ad5b9..aa5b3b2 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -633,7 +633,7 @@ sub commit {
 
 	my $rev;
 	if($revision > $opt_s and defined $parent) {
-		open(H,"git-rev-parse --verify $parent |");
+		open(H,'-|',"git-rev-parse","--verify",$parent);
 		$rev = <H>;
 		close(H) or do {
 			print STDERR "$revision: cannot find commit '$parent'!\n";



-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
BOFH excuse #11:

magnetic interference from money/credit cards
