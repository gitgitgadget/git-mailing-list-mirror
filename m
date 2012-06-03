From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Sun, 3 Jun 2012 11:49:14 +0100
Message-ID: <20120603104914.GA21276@hashpling.org>
References: <20120427082559.GC4023@login.drsnuggles.stderr.nl>
 <20120429082341.GA32664@dcvr.yhbt.net>
 <7vvckihyqm.fsf@alter.siamese.dyndns.org>
 <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
 <20120430081939.GA27715@dcvr.yhbt.net>
 <7vipghgq9a.fsf@alter.siamese.dyndns.org>
 <20120430165315.GO4023@login.drsnuggles.stderr.nl>
 <20120430190200.GA27108@dcvr.yhbt.net>
 <20120430192016.GQ4023@login.drsnuggles.stderr.nl>
 <7vy5pcd7xu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 12:55:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb8TW-0004A4-OI
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 12:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab2FCKzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 06:55:24 -0400
Received: from avasout07.plus.net ([84.93.230.235]:54660 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2FCKzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 06:55:23 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jun 2012 06:55:22 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout07 with smtp
	id HmpE1j0052iA9hg01mpFjT; Sun, 03 Jun 2012 11:49:17 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=bujO9Tmi c=1 sm=1 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=-GleFfVwiy8A:10 a=L1uPjF0L7rgA:10 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10
 a=kj9zAlcOel0A:10 a=Ew9TdX-QAAAA:8 a=ybZZDoGAAAAA:8 a=ndW7ey3SY9u8xrL1zncA:9
 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=wpJ/2au8Z6V/NgdivHIBow==:117
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1Sb8N0-0005xi-MS; Sun, 03 Jun 2012 11:49:14 +0100
Content-Disposition: inline
In-Reply-To: <7vy5pcd7xu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199081>

On Mon, Apr 30, 2012 at 06:08:29PM -0700, Junio C Hamano wrote:
> 
> Ok, something along the lines of this.  Perhaps instead of "compare_",
> we may want to call it "require_", so that negative return maps naturally
> to a failure.
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 427da9e..4a2ec43 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl

snip

> @@ -5464,7 +5481,7 @@ sub _auth_providers () {
>  
>  	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
>  	# this function
> -	if ($SVN::Core::VERSION gt '1.6.12') {
> +	if (compare_svn_version('1.6.12') > 0) {
>  		my $config = SVN::Core::config_get_config($config_dir);
>  		my ($p, @a);
>  		# config_get_config returns all config files from

I presume this patch turned into this commit:

commit f760c903b8525878cd3b426fc61a7a2cf8742609
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed May 2 19:53:50 2012 +0000

    git-svn: introduce SVN version comparison function

Although it was advertised as fixing the breakage introduced by
082afee621aeb2d3746c8ae290af98823f981f34 it didn't fix things for me.
Although I haven't investigate why, trial and error proved that I
could fix it if I changed the comparison to:

       if (::compare_svn_version('1.6.13') > 0) {

For me:
$ svn --version --quiet
1.6.13

Is this the correct fix or do I have a bad svn install on my linux
box?

Charles.
