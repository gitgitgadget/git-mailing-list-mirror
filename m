From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 04/11] gitweb: Create Gitweb::Config module
Date: Thu, 15 Jul 2010 23:21:46 +0200
Message-ID: <201007152321.47358.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-5-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 23:22:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZVsX-0008Pn-59
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 23:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934832Ab0GOVVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 17:21:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59984 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934799Ab0GOVVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 17:21:55 -0400
Received: by bwz1 with SMTP id 1so858091bwz.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=D3V2yDyE9EtB35s5UNytNmdYzaGXw45PA29M9qVr6Ws=;
        b=POxycR/Gs6oYi4VBtRo0dJpXQOmKfx2rYBNKkZQ4fI53+sUq9rU4hzP33O/HlTgDik
         hXGoEtoWm1PDqIKTRnrX0vEj6aW1BwVPuzOCGNfQh5VFLJKheJczA+gWVztfgs8Qvy7n
         26WOGX+VDZFlDwLUU8bPu7nmht6PGXw1AdDnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ey1jpQtEHb3cEVQDlhjntZWAS9lmQshgnTFCB5P2LSG9GTMDvl20NKx0gb9/sh87T3
         IeNQgnKf7D7pPMgHcL4BjKZhLwSLJ/67GctiNoYyM+HRBMhQgcVBB5T3f4SwnApF1RO/
         UF2tMctyQAlCUlkBYMw8YbWhjm/PEi/zCJ6MQ=
Received: by 10.204.34.2 with SMTP id j2mr212149bkd.21.1279228913305;
        Thu, 15 Jul 2010 14:21:53 -0700 (PDT)
Received: from [192.168.1.13] (abwm47.neoplus.adsl.tpnet.pl [83.8.236.47])
        by mx.google.com with ESMTPS id s34sm7658196bkk.1.2010.07.15.14.21.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 14:21:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-5-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151123>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create Gitweb::Config module in 'gitweb/lib/Gitweb/Config.pm'
> to store all the configuration variables and subroutines
> regarding the gitweb.perl script.
> 
> This module depends only on $git_dir from Gitweb::Git and
> includes the configuration related variables and
> subroutines (Including those required for configuration
> of gitweb features).

Here it might be worth noting that subroutines related to per-repository
config (feature_* subroutines) are not in this module, I guess because
of (inter)dependencies.

> 
> Subroutines moved:
> 	evaluate_gitweb_config
> 	configure_gitweb_features
> 	filter_snapshot_fmts
> 	gitweb_get_feature
> 	gitweb_check_feature
> 
> Update gitweb/Makefile to install Gitweb::Config module alongside gitweb
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---
>  gitweb/Makefile             |    1 +
>  gitweb/gitweb.perl          |  495 ++----------------------------------------
>  gitweb/lib/Gitweb/Config.pm |  498 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 522 insertions(+), 472 deletions(-)
>  create mode 100644 gitweb/lib/Gitweb/Config.pm
[...]

> -our $version = "++GIT_VERSION++";
> +# Only configuration variables with build-time overridable
> +# defaults are listed below. The complete set of variables
> +# with their descriptions is listed in Gitweb::Config.
> +$version = "++GIT_VERSION++";

Ah, I see that here you address (somewhat) the issue of moving
descriptions of build-time configuration variables out of gitweb.perl
into individual module(s).
  
[...]

Nice straight refactoring.   It's a pity that git-diff cannot show this
as code movement + some changes, like it would in the case of wholesame
file rename.

-- 
Jakub Narebski
Poland
