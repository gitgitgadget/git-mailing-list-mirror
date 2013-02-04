From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 1/3] Add contrib/credentials/netrc with GPG support
Date: Mon, 04 Feb 2013 13:33:22 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87k3qoudxp.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87sj5cvxnf.fsf_-_@lifelogs.com>
	<7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:33:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2QrU-0002c5-Pm
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 19:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab3BDSd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 13:33:26 -0500
Received: from z.lifelogs.com ([173.255.230.239]:41759 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754067Ab3BDSdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 13:33:25 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 2DF9CDE0C5;
	Mon,  4 Feb 2013 18:33:23 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vk3qo2dsc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Feb 2013 09:24:03 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215406>

--=-=-=
Content-Type: text/plain

On Mon, 04 Feb 2013 09:24:03 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> [administrivia: I would really wish you didn't put "Mail-copies-to:
JCH> never" above].

I normally post through GMane and don't need the extra CC on any list I
read.  I'll make an effort to remove that header here, and apologize for
the inconvenience.

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:

>> +foreach my $v (values %{$options{tmap}})
>> +{
>> + $options{tmap}->{$v} = $v;
>> +}

JCH> Please follow the styles of existing Perl scripts, e.g. indent with
JCH> tab, etc.  Style requests are not optional; it is a prerequisite to
JCH> make the patch readable and reviewable.

Sorry, I didn't realize contrib/ stuff was under the same rules.  I will
attempt to make my contributions fit the project's requirements.

It would help if the requirements were codified as the fairly standard
Emacs file-local variables, so I can just put them in the Perl code or
in .dir-locals.el in the source tree.  At least for Perl I'd like that,
and it could be nice for the Emacs users who write C too.

Would you like me to propose that as a patch?

Either way, I guessed that these settings are what you want as far as
tabs and indentation (I use cperl-mode but perl-mode is the same):

# -*- mode: cperl; tab-width: 8; cperl-indent-level: 4; indent-tabs-mode: t; -*-

...plus hanging braces and avoiding one-line blocks.  I hope that's right.

>> + print <<EOHIPPUS;
>> + ...
>> +EOHIPPUS

JCH> Do we really need to refer readers to Wikipedia or something to
JCH> learn about extinct equid ungulates ;-)?

I think the marker's name is irrelevant, and hope you are OK with
leaving it.

Since the change is a pretty big reformatting, should I squash my 3
commits plus the reformatting commit into one patch, or keep them as a
series?

I am appending the script in its current form so you can review it and
tell me if there's anything else I should add or change in the
formatting.

Thanks
Ted


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=git-credential-netrc
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl
# -*- mode: cperl; tab-width: 8; cperl-indent-level: 4; indent-tabs-mode: t=
; -*-

use strict;
use warnings;

use Getopt::Long;
use File::Basename;

my $VERSION =3D "0.1";

my %options =3D (
               help =3D> 0,
               debug =3D> 0,

               # identical token maps, e.g. host -> host, will be inserted =
later
               tmap =3D> {
                        port =3D> 'protocol',
                        machine =3D> 'host',
                        path =3D> 'path',
                        login =3D> 'username',
                        user =3D> 'username',
                        password =3D> 'password',
                       }
              );

# map each credential protocol token to itself on the netrc side
$options{tmap}->{$_} =3D $_ foreach my $v (values %{$options{tmap}});

foreach my $suffix ('.gpg', '') {
    foreach my $base (qw/authinfo netrc/) {
	my $file =3D glob("~/.$base$suffix");
	next unless (defined $file && -f $file);
	$options{file} =3D $file ;
    }
}

Getopt::Long::Configure("bundling");

# TODO: maybe allow the token map $options{tmap} to be configurable.
GetOptions(\%options,
           "help|h",
           "debug|d",
           "file|f=3Ds",
          );

if ($options{help}) {
    my $shortname =3D basename($0);
    $shortname =3D~ s/git-credential-//;

    print <<EOHIPPUS;

$0 [-f AUTHFILE] [-d] get

Version $VERSION by tzz\@lifelogs.com.  License: BSD.

Options:
  -f AUTHFILE: specify a netrc-style file
  -d: turn on debugging

To enable (note that Git will prepend "git-credential-" to the helper
name and look for it in the path):

  git config credential.helper '$shortname -f AUTHFILE'

And if you want lots of debugging info:

  git config credential.helper '$shortname -f AUTHFILE -d'

Only "get" mode is supported by this credential helper.  It opens
AUTHFILE and looks for entries that match the requested search
criteria:

 'port|protocol':
   The protocol that will be used (e.g., https). (protocol=3DX)

 'machine|host':
   The remote hostname for a network credential. (host=3DX)

 'path':
   The path with which the credential will be used. (path=3DX)

 'login|user|username':
   The credential=E2=80=99s username, if we already have one. (username=3DX)

Thus, when we get "protocol=3Dhttps\nusername=3Dtzz", this credential
helper will look for lines in AUTHFILE that match

port https login tzz

OR

protocol https login tzz

OR... etc. acceptable tokens as listed above.  Any unknown tokens are
simply ignored.

Then, the helper will print out whatever tokens it got from the line,
including "password" tokens, mapping e.g. "port" back to "protocol".

The first matching line is used.  Tokens can be quoted as 'STRING' or
"STRING".

No caching is performed by this credential helper.

EOHIPPUS

    exit;
}

my $mode =3D shift @ARGV;

# credentials may get 'get', 'store', or 'erase' as parameters but
# only acknowledge 'get'
die "Syntax: $0 [-f AUTHFILE] [-d] get" unless defined $mode;

# only support 'get' mode
exit unless $mode eq 'get';

my $debug =3D $options{debug};
my $file =3D $options{file};

die "Sorry, you need to specify an existing netrc file (with or without a .=
gpg extension) with -f AUTHFILE"
 unless defined $file;

unless (-f $file) {
    print STDERR "Sorry, the specified netrc $file is not accessible\n" if =
$debug;
    exit 0;
}

my @data;
if ($file =3D~ m/\.gpg$/) {
    @data =3D load('-|', qw(gpg --decrypt), $file)
}
else {
    @data =3D load('<', $file);
}

chomp @data;

unless (scalar @data) {
    print STDERR "Sorry, we could not load data from [$file]\n" if $debug;
    exit;
}

# the query: start with every token with no value
my %q =3D map { $_ =3D> undef } values(%{$options{tmap}});

while (<STDIN>) {
    next unless m/([^=3D]+)=3D(.+)/;

    my ($token, $value) =3D ($1, $2);
    die "Unknown search token $1" unless exists $q{$token};
    $q{$token} =3D $value;
}

# build reverse token map
my %rmap;
foreach my $k (keys %{$options{tmap}}) {
    push @{$rmap{$options{tmap}->{$k}}}, $k;
}

# there are CPAN modules to do this better, but we want to avoid
# dependencies and generally, complex netrc-style files are rare

if ($debug) {
    printf STDERR "searching for %s =3D %s\n", $_, $q{$_} || '(any value)'
     foreach sort keys %q;
}

LINE: foreach my $line (@data) {

    print STDERR "line [$line]\n" if $debug;
    my @tok;
    # gratefully stolen from Net::Netrc
    while (length $line &&
	   $line =3D~ s/^("((?:[^"]+|\\.)*)"|((?:[^\\\s]+|\\.)*))\s*//) {
	(my $tok =3D $+) =3D~ s/\\(.)/$1/g;
	push(@tok, $tok);
    }

    # skip blank lines, comments, etc.
    next LINE unless scalar @tok;

    my %tokens;
    while (@tok) {
	my ($k, $v) =3D (shift @tok, shift @tok);
	next unless defined $v;
	next unless exists $options{tmap}->{$k};
	$tokens{$options{tmap}->{$k}} =3D $v;
    }

    foreach my $check (sort keys %q) {
	if (exists $tokens{$check} && defined $q{$check}) {
	    print STDERR "comparing [$tokens{$check}] to [$q{$check}] in line [$li=
ne]\n" if $debug;
	    next LINE unless $tokens{$check} eq $q{$check};
	}
	else {
	    print STDERR "we could not find [$check] but it's OK\n" if $debug;
	}
    }

    print STDERR "line has passed all the search checks\n" if $debug;
 TOKEN:
    foreach my $token (sort keys %rmap) {
	print STDERR "looking for useful token $token\n" if $debug;
	next unless exists $tokens{$token}; # did we match?

	foreach my $rctoken (@{$rmap{$token}}) {
	    next TOKEN if defined $q{$rctoken};           # don't re-print given t=
okens
	}

	print STDERR "FOUND: $token=3D$tokens{$token}\n" if $debug;
	printf "%s=3D%s\n", $token, $tokens{$token};
    }

    last;
}

sub load {
    # this supports pipes too
    my $io =3D new IO::File(@_) or die "Could not open [@_]: $!\n";
    return <$io>;                          # whole file
}

--=-=-=--
