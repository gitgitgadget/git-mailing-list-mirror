From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Use &#160; instead of &nbsp; for XHTML compliance
Date: Wed, 15 Apr 2009 17:55:04 +0200
Message-ID: <200904151755.07425.jnareb@gmail.com>
References: <20090415154012.GX13966@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ricky Zhou <ricky@fedoraproject.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 17:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7Ql-0007pP-Gd
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 17:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbZDOPwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 11:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbZDOPwI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 11:52:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:36906 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbZDOPwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 11:52:07 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1600902wah.21
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7mxjXmUeyo8O22cWtA4n3oUD04aLPAWMOJExiJvi3Pw=;
        b=mxQpcOAIB6CSCXTTjCl4QowcAspZeDXbkzYB04gTiOkkGK9BL80gBxGbJvhqVAlr4X
         tyCRYHkgMuhDilvecCGOrZRGrFyR2KFn7tFqiCdjI1gk8G9t476OXpceN4fRPg81vDPY
         yNjcz3tVQfxP0UxjOWZ1yP2ZnrhyzkVqobX8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aYllt5UjBIubvQne9Axs+D8paQZb9lZYxYhYIC3Q0pM+v7yOh64bOxNTg4uHR8tEXU
         xroa6JjnBShT8SEMgBSo5VdLBOdsBqcF7l/2NNdaSOHJEqSr9WVBQQ6B5PatxEYF+6kZ
         B/GRYBnWQABYu8bWkz5N51lpv4UYkWhIb8Da0=
Received: by 10.114.39.16 with SMTP id m16mr127518wam.147.1239810726749;
        Wed, 15 Apr 2009 08:52:06 -0700 (PDT)
Received: from ?192.168.1.13? (abws179.neoplus.adsl.tpnet.pl [83.8.242.179])
        by mx.google.com with ESMTPS id v9sm9150966wah.60.2009.04.15.08.52.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 08:52:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090415154012.GX13966@inocybe.teonanacatl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116617>

On Wed, 15 April 2009, Todd Zullinger wrote:

> From: Ricky Zhou <ricky@fedoraproject.org>
> ---
> 
> This was noticed by the Fedora Infrastructure folks.  The pages
> rendered fine in Firefox, but caused an XML error when run through tor
> and privoxy together.  Part of this problem description may belong in
> the commit message -- I was hesitant to add it, as I didn't read all
> of the IRC log where the problem was noticed and debugged.

Wouldn't it be a better solution to add DTD with HTML entities if/when
gitweb serves XHTML 1.0 together application/xhtml+xml mimetype, instead
of unconditionally using what is I think worse solution? Especially that
error is I think quite rare situation and/or bug in browser...

I also don't think that the change -nbsp => -subspaces is necessary;
it causes large code churn for nothing, and name is IMVHO worse.
It is about nonbreakable and non-compactable space.

> 
>  gitweb/gitweb.perl |   40 ++++++++++++++++++++--------------------
>  1 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 33ef190..55b56f7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1042,8 +1042,8 @@ sub esc_html ($;%) {
>  
>  	$str = to_utf8($str);
>  	$str = $cgi->escapeHTML($str);
> -	if ($opts{'-nbsp'}) {
> -		$str =~ s/ /&nbsp;/g;
> +	if ($opts{'-subspaces'}) {
> +		$str =~ s/ /&#160;/g;
>  	}
>  	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
>  	return $str;

-- 
Jakub Narebski
Poland
