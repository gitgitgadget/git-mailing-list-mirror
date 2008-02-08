From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use the config file to set repository owner's name.
Date: Fri, 08 Feb 2008 02:55:33 -0800 (PST)
Message-ID: <m3myqbhg4o.fsf@localhost.localdomain>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br>
	<1202445714-28971-2-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Git Managment for C3SL <git@git.c3sl.ufpr.br>
To: Bruno Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQtw-0004Fe-G6
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814AbYBHKzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757761AbYBHKzj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:55:39 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:22624 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757645AbYBHKzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:55:38 -0500
Received: by fk-out-0910.google.com with SMTP id z23so3419170fkz.5
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=tboQtfYyEXRO0m+dXE2C8ddHwFyXRfAcJ3dc52StYsM=;
        b=WDb5qEFiO5Hm6ZFMBioXRTLtFeV1IXDxkKvNtA9+C8XWotet/DFnGPEsYq1qqlfOoXX7N1F8OxG0rROkA4LAuPNn7d/0SgJ1FwDoUUQgFUSrb+rMTA1r8J1Yaak6oFirU8q7GSwQCsEjSPU4KPluVmErslK3uPw6vaszgPxZIQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=o6Qi2rMHjl445uNFv+yrTQ2DUnCemeye/oioAqc6uZdMY91xsxAe0N2troLCZyhkC9Sqtgc8HNgj6jNI3WNk3qaOQpUxQT0dNcOpPA816KdYMoRrOm+vuRyB1XhOB0XF+elviXxYzpParokWlPUs8UsT25eWPUw5gfUgSSKVCjg=
Received: by 10.78.183.8 with SMTP id g8mr22456897huf.55.1202468135549;
        Fri, 08 Feb 2008 02:55:35 -0800 (PST)
Received: from localhost.localdomain ( [83.8.242.186])
        by mx.google.com with ESMTPS id b33sm11849627ika.5.2008.02.08.02.55.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 02:55:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m18AtQqh027463;
	Fri, 8 Feb 2008 11:55:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m18AtKmC027460;
	Fri, 8 Feb 2008 11:55:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <1202445714-28971-2-git-send-email-ribas@c3sl.ufpr.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73072>

Bruno Ribas <ribas@c3sl.ufpr.br> writes:

> Allow to use configuration variable gitweb.owner set the repository owner,
> it checks the gitweb.owner, if not set it uses filesystem directory's owner.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8ef2735..e8a43b7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1767,7 +1767,12 @@ sub git_get_project_owner {
>  	if (exists $gitweb_project_owner->{$project}) {
>  		$owner = $gitweb_project_owner->{$project};
>  	}
> -	if (!defined $owner) {
> +
> +	if (!defined $owner){
> +		$owner = git_get_project_config('owner');
> +	}
> +
> +	if (!$owner) {
>  		$owner = get_file_owner("$projectroot/$project");
>  	}
>  

First, I think the empty lines added are not needed.

Second, git_get_project_config() subroutine _REQUIRES_ for $git_dir to
be set. So you have to set $git_dir before checking repo config; then
you can reuse $git_dir in checking file owner.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
