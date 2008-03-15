From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Sat, 15 Mar 2008 14:44:42 -0700 (PDT)
Message-ID: <m3ve3nwtl3.fsf@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Mar 15 22:45:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaeBz-0003e4-Vr
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 22:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYCOVor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 17:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbYCOVor
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 17:44:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:15094 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbYCOVop (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 17:44:45 -0400
Received: by fg-out-1718.google.com with SMTP id l27so880845fgb.17
        for <git@vger.kernel.org>; Sat, 15 Mar 2008 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=/GRwzEpGrT1b9ReDgDi9/Q4Xe1tJMI5WYJNYL4fFEgw=;
        b=VoP0HYKUwTdBHDin9uoW7T8075lUP1puMi0r09AAI3iJmFcbgJP/wz2z71nubjeWeqHDJkLePtTEZrSScJaX643rxiU9qvhTD4LTIUsOSQ+TcfzxJ7tKlQc5GgLUT1TKJCD17RWGBchKx+0sKLiLSF3AdnxD1qsEIBCqpajveNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=XP9aAX1EoAbHsaF1qHNLf8oaOL4JBg0DtNh0UFqeJGcYqxBuJybODmfUmWZfi8xcFqA3lBDnENkA9IMZajG8lMuSMrEXxdT78L/DWHi8nEkYwlVC+0nHVpa9ck4oYZPDkm7T+lxl0dD/89ieuv5O5cZkv3ImQR1381IKKnMyPpA=
Received: by 10.86.80.5 with SMTP id d5mr12163455fgb.57.1205617484012;
        Sat, 15 Mar 2008 14:44:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.193.189])
        by mx.google.com with ESMTPS id 4sm16850957fgg.4.2008.03.15.14.44.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Mar 2008 14:44:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2FLiklp008624;
	Sat, 15 Mar 2008 22:44:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2FLiOuG008620;
	Sat, 15 Mar 2008 22:44:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080313231413.27966.3383.stgit@rover>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77341>

Petr Baudis <pasky@suse.cz> writes:

> On repo.or.cz (permanently I/O overloaded and hosting 1050 project +
> forks), 

It looks like repo.or.cz is overwhelmed by its success. I hope that
now that there are other software hosting sites with git hosting
(Savannah, GitHub, Gitorious,...) the number of projects wouldn't grow
as rapidly.

> the projects list (the default gitweb page) can take more than
> a minute to generate. This naive patch adds simple support for caching
> the projects list data structure so that all the projects do not need
> to get rescanned at every page access.

Another solution would be to divide projects list page into pages,
perhaps adding search box for searching for a project (by name, by
description and by owner).

Nevertheless even with pagination, if we want to have "sort by last
update" we do need caching.

[...]
> +# projects list cache for busy sites with many projects;
> +# if you set this to non-zero, it will be used as the cached
> +# index lifetime in minutes
> +# the cached list version is stored in /tmp and can be tweaked
> +# by other scripts running with the same uid as gitweb - use this
> +# only at secure installations; only single gitweb project root per
> +# system is supported!
> +our $projlist_cache_lifetime = 0;

[...]
> +sub git_project_list_body {
[...]
> +	my $cache_file = '/tmp/gitweb.index.cache';
> +	use File::stat;
> +
> +	my @projects;
> +	my $stale = 0;
> +	if ($cache_lifetime and -f $cache_file
> +	    and stat($cache_file)->mtime + $cache_lifetime * 60 > time()
> +	    and open (my $fd, $cache_file)) {
> +		$stale = time() - stat($cache_file)->mtime;
> +		my @dump = <$fd>;
> +		close $fd;
> +		# Hack zone start
> +		my $VAR1;
> +		eval join("\n", @dump);
> +		@projects = @$VAR1;
> +		# Hack zone end
> +	} else {
> +		if ($cache_lifetime and -f $cache_file) {
> +			# Postpone timeout by two minutes so that we get
> +			# enough time to do our job.
> +			my $time = time() - $cache_lifetime + 120;
> +			utime $time, $time, $cache_file;
> +		}
> +		@projects = git_get_projects_details($projlist, $check_forks);
> +		if ($cache_lifetime and open (my $fd, '>'.$cache_file)) {
> +			use Data::Dumper;
> +			print $fd Dumper(\@projects);
> +			close $fd;
> +		}
> +	}

This could be much simplified with perl-cache (perl-Cache-Cache).
Unfortunately this is non-standard module, not distributed (yet?)
with Perl.

Warning: not tested in gitweb!

+	use Cache::FileCache;
+
+	my $cache;
+	my $projects;
+	
+	if ($cache_lifetime) {
+		$cache = new Cache::FileCache(
+			{ namespace => 'gitweb',
+			  default_expires_in => $cache_lifetime
+			});
+		$projects = $cache->get('projects_list');
+	}
+	if (!defined $projects) {
+		$projects = [ git_get_projects_details($projlist, $check_forks); ];
+		$cache->set('projects_list', $projects)
+			if defined $cache;
+	}

-- 
Jakub Narebski
Poland
ShadeHawk on #git
