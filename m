From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/7] gitweb: introduce remote_heads feature
Date: Thu, 16 Sep 2010 23:41:19 +0200
Message-ID: <201009162341.20380.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 23:41:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwMD0-0001Cj-Bp
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 23:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab0IPVl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 17:41:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41717 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab0IPVl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 17:41:28 -0400
Received: by bwz11 with SMTP id 11so2031628bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 14:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aw+YhbCeo+Gy4ZQNdg2AIh6oQ28ZIk0V8USc65AnxfA=;
        b=JyOKuKQDIVKoXamF+0n8/lIDGWIjNse2YDCY7eicmPf6zcDSEE3+MTFJs92JpBYyJH
         u1Tu2pfrCoLMLCs5/bdbEJ4cDGB1GPIFzW8WMa9H60gNK3ulO2XBC2wvas5SUG5cnZCZ
         eQwdpHx9cIRveXMIK/leSvFXjhXVUg/YbKebM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H6dRDq0/VYXKDCaxH1D9YXrlFvJImUDBOv7MfRy5VF7Qq6X02MOwbQEJheIzi3V+t0
         tvA0Tfj6fWY+UZef04Nx3teDnOeIg+2xFC4/E/kZKW4Chno0AjO7Q3tBoHgaN9P64NWG
         egzy1YupaVvsORYcwJUrUjxx2oGI9j5SosC14=
Received: by 10.204.76.3 with SMTP id a3mr2621642bkk.190.1284673286711;
        Thu, 16 Sep 2010 14:41:26 -0700 (PDT)
Received: from [192.168.1.13] (abvm37.neoplus.adsl.tpnet.pl [83.8.210.37])
        by mx.google.com with ESMTPS id y19sm2912883bkw.6.2010.09.16.14.41.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 14:41:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1284629465-14798-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156356>

On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> With this feature enabled, remotes are retrieved (and displayed)
> when getting (and displaying) the heads list. Typical usage would be for
> local repository browsing, e.g. by using git-instaweb (or even a more
> permanent gitweb setup), to check the repository status and the relation
> between tracking branches and the originating remotes.

Good idea.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a85e2f6..7116c26 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -486,6 +486,18 @@ our %feature = (
>  		'sub' => sub { feature_bool('highlight', @_) },
>  		'override' => 0,
>  		'default' => [0]},
> +
> +	# Make gitweb show remotes too in the heads list
> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'remote_heads'}{'default'} = [1];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'remote_heads'}{'override'} = 1;
> +	# and in project config gitweb.remote_heads = 0|1;
> +	'remote_heads' => {
> +		'sub' => sub { feature_bool('remote_heads', @_) },
> +		'override' => 0,
> +		'default' => [0]},

I agree both with this feature being turned off by default, and with
it being per-project overridable.

>  );
>  
>  sub gitweb_get_feature {
> @@ -3146,10 +3158,12 @@ sub git_get_heads_list {
>  	my $limit = shift;
>  	my @headslist;
>  
> +	my $remote_heads = gitweb_check_feature('remote_heads');
> +
>  	open my $fd, '-|', git_cmd(), 'for-each-ref',
>  		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
>  		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
> -		'refs/heads'
> +		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')

The usual way for optionally providing extra arguments to git commands
in gitweb is to use empty list "()" and not empty argument "''", i.e.
it would be:

  +		'refs/heads', ( $remote_heads ? 'refs/remotes' : ())

See for example git_get_references, parse_commits,... and evem the line
with "($limit ? ...)" above in git_get_heads_list.

>  		or return;
>  	while (my $line = <$fd>) {
>  		my %ref_item;
> @@ -3160,8 +3174,9 @@ sub git_get_heads_list {
>  		my ($committer, $epoch, $tz) =
>  			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
>  		$ref_item{'fullname'}  = $name;
> -		$name =~ s!^refs/heads/!!;
> +		$name =~ s!^refs/(head|remote)s/!!;
>  
> +		$ref_item{'class'} = $1;

Is it used anywhere, or is it left to be used by a further commit in
the series?  If it is the latter, perhaps it would be worth mentioning
in the commit message?

>  		$ref_item{'name'}  = $name;
>  		$ref_item{'id'}    = $hash;
>  		$ref_item{'title'} = $title || '(no commit message)';
> -- 
> 1.7.3.rc1.230.g8b572
> 
> 

-- 
Jakub Narebski
Poland
