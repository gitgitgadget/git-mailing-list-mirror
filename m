From: Andrew Myrick <amyrick@apple.com>
Subject: Re: Regression: git-svn clone failure
Date: Tue, 22 Dec 2009 11:38:08 -0800
Message-ID: <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com> <20091222192115.GA10313@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v1130)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sam@vilain.net
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Dec 22 20:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNAYm-0005SK-KR
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 20:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbZLVTiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 14:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754026AbZLVTiM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 14:38:12 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:49289 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbZLVTiL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 14:38:11 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id E65857DD7158;
	Tue, 22 Dec 2009 11:38:08 -0800 (PST)
X-AuditID: 11807134-b7cd9ae000001002-5e-4b3120202f9d
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay14.apple.com (Apple SCV relay) with SMTP id C2.F4.04098.020213B4; Tue, 22 Dec 2009 11:38:08 -0800 (PST)
In-Reply-To: <20091222192115.GA10313@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1130)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135596>


On Dec 22, 2009, at 11:21 AM, Eric Wong wrote:
> That looks like a simple error, does the following patch help?
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 3670960..dba0d12 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3163,7 +3163,8 @@ sub find_extra_svn_parents {
> 				next unless $new_parents[$i];
> 				next unless $new_parents[$j];
> 				my $revs = command_oneline(
> -					"rev-list", "-1", "$i..$j",
> +					"rev-list", "-1",
> +					"$new_parents[$i]..$new_parents[$j]",
> 				       );
> 				if ( !$revs ) {
> 					undef($new_parents[$i]);
> 
> 

Worked like a charm; the fetch is proceeding now.  Thanks, Eric!

Do you know what the "svn cherry-pick ignored" warnings mean, and if it's something I should be concerned about?  This particular project is missing up to 65 commits at some revisions.

-Andrew