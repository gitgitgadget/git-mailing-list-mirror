From: "Michael J. Cohen" <michaeljosephcohen@mac.com>
Subject: [PATCH] Re: git-svn fetch doesn't like spaces in branch names
Date: Wed, 7 Nov 2007 19:53:07 -0500
Message-ID: <B28A099B-1BC8-4CED-856A-5FFD7F6711FC@mac.com>
References: <654A4D1D-712F-4978-9812-E8FA411FAE0D@mac.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael J. Cohen" <michaeljosephcohen@mac.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:53:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpveB-00059I-33
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbXKHAxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbXKHAxL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:53:11 -0500
Received: from smtpoutm.mac.com ([17.148.16.82]:50854 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892AbXKHAxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:53:10 -0500
Received: from mac.com (asmtp010-s [10.150.69.73])
	by smtpoutm.mac.com (Xserve/smtpout019/MantshX 4.0) with ESMTP id lA80rAO6008780
	for <git@vger.kernel.org>; Wed, 7 Nov 2007 16:53:10 -0800 (PST)
Received: from ubuntu.ho (72-17-187-154.ftl.fdn.com [72.17.187.154])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp010/MantshX 4.0) with ESMTP id lA80r7ZF001773
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 7 Nov 2007 16:53:08 -0800 (PST)
In-Reply-To: <654A4D1D-712F-4978-9812-E8FA411FAE0D@mac.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63916>

> mini:TextMateBundles mjc$ git-svn fetch
> Found possible branch point: http://macromates.com/svn/Bundles/trunk/Tools/Dialog 
>  PlugIn => http://macromates.com/svn/Bundles/branches/Dialog PlugIn  
> Completion Menu, 8089
> Initializing parent: Dialog PlugIn Completion Menu@8089
> Bad URL passed to RA layer: Malformed URL for repository at /opt/ 
> local/bin/git-svn line 1607
>
> looks like that might need to be %20 ?


Hacky, but it works.

Signed-off-by: Michael J. Cohen <mjc@cruiseplanners.com>

diff --git a/git-svn.perl b/git-svn.perl
index dd93e32..5dc3b9c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1976,6 +1976,7 @@ sub find_parent_branch {
	my $r = $i->{copyfrom_rev};
	my $repos_root = $self->ra->{repos_root};
	my $url = $self->ra->{url};
+	$branch_from =~ s@([\s])@sprintf("%%%02X", ord($1))@seg;
	my $new_url = $repos_root . $branch_from;
	print STDERR  "Found possible branch point: ",
	              "$new_url => ", $self->full_url, ", $r\n";
-- 
1.5.3.5.1590.gfadfad-dirty
