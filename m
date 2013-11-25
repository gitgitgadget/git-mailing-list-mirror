From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH] gitweb: Make showing branches configurable
Date: Mon, 25 Nov 2013 10:37:20 +0100
Message-ID: <1385372240.2182.8.camel@localhost.localdomain>
References: <1385125848-8243-1-git-send-email-krzesimir@endocode.com>
	 <xmqqhab41gsu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 10:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vksbk-0005gF-NL
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 10:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab3KYJh2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 04:37:28 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:62100 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3KYJh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 04:37:27 -0500
Received: by mail-bk0-f44.google.com with SMTP id d7so1836701bkh.31
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 01:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=e7dfOqWy4agA4BuweFJ5lJsU8kn7IXvNkLRci/2DBUg=;
        b=ia7CRq0N8EHI7fyigYUs+nV3Q2rT2z5EnUojNsxhpFKp0nVilJerDQkJn5NK2ex7i5
         wKpEATDOHvnaRXAFObqnD4o371aTESW+zr89f7PvyLz+mFCddFZA/Gs5926fBvxaKT29
         QjaQWGB1FtHA3Dyv1uGnyow5gTMjDfSmFUDkJXF7Hvdch0LmFZCmD1P/7Ir9eHkHQAN8
         eOmR7WE8eb5PEcVRQKwaIUzyaITuGqV5em0qw+8++2ce/v4iEZ4t3AumGN0/cnq65hsj
         VRqfVSTdf/MEJi+86LrbS7er6Zlyu385I/NwQTkv4jwawaBvzJi4CdUq/OoGiJ+hk7rI
         lUuA==
X-Gm-Message-State: ALoCoQlnPJfYIcu0woBxSbaeRdHoBNszgJ/pCbZVh/U77yCuvYpVe2BguJJJohJjDRDF0/6WJwuI
X-Received: by 10.204.114.12 with SMTP id c12mr593436bkq.61.1385372245482;
        Mon, 25 Nov 2013 01:37:25 -0800 (PST)
Received: from [192.168.1.100] (95-91-241-78-dynip.superkabel.de. [95.91.241.78])
        by mx.google.com with ESMTPSA id qe6sm44998658bkb.5.2013.11.25.01.37.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 01:37:24 -0800 (PST)
In-Reply-To: <xmqqhab41gsu.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238306>

On Fri, 2013-11-22 at 09:34 -0800, Junio C Hamano wrote:
> Krzesimir Nowak <krzesimir@endocode.com> writes:
>=20
> > Running 'make GITWEB_WANTED_REFS=3D"heads wip" gitweb.cgi' will cre=
ate a
> > gitweb CGI script showing branches that appear in refs/heads/ and i=
n
> > refs/wip/. Might be useful for gerrit setups where user branches ar=
e
> > not stored under refs/heads/.
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > ---
> >
> > Notes:
> >     I'm actually not sure if all those changes are really necessary=
 as I
> >     was mostly targeting it for Gerrit use. Especially I mean the c=
hanges
> >     in git_get_remotes_list, fill_remote_heads and print_page_nav. =
I tried
> >     to make it as general as it gets, so there's nothing Gerrit spe=
cific.
>=20
> Thanks.
>=20
> Two knee-jerk reactions after a quick scan.
>=20
>  - You include "heads" for normal builds by hardcoded
>    "GITWEB_WANTED_REFS =3D heads" but include "tags" unconditionally
>    by having @ref_views =3D ("tags", @wanted_refs) in the code.  Why?
>=20

Earlier both "tags" and "heads" were hardcoded there. So now instead of
"heads" we have @wanted_refs.

I suppose I should have given it a better name, like @branch_refs.
Right?

>  - Does this have be a compile-time decision?  It looks like this is
>    something that can and should be made controllable with the
>    normal gitweb configuration mechanism.
>=20

Maybe. I was just looking at Makefile and saw a bunch of configuration
options there, so I just added another one. Haven't noticed the gitweb
config thing. Sorry.

So, we should just hardcode the @wanted_refs (or @branch_refs after the
rename) to simply ('heads'), let it be overriden by perl gitweb config
file and get rid of a new substitution from Makefile?

>=20
> >  gitweb/Makefile    |  4 ++-
> >  gitweb/gitweb.perl | 94 +++++++++++++++++++++++++++++++++++++++---=
------------
> >  2 files changed, 72 insertions(+), 26 deletions(-)
> >
> > diff --git a/gitweb/Makefile b/gitweb/Makefile
> > index cd194d0..361dce9 100644
> > --- a/gitweb/Makefile
> > +++ b/gitweb/Makefile
> > @@ -38,6 +38,7 @@ GITWEB_SITE_HTML_HEAD_STRING =3D
> >  GITWEB_SITE_HEADER =3D
> >  GITWEB_SITE_FOOTER =3D
> >  HIGHLIGHT_BIN =3D highlight
> > +GITWEB_WANTED_REFS =3D heads
> > =20
> >  # include user config
> >  -include ../config.mak.autogen
> > @@ -148,7 +149,8 @@ GITWEB_REPLACE =3D \
> >  	-e 's|++GITWEB_SITE_HTML_HEAD_STRING++|$(GITWEB_SITE_HTML_HEAD_ST=
RING)|g' \
> >  	-e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
> >  	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
> > -	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g'
> > +	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g' \
> > +	-e 's|++GITWEB_WANTED_REFS++|$(GITWEB_WANTED_REFS)|g'
> > =20
> >  GITWEB-BUILD-OPTIONS: FORCE
> >  	@rm -f $@+
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 68c77f6..8bc9e9a 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -17,6 +17,7 @@ use Encode;
> >  use Fcntl ':mode';
> >  use File::Find qw();
> >  use File::Basename qw(basename);
> > +use List::Util qw(min);
> >  use Time::HiRes qw(gettimeofday tv_interval);
> >  binmode STDOUT, ':utf8';
> > =20
> > @@ -122,6 +123,9 @@ our $logo_label =3D "git homepage";
> >  # source of projects list
> >  our $projects_list =3D "++GITWEB_LIST++";
> > =20
> > +# list of "directories" under "refs/" we want to display as branch=
es
> > +our @wanted_refs =3D qw{++GITWEB_WANTED_REFS++};
> > +
> >  # the width (in characters) of the projects list "Description" col=
umn
> >  our $projects_list_description_width =3D 25;
> > =20
> > @@ -632,8 +636,19 @@ sub feature_avatar {
> >  sub check_head_link {
> >  	my ($dir) =3D @_;
> >  	my $headfile =3D "$dir/HEAD";
> > -	return ((-e $headfile) ||
> > -		(-l $headfile && readlink($headfile) =3D~ /^refs\/heads\//));
> > +
> > +	if (-e $headfile) {
> > +		return 1;
> > +	}
> > +	if (-l $headfile) {
> > +		my $rl =3D readlink($headfile);
> > +
> > +		for my $ref (@wanted_refs) {
> > +			return 1 if $rl =3D~ /^refs\/$ref\//;
> > +		}
> > +	}
> > +
> > +	return 0;
> >  }
> > =20
> >  sub check_export_ok {
> > @@ -2515,6 +2530,7 @@ sub format_snapshot_links {
> >  sub get_feed_info {
> >  	my $format =3D shift || 'Atom';
> >  	my %res =3D (action =3D> lc($format));
> > +	my $matched_ref =3D 0;
> > =20
> >  	# feed links are possible only for project views
> >  	return unless (defined $project);
> > @@ -2522,12 +2538,17 @@ sub get_feed_info {
> >  	# or don't have specific feed yet (so they should use generic)
> >  	return if (!$action || $action =3D~ /^(?:tags|heads|forks|tag|sea=
rch)$/x);
> > =20
> > -	my $branch;
> > -	# branches refs uses 'refs/heads/' prefix (fullname) to different=
iate
> > -	# from tag links; this also makes possible to detect branch links
> > -	if ((defined $hash_base && $hash_base =3D~ m!^refs/heads/(.*)$!) =
||
> > -	    (defined $hash      && $hash      =3D~ m!^refs/heads/(.*)$!))=
 {
> > -		$branch =3D $1;
> > +	my $branch =3D undef;
> > +	# branches refs uses 'refs/' + $wanted_refs[x] + '/' prefix
> > +	# (fullname) to differentiate from tag links; this also makes
> > +	# possible to detect branch links
> > +	for my $ref (@wanted_refs) {
> > +		if ((defined $hash_base && $hash_base =3D~ m!^refs/$ref/(.*)$!) =
||
> > +		    (defined $hash      && $hash      =3D~ m!^refs/$ref/(.*)$!))=
 {
> > +			$branch =3D $1;
> > +			$matched_ref =3D $ref;
> > +			last;
> > +		}
> >  	}
> >  	# find log type for feed description (title)
> >  	my $type =3D 'log';
> > @@ -2540,7 +2561,7 @@ sub get_feed_info {
> >  	}
> > =20
> >  	$res{-title} =3D $type;
> > -	$res{'hash'} =3D (defined $branch ? "refs/heads/$branch" : undef)=
;
> > +	$res{'hash'} =3D (defined $branch ? "refs/$matched_ref/$branch" :=
 undef);
> >  	$res{'file_name'} =3D $file_name;
> > =20
> >  	return %res;
> > @@ -3184,24 +3205,43 @@ sub git_get_project_owner {
> >  	return $owner;
> >  }
> > =20
> > -sub git_get_last_activity {
> > -	my ($path) =3D @_;
> > -	my $fd;
> > +sub git_get_last_activity_age {
> > +	my ($refs) =3D @_;
> > +	my $fd =3D -1;
> > =20
> > -	$git_dir =3D "$projectroot/$path";
> >  	open($fd, "-|", git_cmd(), 'for-each-ref',
> >  	     '--format=3D%(committer)',
> >  	     '--sort=3D-committerdate',
> >  	     '--count=3D1',
> > -	     'refs/heads') or return;
> > +	     $refs) or return undef;
> > +
> >  	my $most_recent =3D <$fd>;
> > -	close $fd or return;
> > +	close $fd or return undef;
> >  	if (defined $most_recent &&
> >  	    $most_recent =3D~ / (\d+) [-+][01]\d\d\d$/) {
> >  		my $timestamp =3D $1;
> > -		my $age =3D time - $timestamp;
> > -		return ($age, age_string($age));
> > +		return time - $timestamp;
> > +	}
> > +
> > +	return undef;
> > +}
> > +
> > +sub git_get_last_activity {
> > +	my ($path) =3D @_;
> > +	my @ages =3D ();
> > +
> > +	$git_dir =3D "$projectroot/$path";
> > +	for my $ref (@wanted_refs) {
> > +		my $age =3D git_get_last_activity_age('refs/' . $_);
> > +
> > +		push @ages, $age if defined $age;
> >  	}
> > +	if (@ages) {
> > +		my $min_age =3D min(@ages);
> > +
> > +		return ($min_age, age_string($min_age));
> > +	}
> > +
> >  	return (undef, undef);
> >  }
> > =20
> > @@ -3223,7 +3263,7 @@ sub git_get_remotes_list {
> >  		next if $wanted and not $remote eq $wanted;
> >  		my ($url, $key) =3D ($1, $2);
> > =20
> > -		$remotes{$remote} ||=3D { 'heads' =3D> () };
> > +		$remotes{$remote} ||=3D { map { $_ =3D> () } @wanted_refs };
> >  		$remotes{$remote}{$key} =3D $url;
> >  	}
> >  	close $fd or return;
> > @@ -3237,9 +3277,11 @@ sub fill_remote_heads {
> >  	my @heads =3D map { "remotes/$_" } keys %$remotes;
> >  	my @remoteheads =3D git_get_heads_list(undef, @heads);
> >  	foreach my $remote (keys %$remotes) {
> > -		$remotes->{$remote}{'heads'} =3D [ grep {
> > -			$_->{'name'} =3D~ s!^$remote/!!
> > -			} @remoteheads ];
> > +		foreach my $ref (@wanted_refs) {
> > +			$remotes->{$remote}{$ref} =3D [ grep {
> > +				$_->{'name'} =3D~ s!^$remote/!!
> > +				} @remoteheads ];
> > +		}
> >  	}
> >  }
> > =20
> > @@ -3644,7 +3686,7 @@ sub parse_from_to_diffinfo {
> > =20
> >  sub git_get_heads_list {
> >  	my ($limit, @classes) =3D @_;
> > -	@classes =3D ('heads') unless @classes;
> > +	@classes =3D @wanted_refs unless @classes;
> >  	my @patterns =3D map { "refs/$_" } @classes;
> >  	my @headslist;
> > =20
> > @@ -3662,7 +3704,8 @@ sub git_get_heads_list {
> >  		my ($committer, $epoch, $tz) =3D
> >  			($committerinfo =3D~ /^(.*) ([0-9]+) (.*)$/);
> >  		$ref_item{'fullname'}  =3D $name;
> > -		$name =3D~ s!^refs/(?:head|remote)s/!!;
> > +		my $strip_refs =3D join '|', @wanted_refs;
> > +		$name =3D~ s!^refs/(?:$strip_refs|remotes)/!!;
> > =20
> >  		$ref_item{'name'}  =3D $name;
> >  		$ref_item{'id'}    =3D $hash;
> > @@ -4286,7 +4329,7 @@ sub git_print_page_nav {
> >  # available if the feature is enabled
> >  sub format_ref_views {
> >  	my ($current) =3D @_;
> > -	my @ref_views =3D qw{tags heads};
> > +	my @ref_views =3D ("tags", @wanted_refs);
> >  	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads'=
);
> >  	return join " | ", map {
> >  		$_ eq $current ? $_ :
> > @@ -7179,7 +7222,8 @@ sub snapshot_name {
> >  		$ver =3D $1;
> >  	} else {
> >  		# branches and other need shortened SHA-1 hash
> > -		if ($hash =3D~ m!^refs/(?:heads|remotes)/(.*)$!) {
> > +		my $strip_refs =3D join '|', @wanted_refs;
> > +		if ($hash =3D~ m!^refs/(?:$strip_refs|remotes)/(.*)$!) {
> >  			$ver =3D $1;
> >  		}
> >  		$ver .=3D '-' . git_get_short_hash($project, $hash);

--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
