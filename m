From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: show progress in working_head_info()
Date: Sat, 10 Jan 2015 22:21:35 +0000
Message-ID: <20150110222135.GB32253@dcvr.yhbt.net>
References: <1420896096-15254-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 23:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA4Pc-0003Qb-QN
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 23:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbbAJWVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 17:21:36 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42445 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516AbbAJWVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 17:21:36 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9DB1FA58;
	Sat, 10 Jan 2015 22:21:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1420896096-15254-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262278>

Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> The working_head_info routine takes a very long time to execute on large
> repositories. The least we can do is to comfort users that some progress
> is being made.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  I was worried because of the long wait, so I wrote this to convince
>  myself that git-svn wasn't stuck.

Unfortunately, this breaks show-ignore and t9101-git-svn-props.sh

show-ignore.expect show-ignore.got differ: char 1, line 1
not ok 23 - test show-ignore

Perhaps output should go to STDERR and also respect $_q?

>  git-svn.perl | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 60f8814..6aa156c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2022,6 +2022,9 @@ sub working_head_info {
>  			next;
>  		}
>  		next unless s{^\s*(git-svn-id:)}{$1};
> +		my $chomped = $_;
> +		chomp $chomped;
> +		print "[Importing] $chomped\n";
>  		my ($url, $rev, $uuid) = extract_metadata($_);
>  		if (defined $url && defined $rev) {
>  			next if $max{$url} and $max{$url} < $rev;
