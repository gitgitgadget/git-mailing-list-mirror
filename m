From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Sat, 6 Dec 2008 01:34:21 +0100
Message-ID: <200812060134.22959.jnareb@gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com> <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 01:35:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8l98-0003Ej-EJ
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 01:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbYLFAe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 19:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbYLFAe3
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 19:34:29 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:35667 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbYLFAe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 19:34:28 -0500
Received: by ey-out-2122.google.com with SMTP id 6so117023eyi.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 16:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/5CF5kMCGJdD3h+JCo2t2QIf9dplt3lOj8th0A0Qq3s=;
        b=lehfwMIVCxICUZqMm7qsx5kV7db6v5mapDDekilNQs5FBfFxruGBtf99UhhFERi2RO
         sd22TNLYDl8SdPPZzyw43f0ErVmilph4usRX/+blOMIQwMSFeYNl09OiJOb1eLJzrSfh
         fSjOnrKn/zdY+wYQoW/1NbXQ0+LQD83AYQrjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qSa4VVZsACytVJU61ZS/J9iKf9blW4JqgYgmHK0uOSRs7CKecjk+UhCaSU9iZHntR3
         4cG0jb7+NThAbriu3Zde73/vE+vjbFpGlcLoZXeGTCbIdQmpql5InvSuH4L38u363/Zi
         kOXNt9sdHqsXuBEp2kCoMVmUw64nESV4G2AGk=
Received: by 10.210.10.8 with SMTP id 8mr581613ebj.7.1228523666259;
        Fri, 05 Dec 2008 16:34:26 -0800 (PST)
Received: from ?192.168.1.11? (abwe217.neoplus.adsl.tpnet.pl [83.8.228.217])
        by mx.google.com with ESMTPS id b30sm12509253ika.19.2008.12.05.16.34.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Dec 2008 16:34:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102425>

I'm sorry for the delay reviewing this patch series...

On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:

> The manually-built email format in commitdiff_plain output is not
> appropriate for feeding git-am, because of two limitations:
>  * when a range of commits is specified, commitdiff_plain publishes a
>    single patch with the message from the first commit, instead of a
>    patchset,

This is because 'commitdiff_plain' wasn't _meant_ as patch series view,
to be fed to git-am. Actually it is a bit cross between "git show"
result with '--pretty=email' format, and "git diff" between two commits,
to be fed to git-apply or GNU patch.

Nevertheless the above reasoning doesn't need to be put in a commit
message. But it explains why new 'patch' / 'patchset' view is needed:
because there was no equivalent.

>  * in either case, the patch summary is replicated both as email subject
>    and as first line of the email itself, resulting in a doubled summary
>    if the output is fed to git-am.

This is independent issue which is I think worth correcting anyway,
unless we decide to scrap 'commitdiff_plain' view altogether.
But I think we would want some text/plain patch view to be applied
by GNU patch (for example in RPM .spec file).

> 
> We thus create a new view that can be fed to git-am directly by exposing
> the output of git format-patch directly. This allows patch exchange and
> submission via gitweb.

Which is in my opinion a very good idea.

> 
> A configurable limit is imposed on the number of commits which will be
> included in a patchset, to prevent DoS attacks on the server. Setting
> the limit to 0 will disable the patch view, setting it to a negative
> number will remove the limit.

Note that this limit doesn't need to be lower than page length limit,
i.e. currently 100 commits, as new 'patch' view doesn't generate
greater load than 'log' view (which is split into 100 commits long
pages).

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   41 ++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 40 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 2738643..c9abfcf 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -329,6 +329,13 @@ our %feature = (
>  	'ctags' => {
>  		'override' => 0,
>  		'default' => [0]},
> +
> +	# The maximum number of patches in a patchset generated in patch
> +	# view. Set this to 0 or undef to disable patch view, or to a
> +	# negative number to remove any limit.
> +	'patches' => {
> +		'override' => 1,
> +		'default' => [16]},
>  );

You need to set "'sub' => \&feature_patches" for feature to be 
override-able at all.  Also features are usually not overridable
by default, which reduces load a tiny bit (by _possibly_ not reading
config, although that shouldn't matter much now with reading whole
commit using single call to git-config, and not one call per variable).
And I think the default might be set larger: 'log' view generates
as big if not bigger load, and it is split into 100 commits long
pages.

>  
>  sub gitweb_get_feature {
> @@ -503,6 +510,7 @@ our %actions = (
>  	"heads" => \&git_heads,
>  	"history" => \&git_history,
>  	"log" => \&git_log,
> +	"patch" => \&git_patch,
>  	"rss" => \&git_rss,
>  	"atom" => \&git_atom,
>  	"search" => \&git_search,
> @@ -5386,6 +5394,12 @@ sub git_blobdiff_plain {
>  
>  sub git_commitdiff {
>  	my $format = shift || 'html';
> +
> +	my $patch_max = gitweb_check_feature('patches');

Wouldn't it be better to name this variable $max_patchset_size, or
something like that? I'm not saying that this name is bad, but I'm
wondering if it could be better...

> +	if ($format eq 'patch') {
> +		die_error(403, "Patch view not allowed") unless $patch_max;

So undef and '' means "not allowed", beside '0'? I think it is a good
idea.

And it would be better (although now it is not as much performance hit)
to move "gitweb_check_feature('patches');" inside conditional:

+	my $patch_max;
+	if ($format eq 'patch') {
+		$patch_max = gitweb_check_feature('patches');
+		die_error(403, "Patch view not allowed") unless $patch_max;
+	}
+

> +	}
> +
>  	$hash ||= $hash_base || "HEAD";
>  	my %co = parse_commit($hash)
>  	    or die_error(404, "Unknown commit object");
> @@ -5396,6 +5410,7 @@ sub git_commitdiff {
>  	}
>  	# we need to prepare $formats_nav before almost any parameter munging
>  	my $formats_nav;
> +

Hmmm... some accidental change, it looks like.

>  	if ($format eq 'html') {
>  		$formats_nav =
>  			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
> @@ -5483,7 +5498,12 @@ sub git_commitdiff {
>  		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
>  			'-p', $hash_parent_param, $hash, "--"
>  			or die_error(500, "Open git-diff-tree failed");
> -
> +	} elsif ($format eq 'patch') {
> +		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
> +			'--stdout', $patch_max > 0 ? "-$patch_max" : (),

> +			$hash_parent ? ('-n', "$hash_parent..$hash") :
> +			('--root', '-1', $hash)

This bit makes 'patch' view behave bit differently than git-format-patch,
which I think is a good idea: namely it shows single patch if there is
no cutoff.  This should be mentioned in commit message, and perhaps
even in a comment in code.

Beside, if you show only single patch because $hash_parent is not set,
you don't need to examine $patch_max nor set limit, because you use '-1'.
Currently if $patch_max > 0 and !$hash_parent, you pass limit for the
number of patches twice.  This I think is harmless but...

> +			or die_error(500, "Open git-format-patch failed");
>  	} else {
>  		die_error(400, "Unknown commitdiff format");
>  	}
> @@ -5532,6 +5552,15 @@ sub git_commitdiff {
>  			print to_utf8($line) . "\n";
>  		}
>  		print "---\n\n";
> +	} elsif ($format eq 'patch') {
> +		my $filename = basename($project) . "-$hash.patch";
> +
> +		print $cgi->header(
> +			-type => 'text/plain',
> +			-charset => 'utf-8',
> +			-expires => $expires,
> +			-content_disposition => 'inline; filename="' . "$filename" . '"');

Good.

> +		# TODO add X-Git-Tag/X-Git-Url headers in a sensible way

Sensible way would mean modifying git-format-patch to be able to add
extra headers via command option, just like it is now possible via
config variable format.headers, I think.  Because there are no surefire
markers of where one patch ends and another begins: commit message is
free text, and can contain diff... although if it contains diff
separator '---' then git-am would have problem with patch; or at least
even assuming sane commit messages it is not easy.

Also I think that only X-Git-Url makes sense, and it is per whole
patchset (whole 'patch' view output) and not for each individual
patch.

>  	}
>  
>  	# write patch
> @@ -5553,6 +5582,11 @@ sub git_commitdiff {
>  		print <$fd>;
>  		close $fd
>  			or print "Reading git-diff-tree failed\n";
> +	} elsif ($format eq 'patch') {
> +		local $/ = undef;
> +		print <$fd>;
> +		close $fd
> +			or print "Reading git-format-patch failed\n";
>  	}
>  }
>  
> @@ -5560,6 +5594,11 @@ sub git_commitdiff_plain {
>  	git_commitdiff('plain');
>  }
>  
> +# format-patch-style patches
> +sub git_patch {
> +	git_commitdiff('patch');
> +}
> +

O.K.

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
