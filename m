From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn rebase issues (the commiter gets changed)
Date: Sat, 15 Dec 2007 19:39:47 -0800
Message-ID: <20071216033947.GB17666@muzzle>
References: <94ccbe710711220815j663d22e0v3c744244d0a87b66@mail.gmail.com> <20071129075205.GB32277@soma> <94ccbe710711290816t7a6ba9b1o8f37ecf583305a51@mail.gmail.com> <20071216032523.GA17666@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kMN-0001nx-P3
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbXLPDjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbXLPDjs
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:39:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34896 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbXLPDjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:39:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6F4AE7DC10A;
	Sat, 15 Dec 2007 19:39:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071216032523.GA17666@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68429>

Eric Wong <normalperson@yhbt.net> wrote:
> From 84e99bffc72c10ec7db6d5ae7af6a795b75ef724 Mon Sep 17 00:00:00 2001
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl |   50 +++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index d411a34..7cd62fc 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2089,5 +2116,6 @@ sub do_git_commit {
>  	defined(my $pid = open3(my $msg_fh, my $out_fh, '>&STDERR', @exec))
>  	                                                           or croak $!;
>  	print $msg_fh $log_entry->{log} or croak $!;
> +	restore_commit_header_env($old_env);
>  	unless ($self->no_metadata) {
>  		print $msg_fh "\ngit-svn-id: $log_entry->{metadata}\n"
> \ No newline at end of file

Hi Junio,

This "\ No newline at end of file" from git-format-patch seems wrong.

Bisecting reveals that it started happening at:

  913b45f51b151d8e29f86df67d3e10853d831470
  xdi_diff: trim common trailing lines

-- 
Eric Wong
