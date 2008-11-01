From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATHv2 7/8] gitweb: embed snapshot format parameter in PATH_INFO
Date: Sat, 1 Nov 2008 01:18:13 +0100
Message-ID: <200811010118.14191.jnareb@gmail.com>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com> <1224426270-27755-1-git-send-email-giuseppe.bilotta@gmail.com> <1224426270-27755-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:19:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4DI-0005MX-IF
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 01:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYKAASX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 20:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbYKAASX
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 20:18:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:57654 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbYKAASW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 20:18:22 -0400
Received: by nf-out-0910.google.com with SMTP id d3so674367nfc.21
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Nqps4FC9VVBC6rLicMNvm1G4/ujD3oNQtUAIfopeyn4=;
        b=SBVlEDUCeHsMyveD4quguQVWmgy1qgWqiDd4TdiW8MUanLmcn23VfKjpyWNB9T43Mo
         yOnyDu933AtZRTN0CT9GAvZ4p6IDPaxxMPbHZURbxZzbx5Vq7wxCctZC/W8fyMUCXSRT
         U2D1CcJVn7yBeynLuRD762hj/CWljgJ9cXAsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rEQJfD4ubeecU6ipqyPc+xyWnqlLV3nFtnnfWHsqHvFOx0bLpf9oNRBVnvr7Qo7heh
         d6Gmp+Mv8vzgC2fuevRHW1IxIo2pXYCxViwpMuBnhB6PWTTVssjwPh2Ru1vAOKxgieiM
         eKSoxnSo7fQMUuAF465yY9Pfsm5EgC/6tHjH4=
Received: by 10.210.81.3 with SMTP id e3mr5167313ebb.112.1225498700293;
        Fri, 31 Oct 2008 17:18:20 -0700 (PDT)
Received: from ?192.168.1.11? (abwk207.neoplus.adsl.tpnet.pl [83.8.234.207])
        by mx.google.com with ESMTPS id 23sm4882720eya.7.2008.10.31.17.18.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 17:18:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1224426270-27755-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99689>

On Sun, 19 Oct 2008, Giuseppe Bilotta wrote:

I'm sorry for the delay.

> When PATH_INFO is active, get rid of the sf CGI parameter by embedding
> the snapshot format information in the PATH_INFO URL, in the form of an
> appropriate extension.

The question is: should we use format suffix (e.g. 'tar.gz'),
or format name (e.g. 'tgz')?  The latter is later easier to parse,
see comments to first patch in better snapshot support for path_info.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e9e9e60..5fd5a1f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -795,6 +795,7 @@ sub href (%) {
>  		#   - action
>  		#   - hash_parent or hash_parent_base:/file_parent
>  		#   - hash or hash_base:/file_name
> +		#   - the snapshot_format as an appropriate suffix
>  
>  		# When the script is the root DirectoryIndex for the domain,
>  		# $href here would be something like http://gitweb.example.com/

Good.

> @@ -806,6 +807,10 @@ sub href (%) {
>  		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
>  		delete $params{'project'};
>  
> +		# since we destructively absorb parameters, we keep this
> +		# boolean that remembers if we're handling a snapshot
> +		my $is_snapshot = $params{'action'} eq 'snapshot';
> +

Side note: we destructively absorb parameters, because parameters
which are not absorbed are then used to generate query string part
of URL.

Deleting parameter but remembering the fact that it was used is one
(but not only) solution.

>  		# Summary just uses the project path URL, any other action is
>  		# added to the URL
>  		if (defined $params{'action'}) {
> @@ -845,6 +850,22 @@ sub href (%) {
>  			$href .= esc_url($params{'hash'});
>  			delete $params{'hash'};
>  		}
> +
> +		# If the action was a snapshot, we can absorb the
> +		# snapshot_format parameter too
> +		if ($is_snapshot) {
> +			my $fmt = $params{'snapshot_format'};
> +			# snapshot_format should always be defined when href()
> +			# is called, but just in case some code forgets, we
> +			# fall back to the default

> +			if (!$fmt) {
> +				my @snapshot_fmts = gitweb_check_feature('snapshot');
> +				@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
> +				$fmt = $snapshot_fmts[0];
> +			}

I anderstand that the above code is improved with new patch?

> +			$href .= $known_snapshot_formats{$fmt}{'suffix'};

Again: should we use snapshot prefix, or snapshot name, which means here
do we use $known_snapshot_formats{$fmt}{'suffix'}; or just $fmt; ?

> +			delete $params{'snapshot_format'};
> +		}
>  	}
>  
>  	# now encode the parameters explicitly
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
