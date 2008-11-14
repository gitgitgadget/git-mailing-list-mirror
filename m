From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 01/11] gitweb: introduce remote_heads feature
Date: Fri, 14 Nov 2008 19:15:17 +0100
Message-ID: <200811141915.17680.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 19:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L13Di-00039d-VK
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 19:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYKNSPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 13:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYKNSPX
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 13:15:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:59752 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYKNSPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 13:15:23 -0500
Received: by nf-out-0910.google.com with SMTP id d3so760506nfc.21
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=209xHvWDy5cwKe4l8Fl3cf7f2DEgUq/8235AtBtOCRc=;
        b=SHyQgTbQc4F+XEzsv/wCuvfI2qFAoqeKyCFsk4hynfBb/OKlrN+LtEGP9onq3GKzVm
         CipAAXysAbJk695+YWp5/aolEQzTsUK3Ndettgyx68mr7bdaBZfCr3Icu6mrATdD9/pq
         8DoX3ZzjDOgxeSUM72w2cjdnluHlBavdqP08Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vgQ5/cJdyzIF2yiH7Wq/0UVpxvsIrQXJDdH8TvpGqdYHFLcce/pZGLSTQeA128fJGz
         Z2yRmUJ37SZVaZ0r7/GVL+858DTTQ1eDeeRQzW4FbMz0vMurYsXQB8/k6SHSmQlaralq
         0Sxl0FXySyYkava68/12VUuEiLdRAJchhOpmc=
Received: by 10.86.86.12 with SMTP id j12mr761658fgb.64.1226686520920;
        Fri, 14 Nov 2008 10:15:20 -0800 (PST)
Received: from ?192.168.1.11? (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id d4sm2017068fga.5.2008.11.14.10.15.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 10:15:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100997>

On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:

> With this feature enabled, remotes are retrieved (and displayed)
> when getting (and displaying) the heads list.

I think it would be good idea to add in commit message idea _why_
such feature would be useful, for example

  This is useful if you want to use git-instaweb to examine the state
  of repository, influding remote-tracking branches, or a repository
  is fork of other repository, and remote-tracking branches are used
  to see what commits this fork has in addition to those from forked
  (main) repository.

Or something like that.

It would be also in my opinion a good idea to modify git-instaweb.sh
(I guess better in separate commit) to make it make use of this new
feature... unless it does it already, doesn't it?

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   31 +++++++++++++++++++++++++++++--
>  1 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 933e137..b6c4233 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -327,6 +327,18 @@ our %feature = (
>  	'ctags' => {
>  		'override' => 0,
>  		'default' => [0]},
> +
> +	# Make gitweb show remotes too in the heads list

I'm not native engish speaker, but shouldn't instead of "remotes too"
be "also remotes" or "remotes also"?

> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'remote_heads'}{'default'} = [1];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'remote_heads'}{'override'} = 1;
> +	# and in project config gitweb.remote_heads = 0|1;
> +	'remote_heads' => {
> +		'sub' => \&feature_remote_heads,
> +		'override' => 0,
> +		'default' => [0]},
>  );
>  
>  sub gitweb_check_feature {
> @@ -392,6 +404,18 @@ sub feature_pickaxe {
>  	return ($_[0]);
>  }
>  
> +sub feature_remote_heads {
> +	my ($val) = git_get_project_config('remote_heads', '--bool');
> +
> +	if ($val eq 'true') {
> +		return (1);
> +	} elsif ($val eq 'false') {
> +		return (0);
> +	}
> +
> +	return ($_[0]);
> +}

Hmmm... I think it is hight time to provide option to 
git_get_project_config to _not_ use backward compatibility with 
'git config --bool', i.e. return Perl bool, and not 'true'/'false'
string.

But this is I think outside scope of this patch...

> +
>  # checking HEAD file with -e is fragile if the repository was
>  # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
>  # and then pruned.
> @@ -2642,10 +2666,12 @@ sub git_get_heads_list {
>  	my $limit = shift;
>  	my @headslist;
>  
> +	my ($remote_heads) = gitweb_check_feature('remote_heads');
> +
>  	open my $fd, '-|', git_cmd(), 'for-each-ref',
>  		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
>  		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
> -		'refs/heads'
> +		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
>  		or return;
>  	while (my $line = <$fd>) {
>  		my %ref_item;
> @@ -2656,8 +2682,9 @@ sub git_get_heads_list {
>  		my ($committer, $epoch, $tz) =
>  			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
>  		$ref_item{'fullname'}  = $name;
> -		$name =~ s!^refs/heads/!!;
> +		$name =~ s!^refs/(head|remote)s/!!;
>  
> +		$ref_item{'class'} = $1;

Nice catch.

>  		$ref_item{'name'}  = $name;
>  		$ref_item{'id'}    = $hash;
>  		$ref_item{'title'} = $title || '(no commit message)';
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
