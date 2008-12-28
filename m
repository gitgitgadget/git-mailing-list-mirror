From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix export check in git_get_projects_list
Date: Sun, 28 Dec 2008 03:12:01 +0100
Message-ID: <200812280312.02615.jnareb@gmail.com>
References: <a899d7ef0812270139u7dd28ee1q45a8c05f7c95db2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <petr.baudis@novartis.com>
To: "Devin Doucette" <devin@doucette.cc>
X-From: git-owner@vger.kernel.org Sun Dec 28 03:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGl8N-0004Jb-3f
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 03:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbYL1CKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 21:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbYL1CKo
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 21:10:44 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:35577 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbYL1CKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 21:10:43 -0500
Received: by ewy10 with SMTP id 10so4523344ewy.13
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 18:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZU9IteomGgflOS2fhUSA90W5n4jvRsDjzQAho5IQCPk=;
        b=w7J1Px4NoaXyHSM+uW7wzZACur5xqUDj/Ks7+5iYpft7W3CvXtbcmvuC6+mqGDeL0e
         RABpmjG1CPnprvLFA7iDg5SHF9qWh3AnpmS64cIDt7CdW/ESJR5fkPJRi+oI7Hyp6f9w
         5bUE9fa0GvGzgZFYISPvLtjsT5GpydJdlu8jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HZeapxbU7s0HjBvoMdhtcqxvSjFQRCZkZ/bguV4HrpUg170hX6cesq9deQvNsCEu/s
         rFBQz9Bh5q+AiFcExxb85aMiMBv6233VU0XzSgWBdlkAqun8F6QuwtVODi9c96znuMTq
         hlvtNVROu4Lu0rSBSUeJiD2Uwgjn7Xxcy7Acg=
Received: by 10.210.12.13 with SMTP id 13mr9738057ebl.93.1230430241566;
        Sat, 27 Dec 2008 18:10:41 -0800 (PST)
Received: from ?192.168.1.11? (abvb166.neoplus.adsl.tpnet.pl [83.8.199.166])
        by mx.google.com with ESMTPS id 23sm2348198eya.53.2008.12.27.18.10.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Dec 2008 18:10:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <a899d7ef0812270139u7dd28ee1q45a8c05f7c95db2f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104040>

On Sat, 27 Dec 2008, Devin Doucette wrote:

> When $filter was empty, the path passed to check_export_ok would
> contain an extra '/', which some implementations of export_auth_hook
> are sensitive to.
> 
> It makes more sense to fix this here than to handle the special case
> in each implementation of export_auth_hook.
> 
> Signed-off-by: Devin Doucette <devin@doucette.cc>

Good catch. Thanks.

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8f574c7..99f71b4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2147,8 +2147,9 @@ sub git_get_projects_list {
> 
>  				my $subdir = substr($File::Find::name, $pfxlen + 1);
>  				# we check related file in $projectroot
> -				if (check_export_ok("$projectroot/$filter/$subdir")) {
> -					push @list, { path => ($filter ? "$filter/" : '') . $subdir };
> +				my $path = ($filter ? "$filter/" : '') . $subdir;

Nice and clear, but wouldn't be better to use slightly more effective

+				my $path = $filter ? "$filter/$subdir" : $subdir;

Or even, taking care of the case when $filter eq '0'

+				my $path = defined $filter && $filter ne '' ? "$filter/$subdir" : $subdir;

> +				if (check_export_ok("$projectroot/$path")) {
> +					push @list, { path => $path };
>  					$File::Find::prune = 1;
>  				}
>  			},
> -- 
> 1.6.1.rc4
> 

-- 
Jakub Narebski
Poland
