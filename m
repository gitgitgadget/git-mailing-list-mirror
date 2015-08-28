From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-mediawiki: support subpages as subdirectories
Date: Fri, 28 Aug 2015 10:31:59 -0700
Message-ID: <xmqq7fof2ub4.fsf@gitster.mtv.corp.google.com>
References: <1440742486-4356-1-git-send-email-lyubomyr-shaydariv@users.noreply.github.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@imag.fr
To: Lyubomyr Shaydariv <dev.konsole@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:32:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVNVY-00087p-9Z
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbbH1RcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:32:03 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34628 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbbH1RcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:32:01 -0400
Received: by pabzx8 with SMTP id zx8so69138212pab.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=boKWqidDkbNVGKTwYJQwUyPqRXPUZJY2JQyNcVK38aM=;
        b=fJ0JzHB/EMHxWnX4hSoDhutsKlktlDx793thJWM2AlFU68+Litb7iV9SBEiQc6qSIP
         1cFqjnwcogJsaJ/hb8ThDz4bBktoYJEDRraAMafPZgSzye+1J6HOj8Hw+v86ouGGHHAq
         NKqwM5oRy4ykk4Gq37Phq5g8+WCXLIyxzgKV9uo9mIu2m/bhxwMLanib6LO5WoQL1QyS
         2AJESPXnzbdrHgQUtaHE9EyD1O66cftLB6xDthm8PwMuzL9OJqby7lZUJ112HGfQ6rpr
         A4/uUBrGRA+S8C5CCZOgPTfy1zl9LUKhILjd6HTg8x97plDKsCMNa/ZyuB4POF/EWQ5b
         V79g==
X-Received: by 10.68.192.9 with SMTP id hc9mr17119875pbc.57.1440783120953;
        Fri, 28 Aug 2015 10:32:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id pg5sm6351851pdb.81.2015.08.28.10.31.59
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 10:32:00 -0700 (PDT)
In-Reply-To: <1440742486-4356-1-git-send-email-lyubomyr-shaydariv@users.noreply.github.com>
	(Lyubomyr Shaydariv's message of "Fri, 28 Aug 2015 09:14:46 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276737>

Lyubomyr Shaydariv <dev.konsole@gmail.com> writes:

> This is a fix for https://github.com/moy/Git-Mediawiki/issues/22

Do not force readers of "git log" to go to the web.  Please have a
real problem description (I notice that the initial description of
issues/22 by vokimon very much readable and you can just use that)
before that URL.

> The subdirectories option is enabled using -c remote.origin.subpageDirs=true
> during the cloning and it is not recommended to be modified in or
> removed from .git/config after the cloning.

What happens when I clone without setting it and then later set it
(or vice versa)?  Does it completely break the resulting repository
and/or the MediaWiki side?

What I am wondering is if it is merely "it is not recommended" or it
should be a bit stronger in order to save users from hurting
themselves.  If the possible breakage is minor, a casual mention
like the above in the log message may be OK.  On the other hand, if
it is major enough, we may even want to have a code that forbids
flipping the setting in the middle (which may mean that you would
have this recorded somewhere outside of the config file).

> Signed-off-by: Lyubomyr Shaydariv <lyubomyr-shaydariv@users.noreply.github.com>
> Reported-by: David Garcia Garzon
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
> index 8dd74a9..f3624be 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -63,6 +63,11 @@ chomp(@tracked_pages);
>  my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.${remotename}.categories"));
>  chomp(@tracked_categories);
>  
> +# Use subdirectories for subpages
> +my $use_subpage_dirs = run_git("config --get --bool remote.${remotename}.subpageDirs");
> +chomp($use_subpage_dirs);
> +$use_subpage_dirs = ($use_subpage_dirs eq 'true');
> +
>  # Import media files on pull
>  my $import_media = run_git("config --get --bool remote.${remotename}.mediaimport");
>  chomp($import_media);
> @@ -689,6 +694,9 @@ sub fe_escape_path {
>      $path =~ s/\\/\\\\/g;
>      $path =~ s/"/\\"/g;
>      $path =~ s/\n/\\n/g;
> +    if ($use_subpage_dirs) {
> +        $path =~ s/%2F/\//g;
> +    }
>      return qq("${path}");
>  }
>  
> @@ -927,7 +935,7 @@ sub mw_import_revids {
>  		# If this is a revision of the media page for new version
>  		# of a file do one common commit for both file and media page.
>  		# Else do commit only for that page.
> -		print {*STDERR} "${n}/", scalar(@{$revision_ids}), ": Revision #$rev->{revid} of $commit{title}\n";
> +		print {*STDERR} "${n}/", scalar(@{$revision_ids}), ": Revision #$rev->{revid} of ", fe_escape_path($commit{title}), "\n";
>  		import_file_revision(\%commit, ($fetch_from == 1), $n_actual, \%mediafile);
>  	}
