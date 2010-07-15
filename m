From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 03/11] gitweb: Create Gitweb::Git module
Date: Thu, 15 Jul 2010 22:13:27 +0200
Message-ID: <201007152213.27998.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-4-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 22:13:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZUoR-0007qk-0U
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 22:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934636Ab0GOUNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 16:13:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38427 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934633Ab0GOUNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 16:13:35 -0400
Received: by fxm14 with SMTP id 14so680010fxm.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VpIDmqSO7vAYIk/ZYYWHc7TkcpJFTcFjloSCMAOdSg8=;
        b=dIlJrFJ8iXTLS3EkOLS/SmM7NLdxEXCKt8n6+8aOcfPZ2XJWBzyLaiV3vwtq9dIQNo
         KjRODxFU/6kfQGDF4SSvnOJm3oNZntCVBakoyrGJb9ZcZQHIAPkj/SmZSlApp+zaumWk
         LH8ChF6nySry/1N7rlpnEo4rbyynpEmoAzdJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aTIFozaEPj01ENpUgiQIHSRujuqYbqa5EZTrvSLFRLclzk3JYCMCULP0auRszPhfka
         FehKP/exhfvmI/Iz2qtmD1+3MVRde4GAWcBRttr4VImN6Hnep3UTqu1rGt2duNl7ix0h
         nASd1rZ/ZZYBXW9qNCwwRw7kMZ2y9NMDtz1vA=
Received: by 10.86.77.19 with SMTP id z19mr297081fga.3.1279224814434;
        Thu, 15 Jul 2010 13:13:34 -0700 (PDT)
Received: from [192.168.1.13] (abwm47.neoplus.adsl.tpnet.pl [83.8.236.47])
        by mx.google.com with ESMTPS id r2sm453562faq.28.2010.07.15.13.13.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 13:13:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-4-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151120>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create a Gitweb::Git module in  'gitweb/lib/Gitweb/Git.pm'
> to deal with running git commands (and also processing output
> of git commands with external programs) from gitweb.
> 
> This module is intended as standalone module, which does not require
> (include) other gitweb' modules to avoid circular dependencies.  That
> is why it includes $GIT variable, even though this variable is
> configured during building gitweb.  On the other hand $GIT is more
> about git configuration, than gitweb configuration.
> 
> Subroutines moved:
> 	evaluate_git_version
> 	git_cmd
> 	quote_command
> 
> Update gitweb/Makefile to install Gitweb::Git module alongside gitweb
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

This change (this refactoring) is fairly uncontroversial...

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
[...]
> -# core git executable to use
> -# this can just be "git" if your webserver has a sensible PATH
> -our $GIT = "++GIT_BINDIR++/git";
> +# $GIT is from Gitweb::Git
> +$GIT = "++GIT_BINDIR++/git";

[...]
> +# core git executable to use
> +# this can just be "git" if your webserver has a sensible PATH
> +our $GIT;

...but for addressing the discussion about whether to put (or rather
leave) description of $GIT variable in main gitweb/gitweb.perl script,
to have description of all build-time configuration variables in one
place.  You should at least say something about this issue either in
commit message, or in the comments for this patch, in my opinion.

-- 
Jakub Narebski
Poland
