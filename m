From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/2] gitweb: extend &git_get_head_hash to be &git_get_hash
Date: Thu, 10 Sep 2009 23:49:49 +0200
Message-ID: <200909102349.50988.jnareb@gmail.com>
References: <4AA96D9B.6090003@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Sep 10 23:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlrWY-0003Jw-84
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 23:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbZIJVtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 17:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754359AbZIJVtk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 17:49:40 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:35818 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbZIJVtj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 17:49:39 -0400
Received: by fxm17 with SMTP id 17so435933fxm.37
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cqebAGQfYMSOwOnaFaAYA49CLNNHQApWp2zJe+u2W1Y=;
        b=V6gxJxTiKDPaoLTmiJ46b1oqGnjkC37TmmeWQS3e3wkeWrkmczD2p8Oa8ByL7noYP+
         3LPFvTKIPkvCzuu/ExuiqygrNWeLfMvdIzHlfjpB7Ti3YEkJ9XPDiSYgxIv/ZOtBmzm2
         +7bqKcECJseLfU6lM1HsW0vTU6EG8Yvm0stxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q0Q6xGg4sLY+VDD7jQCxKQRFw5EFea+WItkctD3OPCv7/MmSN1VRV+QWo11LC5NeVn
         2K7YuqOup5JMTFelbWwmQdk3i2uL11kl/RSXQNFYr+R27D8FPCWkS76qO2xkw9VSq3NS
         ncu3AfGyMOqQXBOnl+ct3fVGfPgJWrvXMUbHc=
Received: by 10.86.251.40 with SMTP id y40mr1643339fgh.57.1252619382022;
        Thu, 10 Sep 2009 14:49:42 -0700 (PDT)
Received: from ?192.168.1.13? (abwa69.neoplus.adsl.tpnet.pl [83.8.224.69])
        by mx.google.com with ESMTPS id l19sm832866fgb.17.2009.09.10.14.49.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 14:49:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4AA96D9B.6090003@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128151>

On Thu, 10 Sep 2009, Mark Rada wrote:

> gitweb: extend &git_get_head_hash to be &git_get_hash

Should be "extend git_get_head_hash to be git_get_hash", see below.

>
> This adds an optional second argument to the routine which lets the
> caller specify a treeish that can be translated to a hash id by
> rev-parse.

Minor nit: we use "tree-ish" not "treeish" in documentation.

> 
> To maintain some backwards compatability, the second argument is
> optional and it will default to `HEAD' if not specified.

Why 'some'?  It does maintain backward compatibility.

Also i am not sure about git_get_hash defaulting to "HEAD". Perhaps
it would be better to keep git_get_head_hash as warpper around 
git_get_hash?  Or perhaps it would be better to explicitly pass
"HEAD" as second parameter?

> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>

It looks like a good idea, even if it doesn't make much sense as
a standalone patch.

> ---
>  gitweb/gitweb.perl |   31 ++++++++++++++++---------------
>  1 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 24b2193..d650188 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1981,13 +1981,14 @@ sub quote_command {
>  		map { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
>  }
>  
> -# get HEAD ref of given project as hash
> -sub git_get_head_hash {
> +# get object id of given project as full hash, defaults to HEAD
> +sub git_get_hash {

I'm not sure about naming (not that git_get_head_hash was best), as
you don't see from git_get_hash subroutine name that the first parameter
is the name of repository (the git_get_head_hash at least hinted, if
very weekly, at it).

>  	my $project = shift;
> +	my $hash = shift || 'HEAD';
>  	my $o_git_dir = $git_dir;
>  	my $retval = undef;
>  	$git_dir = "$projectroot/$project";
> -	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
> +	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--verify', "$hash") {

Minor nit: we don't need to quote (stringify) single variable here; 
using 
  ..., '--verify', $hash)
would work as well.

>  		my $head = <$fd>;
>  		close $fd;
>  		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
> @@ -4737,7 +4738,7 @@ sub git_summary {
>  }
>  
>  sub git_tag {
> -	my $head = git_get_head_hash($project);
> +	my $head = &git_get_hash($project);

One very rarely needs to use explicit "&" subroutine calling syntax;
I think only when you want to circumvent subroutine prototype (which
is different from function/procedure prototypes in other languages).
Current practice is to not use it.

Besides it it not used anywhere else in gitweb (consistency).

>  	git_header_html();
>  	git_print_page_nav('','', $head,undef,$head);
>  	my %tag = parse_tag($hash);
> @@ -4778,7 +4779,7 @@ sub git_blame {
>  
>  	# error checking
>  	die_error(400, "No file name given") unless $file_name;
> -	$hash_base ||= git_get_head_hash($project);
> +	$hash_base ||= &git_get_hash($project);

Same as above: use "git_get_hash($project)" or "git_get_hash($project, 'HEAD');"

>  	die_error(404, "Couldn't find base commit") unless $hash_base;
>  	my %co = parse_commit($hash_base)
>  		or die_error(404, "Commit not found");
> @@ -4911,7 +4912,7 @@ HTML
>  }
>  
>  sub git_tags {
> -	my $head = git_get_head_hash($project);
> +	my $head = &git_get_hash($project);

Same as above: use "git_get_hash($project)"

>  	git_header_html();
>  	git_print_page_nav('','', $head,undef,$head);
>  	git_print_header_div('summary', $project);
> @@ -4924,7 +4925,7 @@ sub git_tags {
>  }
>  
>  sub git_heads {
> -	my $head = git_get_head_hash($project);
> +	my $head = &git_get_hash($project);

Same as above: use "git_get_hash($project)"

>  	git_header_html();
>  	git_print_page_nav('','', $head,undef,$head);
>  	git_print_header_div('summary', $project);
> @@ -4942,7 +4943,7 @@ sub git_blob_plain {
>  
>  	if (!defined $hash) {
>  		if (defined $file_name) {
> -			my $base = $hash_base || git_get_head_hash($project);
> +			my $base = $hash_base || &git_get_hash($project);

Same as above: use "git_get_hash($project)"
[...]

-- 
Jakub Narebski
Poland
