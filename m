From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 11/11] gitweb: Create Gitweb::Parse module
Date: Mon, 19 Jul 2010 16:55:50 +0200
Message-ID: <201007191655.51604.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-12-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 16:56:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OarlM-0003ls-F0
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 16:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935418Ab0GSO4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 10:56:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42566 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935249Ab0GSO4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 10:56:02 -0400
Received: by fxm14 with SMTP id 14so2210864fxm.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=j/z8clOuuLCo2qif6fBmboGlRNqdw1FbwwfcJTMSSek=;
        b=dJlg7cV/Ryt46HdMo3ahN4cwvlyxN6pR/gCumRd8eTja5i8Bh5LZ4dWbGFYqdeyqQf
         QPkISXXmBMZcZTu8ZCYDd6jo3HVA1P9KA/TyWx+nPHhWPxbmZ5AB0JQ9WY+Y8RNauKTC
         GDGuWKYhBiV7AHZ/x1PSS+r7m1TX44+5hbTb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oVUBzDQr0Zj9veT6f5/WrHjWO7MWHJw5dLxlxE4DomNCGVePGkKOB9IWmxMWWkOXub
         IEY9DPLgiaDbKUlq8iWzmxL7FHsYRGWaRBa1UkGHb5kFpVXgHSFGQ6aGNEcXSuE/OfzP
         ePCcUMVggusMBxM1gy9wowUkKCtoCs+EFvGGE=
Received: by 10.223.124.205 with SMTP id v13mr3844717far.94.1279551360774;
        Mon, 19 Jul 2010 07:56:00 -0700 (PDT)
Received: from [192.168.1.13] (abwh94.neoplus.adsl.tpnet.pl [83.8.231.94])
        by mx.google.com with ESMTPS id r10sm2046379faq.5.2010.07.19.07.55.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 07:55:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-12-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151250>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create Gitweb::Parse module in 'gitweb/lib/Gitweb/Parse.pm'
> to store the subroutines which related to parsing functions
> required for gitweb.

O.K., that is nicely defined module, although you would probably
want to add _what_ those functions parse: most of them (or all
of them) parse or help parsing output of git commands.

By the way, in the future we might want to move those subroutines
to Git::Parse (or individual Git::Commit, Git::Tag, etc. modules).
By "in the future" I mean here when we move to using Git.pm in 
gitweb... which currently would require some functionality that is
just not present in Git.pm.

> 
> This module depends on Git.pm, Escape.pm, View.pm and Util.pm.

Usual notice: Git.pm or Gitweb::Git, etc.?

> 
> Subroutines moved:
> 	unquote
> 	parse_date
> 	parse_tag
> 	parse_commit_text
> 	parse_commit
> 	parse_commits
> 	parse_difftree_raw_line
> 	parsed_difftree_line
> 	parse_ls_tree_line
> 	parse_from_to_diffinfo

One of those is not like the other.  parsed_difftree_line is really an
utility (helper) function, but I guess it is here and not in Gitweb::Util
because of its dependency on parse_difftree_raw_line, and therefore it
would add circular dependency of Gitweb::Parse to Gitweb::Util.

> 
> Update 'gitweb/Makefile' to install Gitweb::Parse alongside gitweb.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---
>  gitweb/Makefile            |    1 +
>  gitweb/gitweb.perl         |  392 +-----------------------------------------
>  gitweb/lib/Gitweb/Parse.pm |  414 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 416 insertions(+), 391 deletions(-)
>  create mode 100644 gitweb/lib/Gitweb/Parse.pm

[...]
> diff --git a/gitweb/lib/Gitweb/Parse.pm b/gitweb/lib/Gitweb/Parse.pm
> new file mode 100644
> index 0000000..6eeef2c
> --- /dev/null
> +++ b/gitweb/lib/Gitweb/Parse.pm
> @@ -0,0 +1,414 @@
> +#!/usr/bin/perl
> +#
> +# Gitweb::Parse -- gitweb's parse_* subs package

Wouldn't "subroutines related to parsing output of git commands, required
by gitweb" be a better description here?

> +#
> +# This program is licensed under the GPLv2

Sidenote: do we want "GPLv2" or "GPLv2 or later", or even "GPLv2 or later,
at discretion of Junio C Hamano"?

> +
> +package Gitweb::Parse;
> +
> +use strict;
> +use warnings;
> +use Exporter qw(import);
> +
> +our @EXPORT = qw(parse_date parse_tag parse_commit_text parse_commit
> +                 parse_commits parse_difftree_raw_line parsed_difftree_line
> +                 parse_ls_tree_line parse_from_to_diffinfo unquote);

Sidenote: in the future commit we might want to not export 'unquote' by
default (but still be able to export it / export it with ':all' tag).
I don't think we use it outside subroutines defined in this module.
But I guess it is better left for a later commit.

> +
> +use Gitweb::Git qw(git_cmd);
> +use Gitweb::Request qw(@extra_options $hash $hash_parent);
> +use Gitweb::Escape qw(to_utf8);
> +use Gitweb::View qw(href chop_str age_string die_error);
> +use Gitweb::Util qw(fill_from_file_info is_deleted);

While at it, lets review those subroutines.

All those comments are meant for a future commit, and are not in any
way requirement for Pavan.  Splitting should in my opinion be just simple
code movement / code reorganization, without any changes.

> +# git may return quoted and escaped filenames
> +sub unquote {
> +	my $str = shift;
> +
> +	sub unq {
> +		my $seq = shift;
> +		my %es = ( # character escape codes, aka escape sequences
> +			't' => "\t",   # tab            (HT, TAB)
> +			'n' => "\n",   # newline        (NL)
> +			'r' => "\r",   # return         (CR)
> +			'f' => "\f",   # form feed      (FF)
> +			'b' => "\b",   # backspace      (BS)
> +			'a' => "\a",   # alarm (bell)   (BEL)
> +			'e' => "\e",   # escape         (ESC)
> +			'v' => "\013", # vertical tab   (VT)
> +		);
> +
> +		if ($seq =~ m/^[0-7]{1,3}$/) {
> +			# octal char sequence
> +			return chr(oct($seq));
> +		} elsif (exists $es{$seq}) {
> +			# C escape sequence, aka character escape code
> +			return $es{$seq};
> +		}
> +		# quoted ordinary character
> +		return $seq;
> +	}

Sidenote: I wonder if it wouldn't be better to move definition of 'unq'
subroutine to outside of 'unquote', i.e. do not nest subroutines.

> +
> +	if ($str =~ m/^"(.*)"$/) {
> +		# needs unquoting
> +		$str = $1;
> +		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;

Sidenote: hmmm... aren't digit escape sequences always three digits long,
with exception of '\0' for NUL byte?  I mean, wouldn't it be better to
use

  +		$str =~ s/\\([^0-7]|0|[0-7]{3})/unq($1)/eg;

> +	}
> +	return $str;
> +}
> +
> +## ----------------------------------------------------------------------
> +## parse to hash functions
> +

Sidenote: we would probably want to add description of this subroutine
later (in subsequent commits).  This subroutine takes e.g. authortime
as returned by git (epoch + numerical timezone), parses its and 
_formats_ to rfc2822, mday-time, ISO 8601 and other formats... hmmm...
perhaps we should separate parsing from formatting...

But all of this should be left for later commit.

> +sub parse_date {
> +	my $epoch = shift;
> +	my $tz = shift || "-0000";
> +
> +	my %date;
> +	my @months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
> +	my @days = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
> +	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($epoch);
> +	$date{'hour'} = $hour;
> +	$date{'minute'} = $min;
> +	$date{'mday'} = $mday;
> +	$date{'day'} = $days[$wday];
> +	$date{'month'} = $months[$mon];
> +	$date{'rfc2822'}   = sprintf "%s, %d %s %4d %02d:%02d:%02d +0000",
> +	                     $days[$wday], $mday, $months[$mon], 1900+$year, $hour ,$min, $sec;
> +	$date{'mday-time'} = sprintf "%d %s %02d:%02d",
> +	                     $mday, $months[$mon], $hour ,$min;
> +	$date{'iso-8601'}  = sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ",
> +	                     1900+$year, 1+$mon, $mday, $hour ,$min, $sec;
> +
> +	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
> +	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
> +	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($local);
> +	$date{'hour_local'} = $hour;
> +	$date{'minute_local'} = $min;
> +	$date{'tz_local'} = $tz;
> +	$date{'iso-tz'} = sprintf("%04d-%02d-%02d %02d:%02d:%02d %s",
> +	                          1900+$year, $mon+1, $mday,
> +	                          $hour, $min, $sec, $tz);
> +	return %date;
> +}
> +
> +sub parse_tag {
> +	my $tag_id = shift;
> +	my %tag;
> +	my @comment;
> +
> +	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;

In the future, when we move to using Git.pm (the "use Git", not 
"use Gitweb::Git"), it could be

  +	$repo->get_object_with_type("tag", $tag_id) or return;

Or not.  Or something like that.

> +	$tag{'id'} = $tag_id;
> +	while (my $line = <$fd>) {
> +		chomp $line;
> +		if ($line =~ m/^object ([0-9a-fA-F]{40})$/) {
> +			$tag{'object'} = $1;
> +		} elsif ($line =~ m/^type (.+)$/) {
> +			$tag{'type'} = $1;
> +		} elsif ($line =~ m/^tag (.+)$/) {
> +			$tag{'name'} = $1;
> +		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
> +			$tag{'author'} = $1;
> +			$tag{'author_epoch'} = $2;
> +			$tag{'author_tz'} = $3;
> +			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
> +				$tag{'author_name'}  = $1;
> +				$tag{'author_email'} = $2;
> +			} else {
> +				$tag{'author_name'} = $tag{'author'};
> +			}

Sidenote: I wonder if parsing name + email out of author / comitter /
/ tagger info shouldn't be moved to a separate subroutine, or is it not
worth it...

Again, better left for later commit.

> +		} elsif ($line =~ m/--BEGIN/) {
> +			push @comment, $line;
> +			last;

Sidenote: WTF is that?  The (ASCII armored) signature block can occur
only in the tag message (tag "payload"), and coun't be in heder, 
could it?

But fix of this issue should be left for later commit.

> +		} elsif ($line eq "") {
> +			last;
> +		}
> +	}
> +	push @comment, <$fd>;

  +	my @comment = <$fd>;

Again, this is better left for later commit.

> +	$tag{'comment'} = \@comment;
> +	close $fd or return;
> +	if (!defined $tag{'name'}) {
> +		return

  +		return;

Fix (I guess), better left for later commit.

> +	};
> +	return %tag

  +	return %tag;

Same.

> +}
> +

Sidenote: we should probably add description of this subroutine in
a later commit.

> +sub parse_commit_text {
> +	my ($commit_text, $withparents) = @_;

Sidenote: I wonder if using "named parameters" here wouldn't make
for a better API, i.e.

  +	my ($commit_text, %opts) = @_;
  +	my $withparents = $opts{'-with-parents'};

> +	my @commit_lines = split '\n', $commit_text;
> +	my %co;
> +
> +	pop @commit_lines; # Remove '\0'
> +
> +	if (! @commit_lines) {
> +		return;
> +	}
> +
> +	my $header = shift @commit_lines;
> +	if ($header !~ m/^[0-9a-fA-F]{40}/) {
> +		return;
> +	}
> +	($co{'id'}, my @parents) = split ' ', $header;

Those five lines above very much depend that the output is generated
by 'git rev-list --parents ...", i.e. that there is line with SHA-1
of commit, and then line with _effective_ parents of a commit.

> +	while (my $line = shift @commit_lines) {

Sidenote: parse_tag 'chomp's each line first.

> +		last if $line eq "\n";
> +		if ($line =~ m/^tree ([0-9a-fA-F]{40})$/) {
> +			$co{'tree'} = $1;
> +		} elsif ((!defined $withparents) && ($line =~ m/^parent ([0-9a-fA-F]{40})$/)) {
> +			push @parents, $1;

Sidenote: we would probably want to distinguish between real / original
parents (as recorded in the object) and effective parents (history 
simplification e.g. in 'history' view, and grafts).

> +		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
> +			$co{'author'} = to_utf8($1);
> +			$co{'author_epoch'} = $2;
> +			$co{'author_tz'} = $3;
> +			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
> +				$co{'author_name'}  = $1;
> +				$co{'author_email'} = $2;
> +			} else {
> +				$co{'author_name'} = $co{'author'};
> +			}

Sidenote: again, perhaps parsing of aithor info should be refactored
into a separate subroutine, to avoid code duplication.

> +		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
> +			$co{'committer'} = to_utf8($1);
> +			$co{'committer_epoch'} = $2;
> +			$co{'committer_tz'} = $3;
> +			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
> +				$co{'committer_name'}  = $1;
> +				$co{'committer_email'} = $2;
> +			} else {
> +				$co{'committer_name'} = $co{'committer'};
> +			}
> +		}

Same.

> +	}
> +	if (!defined $co{'tree'}) {
> +		return;
> +	};
> +	$co{'parents'} = \@parents;
> +	$co{'parent'} = $parents[0];
> +

This foreach skips initial (leading) empty lines.

> +	foreach my $title (@commit_lines) {
> +		$title =~ s/^    //;
> +		if ($title ne "") {
> +			$co{'title'} = chop_str($title, 80, 5);
> +			# remove leading stuff of merges to make the interesting part visible
> +			if (length($title) > 50) {
> +				$title =~ s/^Automatic //;
> +				$title =~ s/^merge (of|with) /Merge ... /i;
> +				if (length($title) > 50) {
> +					$title =~ s/(http|rsync):\/\///;
> +				}
> +				if (length($title) > 50) {
> +					$title =~ s/(master|www|rsync)\.//;
> +				}
> +				if (length($title) > 50) {
> +					$title =~ s/kernel.org:?//;
> +				}
> +				if (length($title) > 50) {
> +					$title =~ s/\/pub\/scm//;
> +				}
> +			}
> +			$co{'title_short'} = chop_str($title, 50, 5);

Sidenote: this simplification for 'title_short' should probably be
refactored into separate subroutine, and improved.  But that's a
matter for a later commit, if any.

> +			last;
> +		}
> +	}
> +	if (! defined $co{'title'} || $co{'title'} eq "") {
> +		$co{'title'} = $co{'title_short'} = '(no commit message)';
> +	}
> +	# remove added spaces
> +	foreach my $line (@commit_lines) {
> +		$line =~ s/^    //;
> +	}

Using 'map' would be probably more idiomatic:

  +	# remove added spaces
  +	map { s/^[ ]{4}// } @commit_lines;

> +	$co{'comment'} = \@commit_lines;
> +
> +	my $age = time - $co{'committer_epoch'};
> +	$co{'age'} = $age;
> +	$co{'age_string'} = age_string($age);

> +	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($co{'committer_epoch'});
> +	if ($age > 60*60*24*7*2) {
> +		$co{'age_string_date'} = sprintf "%4i-%02u-%02i", 1900 + $year, $mon+1, $mday;
> +		$co{'age_string_age'} = $co{'age_string'};
> +	} else {
> +		$co{'age_string_date'} = $co{'age_string'};
> +		$co{'age_string_age'} = sprintf "%4i-%02u-%02i", 1900 + $year, $mon+1, $mday;
> +	}

Sidenote: the above block should be probably refactored in a later commit.

> +	return %co;
> +}
> +
> +sub parse_commit {
> +	my ($commit_id) = @_;
> +	my %co;
> +
> +	local $/ = "\0";
> +
> +	open my $fd, "-|", git_cmd(), "rev-list",
> +		"--parents",
> +		"--header",
> +		"--max-count=1",
> +		$commit_id,
> +		"--",
> +		or die_error(500, "Open git-rev-list failed");
> +	%co = parse_commit_text(<$fd>, 1);

With new API (see above) it would be

  +	%co = parse_commit_text(<$fd>, -with-parents => 1);

> +	close $fd;
> +
> +	return %co;
> +}
> +
> +sub parse_commits {
> +	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;

Here a weakness (I think) of Perl way of passing subroutine arguments
is shown: it is impossible to have both slurpy @args and named parameters
i.e. %opts, unless we pass optional / named parameters in hashref, i.e.

  +	my ($commit_id, @args) = @_;
  +	my %opts = ('-max-count' => 1, '-skip' => 0);
  +	%opts = (%opts, %{ shift @args }) if ref($args[ 0]) eq 'HASH';
  +	%opts = (%opts, %{ pop   @args }) if ref($args[-1]) eq 'HASH';

or something like that, and then using $opts{'-max-count'} and 
$opts{'-skip'} in place of $maxcount and $skip, etc.

> +	my @cos;

Errrr... @commits or @commit_list.

> +
> +	$maxcount ||= 1;
> +	$skip ||= 0;
> +
> +	local $/ = "\0";
> +
> +	open my $fd, "-|", git_cmd(), "rev-list",
> +		"--header",
> +		@args,
> +		("--max-count=" . $maxcount),
> +		("--skip=" . $skip),
> +		@extra_options,
> +		$commit_id,
> +		"--",
> +		($filename ? ($filename) : ())
> +		or die_error(500, "Open git-rev-list failed");
> +	while (my $line = <$fd>) {

Hmmm... should it be called '$line' if it is "\0" separated chunk, 
i.e. single commit?  $commit_text could be better name, and if we
'chomp'ed it, we wouldn't have to 'pop' trailing "\0" in
parse_commit_text.

> +		my %co = parse_commit_text($line);
> +		push @cos, \%co;
> +	}
> +	close $fd;
> +
> +	return wantarray ? @cos : \@cos;

Nowadays I really wonder if it is such a good idea, and if it wouldn't
be better to just always return @cos (i.e. @commits / @commit_list).

We are a bit inconsistent WRT. context sensitivity.

> +}
> +
> +# parse line of git-diff-tree "raw" output
> +sub parse_difftree_raw_line {
> +	my $line = shift;
> +	my %res;
> +
> +	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
> +	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
> +	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
> +		$res{'from_mode'} = $1;
> +		$res{'to_mode'} = $2;
> +		$res{'from_id'} = $3;
> +		$res{'to_id'} = $4;
> +		$res{'status'} = $5;
> +		$res{'similarity'} = $6;
> +		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
> +			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
> +		} else {
> +			$res{'from_file'} = $res{'to_file'} = $res{'file'} = unquote($7);
> +		}
> +	}
> +	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
> +	# combined diff (for merge commit)
> +	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:[0-9a-fA-F]{40} )+)([a-zA-Z]+)\t(.*)$//) {
> +		$res{'nparents'}  = length($1);
> +		$res{'from_mode'} = [ split(' ', $2) ];
> +		$res{'to_mode'} = pop @{$res{'from_mode'}};
> +		$res{'from_id'} = [ split(' ', $3) ];
> +		$res{'to_id'} = pop @{$res{'from_id'}};
> +		$res{'status'} = [ split('', $4) ];
> +		$res{'to_file'} = unquote($5);
> +	}
> +	# 'c512b523472485aef4fff9e57b229d9d243c967f'
> +	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
> +		$res{'commit'} = $1;
> +	}
> +
> +	return wantarray ? %res : \%res;

Same here.

> +}
> +
> +# wrapper: return parsed line of git-diff-tree "raw" output
> +# (the argument might be raw line, or parsed info)
> +sub parsed_difftree_line {
> +	my $line_or_ref = shift;
> +
> +	if (ref($line_or_ref) eq "HASH") {
> +		# pre-parsed (or generated by hand)
> +		return $line_or_ref;
> +	} else {
> +		return parse_difftree_raw_line($line_or_ref);
> +	}
> +}
> +
> +# parse line of git-ls-tree output
> +sub parse_ls_tree_line {
> +	my $line = shift;
> +	my %opts = @_;
> +	my %res;
> +
> +	if ($opts{'-l'}) {
> +		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa   16717	panic.c'
> +		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40}) +(-|[0-9]+)\t(.+)$/s;
> +
> +		$res{'mode'} = $1;
> +		$res{'type'} = $2;
> +		$res{'hash'} = $3;
> +		$res{'size'} = $4;
> +		if ($opts{'-z'}) {
> +			$res{'name'} = $5;
> +		} else {
> +			$res{'name'} = unquote($5);
> +		}
> +	} else {
> +		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
> +		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
> +
> +		$res{'mode'} = $1;
> +		$res{'type'} = $2;
> +		$res{'hash'} = $3;
> +		if ($opts{'-z'}) {
> +			$res{'name'} = $4;
> +		} else {
> +			$res{'name'} = unquote($4);
> +		}

Hmmm... not all parse_* subroutines that can support '-z' named
option do it.

> +	}
> +
> +	return wantarray ? %res : \%res;

Same issue about context sensitivity here.

> +}
> +
> +# generates _two_ hashes, references to which are passed as 2 and 3 argument
> +sub parse_from_to_diffinfo {
> +	my ($diffinfo, $from, $to, @parents) = @_;
> +
> +	if ($diffinfo->{'nparents'}) {
> +		# combined diff
> +		$from->{'file'} = [];
> +		$from->{'href'} = [];
> +		fill_from_file_info($diffinfo, @parents)
> +			unless exists $diffinfo->{'from_file'};
> +		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
> +			$from->{'file'}[$i] =
> +				defined $diffinfo->{'from_file'}[$i] ?
> +				        $diffinfo->{'from_file'}[$i] :
> +				        $diffinfo->{'to_file'};
> +			if ($diffinfo->{'status'}[$i] ne "A") { # not new (added) file
> +				$from->{'href'}[$i] = href(action=>"blob",
> +				                           hash_base=>$parents[$i],
> +				                           hash=>$diffinfo->{'from_id'}[$i],
> +				                           file_name=>$from->{'file'}[$i]);
> +			} else {
> +				$from->{'href'}[$i] = undef;
> +			}
> +		}
> +	} else {
> +		# ordinary (not combined) diff
> +		$from->{'file'} = $diffinfo->{'from_file'};
> +		if ($diffinfo->{'status'} ne "A") { # not new (added) file
> +			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
> +			                       hash=>$diffinfo->{'from_id'},
> +			                       file_name=>$from->{'file'});
> +		} else {
> +			delete $from->{'href'};
> +		}
> +	}
> +
> +	$to->{'file'} = $diffinfo->{'to_file'};
> +	if (!is_deleted($diffinfo)) { # file exists in result
> +		$to->{'href'} = href(action=>"blob", hash_base=>$hash,
> +		                     hash=>$diffinfo->{'to_id'},
> +		                     file_name=>$to->{'file'});
> +	} else {
> +		delete $to->{'href'};
> +	}
> +}

Hmmm... this subroutine is not exactly like the other.  I wonder if it
wouldn't be better to leave it together with git_patchset_body.  Or
with fill_from_file_info.

> +
> +1;
> -- 
> 1.7.1.455.g8f441

-- 
Jakub Narebski
Poland
