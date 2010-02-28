From: Jakub Narebski <jnareb@gmail.com>
Subject: gitweb: Simple file based output caching TODO (was: Re: [RFC PATCHv3 00/10] gitweb: Simple file based output caching)
Date: Sun, 28 Feb 2010 03:54:49 +0100
Message-ID: <201002280354.51366.jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 03:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlZJ6-0004cW-8K
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 03:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967982Ab0B1Cyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 21:54:54 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:53437 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966874Ab0B1Cyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 21:54:53 -0500
Received: by fxm19 with SMTP id 19so1303871fxm.21
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 18:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=bJeIqwtuhpm/ngaQBZCcwMjcP7EgHFyJvB/tJH7RiEc=;
        b=tL3wei6/sQ1bltCKqRxh94Gletp9E/GERJ5JAB4MONr0Aqv39RIUmL/B/4mGXvdwlW
         h4waGk252lfc02NX7Vmr5Btj8XU/Vye9G19j7tLDNHLmUcrOxQzbWPQOtwu3RlzEcLlw
         53uca0CSG6iMaRfODRhJLtXptQxJso5g1WTC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=s4XlEDMxQOPmP+UZ4XF1NPGMCD/+nZjc5+k+hxk47j7YlzfZs5ePVPo8z1nNQ6YPPD
         eKN3//Np1a7gbBWXc+vw6qBmSW8ScCIbPp0859XEk/s1Slmk5kphuDXg0FuuDlU6ItRL
         J2Fu3ILe+YZoVgGzCHWgsgbwufC/oL0wCARlc=
Received: by 10.223.7.4 with SMTP id b4mr2902934fab.102.1267325691539;
        Sat, 27 Feb 2010 18:54:51 -0800 (PST)
Received: from ?192.168.1.13? (abwh107.neoplus.adsl.tpnet.pl [83.8.231.107])
        by mx.google.com with ESMTPS id 13sm1224285fxm.6.2010.02.27.18.54.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 18:54:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141240>

On Tue, 16 Feb 2010, Jakub Narebski wrote:
> This 10 patches long patch series is intended (yet) as preliminary version
> for splitting large 'gitweb: File based caching layer (from git.kernel.org)'
> mega-patch by John 'Warthog9' Hawley aka J.H., by starting small and
> adding features piece by piece.

[...]
> Shortlog:
> ~~~~~~~~~
> Jakub Narebski (10):
>   gitweb: href(..., -path_info => 0|1)
>   gitweb/cache.pm - Very simple file based cache
>   gitweb/cache.pm - Stat-based cache expiration
>   gitweb: Use Cache::Cache compatibile (get, set) output caching
>   gitweb/cache.pm - Adaptive cache expiration time
>   gitweb: Use CHI compatibile (compute method) caching
>   gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
>   gitweb/cache.pm - Serve stale data when waiting for filling cache
>   gitweb/cache.pm - Regenerate (refresh) cache in background
>   gitweb: Show appropriate "Generating..." page when regenerating cache

Here is the list of things that needs to be addressed in the future 
next (v4) version of this series, hopefully finally not an RFC.

* The caching engine (GitwebCache::SimpleFileCache) starts with default
  expire time of "never" (-1), while later it uses gitweb defaults when
  adaptive caching lifetime is added (20 / 1200 seconds).  This (slight)
  inconsistency should be fixed, either by using default of "never", or
  by using gitweb defaults for caching engine defaults in both patches:
    gitweb/cache.pm - Stat-based cache expiration
    gitweb/cache.pm - Adaptive cache expiration time

  Note that caching engine defaults are *independent* of gitweb's 
  defaults in %cache_options.

* Describe (better than it is now) in comments or in commit message
  why Temp::File is used for 'atomic write' _without_ locking (even
  when there might be more than one process (re)generating the same
  cache entry simultaneously).

* [improvement].  When using locking after
    gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
  it is ensured that only one process would (re)generate cache entry.
  Therefore Temp::File is not needed for temporary file; the temporary
  file can have constant name.  This should improve performance a bit.

  But this might be unnecessary complication.

* Show information about when page was generated in the footer always
  when caching is enabled; currently it is shown only if caching *and*
  'timed' feature is enabled 
    gitweb: Use Cache::Cache compatibile (get, set) output caching

* Actually check that using alternate caching engine works.  It can be
  done (what is described in gitweb/README) by setting $cache to either
  cache engine class (package) name, or to cache object (instantiated
  cache).

* [cleanup] Remove commented out alternate solutions (commented out
  code).

* Benchmark overhead of caching, and performance of caching, perhaps for
  different caching engines including original patch by J.H.

John, Pasky, do you have any further comments / requests?
-- 
Jakub Narebski
Poland
