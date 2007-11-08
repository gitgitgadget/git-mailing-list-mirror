From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Re: git-svn fetch doesn't like spaces in branch names
Date: Thu, 8 Nov 2007 08:29:18 +0100
Message-ID: <20071108072918.GC3170@steel.home>
References: <654A4D1D-712F-4978-9812-E8FA411FAE0D@mac.com> <B28A099B-1BC8-4CED-856A-5FFD7F6711FC@mac.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael J. Cohen" <michaeljosephcohen@mac.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 08:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq1pX-00066D-Fv
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbXKHH3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 02:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbXKHH3V
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:29:21 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:30608 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbXKHH3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:29:20 -0500
Received: from tigra.home (Fc819.f.strato-dslnet.de [195.4.200.25])
	by post.webmailer.de (fruni mo54) (RZmta 14.0)
	with ESMTP id N0223ejA80f2lJ ; Thu, 8 Nov 2007 08:29:18 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 36FA8277AE;
	Thu,  8 Nov 2007 08:29:18 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 13C1656D22; Thu,  8 Nov 2007 08:29:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <B28A099B-1BC8-4CED-856A-5FFD7F6711FC@mac.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWowxOg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63943>

Michael J. Cohen, Thu, Nov 08, 2007 01:53:07 +0100:
>> mini:TextMateBundles mjc$ git-svn fetch
>> Found possible branch point: 
>> http://macromates.com/svn/Bundles/trunk/Tools/Dialog PlugIn => 
>> http://macromates.com/svn/Bundles/branches/Dialog PlugIn Completion Menu, 
>> 8089
>> Initializing parent: Dialog PlugIn Completion Menu@8089
>> Bad URL passed to RA layer: Malformed URL for repository at 
>> /opt/local/bin/git-svn line 1607
>>
>> looks like that might need to be %20 ?
>
>
> Hacky, but it works.
>
> Signed-off-by: Michael J. Cohen <mjc@cruiseplanners.com>
>
> diff --git a/git-svn.perl b/git-svn.perl
> index dd93e32..5dc3b9c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1976,6 +1976,7 @@ sub find_parent_branch {
> 	my $r = $i->{copyfrom_rev};
> 	my $repos_root = $self->ra->{repos_root};
> 	my $url = $self->ra->{url};
> +	$branch_from =~ s@([\s])@sprintf("%%%02X", ord($1))@seg;

You don't need "[" and "]".
