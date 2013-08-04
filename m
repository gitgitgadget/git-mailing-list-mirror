From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH 2/3] hooks/post-receive-email: force log messages in UTF-8
Date: Sun, 4 Aug 2013 18:54:48 +0400
Message-ID: <20130804145448.GA15097@dell-note>
References: <20130802232118.GB2963@elie.Belkin>
 <20130802232338.GD2963@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Alexander Gerasiov <gq@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 16:54:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5zhx-0001iZ-7S
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 16:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab3HDOyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 10:54:53 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35911 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab3HDOyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 10:54:52 -0400
Received: by mail-lb0-f172.google.com with SMTP id o7so1506500lbv.31
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=K5LBC4IPM+FmBYHt+jOydsJTbrKh+hVKu1OOMn0e6h8=;
        b=kTGLi3b62au7hai0teVhEt9beo6B/gRJ1x6DAXxo24Xqoy6qhW9ayg4RVriCXjPoPi
         x1HgD6/AMss+/yn8CLviIR7cqqvGGVRcl7ZEw65GCLmKDgw/YFNGPnox4uDu/8cPX/1l
         BBBMkusqFMb0uyzwz2hwTVHIqDBBtrMTzChFISZ0/V5wlRRajuMPPshtJs3e4Wcb3XOU
         C8h0bFuOS/UOjPbTOP5mdB6Ct4wvdooq7H0wWojVGvg3pMZMAmZZKchN5d0HlkYb8sa0
         vwKrkssouPKzzEEWE1ixVxue8iCbgu1WODn5AD7RKNeE8JvBGW+Hh+DbzrDnjTyRsyZ2
         Fs4A==
X-Received: by 10.152.21.34 with SMTP id s2mr6797695lae.55.1375628090865;
        Sun, 04 Aug 2013 07:54:50 -0700 (PDT)
Received: from localhost (ppp91-77-30-85.pppoe.mtu-net.ru. [91.77.30.85])
        by mx.google.com with ESMTPSA id 8sm7163650lbq.4.2013.08.04.07.54.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Aug 2013 07:54:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130802232338.GD2963@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231632>

On Fri, Aug 02, 2013 at 04:23:38PM -0700, Jonathan Nieder wrote:
> Git commands write commit messages in UTF-8 by default, but that
> default can be overridden by the [i18n] commitEncoding and
> logOutputEncoding settings.  With such a setting, the emails written
> by the post-receive-email hook use a mixture of encodings:
> 
>  1. Log messages use the configured log output encoding, which is
>     meant to be whatever encoding works best with local terminals
>     (and does not have much to do with what encoding should be used
>     for email)
> 
>  2. Filenames are left as is: on Linux, usually UTF-8, and in the Mingw
>     port (which uses Unicode filesystem APIs), always UTF-8
I cannot say exactly if it makes sense for THIS patch, but I'd like to
remind about Cygwin port, which definitely does not use UTF-8 encoding
(in my case it is Windows-1251) for filenames.
> 
>  3. The "This is an automated email" preface uses a project description
>     from .git/description, which is typically in UTF-8 to support
>     gitweb.
> 
> So (1) is configurable, and (2) and (3) are unconfigurable and
> typically UTF-8.  Override the log output encoding to always use UTF-8
> when writing the email to get the best chance of a comprehensible
> single-encoding email.
I cannot agree to receive e-mails in UTF-8 only for Windows projects
which have non-UTF-8 encoding. I want to see and read correctly formed
e-mail without any corrupted symbols instead of filenames (that is the
main problem here as far as filenames are not converted unlike log
messages)
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  contrib/hooks/post-receive-email | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 72084511..ba93a0d8 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -471,7 +471,7 @@ generate_delete_branch_email()
>  	echo "       was  $oldrev"
>  	echo ""
>  	echo $LOGBEGIN
> -	git diff-tree -s --always --pretty=oneline $oldrev
> +	git diff-tree -s --always --encoding=UTF-8 --pretty=oneline $oldrev
>  	echo $LOGEND
>  }
>  
> @@ -571,7 +571,7 @@ generate_delete_atag_email()
>  	echo "       was  $oldrev"
>  	echo ""
>  	echo $LOGBEGIN
> -	git diff-tree -s --always --pretty=oneline $oldrev
> +	git diff-tree -s --always --encoding=UTF-8 --pretty=oneline $oldrev
>  	echo $LOGEND
>  }
>  
> @@ -617,7 +617,7 @@ generate_general_email()
>  	echo ""
>  	if [ "$newrev_type" = "commit" ]; then
>  		echo $LOGBEGIN
> -		git diff-tree -s --always --pretty=medium $newrev
> +		git diff-tree -s --always --encoding=UTF-8 --pretty=medium $newrev
>  		echo $LOGEND
>  	else
>  		# What can we do here?  The tag marks an object that is not
> @@ -636,7 +636,7 @@ generate_delete_general_email()
>  	echo "       was  $oldrev"
>  	echo ""
>  	echo $LOGBEGIN
> -	git diff-tree -s --always --pretty=oneline $oldrev
> +	git diff-tree -s --always --encoding=UTF-8 --pretty=oneline $oldrev
>  	echo $LOGEND
>  }
>  
> -- 
> 1.8.4.rc1
> 

-- 
Alexey Shumkin
