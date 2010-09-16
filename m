From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/7] gitweb: link heads and remotes view
Date: Fri, 17 Sep 2010 01:02:22 +0200
Message-ID: <201009170102.23053.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 01:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwNTQ-00033F-C4
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 01:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab0IPXCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 19:02:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38424 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab0IPXCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 19:02:30 -0400
Received: by bwz11 with SMTP id 11so2098400bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hTqRGAPziFSfnmIbnOy7CIlLdO37QO8f3TdzR9xzqtQ=;
        b=sRDSGX5VMI9fXPvEG+43LGPcWInVNL8kTZOF2T7GKuiqFGhRmk5Y2JD8MIXPLX65a3
         HB05px2Nw78TRvxmsVe35xfnoRx7O/QTzNLKIVdeH3WSbCaqkfFFbueB8F6pyKWEMsw3
         yvnffplkHBwR2VIwRMaNfYWXoUHf3Ojrm6J4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vvEpaPbvY2Z/+crEd9Yx5IRpgWlrHK/QnEVonDiI/m+wMN4R9klmYvQVbgHXjYiQe8
         QkVBfPgaQ+7dTISvuK4b0Cr8tjfmQ6Ag51e3Rjfs3Okj8JWD9zFrciCIOlIafw4wLoEV
         iqADd84+S2Scmn3DErOZfzLRZChVHkwQH6CE4=
Received: by 10.204.163.69 with SMTP id z5mr3042499bkx.167.1284678148782;
        Thu, 16 Sep 2010 16:02:28 -0700 (PDT)
Received: from [192.168.1.13] (abvm37.neoplus.adsl.tpnet.pl [83.8.210.37])
        by mx.google.com with ESMTPS id f10sm2971223bkl.5.2010.09.16.16.02.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 16:02:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1284629465-14798-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156361>

On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> Add a link in heads view to remotes view (if the feature is
> enabled), and conversely from remotes to heads.

Good idea... but this commit message doesn't tell us *where* this link
do appear.  It is in lower part (the action specific part) of page
navigation menu.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0118739..6138c6e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5511,7 +5511,10 @@ sub git_tags {
>  sub git_heads {
>  	my $head = git_get_head_hash($project);
>  	git_header_html();
> -	git_print_page_nav('','', $head,undef,$head);
> +	my $heads_nav = gitweb_check_feature('remote_heads') ?
> +		$cgi->a({-href => href(action=>"remotes", -replay=>1)},
> +		        "remotes") : undef;

I think it would be more readable here to use 'if' statement instead
of conditional operator.

> +	git_print_page_nav('','', $head,undef,$head, $heads_nav);
>  	git_print_header_div('summary', $project);
>  
>  	my @headslist = git_get_heads_list(undef, 'heads');
> @@ -5527,7 +5530,10 @@ sub git_remotes {
>  
>  	my $head = git_get_head_hash($project);
>  	git_header_html();
> -	git_print_page_nav('','', $head,undef,$head);
> +	my $heads_nav =
> +		$cgi->a({-href => href(action=>"heads", -replay=>1)},
> +		        "heads");
> +	git_print_page_nav('','', $head,undef,$head, $heads_nav);
>  	git_print_header_div('summary', $project);
>  
>  	my @remotelist = git_get_heads_list(undef, 'remotes');
> -- 
> 1.7.3.rc1.230.g8b572
> 
> 

-- 
Jakub Narebski
Poland
