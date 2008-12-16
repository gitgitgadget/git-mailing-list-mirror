From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv4 2/3] gitweb: add patches view
Date: Tue, 16 Dec 2008 04:14:55 +0100
Message-ID: <200812160414.56486.jnareb@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com> <1228575755-13432-2-git-send-email-giuseppe.bilotta@gmail.com> <1228575755-13432-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 04:16:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCQQ4-0006yu-Pv
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 04:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYLPDPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 22:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbYLPDPE
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 22:15:04 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:39134 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYLPDPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 22:15:03 -0500
Received: by ewy10 with SMTP id 10so3441014ewy.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 19:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AAdTe7z8ivLtqDiR0vR4QocSl22+dAkBnepR+hRWFR4=;
        b=nnD9fC0ex0olZuj+DNS88/D85+H9NhktGo46KCiVAp4u6Ysd7cQlGuPc8tuBjl2MBG
         e4c6B4i4M6RAOzTwlXoOa/D6lDLFnT7WLwK/OEZrmRkU3ZLDZBZ542kL7A7HdYewVAVG
         VVDRcbcZTSfh7GPgy4397Hs7qGaLJs5/koFsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RkuuSShVoIZMVf+Sc/38f4CO4Xyf3G2HIX6dFG+4M479r/QQOlkObyFLB1MCz7fa1A
         1PsD9gp2X62C/zSDVAMOwaoiqCASfRMEtNfoq1yRwpvRgvsphK/LGJyMHL6L9v7aZrUK
         1KgS/wP6qX9rLU5VAl80pYtmCAXihDEiA0gYc=
Received: by 10.210.72.14 with SMTP id u14mr8666562eba.73.1229397301883;
        Mon, 15 Dec 2008 19:15:01 -0800 (PST)
Received: from ?192.168.1.11? (abve222.neoplus.adsl.tpnet.pl [83.8.202.222])
        by mx.google.com with ESMTPS id h4sm2260950nfh.62.2008.12.15.19.14.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 19:15:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1228575755-13432-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103237>

On Sat, 6 Dec 2008 16:02, Giuseppe Bilotta wrote:

> The only difference between patch and patches view is in the treatement
> of single commits: the former only displays a single patch, whereas the
> latter displays a patchset leading to the specified commit.

I like that fact that we have "patches" action which intent is to
show series of patches, and "patch" action which intent is to show
single patch. I'm just not sure if "patch" view should not simply
ignore $hash_parent...

Signoff?

> ---
>  gitweb/gitweb.perl |   20 ++++++++++++++++++--
>  1 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 71d5af4..dfc7128 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -525,6 +525,7 @@ our %actions = (
>  	"history" => \&git_history,
>  	"log" => \&git_log,
>  	"patch" => \&git_patch,
> +	"patches" => \&git_patches,
>  	"rss" => \&git_rss,
>  	"atom" => \&git_atom,
>  	"search" => \&git_search,
> @@ -5408,6 +5409,9 @@ sub git_blobdiff_plain {
>  
>  sub git_commitdiff {
>  	my $format = shift || 'html';
> +	# for patch view: should we limit ourselves to a single patch
> +	# if only a single commit is passed?
> +	my $single_patch = shift && 1;

What does this "shift && 1" does? Equivalent of "!!shift"?
Is it really needed?

Perhaps it would be better to use %opts trick, like for some other
gitweb subroutines (-single=>1, or -single_patch=>1, or -nmax=>1)?
Or perhaps not...

>  
>  	my $patch_max;
>  	if ($format eq 'patch') {
> @@ -5524,7 +5528,15 @@ sub git_commitdiff {
>  			}
>  			push @commit_spec, '-n', "$hash_parent..$hash";
>  		} else {
> -			push @commit_spec, '-1', '--root', $hash;
> +			if ($single_patch) {
> +				push @commit_spec, '-1';
> +			} else {
> +				if ($patch_max > 0) {
> +					push @commit_spec, "-$patch_max";
> +				}
> +				push @commit_spec, "-n";
> +			}
> +			push @commit_spec, '--root', $hash;

Nice.

>  		}
>  		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
>  			'--stdout', @commit_spec
> @@ -5620,7 +5632,11 @@ sub git_commitdiff_plain {
>  
>  # format-patch-style patches
>  sub git_patch {
> -	git_commitdiff('patch');
> +	git_commitdiff('patch', 1);
> +}
> +
> +sub git_patches {
> +	git_commitdiff('patch', 0);

I quite like it.

>  }
>  
>  sub git_history {
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
