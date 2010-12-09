From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 05/18] gitweb: Regression fix concerning binary output of files
Date: Thu, 09 Dec 2010 15:33:55 -0800 (PST)
Message-ID: <m339q634jx.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-6-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 00:34:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQpzu-0004MA-AW
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 00:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab0LIXd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 18:33:57 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:54840 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab0LIXd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 18:33:57 -0500
Received: by bwz16 with SMTP id 16so3349641bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 15:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=/NWPJ/zg6Gyt8chwv+45MqhH//D0AUBLhHxFgPfzFm4=;
        b=U+QdaZ7JxVJnXWLHcSJrHw0qbZNZUe6d5BuPuKgiAOO5x/NRdGamK9NQGZn/rkUKYT
         BXNkESMBen2zY5SAOCt8zKYlNDU0GqVijgvVvtEp01tq1O+9LxfPN9eVtTeaFilj7lwu
         Xuz5IWpaa6R0Srd+QCz4Q1wj8ltrpQBqdtNhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=CO1ytxh+Dw0WUBmPZ0PNXHreSW0t+1VZXj9Q1wLVemyXQPanXqP9i28ZNspWHxIERO
         NvL+sQXsDINhH6NhKe2xhnzDGdoPEKWrFMLn9GaiBpnHw1zP9+7krbGmPeKr/kSzL/nR
         SFuE2b8UmK0eQHTBCkLgenlBKP37s0SkEq3d0=
Received: by 10.204.72.130 with SMTP id m2mr96896bkj.15.1291937635814;
        Thu, 09 Dec 2010 15:33:55 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id b17sm1237947bku.20.2010.12.09.15.33.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 15:33:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB9NXNhv019741;
	Fri, 10 Dec 2010 00:33:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB9NX6bC019733;
	Fri, 10 Dec 2010 00:33:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-6-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163358>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This solves the regression introduced with v7.2 of the gitweb-caching code,
> fix proposed by Jakub in his e-mail.
> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3c3ff08..f2ef3da 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5664,7 +5664,7 @@ sub git_blob_plain {
>  	if ($caching_enabled) {
>  		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
>  	}else{
> -		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
> +		open BINOUT, '>&', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
>  	}
>  	binmode BINOUT, ':raw';
>  	print BINOUT <$fd>;

I'd rather you rebase on top of v7.4, where this issue was fixed in
different way... well, at least in easier to undertstand way (in the
solution used above one must know that if caching is disabled,
$fullhashbinpath is *STDOUT - and has nothing to do with any _path_).

This probably should be squashed, if using v7.4 is not chosen.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
