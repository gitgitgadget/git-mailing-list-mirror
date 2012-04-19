From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH] gitweb: Improve repository verification
Date: Thu, 19 Apr 2012 11:30:43 -0700
Message-ID: <xmqq397zwp4c.fsf@junio.mtv.corp.google.com>
References: <20120403132735.GA12389@camk.edu.pl>
	<20120416213938.GB22574@camk.edu.pl>
	<201204180136.08570.jnareb@gmail.com>
	<201204191807.32410.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 20:30:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKw82-0000zn-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 20:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230Ab2DSSaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 14:30:46 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:32914 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab2DSSap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 14:30:45 -0400
Received: by ghbz15 with SMTP id z15so1006008ghb.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=l30E4TlCJ5cZNDFeAFtGdYdLd1/vaBJ5MKo28GTbPAk=;
        b=gJOozSBq2upgRCoSEsnGKMAZIt1cGEmnu877LUS9iK9R3xLjYUSpDGWE/Clm0Ef82T
         cSJwOD/tsxvin/GV+8bR6T12QB7xKVFD4kL7uPetPrGNtrisfYFJwvvkvsnvLY6SzTOv
         QllZ9vO9rHZ7k66COn3SdVYiObi0VAHW0gzSwAUGeDhNx2AAJpiM/2st1qiSi6aRFAQ8
         BI+GuZLjHd/1CePkas/0INVz6nQ+Y6QzrZ7sCxhZx3TRi5zpX8uQgrGT2oyiFJE1IdVc
         s9o5Z/odcDDVLCJ8KNYIaWWQPX3jayWU0ObMStOOQ16wqN7saKgtZO0heiDqjQ1QC7eO
         WCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=l30E4TlCJ5cZNDFeAFtGdYdLd1/vaBJ5MKo28GTbPAk=;
        b=pZRMGwk+euw50dKyCJp+DV+HkqFY8v9Dh0qpozqbq60f90CWI909tNRRETsGvqwz3A
         XwyyDgsNBxcrD4lc9NU3sDDClZBoKTTegcUh5BOxwAtVzO1pxxBCY2bAp2ubE/F8tAae
         x0Cr57sGIW1tS6Na8L86JkHAzWxbznWTSP3g7152jfdbzUu0R3uFhUVgO0WN50ZM4ebj
         MYtnRhdqQMkZrepen2XUOiTSmNWKvI1c5Tk32w27hrcFqJjoJ7g9HOAieuv3MIt/WA0H
         GQuhZyQmRHSrMxFSd99Dpwh9VDzcj4I7A6Au4Vr8DHDl3UyavCKsGGc9cvhhxZDpeNWA
         1scA==
Received: by 10.236.165.99 with SMTP id d63mr3662146yhl.7.1334860244633;
        Thu, 19 Apr 2012 11:30:44 -0700 (PDT)
Received: by 10.236.165.99 with SMTP id d63mr3662132yhl.7.1334860244557;
        Thu, 19 Apr 2012 11:30:44 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id a33si552853anp.2.2012.04.19.11.30.44
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 11:30:44 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 5952E10004D;
	Thu, 19 Apr 2012 11:30:44 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id DBF60E1209; Thu, 19 Apr 2012 11:30:43 -0700 (PDT)
In-Reply-To: <201204191807.32410.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 19 Apr 2012 18:07:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQldKv1NrodYyVfwd65gIq9P9flaypiFEWcVqkSsBXuc5qN0bts4b9T8k058sNl7VCNHIQpfAFVieOBYt2SyuzdUbI2P8HL1EcT9TB1jwgmD9g4ps+M+ufGkeUq8LZ5+3kK3LcVs7Dt8h27qk4OdVlb5LFU8c6YTHiShiwNtuOkqqd1THPs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195959>

Jakub Narebski <jnareb@gmail.com> writes:

> Bring repository verification in check_export_ok() to standards of
> is_git_directory function from setup.c (core git), and validate_headref()
> to standards of the same function in path.c,... and a bit more.
>
> validate_headref() replaces check_head_link(); note that the former
> requires path to HEAD file, while the late latter path to repository.
>
> Issues of note:
> * is_git_directory() in gitweb is a bit stricter: it checks that
>   "/objects" and "/refs" are directories, and not only 'executable'
>   permission,
> * validate_headref() in gitweb is a bit stricter: it checks that
>   reference symlink or symref points to starts with "refs/heads/",
>   and not only with "refs/",
> * calls to check_head_link(), all of which were meant to check if
>   given directory can be a git repository, were replaced by newly
>   introduced is_git_directory().
>
> This change is preparation for removing "Last change" column from list
> of projects, which is currently used also for validating repository.
>
> Suggested-by: Kacper Kornet <draenog@pld-linux.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Here is how such first step could look like...

Do you mean by "could look like" that this is still an RFC, or is this
something we want to apply and see how well it makes people's lives in
the field?

By the way, I wonder (1) if it is worth adding support for the textual
".git" file that contains "gitdir: $path", and (2) if so how big a
change would we need to do so.

>  gitweb/gitweb.perl |   52 ++++++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 098e527..767d7a5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -621,19 +621,51 @@ sub feature_avatar {
>  	return @val ? @val : @_;
>  }
>  
> -# checking HEAD file with -e is fragile if the repository was
> -# initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
> -# and then pruned.
> -sub check_head_link {
> -	my ($dir) = @_;
> -	my $headfile = "$dir/HEAD";
> -	return ((-e $headfile) ||
> -		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
> +# Test if it looks like we're at a git directory.
> +# We want to see:
> +#
> +#  - an objects/ directory,
> +#  - a refs/ directory,
> +#  - either a HEAD symlink or a HEAD file that is formatted as
> +#    a proper "ref:", or a regular file HEAD that has a properly
> +#    formatted sha1 object name.
> +#
> +# See is_git_directory() in setup.c
> +sub is_git_directory {
> +	my $dir = shift;
> +	return
> +		-x "$dir/objects" && -d _ &&
> +		-x "$dir/refs"    && -d _ &&
> +		validate_headref("$dir/HEAD");
> +}
> +
> +# Check HEAD file, that it is either
> +#
> +#  - a "refs/heads/.." symlink, or
> +#  - a symbolic ref to "refs/heads/..", or
> +#  - a detached HEAD.
> +#
> +# See validate_headref() in path.c
> +sub validate_headref {
> +	my $headfile = shift;
> +	if (-l $headfile) {
> +		return readlink($headfile) =~ m!^refs/heads/!;
> +
> +	} elsif (-e _) {
> +		open my $fh, '<', $headfile or return;
> +		my $line = <$fh>;
> +		close $fh or return;
> +
> +		return
> +			$line =~ m!^ref:\s*refs/heads/! ||  # symref
> +			$line =~ m!^[0-9a-z]{40}$!i;        # detached HEAD
> +	}
> +	return;
>  }
>  
>  sub check_export_ok {
>  	my ($dir) = @_;
> -	return (check_head_link($dir) &&
> +	return (is_git_directory($dir) &&
>  		(!$export_ok || -e "$dir/$export_ok") &&
>  		(!$export_auth_hook || $export_auth_hook->($dir)));
>  }
> @@ -842,7 +874,7 @@ sub evaluate_path_info {
>  	# find which part of PATH_INFO is project
>  	my $project = $path_info;
>  	$project =~ s,/+$,,;
> -	while ($project && !check_head_link("$projectroot/$project")) {
> +	while ($project && !is_git_directory("$projectroot/$project")) {
>  		$project =~ s,/*[^/]*$,,;
>  	}
>  	return unless $project;
