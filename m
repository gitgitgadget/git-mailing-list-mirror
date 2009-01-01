From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Handle actions with no project in evaluate_path_info
Date: Fri, 2 Jan 2009 00:58:29 +0100
Message-ID: <200901020058.30748.jnareb@gmail.com>
References: <a899d7ef0812272326j1a407c30k936bf8d8975c9063@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: "Devin Doucette" <devin@doucette.cc>
X-From: git-owner@vger.kernel.org Fri Jan 02 00:58:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXQq-0006kM-Uc
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 00:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373AbZAAX5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 18:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbZAAX5K
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 18:57:10 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:18147 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbZAAX5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 18:57:09 -0500
Received: by ey-out-2122.google.com with SMTP id 22so700534eye.37
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=h4DQ8rS8RVJJZ7FGaot91OdRHz0cyiBUXtPYvgcoQes=;
        b=Kdc4f/ZqLbaYBYqaGnW7Krx4cM/DQgmeLbWZcGQ6BRL9hX3CTSzhpU7dQCu8CT5Gsi
         xqqkZVOhwVS/LpgN4U2ypIYkhnGTuxtRtOdEbGjED+FchuCetqPQgGcrpI5FQgzVRxhF
         TqDUbgxGr03LQkeJObY+L8LtHMOWV2oZAhTOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rIGXnyBwf8JXtlYjZHacWmo3w41JgHuL5FT7o1rkYmtJW0TRJZWs2P0/nzSVnW+iVU
         u0Tf+z4l/wtPBHFgPcO12EMqe20gLdOGJyr8rHopuAFHyZ03s/r454EF+/STopEaXiJO
         BeqIWzLP9Z/xMTWmQgiP+0VGBg+RCry2NMUFY=
Received: by 10.210.59.3 with SMTP id h3mr20338594eba.87.1230854226175;
        Thu, 01 Jan 2009 15:57:06 -0800 (PST)
Received: from ?192.168.1.11? (abwl150.neoplus.adsl.tpnet.pl [83.8.235.150])
        by mx.google.com with ESMTPS id 28sm3239558eye.30.2009.01.01.15.56.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jan 2009 15:57:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <a899d7ef0812272326j1a407c30k936bf8d8975c9063@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104345>

On Sun, 28 Dec 2008, Devin Doucette wrote:

> The action would not be set if no valid project was found in
> path_info. Removing the return if the project was not specified fixes
> the project_index and opml actions when using path_info.
>

Thanks for catching this.

Truth to be told we parse action parameter in path_info only since
d8c2882 (gitweb: parse project/action/hash_base:filename PATH_INFO)
by Giuseppe Bilotta (CC-ed; I think he is correct person to give
Ack for this patch). Earlier only "default" actions could be expressed
using only path_info, and project-less 'opml' and 'project_index'
actions are not default actions for projectless URL, so there was no
such problem then.
 
> Signed-off-by: Devin Doucette <devin@doucette.cc>
> ---
>  gitweb/gitweb.perl |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8f574c7..b6a8ea9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -552,8 +552,7 @@ sub evaluate_path_info {
>  	while ($project && !check_head_link("$projectroot/$project")) {
>  		$project =~ s,/*[^/]*$,,;
>  	}
> -	return unless $project;
> -	$input_params{'project'} = $project;
> +	$input_params{'project'} = $project if $project;
> 
>  	# do not change any parameters if an action is given using the query string
>  	return if $input_params{'action'};
> -- 
> 1.6.1.rc4
> 

-- 
Jakub Narebski
Poland
