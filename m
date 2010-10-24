From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: complete config list from other manpages
Date: Sun, 24 Oct 2010 16:36:50 +0200
Message-ID: <201010241636.51106.jnareb@gmail.com>
References: <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch> <8145782bddf60325909f328337cb76d25c4402cf.1287872553.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 24 16:37:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA1hF-0007CQ-2o
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 16:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613Ab0JXOhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 10:37:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47521 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085Ab0JXOhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 10:37:05 -0400
Received: by bwz11 with SMTP id 11so1720981bwz.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=34O7tSEDiCM2hRiM8gsIGY6BbawjOD4bNPzMNCkCoss=;
        b=Meu3RVVbaXarej+WBTVQ6jrNBxpmEOUlVc2nwl6JjCZIlEflh9VUE8jvCvlTkda+jy
         eDe54Y2/ge7nN7ey47EdxYwFY0u/JBJx86UuKYXaIUv3j586a6XeWPH27ydsKipeXdqz
         IEAEnKgp9v9jrsnK/wHLgscPTvBtNsUp3z3DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wpM/0YRZNt17kgLQqckWU7l/Eq8WqWlowQUVWlA87ON9XO0nlB5UiRXTyjrYxn/ePn
         MgwRI2ikka5fA59sLi5Jzan16KDaYZNdVyHl83CBgQgSRs2MQvmjG09XZbypAKNagzd1
         Wa+d1nQvLKphY1LDvt+TnuhUviFHhJR3WJa3w=
Received: by 10.204.72.19 with SMTP id k19mr461365bkj.194.1287931023730;
        Sun, 24 Oct 2010 07:37:03 -0700 (PDT)
Received: from [192.168.1.13] (abvu207.neoplus.adsl.tpnet.pl [83.8.218.207])
        by mx.google.com with ESMTPS id p34sm3929644bkf.15.2010.10.24.07.36.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 07:37:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8145782bddf60325909f328337cb76d25c4402cf.1287872553.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159876>

This is second review, with the same comments ad the one before,
and containing proposal for simpler autogeneration script.

On Sat, 24 Oct 2010, Thomas Rast wrote:

> Add an autogeneration script that inserts links to other manpages
> describing config variables,

Actualy it is "Add ... and run it to generate config-vars.txt",
or "Create ... and use it to ...", isn't it.

> as follows: 
> 
> * parse config-vars-src.txt (as it now needs to be renamed) to find
>   out its current contents
> 
> * parse each manpage source (following includes) for config variable
>   headers (the blocks are ignored)
> 
> * assemble a new config-vars.txt that completes the original list with
>   "See linkgit:git-foo[1]" entries for all variables that were not in
>   it.

I find this itemized list slightly hard to read (as you can see by the
confusion shown in previous review of this patch).  I think it would be
better to describe _goal_ of this script first, and only then how it 
does that.

For example:

  The Documentation/make-config-list.perl script finds all config
  variables that are defined in individual manpages that are missing
  from the list of all config variable (in git-config(1) manpage).
  It then generates stub[1] documentation for those missing config
  variables at appropriate place in Documentation/config-vars.txt,
  using the following form:

    foo.bar::
    foo.baz::
    	See linkgit:git-foo[1].

  It does that by parsing config-vars-src.txt (now source for 
  config-vars.txt) getting list of all config variables to find later
  which ones are missing, parsing each manpage source provided on 
  command line (following includes) for config variable headers to
  find which config variables are described directly on individual
  manpages, then it assembles config-vars.txt with missing variables
  added[2].

  NOTE that as a side-effect list of config variables would be sorted
  in alphabetical order[3]

[1] Not a best word, but I couldn't think of a better one.
[2] This paragraph could be done as itemized list, as before.
[3] In my proposal it is not necessary; note that some of config 
    variables are grouped _by function_ to be close together, and
    your script would destroy that.

> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> 
> Jakub Narebski wrote:
> > Could you please resend this patch using rename detection 
> > (git format-patch -M)?  It would make it clear what the difference
> > between config-vars and config-vars-src is, if any.
> 
> Right, sorry about that.  There wasn't supposed to be any; I'm
> resending what I pushed out for everyone's convenience, but the stray
> change will be gone in the final version.

Stray changes (there are 2 of them).

>  Documentation/Makefile                             |    9 ++-
>  .../{config-vars.txt => config-vars-src.txt}       |    2 +-
>  Documentation/make-config-list.perl                |  131 ++++++++++++++++++++
>  3 files changed, 140 insertions(+), 2 deletions(-)
>  rename Documentation/{config-vars.txt => config-vars-src.txt} (99%)
>  create mode 100755 Documentation/make-config-list.perl
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index e117bc4..747b849 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -125,7 +125,7 @@ endif
>  
>  SHELL_PATH ?= $(SHELL)
>  # Shell quote;
> -SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
> +SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH)) #'
>  
>  #
>  # Please note that there is a minor bug in asciidoc.

Stray change, doesn't belong in this commit (and probably should be
skipped altogether).

BTW. there was a proposal to do something like that by saving quote
in a variable, and using it in shell quoting...

> @@ -320,6 +320,13 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
>  	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
>  	mv $@+ $@
>  
> +config-vars.txt: config-vars-src.txt $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
> +	./make-config-list.perl --mainlist=config-vars-src.txt \
> +		--ignore=config-vars.txt \
> +		$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT) \
> +		> config-vars.txt+ && \


Very, very minor nitpick: wouldn't it read better as the following?

  +	./make-config-list.perl \
  +		--mainlist=config-vars-src.txt \
  +		--ignore=config-vars.txt \
  +		$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT) \
  +		> config-vars.txt+ && \

> +		> config-vars.txt+ && \
> +	mv config-vars.txt+ config-vars.txt
> +
>  $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
>  	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
>  
> diff --git a/Documentation/config-vars.txt b/Documentation/config-vars-src.txt
> similarity index 99%
> rename from Documentation/config-vars.txt
> rename to Documentation/config-vars-src.txt
> index a8d37a7..949259c 100644
> --- a/Documentation/config-vars.txt
> +++ b/Documentation/config-vars-src.txt
> @@ -936,7 +936,7 @@ gitcvs.dbname::
>  
>  gitcvs.dbdriver::
>  	Used Perl DBI driver. You can specify any available driver
> -        for this here, but it might not work. git-cvsserver is tested
> +	for this here, but it might not work. git-cvsserver is tested
>  	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
>  	reported *not* to work with 'DBD::mysql'. Experimental feature.
>  	May not contain double colons (`:`). Default: 'SQLite'.

Stray change (spaces to tab), which should be done as separate 
"whitespace cleanup" patch.

> diff --git a/Documentation/make-config-list.perl b/Documentation/make-config-list.perl
> new file mode 100755
> index 0000000..f086867
> --- /dev/null
> +++ b/Documentation/make-config-list.perl
> @@ -0,0 +1,131 @@
> +#!/usr/bin/perl
> +
> +use strict;
> +use warnings;
> +use Getopt::Long;
> +
> +my %ignore;
> +
> +my $rc = GetOptions(
> +	"mainlist=s" => \my $mainlistfile,
> +	"ignore=s" => sub { $ignore{$_[1]} = 1 },
> +	"no-sort" => \my $no_sort,
> +	);

Errr, wouldn't it be better to do it this way:

  +my $sort = 1;
  +my $rc = GetOptions(
  +	"mainlist=s" => \my $mainlistfile,
  +	"ignore=s" => \my @ignore,
  +	"sort!" => \$sort,
  +);
  +my %ignore = map { $_ => 1 } @ignore;

Though it is not necessary; I guess it is a matter of taste.

BTW. does your sript work correctly with `--no-sort`?

> +
> +if (!$rc or (!-r $mainlistfile)) {
> +	print "$0 --mainlist=<mainlist> [--ignore=<ignore>...] <asciidoc_manpage>...\n";
> +	exit 1;
> +}

I'd rather you did a better error handling:

  +if (!$rc || !defined $mainlistfile) {
  +	print "$0 --mainlist=<mainlist> [--ignore=<ignore>...] <asciidoc_manpage>...\n";
  +	exit 1;
  +}

and leave handling '!-r $mainlistfile' to read_varlist() subroutine.

> +

This subroutine needs description, I think; at least oneline comment
describing it.

> +sub read_varlist {
> +	my ($file) = @_;
> +
> +	open my $fh, "<", $file or die "cannot open $file: $!";

You are a bit inconsistent here.  read_varlist() has

   	open my $fh, "<", $file or die "cannot open $file: $!";

while read_file() has

   	my $fp;
   	open $fp, '<', $name or die "open $name failed: $!";

Note that you can use the same name of filehandle (e.g. $fh), as it is
local to the subroutine.

> +	my (%mainlist, @mainvars);
> +
> +	my ($v, $last_v);
> +	my $in_block = 0;

I would done this differently, and IMHO in a simpler way.  Instead of
generating %mainvars structure, that holds for each variable the contents
of its description (in the form of list of lines), adding missing 
variables to it, and then (re)generating config-vars.txt from it:

  --mainlist=config-vars-src.txt
          |
          v
  @mainlist, %mainvars
          |
          |  <-- %vars <-- <asciidoc_manpage>...
          |
          v
  @all_keys, %out
          |
          v
  > config-vars.txt+

wouldn't it be better to simply store where description of each variable
begins in a file (line number, or file position), and then use it to 
inject generated description for missing variables in correct place?

> +	while (<$fh>) {
> +		if (/^(\S+)::/) {
> +			$v = lc $1;

Note: because you are (re)generating config-vars.txt from those data
structures this has an unfortunate side-effect of lowercasing all config
variable names in final config-bars.txt, e.g. it would replace
`core.ignoreCygwinFSTricks` with `core.ignorecygwinfstricks`.

> +			$in_block = 0;
> +			push @{$mainlist{$v}}, $_;
> +			push @mainvars, $v;

So in the proposed implementation it would simply be:

  +			$mainlist{lc($v)} = $.;
  +			push @mainvars, $v;

I think lc($v) is needed only in %mainlist keys.

> +		} elsif (/^$/ && !$in_block) {
> +			if (defined $last_v && !$#{$mainlist{$last_v}}) {
> +				$mainlist{$last_v} = $mainlist{$v};
> +			}
> +			$last_v = $v;

Besides, if I understand it correctly, that any empty line which does
not precede config variable definition, and is not inside literal block,
is a *bug* in AsciiDoc markup.  It should be "^+$" (continuation),
not "^$".

This branch of conditional would be simply not required in proposed
alternate solution.


By the way, why you do not follow includes in this file (for example
'include::merge-config.txt[]'?

> +		} elsif (defined $v) {
> +			push @{$mainlist{$v}}, $_;
> +			$in_block = !$in_block if /^--$/;
> +		}

This branch of conditional would be simply not required in proposed
alternate solution.

Well... assuming that we do not have lines matching /^(\S+)::/ in literal
blocks (which we don't, and which you also assume).

> +	}
> +
> +	close $fh or die "eh? close failed: $!";

You are a bit inconsistent here.  read_varlist() has

   	close $fh or die "eh? close failed: $!";

while read_file() has

   	close $fp or die "close $name failed: $!";

> +
> +	return \%mainlist, \@mainvars;
> +}
> +
> +my %vars;
> +my %sections;

I think those variables needs better names, for example
%vars_manpages (as it is mapping from config variable name found in
manpage to list of manpages it was found in) and %manpage_section
(as it is mapping from manpage name to man section, for purpose of
linking).

Though perhaps %vars could be left as is...

> +

This subroutine needs description, I think; at least oneline comment
describing it.  And probably better name, like read_manpage().

> +sub read_file {
> +	my ($name, $main_name) = @_;
> +	if (!defined $main_name) {
> +		$main_name = $name;
> +	}
> +	my $manpage_name = $main_name;
> +	$manpage_name =~ s/\.txt//;

Wouldn't it be simpler to pass $filename, $manpage as arguments to
read_file(), rather than $filename/$name, $main_name?

It would read as:

  +# Parse manpages for config variables and sections, following includes
  +sub read_manpage {
  +	my ($filename, $manpage) = @_;
  +	if (!defined $manpage) {
  +		$manpage = $filename;
  +		$manpage =~ s/\.txt//;
  +	}

And of course s/$name/$filename/ and s/$manpage_name/$manpage/.  Well, 
the change of variable names is not really necessary.

> +	my $fp;
> +	open $fp, '<', $name or die "open $name failed: $!";
> +	while (<$fp>) {
> +		if ($. < 5 && /^$manpage_name\((\d+)\)/) {
> +			$sections{$manpage_name} = $1;
> +		}
> +		if (/^([a-z0-9]+\.[a-z<>0-9.]+)::/) {
> +			push @{$vars{$1}}, $manpage_name;
> +		}
> +		if (/^include::\s*(\S+)\s*\[\]/
> +		    && !exists $ignore{$1}) {
> +			read_file($1, $main_name);
> +		}
> +	}
> +	close $fp or die "close $name failed: $!";
> +}
> +
> +foreach my $name (@ARGV) {
> +	read_file($name);
> +}

O.K. nicely done.  This would be unchanged in proposed alternate 
solution.

> +
> +my ($mainlist, $mainvars) = read_varlist($mainlistfile);
> +
> +my @all_keys = @$mainvars;
> +foreach my $k (keys %vars) {
> +	if (!exists $mainlist->{$k}) {
> +		push @all_keys, $k;
> +	}
> +}

I propose the following:

  +my @missing_vars = ();
  +foreach my $k (keys %vars) {
  +	if (!exists $mainlist->{$k}) {
  +		push @missing_vars, $k;
  +	}
  +}

or even

  +foreach my $k (keys %vars) {
  +	if (exists $mainlist->{$k}) {
  +		delete $vars{$k};
  +	}
  +}

so that %vars would now contain only missing variables.

> +
> +@all_keys = sort @all_keys unless $no_sort;

So if you pass `--no-sort` to this script, all missing variables would
be put at the end, and if you pass it, the order of variables would be
changed, isn't it?

> +
> +my %out;
> +foreach my $k (@all_keys) {
> +	if (exists $mainlist->{$k}) {
> +		push @{$out{$k}}, @{$mainlist->{$k}}, "\n";
> +	} elsif (exists $vars{$k}) {
> +		push @{$out{$k}}, $k . "::\n";
> +		push @{$out{$k}}, "\tSee ";
> +		my $sep = " ";
> +		foreach my $p (sort @{$vars{$k}}) {
> +			next if ($p =~ /$mainlistfile/);
> +			if (!exists $sections{$p}) {
> +				warn "section for $p unknown";
> +				$sections{$p} = 1;
> +			}
> +			push @{$out{$k}}, $sep . "linkgit:" . $p . "[" . $sections{$p} . "]";
> +			$sep = ", ";
> +		}
> +		push @{$out{$k}}, ".\n\n";
> +	} else {
> +		die "can't happen: $k not in any source";
> +	}
> +}
> +
> +for (my $i = 0; $i < $#all_keys; $i++) {
> +	next if $#{$out{$all_keys[$i]}} != $#{$out{$all_keys[$i+1]}};
> +	my $same = 1;
> +	for (my $j = 1; $j <= $#{$out{$all_keys[$i]}}; $j++) {
> +		if ($out{$all_keys[$i]}[$j] ne $out{$all_keys[$i+1]}[$j]) {
> +			$same = 0;
> +			last;
> +		}
> +	}
> +	if ($same) {
> +		$out{$all_keys[$i]} = [$out{$all_keys[$i]}[0]];
> +	}
> +}
> +
> +foreach my $k (@all_keys) {
> +	print @{$out{$k}};
> +}

Instead of that, I would propose the following UNTESTED code:

-- 8< --
%vars = find_insertion_points($mainlist, \%vars);
# %vars has now the following format:
# 'name' => {
# 	'lineno' => line of $mainfile where description should be inserted
# 	'manpages' => [ <manpage_name>... ]
# }

# group by insertion point
my %insertion_point; ## or just %insert
foreach my $v (keys %vars) {
	push @{$insertion_point{$v->{'lineno'}}}, $v;
}

open my $fh, '<', $mainfile
	or die "cannot open '$mainfile': $!";
while (my $line = <$fh>) {
	if (exists $insertion_point{$.}) {
		print document_vars($insertion_point{$.}, \%vars);
		print "\n";
	}
	print $line;
}
# special case: insertion after last line in $mainfile
print document_vars($insertion_point{-1}, \%vars)
	if exists $insertion_point{-1};
close $fh
	or die "cannot close '$mainfile': $!";

exit 0;

## those subroutines should probably be defined earlier

sub find_insertion_points {
	my ($mainlist, $missing_vars) = @_;

	my %res; ## not required if we modify %$missing_vars in-place

	my %all_vars = (%$mainlist, %$missing_vars);
	my $lineno = -1; # means after last line

	# reverse order because we want to find a place before which to insert
	# generated documentation; it is easy to find where description
	# of variable begins, but in general harder to find where it ends.
	foreach my $key (reverse sort { lc($a) cmp lc($b) } keys %all_vars) {
		my $val = $all_vars{$key};
		if (ref $val) {
			# this came from %$missing_vars
			$res{$v} = { 'lineno' => $lineno, 'manpages' => $val };
			## or $missing_vars->{$v} instead of $res{$v} if in-place
		} else {
			# this came from %$mainlist
			$lineno = $value;
		}
	}
	return %res; ## not required if in-place
}

## this is single place where we need to change code if output changes,
## e.g. to
##
##   format.attach         linkgit:git-format-patch[1]
##   format.cc             linkgit:git-format-patch[1]
##   format.headers        linkgit:git-format-patch[1]
##   format.pretty         linkgit:gitpretty[7]
sub document_vars {
	my ($keylist, $vars) = @_;

	# generate output for each key now, to compact output, because it is
	# easier to compare strings than arrays
	foreach my $k (@$keylist) {
		$vars->{$k}{'output'} = "\tSee: ".gen_links($vars->{$k}{'manpages'}).".\n";
	}

	my $output = '';
	## the below could be done in different way, e.g. using new array for
	## sorted keys, and using 'my $k = pop @keys' etc.
	$keylist = [ sort @$keylist ];
	for (my $i = 0; $i < @$keylist; $i++) {
		my $k = $keylist->[$i];
		$output .= "$k::\n";
		unless ($i <= $#@$keylist &&
		        $keylist->[$i]{'output'} eq $keylist->[$i+1]{'output'}) {
			$output .= $k->{'output'};
		}
	}

	return $output;
}

## we can make it smarter in the future, for example:
## 'linkgit:git-foo[1], linkgit:git-bar[1] and linkgit:git-baz[1] for details';
sub gen_links {
	my $manpages = shift;
	return join(", ", map { linkgit($_) } @$manpages);
}

sub linkgit {
	my $manpage = shift;

	if (!exists $manpage_section{$manpage}) {
		warn "section for $manpage unknown\n";
		$manpage_section{$manpage} = 1;
	}
	return "linkgit:${manpage}[$manpage_section{$manpage}]";
}

__END__
-- >8 --

-- 
Jakub Narebski
Poland
