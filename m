From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] t9501: Skip testing load if we can't detect it
Date: Sat, 06 Feb 2010 03:22:44 -0800 (PST)
Message-ID: <m3eikya9tn.fsf@localhost.localdomain>
References: <1265432440-52146-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 12:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndikf-00032l-FO
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 12:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab0BFLWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 06:22:55 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64879 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab0BFLWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 06:22:54 -0500
Received: by bwz19 with SMTP id 19so537810bwz.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 03:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wKCMUXIfUEoWad1WqfepQh8qdTJ1NxSfUYR731I3s0c=;
        b=LbjzlFr5joIWpcZmgjCxGHy2QpUvbx/mOMgoB2bUEOJkoolU4dWtzKJXNN7Fj9mDF0
         gdDJBgL6Rrjfn4KpGJgQGLfONnohWgqj9sZubnNlUIQm1XUmnu7Scpeq8Vr/3NtPZ89k
         +eBPVFALHvTVgm1KH35ehyOKXtQlzmOYTJ6M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=xDB5YRNMu0qUtlNpgy+7PBPCKuDaO6HPiG2To3YYJB1kRROINChdPiJDqD6VQXzItr
         1GORHPg4Eh1/DRk/M4Te510z123OQqpPuf3yC06Fq+P7ZPgzzLjxH24v3rXxRPM1Y66t
         ieRJrc3Xkq7cbKsJ5VUTQYypaqlq4DyZE0nJI=
Received: by 10.204.48.202 with SMTP id s10mr1179867bkf.34.1265455368274;
        Sat, 06 Feb 2010 03:22:48 -0800 (PST)
Received: from localhost.localdomain (abvb35.neoplus.adsl.tpnet.pl [83.8.199.35])
        by mx.google.com with ESMTPS id 15sm1068722bwz.4.2010.02.06.03.22.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 03:22:44 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o16BM4DT008583;
	Sat, 6 Feb 2010 12:22:15 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o16BLfkM008578;
	Sat, 6 Feb 2010 12:21:41 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1265432440-52146-1-git-send-email-brian@gernhardtsoftware.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139156>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> Currently gitweb only knows how to check for load using /proc/loadavg,
> which isn't available on all systems.  We shouldn't fail the test just
> because we don't know how to check the system load.
> 
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>

NAK.  It is not necessary, and it would be hindrance (one more place
to update) if we are to extend get_loadavg() in gitweb to work without
/proc/loadavg, e.g. via BSD::loadavg module.


Let me explain how it currently works without /proc/loadavg.  

First, load average is by definition non-negative number (>= 0).

Second, the get_loadavg() subroutine is written to be resilent and
robust, and it returns 0 if it can't get load average from system
(which _currently_ means no well-formatted /proc/loadavg file)

Third, the test (as you can see below in context line in quoted diff
below) forces gitweb to go over maximum load by setting $maxload to 0.
This means that regardless of true load, and regardless whether gitweb
can detect system load (remember that if it cant get system load it
returns 0 instead) gitweb would be in "load too high" situation.

> ---
>  t/t9501-gitweb-standalone-http-status.sh |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index 7590f10..992d729 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -115,12 +115,19 @@ test_debug 'cat gitweb.output'
>  # ----------------------------------------------------------------------
>  # load checking
>  
> +if test -e /proc/loadavg
> +then
> +	test_set_prereq PROC_LOADAVG
> +else
> +	say 'skipping load tests (no /proc/loadavg found)'
> +fi
> +
>  # always hit the load limit
>  cat >>gitweb_config.perl <<\EOF
>  our $maxload = 0;
>  EOF
>  
> -test_expect_success 'load checking: load too high (default action)' '
> +test_expect_success PROC_LOADAVG 'load checking: load too high (default action)' '
>  	gitweb_run "p=.git" &&
>  	grep "Status: 503 Service Unavailable" gitweb.headers &&
>  	grep "503 - The load average on the server is too high" gitweb.body
> -- 
> 1.7.0.rc1.141.gd3fd2
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
