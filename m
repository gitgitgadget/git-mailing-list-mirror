From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: introduce localtime feature
Date: Thu, 17 Mar 2011 04:01:18 -0700 (PDT)
Message-ID: <m3d3lq57vw.fsf@localhost.localdomain>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost>
	<e272fa98ecab9d30edb4457e2e215688@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 12:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0AxM-00082Y-2c
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 12:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766Ab1CQLBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 07:01:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49950 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab1CQLBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 07:01:22 -0400
Received: by fxm17 with SMTP id 17so2556300fxm.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=zFzsYDyXj/HxgA+/Zo2tptr2gGk5AdIfhGLFvwelJx0=;
        b=buNmZOJsQGGcLtFn4pqcQgIy/aOS+RFF3rTo71Mm/+k/69Jd83F/Em0MZEtNyH8dmF
         MW8SY20mX+nyc9PoAPqXdtik6VSXCrzmDWY/8BIKj59CcTnxs/YXpEE04Z3oFmrQXAgX
         VTrjSSGBNTF+lBm7N2FGLuW7BgpPUHOxFoX8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=qHcbd06k32c/G8ll93EW/2JxDe7i227F9wfBTnjqfylGlbz3fMsv8ZopqJj/CeEOlT
         w9iCHvRt0iE9hNwHsLo8AelwaRm562TNeB1g74mT1c9wikfHH2leHkn6l2+NGQmM2fa+
         qHYhS0jTefRJ3JT26j8X+Apb4PFVvaFvtYZWI=
Received: by 10.223.6.11 with SMTP id 11mr98015fax.100.1300359679964;
        Thu, 17 Mar 2011 04:01:19 -0700 (PDT)
Received: from localhost.localdomain (aeho51.neoplus.adsl.tpnet.pl [79.186.196.51])
        by mx.google.com with ESMTPS id e23sm851982faa.18.2011.03.17.04.01.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 04:01:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2HB0pDh008199;
	Thu, 17 Mar 2011 12:01:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2HB0aKT008195;
	Thu, 17 Mar 2011 12:00:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <e272fa98ecab9d30edb4457e2e215688@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169234>

Kevin Cernekee <cernekee@gmail.com> writes:

> With this feature enabled, all timestamps are shown in the machine's
> local timezone instead of GMT.

This does not describe why would one want such way of displaying
timestamps, and which views would be affected.

BTW. should it be timezone of web server (machine where gitweb is
run), or local time of author / committer / tagger as described in the
timezone part of git timestamp?
 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  gitweb/gitweb.perl |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3b6a90d..d171ad5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -504,6 +504,12 @@ our %feature = (
>  		'sub' => sub { feature_bool('remote_heads', @_) },
>  		'override' => 0,
>  		'default' => [0]},
> +
> +	# Use localtime rather than GMT for all timestamps.  Disabled
> +	# by default.  Project specific override is not supported.
> +	'localtime' => {
> +		'override' => 0,
> +		'default' => [0]},

Why project specific override is not supported?  I think it might make
sense to enable this feature on project-by-project basis; some
projects might be dispersed geographically, some might not.

It is not as if this feature affect only non-project views, or doesn't
make sense on less that site-wide basis, like other nonoverridable
features.

>  );
>  
>  sub gitweb_get_feature {
> @@ -2927,6 +2933,12 @@ sub parse_date {
>  	$date{'iso-tz'} = sprintf("%04d-%02d-%02d %02d:%02d:%02d %s",
>  	                          1900+$year, $mon+1, $mday,
>  	                          $hour, $min, $sec, $tz);
> +
> +	if (gitweb_check_feature('localtime')) {
> +		$date{'rfc2822'}   = sprintf "%s, %d %s %4d %02d:%02d:%02d $tz",
> +				     $days[$wday], $mday, $months[$mon],
> +				     1900+$year, $hour ,$min, $sec;
> +	}

Is it still an RFC 2822 conformant date?  If it is not, then above
change is invalid, and we have to implement this feature in different
way.

>  	return %date;
>  }
>  
> @@ -3989,7 +4001,7 @@ sub git_print_authorship_rows {
>  		      "</td></tr>\n" .
>  		      "<tr>" .
>  		      "<td></td><td> $wd{'rfc2822'}";
> -		print_local_time(%wd);
> +		print_local_time(%wd) if !gitweb_check_feature('localtime');

Hmmm... I wonder if it wouldn't be better to print both times (perhaps
reversed) in this case...

>  		print "</td>" .
>  		      "</tr>\n";
>  	}
> -- 
> 1.7.4.1
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
