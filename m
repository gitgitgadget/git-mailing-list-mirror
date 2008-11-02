From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATHv2 8/8] gitweb: make the supported snapshot formats array global
Date: Sun, 2 Nov 2008 02:54:59 +0100
Message-ID: <200811020255.01895.jnareb@gmail.com>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com> <1224426270-27755-2-git-send-email-giuseppe.bilotta@gmail.com> <1224426270-27755-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 01:53:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwRD8-0001gy-9b
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 01:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYKBAvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 20:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYKBAvd
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 20:51:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:13381 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYKBAvc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 20:51:32 -0400
Received: by nf-out-0910.google.com with SMTP id d3so777413nfc.21
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 17:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aL7L9tk5oeayR/UegIzO1TJRTIiWwqN4bNLsIvv7K8E=;
        b=rwG6n0f80j0z19n0dfKqM+mggCzNXAlMWQ1QJYkBtkBAUk/fypmBIwCqFRxVEoNma/
         ooWP51kIpMpN0HVlZAPSgDycaPP9nE0j7rSKqGMTXO87mvipcph180slFJFw5vZPPmuy
         ioHZGp2KEEJ364Hn8jsBSi+vY3COpo/BlIbaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CJ2f01JZHUdj31lbOvhzm+By9pDQMp+oJy8XIXrlH9cpP0ViztxeWZTlpwF+3Gufmq
         KfN1XcnPna67s1VB2c6b9EnG/jJJv/WDVsiSIUJp6Edo6ZtDiyRo0PHO4H4Byca4wijv
         jkXLsPyofCPyVjYSOH60FQHAf3Q+sgfThJthI=
Received: by 10.210.43.11 with SMTP id q11mr15694066ebq.51.1225587090792;
        Sat, 01 Nov 2008 17:51:30 -0700 (PDT)
Received: from ?192.168.1.11? (abvc198.neoplus.adsl.tpnet.pl [83.8.200.198])
        by mx.google.com with ESMTPS id 34sm27846952nfu.24.2008.11.01.17.51.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Nov 2008 17:51:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1224426270-27755-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99791>

On Sun, 19 Oct 2008, Giuseppe Bilotta wrote:

> The @snapshot_fmts array, containing the list of the supported snapshot
> formats, was recreated locally in three different routines (with the
> different name @supported_fmts in one of them).
> 
> Its local generation is particularly expensive because two of the
> callers, href() and format_snapshot_links(), are often called many times
> in a single page.
> 
> Simplify code and speed up page generation by making the array global.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Very good idea, although I'd prefer for this patch to come first;
it is not controversial contrary to other patches in this (sub)series
which IMHO needs some thought first.

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   21 ++++++++-------------
>  1 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 5fd5a1f..d1475b7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -748,6 +748,10 @@ if (defined $searchtext) {
>  our $git_dir;
>  $git_dir = "$projectroot/$project" if $project;
>  
> +# list of supported snapshot formats
> +our @snapshot_fmts = gitweb_check_feature('snapshot');
> +@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
> +
>  # dispatch
>  if (!defined $action) {
>  	if (defined $hash) {
> @@ -858,11 +862,7 @@ sub href (%) {
>  			# snapshot_format should always be defined when href()
>  			# is called, but just in case some code forgets, we
>  			# fall back to the default
> -			if (!$fmt) {
> -				my @snapshot_fmts = gitweb_check_feature('snapshot');
> -				@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
> -				$fmt = $snapshot_fmts[0];
> -			}
> +			$fmt ||= $snapshot_fmts[0];
>  			$href .= $known_snapshot_formats{$fmt}{'suffix'};
>  			delete $params{'snapshot_format'};
>  		}
> @@ -1695,8 +1695,6 @@ sub format_diff_line {
>  # linked.  Pass the hash of the tree/commit to snapshot.
>  sub format_snapshot_links {
>  	my ($hash) = @_;
> -	my @snapshot_fmts = gitweb_check_feature('snapshot');
> -	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  	my $num_fmts = @snapshot_fmts;
>  	if ($num_fmts > 1) {
>  		# A parenthesized list of links bearing format names.
> @@ -4898,20 +4896,17 @@ sub git_tree {
>  }
>  
>  sub git_snapshot {
> -	my @supported_fmts = gitweb_check_feature('snapshot');
> -	@supported_fmts = filter_snapshot_fmts(@supported_fmts);
> -
>  	my $format = $input_params{'snapshot_format'};
> -	if (!@supported_fmts) {
> +	if (!@snapshot_fmts) {
>  		die_error(403, "Snapshots not allowed");
>  	}
>  	# default to first supported snapshot format
> -	$format ||= $supported_fmts[0];
> +	$format ||= $snapshot_fmts[0];
>  	if ($format !~ m/^[a-z0-9]+$/) {
>  		die_error(400, "Invalid snapshot format parameter");
>  	} elsif (!exists($known_snapshot_formats{$format})) {
>  		die_error(400, "Unknown snapshot format");
> -	} elsif (!grep($_ eq $format, @supported_fmts)) {
> +	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
>  		die_error(403, "Unsupported snapshot format");
>  	}
>  
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
