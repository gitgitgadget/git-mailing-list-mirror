From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Changed gitweb.remote_heads config key name to gitweb.remoteHeads.
Date: Thu, 7 Jul 2011 20:56:24 +0200
Message-ID: <201107072056.25417.jnareb@gmail.com>
References: <1310061739-4441-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 20:56:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qetkd-0003tZ-Fi
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 20:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab1GGS4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 14:56:34 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:55615 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab1GGS4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 14:56:33 -0400
Received: by fxd18 with SMTP id 18so1343029fxd.11
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=VFDJpv2iRahwCztTNZEH4XX9/ACdT7JDvoWH5exFbws=;
        b=MRfLuMbxkVMXvR9BlgAV0aDTjUwhB85hKADSNTbXEmvOAiQ5zv+6Y1gZ10gnT/5N5U
         xPUm8KVCi/yEz5l272aYIq6gBpBCcTP1TPEWk6JMhWjru0GTvTrhosyckdzRTej861O6
         pVgSUxGCYna7VLcK16apYu+eAZm/Dt7uBLhxc=
Received: by 10.223.28.65 with SMTP id l1mr1675362fac.136.1310064992579;
        Thu, 07 Jul 2011 11:56:32 -0700 (PDT)
Received: from [192.168.1.15] (abwq132.neoplus.adsl.tpnet.pl [83.8.240.132])
        by mx.google.com with ESMTPS id n27sm6871062faa.28.2011.07.07.11.56.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 11:56:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1310061739-4441-1-git-send-email-marcnarc@xiplink.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176769>

On Thu, 7 Jul 2011, Marc Branchaud wrote:

> Git doesn't accept config key names with underscore characters.

Hmmm... that is strange.  Git accepts '-' (though it is discouraged)
but not '_' in config key names.

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

With the caveat that included patch must be applied first,
see below.

> ---
> 
> Came across this today.  The patch is RFC because I have not verified 
> if it's complete or if gitweb even respects the setting.
> 
>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 81dacf2..edbb080 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -524,9 +524,9 @@ our %feature = (
>  	# $feature{'remote_heads'}{'default'} = [1];
>  	# To have project specific config enable override in $GITWEB_CONFIG
>  	# $feature{'remote_heads'}{'override'} = 1;
> -	# and in project config gitweb.remote_heads = 0|1;
> +	# and in project config gitweb.remoteHeads = 0|1;

Key names are case insensitive...

>  	'remote_heads' => {
> -		'sub' => sub { feature_bool('remote_heads', @_) },
> +		'sub' => sub { feature_bool('remoteHeads', @_) },

...but git_get_project_config didn't respect that.  With above, and
without included patch, gitweb would get from "git config --list -z"
'gitweb.remoteheads' (turned lowercase), but as it is written here
it would check if 'gitweb.remoreHeads' key exists... so it would
never match.

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Date: Thu, 7 Jul 2011 20:48:50 +0200
Subject: [PATCH] gitweb: Make git config search case insensitive

Gitweb does not (yet?) use git config variables with subsection, so we
can simply lowercase $key in git_get_project_config: section name and
key name are case insensitive (only subsection name is case
sensitive).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 589c85b..59147b6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2526,6 +2526,7 @@ sub git_get_project_config {
 
 	# key sanity check
 	return unless ($key);
+	$key = lc($key); # assuming there is no subsection
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-- 
1.7.5
