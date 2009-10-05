From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 2/2] gitweb: append short hash ids to snapshot files
Date: Mon, 5 Oct 2009 12:06:17 +0200
Message-ID: <200910051206.18943.jnareb@gmail.com>
References: <4ABE536D.3070705@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Oct 05 12:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MukVw-000861-MA
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 12:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbZJEKIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 06:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbZJEKIO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 06:08:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:62641 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499AbZJEKIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 06:08:12 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1032281fge.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=LoPpJ0/Rcl1ruNkMgHyP4Hm6u1orm/TRQ5TVIyggqcg=;
        b=XlD4DNFJI/eOSAz8c+2cDVIkzZNLX4cj1b93Zj+7h8b79k1YBJdlqWC/fqvTSTcva+
         dPse9mBBq+gUb/xRB5illBF13x2TCD4q8JGxvfiUnRzVpybJFmTN4TzzirSo3+qBJW2j
         MOrXPI6JhLXvp2+ETzwWeiHju0o1yrNODmnJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=h6EqpyY8d/SJWXbIiB/L8k+1GW/57J1fXyTBD1+V84R9t267XfBgKOv8T6uiG6ZHMW
         mByBA0YinEMatJYdfI8KmqroO98/H+Du4db60/2y8dWWOhUXVPyxMq72SHNhz4ELJGVu
         ORyH6lYmSlNhN5jY6tS3qsOzlEGtlC5pUgJCg=
Received: by 10.86.222.15 with SMTP id u15mr4968238fgg.33.1254737184377;
        Mon, 05 Oct 2009 03:06:24 -0700 (PDT)
Received: from ?192.168.1.13? (abvp12.neoplus.adsl.tpnet.pl [83.8.213.12])
        by mx.google.com with ESMTPS id e11sm7072338fga.3.2009.10.05.03.06.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Oct 2009 03:06:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4ABE536D.3070705@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129548>

I am sorry for being late with review of this patch.

On Sat, 26 Sep 2009, Mark Rada wrote:

> Teach gitweb how to produce nicer snapshot names by only using the
> short hash id.

A few questions (which I think should be answered in this commit message).

First, what was original behaviour of 'snapshot' action?  Did gitweb
always convert 'h' (hash) parameter to full SHA-1?

Second, do you preserve 'snapshot' behavior that it generated archive
which unpacks to the directory with the same name as basename of (proposed)
archive name?  I mean here that "repo-2cc6859e.tar.gz" unpacks to
"repo-2cc6859e/" directory.  I guess it does, but this should be
mentioned in the commit message.

>               If clients make requests using a tree-ish that is not a
> partial or full SHA-1 hash, then the short hash will also be appended
> to whatever they asked for.

Here example would be a good idea.  I guess this means that if one is
requesting for snapshot of 'next' or 'v1.6.0' of 'repo.git' project,
one would get 'repo-next-2cc6859.tar.gz' or 'repo-v1.6.0-2cc6859.tar.gz'
as [proposed] snapshot filename.

> 
> This also includes tests cases for t9502-gitweb-standalone-parse-output.

I am not sure if it shouldn't be rather t9502-gitweb-standalone-snapshot
test; see comments below for whys.

> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---
> 
> 
> 	Changes since v4:
> 		- moved git_get_full_hash into this commit
> 		- changed test case format, suggested by Junio
> 		- explicity request at least a length of 7 for short hashes
> 
> 
>  gitweb/gitweb.perl                        |   40 +++++++++++++++--
>  t/t9502-gitweb-standalone-parse-output.sh |   67 +++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+), 4 deletions(-)
>  create mode 100644 t/t9502-gitweb-standalone-parse-output.sh
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8d4a2ae..bc132a5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1983,14 +1983,39 @@ sub quote_command {
>  
>  # get HEAD ref of given project as hash
>  sub git_get_head_hash {
> +	return git_get_full_hash(shift, 'HEAD');
> +}

Good.  This means that we don't need to change code that do not use
new feature (new subroutines).  It's nice to cater to backward 
compatibility, especially if it is so low cost as this one.

> +
> +sub git_get_full_hash {
>  	my $project = shift;
> +	my $hash = shift;

I think it might be good idea here to default to 'HEAD', i.e.

  +	my $hash = shift || 'HEAD';

>  	my $o_git_dir = $git_dir;
>  	my $retval = undef;
>  	$git_dir = "$projectroot/$project";
> -	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
> -		my $head = <$fd>;
> +	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--verify', $hash) {
> +		$hash = <$fd>;
>  		close $fd;
> -		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
> +		if (defined $hash && $hash =~ /^([0-9a-fA-F]{40})$/) {
> +			$retval = $1;
> +		}

I guess that you use "$retval = $1;" instead of just "$retval = $hash;"
because of similarities with git_get_short_hash, isn't it?  Or it is just
following earlier code?

> +	}
> +	if (defined $o_git_dir) {
> +		$git_dir = $o_git_dir;
> +	}
> +	return $retval;
> +}
> +
> +# try and get a shorter hash id
> +sub git_get_short_hash {
> +	my $project = shift;
> +	my $hash = shift;
> +	my $o_git_dir = $git_dir;
> +	my $retval = undef;
> +	$git_dir = "$projectroot/$project";
> +	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--short=7', $hash) {
> +		$hash = <$fd>;
> +		close $fd;
> +		if (defined $hash && $hash =~ /^([0-9a-fA-F]{7,})$/) {
>  			$retval = $1;
>  		}
>  	}

Note that git_get_full_hash (which additionally does verification) and
git_get_short_hash share much of code.  Perhaps it might be worth to
avoid code duplication somehow?  On the other hand it might be not worth
to complicate code by trying to extract common parts here...

> @@ -5203,6 +5228,13 @@ sub git_snapshot {
>  		die_error(400, 'Object is not a tree-ish');
>  	}
>  
> +
> +	my $full_hash = git_get_full_hash($project, $hash);
> +	if ($full_hash =~ /^$hash/) {
> +		$hash = git_get_short_hash($project, $hash);
> +	} else {
> +		$hash .= '-' . git_get_short_hash($project, $hash);
> +	}

I think we might want to avoid calling git_get_full_hash (and extra call
to "git rev-parse" command, which is extra fork) if we know in advance
that  $full_hash =~ /^$hash/  can't be true, i.e. if $hash doesn't match
/^[0-9a-fA-F]+$/.  That would require that we continue to use $hash
and not $full_hash, see comment for the chunk below.

BTW do you think that having better name (nicer name in the case
when $hash is full SHA-1, or name which describes exact version as 
in the case when $hash is branch name or just 'HEAD') is worth
slight extra cost of "git rev-parse --abbrev=7"?

>  	my $name = $project;
>  	$name =~ s,([^/])/*\.git$,$1,;
>  	$name = basename($name);
> @@ -5213,7 +5245,7 @@ sub git_snapshot {
>  	$cmd = quote_command(
>  		git_cmd(), 'archive',
>  		"--format=$known_snapshot_formats{$format}{'format'}",
> -		"--prefix=$name/", $hash);
> +		"--prefix=$name/", $full_hash);

Why this change?

>  	if (exists $known_snapshot_formats{$format}{'compressor'}) {
>  		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
>  	}
> diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
> new file mode 100644
> index 0000000..5f2b1d5
> --- /dev/null
> +++ b/t/t9502-gitweb-standalone-parse-output.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Mark Rada
> +#
> +
> +test_description='gitweb as standalone script (parsing script output).
> +
> +This test runs gitweb (git web interface) as a CGI script from the
> +commandline, and checks that it produces the correct output, either
> +in the HTTP header or the actual script output.'

Currently all tests here are about 'snapshot' action.  They are quite
specific, and they do require some knowledge about chosen archive format.
I think it would be better to put snapshot test into separate test,
i.e. in 't/t9502-gitweb-standalone-snapshot.sh'.

> +
> +
> +. ./gitweb-lib.sh
> +
> +# ----------------------------------------------------------------------
> +# snapshot file name
> +
> +test_commit \
> +	'SnapshotFileTests' \
> +	'i can has snapshot?'

Errr... with filename [cutely] called 'i can has snapshot?' you would
have, I guess, problems with tests on MS Windows, where IIRC '?' is
forbidden in filenames.

Perhaps

  +test_commit \
  +	'Initial commit' \
  +	'foo'

or

  +test_commit \
  +	'SnapshotFileTests' \
  +	'foo' 'i can has snapshot?'


> +

In the test below you use "git rev-parse --verify HEAD" and
"git rev-parse --short HEAD" over and over.  I think it would be better
to calculate them upfront:

  +test_expect_success 'calculate full and short ids' '
  +	FULLID= $(git rev-parse --verify  HEAD) &&
  +	SHORTID=$(git rev-parse --short=7 HEAD)
  +'

> +test_expect_success 'snapshots: give full hash' '

You test here that giving full has works, and that gitweb uses short hash
in file name.  Better name would therefore be something like

  +test_expect_success 'snapshots: give full hash, get short hash' '


> +	ID=`git rev-parse --verify HEAD` &&
> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&

Here I had to remember that 'tgz' snapshot format is enabled by default.
I think it could be better to explicitly enable it in preparation step.

> +	ID=`git rev-parse --short HEAD` &&
> +	grep ".git-$ID.tar.gz" gitweb.output

Here had to think a bit that gitweb.output consists both of HTTP headers,
and of response body, and you are grepping here in the HTTP headers part.
It would be better solution for gitweb_run to split gitweb.output into
gitweb.headers and gitweb.body (perhaps if requested by setting some
variable, e.g. GITWEB_SPLIT_OUTPUT).

It can be done using the following lines:

	sed    -e '/^\r$/'      <gitweb.output >gitweb.headers
	sed -n -e '0,/^\r$/!p'  <gitweb.output >gitweb.body

	# gitweb.headers is used to parse http headers
	# gitweb.body is response without http headers

But the second one uses GNU sed extension; I don't know how to write
it in more portable way.

Then

> +	grep ".git-$ID.tar.gz" gitweb.output

would be

  +	grep ".git-$ID.tar.gz" gitweb.headers

Note that this would mean that t/t9501-gitweb-standalone-http-status.sh
should also be updated to use gitweb.headers and gitweb.body

> +'
> +test_debug 'cat gitweb.output'

Not a good idea in current state.  gitweb.output contains binary part,
and generally it is not a good idea to output binary files (which can
contain ANSI escape sequences) to terminal.

> +
> +test_expect_success 'snapshots: give short hash' '

  +test_expect_success 'snapshots: give short hash, get short hash' '

> +	ID=`git rev-parse --short HEAD` &&

Gitweb uses '--short=7'.  Shouldn't you use the same option here?

> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
> +	grep ".git-$ID.tar.gz" gitweb.output
> +'
> +test_debug 'cat gitweb.output'
> +
> +test_expect_success 'snapshots: give almost full hash' '

  +test_expect_success 'snapshots: give almost full hash, get short hash' '

> +	ID=`git rev-parse --short=30 HEAD` &&
> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
> +	ID=`git rev-parse --short HEAD` &&
> +	grep ".git-$ID.tar.gz" gitweb.output
> +'
> +test_debug 'cat gitweb.output'
> +
> +test_expect_success 'snapshots: give HEAD tree-ish' '

  +test_expect_success 'snapshots: give HEAD, get HEAD-<short hash>' '

> +	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
> +	ID=`git rev-parse --short HEAD` &&
> +	grep ".git-HEAD-$ID.tar.gz" gitweb.output
> +'
> +test_debug 'cat gitweb.output'
> +
> +test_expect_success 'snapshots: give branch name tree-ish' '

  +test_expect_success 'snapshots: give branch name, get <branch name>-<short hash>' '

> +	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
> +	ID=`git rev-parse --short master` &&
> +	grep ".git-master-$ID.tar.gz" gitweb.output
> +'
> +test_debug 'cat gitweb.output'
> +
> +test_expect_success 'snapshots: give tag tree-ish' '

  +test_expect_success 'snapshots: give tag name, get <tag name>-<short hash>' '

> +	gitweb_run "p=.git;a=snapshot;h=SnapshotFileTests;sf=tgz" &&
> +	ID=`git rev-parse --short SnapshotFileTests` &&
> +	grep ".git-SnapshotFileTests-$ID.tar.gz" gitweb.output
> +'
> +test_debug 'cat gitweb.output'

Note that to avoid ambiguities currently gitweb uses refs/heads/master
and refs/tags/SnapshotFileTests... but dealing with this issue should be
left, I think, for separate commit.

> +
> +
> +test_done
> -- 
> 1.6.4.GIT
> 
> 
> 

-- 
Jakub Narebski
Poland
