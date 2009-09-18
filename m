From: David Aguilar <davvid@gmail.com>
Subject: Re: Add compiled date to git --version output?
Date: Thu, 17 Sep 2009 22:03:52 -0700
Message-ID: <20090918050351.GA11242@gmail.com>
References: <544dda350909172117r44761577m11e7d30a1a5d0c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 07:04:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoVde-0007Eo-FX
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 07:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbZIRFD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 01:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755995AbZIRFD4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 01:03:56 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:60988 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbZIRFDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 01:03:55 -0400
Received: by an-out-0708.google.com with SMTP id d40so1195111and.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VrDj7sknfosdjFmH4pP/lqp24Vj0CS7F63MWio+Ycs8=;
        b=WHnvpgyojjNzI2eAyWtABjbLXSywxMh5h3v+SSlSZhYQqGdX1f/0Yoi0zUdVL2a33g
         8URf0X7/NaonSy2dRQi1AD5KvYAeGuB3KwSQZqOpwtP2YW82ruQ18u+IanM2sSRt6JB+
         aeRgm9pVU52PaMIJBN2oC3vlRnJZTKruz1bJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nEcJ4+RB2sXPTXEGHpn0t1oEtEIkeElIlwqlXPTQ/R2QG/NulI++Vs1ZtJM/x5nGGp
         IoShxJ+3LRx6ROZZmDXVyIuPiU/tdCm+wJ7AjkRZDGtFS5jRoSwS3OcPfq3o6mYTl/d8
         TREjsGfjuMiMMMhxkMu7XYmW/bFETflrFX0uk=
Received: by 10.101.63.20 with SMTP id q20mr959248ank.171.1253250239066;
        Thu, 17 Sep 2009 22:03:59 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d12sm72839and.18.2009.09.17.22.03.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 22:03:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544dda350909172117r44761577m11e7d30a1a5d0c91@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128783>

On Fri, Sep 18, 2009 at 12:17:48PM +0800, Nazri Ramliy wrote:
> Sometimes I wanted to know how outdated git is on my system.

	$ ls -la $(which git)


> Coming up with a script to parse "git --version" output to get the SHA1,
> and compare that to master's SHA1 seemed a little overkill compared to
> this:
> 
> diff --git a/help.c b/help.c
> index 294337e..bc83491 100644
> --- a/help.c
> +++ b/help.c
> @@ -361,6 +361,9 @@ const char *help_unknown_cmd(const char *cmd)
> 
>  int cmd_version(int argc, const char **argv, const char *prefix)
>  {
> -       printf("git version %s\n", git_version_string);
> +       printf("git version %s compiled %s %s\n",
> +                       git_version_string,
> +                       __DATE__,
> +                       __TIME__);
>         return 0;
>  }
> 
> With this, git --version gives:
> 
>         git version 1.6.5.rc1.19.g8426.dirty compiled Sep 18 2009 12:03:29
> 
> Thoughts?

For whatever it's worth, I would feel more comfortable if this
were guarded behind an option e.g. 'git version --date'.

I suspect that there are a fair number of scripts out there
parsing the output of 'git version'.  'git version' is not
plumbing but we still might want to avoid breaking them.

Is it better to say "compiled on $date" or "compiled $date"?

It's meant to be informational (aka not an actual English
sentence) so I guess it could go either way; "compiled on"
is a little more proper, though.

What about "born on $date" since it gives users a subliminal
suggestion that they should consider upgrading to a fresh git?
;)


-- 

	David
