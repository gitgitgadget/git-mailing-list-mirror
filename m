From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 1/5] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Sun, 19 Oct 2008 00:41:44 +0200
Message-ID: <200810190041.44711.jnareb@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 01:27:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrLCq-00075Z-QU
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 01:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYJRX0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 19:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYJRX0Y
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 19:26:24 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:6810 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYJRX0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 19:26:23 -0400
Received: by ey-out-2122.google.com with SMTP id 6so397901eyi.37
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1ZDKKdQZxEYeH9yPo9cwLbXc6Yb2c/0/DRlQe2XdFUA=;
        b=Q6fJ2qUWH1XOUBKz1kOhv1sv+MbKA6Khybj7TIlk12Ic5C2xlDJeVOEhI8x4V3B7Pm
         qSqqdqa1PHRKPRmQuz2s/9LBwNvkMx4Sf8R/TvognetlIbXmSAUtFfHLukbRuAhtMJjt
         koHA3MdPn4lO76Y7BQDDyPMqU8FF1g/TlBXr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UgHT5PdsbY+bgh+Xh7d8Lj/EgwrEGwdDsgqJy7syt1rGelSGRK5jqdCQ4+JFbWZlzE
         vFEUR27fNF6319eaOgSXMxlUJvaW50lSXskqlXbDOou8dmhGdQKo1e256AUow34dRrQ1
         6shAT0PoekegWDc/Cfi1kthP91LQ2N6nLk53M=
Received: by 10.210.90.8 with SMTP id n8mr6582805ebb.97.1224372381211;
        Sat, 18 Oct 2008 16:26:21 -0700 (PDT)
Received: from ?192.168.1.11? (abwr242.neoplus.adsl.tpnet.pl [83.8.241.242])
        by mx.google.com with ESMTPS id 7sm7149891eyb.1.2008.10.18.16.26.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Oct 2008 16:26:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98580>

On Thu, 16 Oct 2008, Giuseppe Bilotta wrote:

> This patch enables gitweb to parse URLs with more information embedded
> in PATH_INFO, reducing the need for CGI parameters. The typical gitweb
> path is now $project/$action/$hash_base:$file_name or
> $project/$action/$hash
> 
> This is mostly backwards compatible with the old-style gitweb paths,
> $project/$branch[:$filename], except when it was used to access a branch
> whose name matches a gitweb action.

...in which case old code would access branch, and new code would treat
name as action.  This shouldn't matter in practice, unless there are
branches named exactly as gitweb actions.

[But I think current commit description is enough. Just in case...]

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I like it. For what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   37 +++++++++++++++++++++++++++++++------
>  1 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c5254af..6d0dc26 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -534,23 +534,48 @@ sub evaluate_path_info {
>  	return if $input_params{'action'};
>  	$path_info =~ s,^\Q$project\E/*,,;
>  
> +	# next, check if we have an action
> +	my $action = $path_info;
> +	$action =~ s,/.*$,,;
> +	if (exists $actions{$action}) {
> +		$path_info =~ s,^$action/*,,;
> +		$input_params{'action'} = $action;
> +	}
> +
> +	# list of actions that want hash_base instead of hash

...and can have no file_name ('f') parameter.

> +	my @wants_base = (
> +		'tree',
> +		'history',
> +	);

I like this solution.  It makes path_info URL unambiguous: it is 
<project>/log/<hash> (where <hash> is usually refname), and
<project>/tree/<hash_base> which is just shortcut for <project>/tree/<hash_base>:/

It means that the @wants_base list contains actions which require / use
$hash_base and $file_name, but $file_name might be not set, which denotes
top directory (root tree).

> +
>  	my ($refname, $pathname) = split(/:/, $path_info, 2);
>  	if (defined $pathname) {
> -		# we got "project.git/branch:filename" or "project.git/branch:dir/"
> +		# we got "branch:filename" or "branch:dir/"
>  		# we could use git_get_type(branch:pathname), but it needs $git_dir

Well, this comment was there... but actually I think we avoid 
git_get_type("branch:pathname") because currently it is additional fork.
And with convention that filename part of path_info ends in '/' for
directories (quite sensible I think) it is not needed.  Moreso after
next patch in series, when we state action explicitly, and the only
difference _might_ be for 'history' view (which is for directories
and for files both).

>  		$pathname =~ s,^/+,,;
>  		if (!$pathname || substr($pathname, -1) eq "/") {
> -			$input_params{'action'} = "tree";
> +			$input_params{'action'} ||= "tree";
>  			$pathname =~ s,/$,,;
>  		} else {
> -			$input_params{'action'} = "blob_plain";
> +			$input_params{'action'} ||= "blob_plain";
>  		}
>  		$input_params{'hash_base'} ||= $refname;
>  		$input_params{'file_name'} ||= $pathname;
>  	} elsif (defined $refname) {
> -		# we got "project.git/branch"
> -		$input_params{'action'} = "shortlog";
> -		$input_params{'hash'} ||= $refname;
> +		# we got "branch". in this case we have to choose if we have to
                                 ^ ^
                                 |-|-- ??? (typo?)

> +		# set hash or hash_base.
> +		#
> +		# Most of the actions without a pathname only want hash to be
> +		# set, except for the ones specified in @wants_base that want
> +		# hash_base instead. It should also be noted that hand-crafted
> +		# links having 'history' as an action and no pathname or hash
> +		# set will fail, but that happens regardless of PATH_INFO.

Ah, I see that the comment about what makes action to be put into
@wants_base is here.

> +		$input_params{'action'} ||= "shortlog";
> +		if (grep {$input_params{'action'} eq $_} @wants_base) {

Style: I would use here (but perhaps it is just me) for better 
readibility

+		if (grep { $input_params{'action'} eq $_ } @wants_base) {

> +			$input_params{'hash_base'} ||= $refname;
> +		} else {
> +			$input_params{'hash'} ||= $refname;
> +		}
>  	}
>  }
>  evaluate_path_info();
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
