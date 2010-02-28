From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: Simple file based output caching TODO
Date: Sun, 28 Feb 2010 12:51:23 +0100
Message-ID: <201002281251.26520.jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com> <201002280354.51366.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 12:51:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlhgY-0006Gx-CE
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 12:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965319Ab0B1Lvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 06:51:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:61563 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab0B1Lvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 06:51:37 -0500
Received: by fg-out-1718.google.com with SMTP id d23so563435fga.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 03:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sLBBWAJJkzd+KTekZwQrvnLATzI6ggBlBeiO7MMbNdM=;
        b=GyAwJ7sbZoTlL1ItJ+jeSlgcV8cwxPVpwBMXT5PFEgZlfldg7C+/68ZceF3oDbCkLz
         /vWTVJLjRbuvajjhfjwdUN0/KOBEVO9WhgfdVxIjmeRrCkLTtt+JvUP89wb9zduG/TRm
         Q8yTvCxpIxH32Pgg8w3vsSKjYIm25uaqn2mls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AAtR6m2dAkF35RvzA13l/6G5DcZuTTMfUYqAa3Oi79jQTdNCU+ZRaQiQMdm15ssn13
         1SqRJJJSLDzWm5g74SgMzgjVg9PeSI9CStqjgrev93Ku+b3YSVdHQAXj1vvknhnWbOmp
         HOB1LQNSrIXx3gd2vpBPi4joLyKUXzu/2hGNw=
Received: by 10.87.47.3 with SMTP id z3mr4986946fgj.70.1267357895741;
        Sun, 28 Feb 2010 03:51:35 -0800 (PST)
Received: from ?192.168.1.13? (abwn28.neoplus.adsl.tpnet.pl [83.8.237.28])
        by mx.google.com with ESMTPS id e20sm7330442fga.10.2010.02.28.03.51.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Feb 2010 03:51:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201002280354.51366.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141248>

> Here is the list of things that needs to be addressed in the future 
> next (v4) version of this series, hopefully finally not an RFC.
> 
> * The caching engine (GitwebCache::SimpleFileCache) starts with default
>   expire time of "never" (-1), while later it uses gitweb defaults when
>   adaptive caching lifetime is added (20 / 1200 seconds).  This (slight)
>   inconsistency should be fixed, either by using default of "never", or
>   by using gitweb defaults for caching engine defaults in both patches:
>     gitweb/cache.pm - Stat-based cache expiration
>     gitweb/cache.pm - Adaptive cache expiration time
> 
>   Note that caching engine defaults are *independent* of gitweb's 
>   defaults in %cache_options.
> 
> * Describe (better than it is now) in comments or in commit message
>   why Temp::File is used for 'atomic write' _without_ locking (even
>   when there might be more than one process (re)generating the same
>   cache entry simultaneously).
> 
> * [improvement].  When using locking after
>     gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
>   it is ensured that only one process would (re)generate cache entry.
>   Therefore Temp::File is not needed for temporary file; the temporary
>   file can have constant name.  This should improve performance a bit.
> 
>   But this might be unnecessary complication.
> 
> * Show information about when page was generated in the footer always
>   when caching is enabled; currently it is shown only if caching *and*
>   'timed' feature is enabled 
>     gitweb: Use Cache::Cache compatibile (get, set) output caching
> 
> * Actually check that using alternate caching engine works.  It can be
>   done (what is described in gitweb/README) by setting $cache to either
>   cache engine class (package) name, or to cache object (instantiated
>   cache).
> 
> * [cleanup] Remove commented out alternate solutions (commented out
>   code).
> 
> * Benchmark overhead of caching, and performance of caching, perhaps for
>   different caching engines including original patch by J.H.

* Turn off 'blame_incremental' view (and links to it) when caching is
  enabled.  It doesn't make sense without support for "tee"-ing output
  in caching engine (or to be more exact in the output capturing
  engine), i.e. without printing output while capturing it.  

  Also currently it doesn't work anyway, for some reason.

* Check why git_generating_data_html, i.e. the "Generating..." 
  subroutine doesn't add '.' as activity indicator and fix it.
  Test if the trick employed by it works in other browsers.

-- 
Jakub Narebski
Poland
