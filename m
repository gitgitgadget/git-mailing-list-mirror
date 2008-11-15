From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 09/11] gitweb: git_is_head_detached() function
Date: Sun, 16 Nov 2008 00:43:45 +0100
Message-ID: <200811160043.46017.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 00:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Up7-00077X-AL
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 00:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYKOXnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 18:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbYKOXnu
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 18:43:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:20938 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYKOXnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 18:43:49 -0500
Received: by ug-out-1314.google.com with SMTP id 39so162350ugf.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 15:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=E0seau5/iZi2nwP6T75VDvlVbATKD+MMI+PDcTainVs=;
        b=lBjbVq4bcakn/d8L3vPSlOXXruFukXOdGmUWbpsGnO18AAi+3Izo6HTeoMoq1Z7wA2
         jpXapemuOZI7CIrIkvgUsu3zuuc64Gi//4W33BieAkQNTu02euW1hLyMO+oRKZIWKBPP
         dxlQYxMJvpq6yfWofajg7+xVer6cCTmakmKoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XjtFb2lB5GidH29ys/WDqsl834lJpWRcK2ShleEE2Ur4xKFjm9oaXIcZ2q3lTbi+Sw
         tAqGdC6OLCWlse6aI+yG+nm5utsqW7ssPWscZ05Mo6mUVMi2Mff63R0u4B4bZkfRsxoy
         gQn/tflH/h3sYPp1UESQHCpQK1S3Zmn9DCyPE=
Received: by 10.67.94.12 with SMTP id w12mr553574ugl.88.1226792627599;
        Sat, 15 Nov 2008 15:43:47 -0800 (PST)
Received: from ?192.168.1.11? (abwb4.neoplus.adsl.tpnet.pl [83.8.225.4])
        by mx.google.com with ESMTPS id 32sm1672617ugf.40.2008.11.15.15.43.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 15:43:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101097>

On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:

> The function checks if the HEAD for the current project is detached by
> checking if 'git branch' returns "* (no branch)"
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

In my opinion this patch should really be squashed together with
previous one. They belong together.

> ---
>  gitweb/gitweb.perl |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a168f6f..ceb0271 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1844,6 +1844,13 @@ sub git_get_head_hash {
>  	return $retval;
>  }
>  
> +# check if current HEAD is detached
> +sub git_is_head_detached {
> +	my @x = (git_cmd(), 'branch');
> +	my @ret = split("\n", qx(@x));
> +	return 0 + grep { /^\* \(no branch\)$/ } @ret;
> +}

First, not git-branch. Second, you can use Perl-only solution:

+# check if current HEAD is detached
+sub git_is_head_detached {
+	my $head_file = "$project/HEAD";
+	return if -l $head_file; # symlink
+	open my $fd, '<', $head_file
+		or return;
+	my $head_hash = <$fd>;
+	close $fd;
+	return if $head_hash =~ /^ref: /;
+	return $head_hash;
+}

Alternate solution would be to create git_get_symbolic_ref, and use
"!defined $current_branch" in place of "git_is_head_detached()".

> +
>  # get type of given object
>  sub git_get_type {
>  	my $hash = shift;
> @@ -2673,11 +2680,9 @@ sub git_get_heads_list {
>  	my @headslist;
>  
>  	if (grep { $_ eq 'heads' } @class) {
> -		my @x = (git_cmd(), 'branch');
> -		my @ret = split("\n", qx(@x));
> -		if (grep { /^\* \(no branch\)$/ } @ret) { ;
> +		if (git_is_head_detached()) {
>  			my %ref_item;
> -			@x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
> +			my @x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');

Hmmm... git-log, git-show, or perhaps parse_commit?

>  			my ($hash, $epoch, $title) = split("\n", qx(@x), 3);
>  
>  			$ref_item{'class'} = 'head';
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
