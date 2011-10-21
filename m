From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix regression when filtering out forks
Date: Fri, 21 Oct 2011 22:51:18 +0200
Message-ID: <201110212251.18810.jnareb@gmail.com>
References: <1319223861-10803-1-git-send-email-jm@jmuchemb.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julien Muchembled <jm@jmuchemb.eu>
X-From: git-owner@vger.kernel.org Fri Oct 21 22:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHM43-0007Gy-39
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 22:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab1JUUv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 16:51:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45206 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab1JUUv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 16:51:28 -0400
Received: by eye27 with SMTP id 27so4227987eye.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=yNOk4zSo++pr5xTMfze6wQJE4fKRaGca/tvw9t0jzn0=;
        b=TF/c5pvEKh+gqprjeMby5VZdvxrpazWP6VyLuayip+3hT79Kd+vLEbyoOg46/v49GV
         9AN7+nQP5U55ozYj+FnFjCdYbafXE/7zovj4EJLb3ytSBSjsoQ0LsKvFS/OOtjvQ8tGA
         mYEzJ++oV+cZoiqtKhSsWZT5DXG4J5jKvME2s=
Received: by 10.223.76.24 with SMTP id a24mr17418682fak.31.1319230287180;
        Fri, 21 Oct 2011 13:51:27 -0700 (PDT)
Received: from [192.168.1.13] (abwe57.neoplus.adsl.tpnet.pl. [83.8.228.57])
        by mx.google.com with ESMTPS id o16sm24177288fag.21.2011.10.21.13.51.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 13:51:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1319223861-10803-1-git-send-email-jm@jmuchemb.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184085>

On Fri, 21 Oct 2011, Julien Muchembled wrote:

> This fixes a condition in filter_forks_from_projects_list that failed if
> process directory was different from project root: in such case, the subroutine
> was a no-op and forks were not detected.
> 
> Signed-off-by: Julien Muchembled <jm@jmuchemb.eu>

Thanks.

I am embarrassed that I missed this; in the test I have added $projectroot
_is_ current directory for script.  Anyway I have tested this in running
local installation on testsuite, and it now works (i.e. hide forks under
"+" character, where it would not before - gitweb shown every project).

Tested-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 70a576a..206e2a6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2875,7 +2875,7 @@ sub filter_forks_from_projects_list {
>  		$path =~ s/\.git$//;      # forks of 'repo.git' are in 'repo/' directory
>  		next if ($path =~ m!/$!); # skip non-bare repositories, e.g. 'repo/.git'
>  		next unless ($path);      # skip '.git' repository: tests, git-instaweb
> -		next unless (-d $path);   # containing directory exists
> +		next unless (-d "$projectroot/$path"); # containing directory exists
>  		$pr->{'forks'} = [];      # there can be 0 or more forks of project
>  
>  		# add to trie
> -- 

-- 
Jakub Narebski
Poland
