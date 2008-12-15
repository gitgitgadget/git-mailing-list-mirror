From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv4 1/3] gitweb: add patch view
Date: Mon, 15 Dec 2008 14:17:15 +0100
Message-ID: <200812151417.16372.jnareb@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com> <1228575755-13432-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 14:18:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCDLV-0005Nb-OO
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 14:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbYLONRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 08:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbYLONRa
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 08:17:30 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:36171 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYLONR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 08:17:29 -0500
Received: by ewy10 with SMTP id 10so3012817ewy.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vUyNgDG39fdrnYXYxGT5VBOe9wIs9M6ts8icStHgjyE=;
        b=e2amhiTnsO0T25Yy/oP6gKciUH9XRgBmkTIQyR6QgOraOZtKdF1lZnSCRfGj5C97+O
         8G14Vo1CjcAq1bOf9mfaFEBYuaksp79RpdXnqZWbVEjGEJurbY0Zi1TqBzo8xqWyI+jA
         YDtsmD/QmpWrJfwVDbSXTPic1VxmCk94FWwUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=s0g6wUuwEab03pavX2MqEvxt8ECXE5LAmuCkacQMB696VbGcdBl4avelK70H1qh8DR
         fc934c2WzD+fBeVztDKkNp5ziGt1saLSRPnI6lXk/okiiQDYsM8Jx4GbjMwM38N3sVHL
         uQIydBCybOJZPHxO/4Zfqfp8qIhKTt3csyaOA=
Received: by 10.210.34.2 with SMTP id h2mr3063841ebh.176.1229347047140;
        Mon, 15 Dec 2008 05:17:27 -0800 (PST)
Received: from ?192.168.1.11? (abva128.neoplus.adsl.tpnet.pl [83.8.198.128])
        by mx.google.com with ESMTPS id 34sm14588339nfu.73.2008.12.15.05.17.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 05:17:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1228575755-13432-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103161>

On Sat, 6 Dec 2008, Giuseppe Bilotta wrote:

> The output of commitdiff_plain is not intended for git-am:
>  * when given a range of commits, commitdiff_plain publishes a single
>    patch with the message from the first commit, instead of a patchset
>  * the hand-built email format replicates the commit summary both as
>    email subject and as first line of the email itself, resulting in
>    a duplication if the output is used with git-am.
> 
> We thus create a new view that can be fed to git-am directly, allowing
> patch exchange via gitweb. The new view exposes the output of git
> format-patch directly, limiting it to a single patch in the case of a
> single commit.
> 
> A configurable upper limit is imposed on the number of commits which
> will be included in a patchset, to prevent DoS attacks on the server.
> Setting the limit to 0 will disable the patch view, setting it to a
> negative number will remove the limit.

It would be good to have in commit mesage what is the default upper
limit (or if we decide to have this feature turned off by default,
proposed limit to choose when enabling this feature).

Does limit of 16 patches have any numbers behind it? We use page size
of 100 commits for 'shortlog', 'log' and 'history' views, but for
those views we don't need to generate patches (which is slower). From
a few tests "git log -100" is faster than "git format-patch -100 --stdout"
about 30 times in warm cache case, and about 1.7 times in cold cache
case.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Other than that minor detail I like this patch

> ---
>  gitweb/gitweb.perl |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 64 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 95988fb..71d5af4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -329,6 +329,14 @@ our %feature = (
>  	'ctags' => {
>  		'override' => 0,
>  		'default' => [0]},
> +
> +	# The maximum number of patches in a patchset generated in patch
> +	# view. Set this to 0 or undef to disable patch view, or to a
> +	# negative number to remove any limit.

I think it would be nice to have standard boilerplate explanation how
to change it, and how to override it, with the addition on how to
disable it from repository config, because it is not very obvious.

Something like:

+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'patches'}{'default'} = [];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'patches'}{'override'} = 1;
+	# and in project config, maximum number of patches in a patchset
+	# or 0 to disable.  Example: gitweb.patches = 0

> +	'patches' => {
> +		'sub' => \&feature_patches,
> +		'override' => 0,
> +		'default' => [16]},
>  );
>  
>  sub gitweb_get_feature {
> @@ -410,6 +418,19 @@ sub feature_pickaxe {
>  	return ($_[0]);
>  }
>  
> +sub feature_patches {
> +	my @val = (git_get_project_config('patches', '--int'));
> +
> +	# if @val is empty, the config is not (properly)
> +	# overriding the feature, so we return the default,
> +	# otherwise we pick the override

Very similar feature_snapshot subroutine doesn't have such comment.
I don't think it is necessary, and its wording might cause confusion.

> +	if (@val) {
> +		return @val;
> +	}
> +
> +	return ($_[0]);
> +}
> +

Nice.

>  # checking HEAD file with -e is fragile if the repository was
>  # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
>  # and then pruned.
> @@ -503,6 +524,7 @@ our %actions = (
>  	"heads" => \&git_heads,
>  	"history" => \&git_history,
>  	"log" => \&git_log,
> +	"patch" => \&git_patch,
>  	"rss" => \&git_rss,
>  	"atom" => \&git_atom,
>  	"search" => \&git_search,
> @@ -5386,6 +5408,13 @@ sub git_blobdiff_plain {
>  
>  sub git_commitdiff {
>  	my $format = shift || 'html';
> +
> +	my $patch_max;
> +	if ($format eq 'patch') {
> +		$patch_max = gitweb_check_feature('patches');
> +		die_error(403, "Patch view not allowed") unless $patch_max;
> +	}
> +

Hmmm... gitweb_check_feature

>  	$hash ||= $hash_base || "HEAD";
>  	my %co = parse_commit($hash)
>  	    or die_error(404, "Unknown commit object");
> @@ -5483,7 +5512,23 @@ sub git_commitdiff {
>  		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
>  			'-p', $hash_parent_param, $hash, "--"
>  			or die_error(500, "Open git-diff-tree failed");
> -
> +	} elsif ($format eq 'patch') {
> +		# For commit ranges, we limit the output to the number of
> +		# patches specified in the 'patches' feature.
> +		# For single commits, we limit the output to a single patch,
> +		# diverging from the git format-patch default.

I think it would be more clear to use

+		# diverging from the git-format-patch default.

> +		my @commit_spec = ();
> +		if ($hash_parent) {
> +			if ($patch_max > 0) {
> +				push @commit_spec, "-$patch_max";
> +			}
> +			push @commit_spec, '-n', "$hash_parent..$hash";
> +		} else {
> +			push @commit_spec, '-1', '--root', $hash;
> +		}

Nice solution. I like it.

> +		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
> +			'--stdout', @commit_spec
> +			or die_error(500, "Open git-format-patch failed");
>  	} else {
>  		die_error(400, "Unknown commitdiff format");
>  	}
> @@ -5532,6 +5577,14 @@ sub git_commitdiff {
>  			print to_utf8($line) . "\n";
>  		}
>  		print "---\n\n";
> +	} elsif ($format eq 'patch') {
> +		my $filename = basename($project) . "-$hash.patch";

I am wondering if we could somehow mark (encode) either $hash_parent
or number of patches in proposed filename... but I don't think it is
worth it.

> +
> +		print $cgi->header(
> +			-type => 'text/plain',
> +			-charset => 'utf-8',
> +			-expires => $expires,
> +			-content_disposition => 'inline; filename="' . "$filename" . '"');
>  	}
>  
>  	# write patch
> @@ -5553,6 +5606,11 @@ sub git_commitdiff {
>  		print <$fd>;
>  		close $fd
>  			or print "Reading git-diff-tree failed\n";
> +	} elsif ($format eq 'patch') {
> +		local $/ = undef;
> +		print <$fd>;
> +		close $fd
> +			or print "Reading git-format-patch failed\n";

Nice, although... I'd prefer for Perl expert to say if it is better
to dump file as a whole in such way (it might be quite large), or
to do it line by line, i.e. without "local $/ = undef;", or using
"print while <$fd>;" also without "local $/ = undef;".


>  	}
>  }
>  
> @@ -5560,6 +5618,11 @@ sub git_commitdiff_plain {
>  	git_commitdiff('plain');
>  }
>  
> +# format-patch-style patches
> +sub git_patch {
> +	git_commitdiff('patch');
> +}
> +

Nice.

>  sub git_history {
>  	if (!defined $hash_base) {
>  		$hash_base = git_get_head_hash($project);
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
