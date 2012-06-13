From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/6] Test environment of git-remote-mediawiki
Date: Wed, 13 Jun 2012 12:14:49 +0200
Message-ID: <CACBZZX5v_cZTddWB3vPsepL2LPzP8zd+pOC5w+=SV8aYJpL3HA@mail.gmail.com>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
 <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1339535563-18958-2-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 13 12:15:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sekbo-0007uJ-Jj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 12:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab2FMKPL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 06:15:11 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:43850 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2FMKPK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 06:15:10 -0400
Received: by vbbff1 with SMTP id ff1so284667vbb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hRwnE3RxRqCewsEzQ26z4apLQrIW3M4wjaolznxYgUI=;
        b=xdQoBWUpeYDe++8YmQzAwcBHvTuSmeBZaftze4zPb7BgyXLykhJL+S2LQw+dgjfGzX
         nGeM6vrx46AtqUMsSomeEE1I+Ug6al/wCQZUztA9ZQw4LXynY9eqjN0YhOYlGEULY9zM
         7btxifPnTUjXIY421dl9fY0pEtmoPw+GgT2l+C0X6jvGHktqUIfFhzwEzfBy6k/wU6L7
         WKg1dsjn2/ocgjN0J6nvAjQdsYOkq3ttmO8xbTncAVEbGhSdHu1MZ7p/cZqCaEv1DOKW
         PGzT3Bljq3WYAlZZC7L4n90ZIlogUxO4ZZ/+MFEx1BOx4KcSm+mBs4HH2KkfQhzmsXJS
         gAWg==
Received: by 10.220.155.197 with SMTP id t5mr16649593vcw.6.1339582509434; Wed,
 13 Jun 2012 03:15:09 -0700 (PDT)
Received: by 10.52.156.229 with HTTP; Wed, 13 Jun 2012 03:14:49 -0700 (PDT)
In-Reply-To: <1339535563-18958-2-git-send-email-simon.cathebras@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199886>

On Tue, Jun 12, 2012 at 11:12 PM, Simon Cathebras
<simon.cathebras@ensimag.imag.fr> wrote:

Some comments on your perl style:

> +use Switch;
> +use encoding 'utf8';
> +use DateTime::Format::ISO8601;
> +use open ':encoding(utf8)';
> +use constant SLASH_REPLACEMENT =3D> "%2F";
> +
> +#Parsing of the config file
> +
> +my $configfile =3D "$ENV{'CURR_DIR'}/test.config";
> +my %config;
> +open (CONFIG,"< $configfile") || die "can't open $configfile: $!";
> +while (<CONFIG>)

You probably want to use lexical filehandles instead:

    open my $config, "<", $configfile or die "...";
    while (<$config>)

And also note the three-arg open I'm using, might want to change the
rest to use that.

> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0chomp;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0s/#.*//;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0s/^\s+//;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0s/\s+$//;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0next unless length;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0my ($key, $value) =3D split (/\s*=3D\s*/=
,$_, 2);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0$config{$key} =3D $value;
> + =C2=A0 =C2=A0 =C2=A0 last if ($key eq 'LIGHTTPD' and $value eq 'fal=
se');
> + =C2=A0 =C2=A0 =C2=A0 last if ($key eq 'PORT');
> +}

And add:

    close $config or die "can't close $configfile: $!";

Also you can do:

    while (my $line =3D <$config>) {
        chomp $line;

Which IMO makes any code that's more than 2-3 lines long less
confusing as there's no doubt what $_ refers to.

> +my $wiki_address =3D "http://$config{'SERVER_ADDR'}".":"."$config{'P=
ORT'}";
> +my $wiki_url =3D "$wiki_address/$config{'WIKI_DIR_NAME'}/api.php";
> +my $wiki_admin =3D "$config{'WIKI_ADMIN'}";
> +my $wiki_admin_pass =3D "$config{'WIKI_PASSW'}";
> +my $mw =3D MediaWiki::API->new;
> +$mw->{config}->{api_url} =3D $wiki_url;
> +
> +sub mediawiki_clean_filename {
> + =C2=A0 =C2=A0 =C2=A0 my $filename =3D shift;
> + =C2=A0 =C2=A0 =C2=A0 $filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
> + =C2=A0 =C2=A0 =C2=A0 # [, ], |, {, and } are forbidden by MediaWiki=
, even URL-encoded.
> + =C2=A0 =C2=A0 =C2=A0 # Do a variant of URL-encoding, i.e. looks lik=
e URL-encoding,
> + =C2=A0 =C2=A0 =C2=A0 # but with _ added to prevent MediaWiki from t=
hinking this is
> + =C2=A0 =C2=A0 =C2=A0 # an actual special character.
> + =C2=A0 =C2=A0 =C2=A0 $filename =3D~ s/[\[\]\{\}\|]/sprintf("_%%_%x"=
, ord($&))/ge;
> + =C2=A0 =C2=A0 =C2=A0 # If we use the uri escape before
> + =C2=A0 =C2=A0 =C2=A0 # we should unescape here, before anything
> +
> + =C2=A0 =C2=A0 =C2=A0 return $filename;
> +}
> +
> +sub mediawiki_smudge_filename {
> + =C2=A0 =C2=A0 =C2=A0 my $filename =3D shift;
> + =C2=A0 =C2=A0 =C2=A0 $filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
> + =C2=A0 =C2=A0 =C2=A0 $filename =3D~ s/ /_/g;
> + =C2=A0 =C2=A0 =C2=A0 # Decode forbidden characters encoded in media=
wiki_clean_filename
> + =C2=A0 =C2=A0 =C2=A0 $filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/s=
printf("%c", hex($1))/ge;
> + =C2=A0 =C2=A0 =C2=A0 return $filename;
> +}

I don't how in the big picture you're aiming to encode article names
as filenames but if you can at all avoid doing so (i.e. the user
doesn't need to be exposed to those files) it's much simpler just to
take the article name, sha1sum it and use the first 5-10 bytes of that
as the filename.

With all the filesystems and OS's out there and their odd rules it can
be tricky to write code that takes an arbitrary string and attempts to
cast it to a valid filename or path.

> +# wiki_login <name> <password>
> +#
> +# Logs the user with <name> and <password> in the global variable
> +# of the mediawiki $mw
> +sub wiki_login {
> + =C2=A0 =C2=A0 =C2=A0 $mw->login( { lgname =3D> "$_[0]",lgpassword =3D=
> "$_[1]" } )
> + =C2=A0 =C2=A0 =C2=A0 || die "getpage: login failed";
> +}
> +
> +# wiki_getpage <wiki_page> <dest_path>
> +#
> +# fetch a page <wiki_page> from the wiki referenced in the global va=
riable
> +# $mw and copies its content in directory dest_path
> +sub wiki_getpage {
> + =C2=A0 =C2=A0 =C2=A0 my $pagename =3D $_[0];
> + =C2=A0 =C2=A0 =C2=A0 my $destdir =3D $_[1];
> +
> + =C2=A0 =C2=A0 =C2=A0 my $page =3D $mw->get_page( { title =3D> $page=
name } );
> + =C2=A0 =C2=A0 =C2=A0 if (!defined($page)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "getpage: wiki=
 does not exist";
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 my $content =3D $page->{'*'};
> + =C2=A0 =C2=A0 =C2=A0 if (!defined($content)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "getpage: page=
 does not exist";
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 # Replace spaces by underscore in the page nam=
e
> + =C2=A0 =C2=A0 =C2=A0 $pagename=3D$page->{'title'};
> + =C2=A0 =C2=A0 =C2=A0 $pagename =3D mediawiki_smudge_filename $pagen=
ame;
> + =C2=A0 =C2=A0 =C2=A0 open(my $file, ">$destdir/$pagename.mw");
> + =C2=A0 =C2=A0 =C2=A0 print $file "$content";
> + =C2=A0 =C2=A0 =C2=A0 close ($file);
> +
> +}
> +
> +# wiki_delete_page <page_name>
> +#
> +# delete the page with name <page_name> from the wiki referenced
> +# in the global variable $mw
> +sub wiki_delete_page {
> + =C2=A0 =C2=A0 =C2=A0 my $pagename =3D $_[0];
> +
> + =C2=A0 =C2=A0 =C2=A0 my $exist=3D$mw->get_page({title =3D> $pagenam=
e});
> +
> + =C2=A0 =C2=A0 =C2=A0 if (defined($exist->{'*'})){
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $mw->edit({ action=
 =3D> 'delete',
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 title =3D> $pagename})
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || die $mw->{error=
}->{code} . ": " . $mw->{error}->{details};
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "no page with =
such name found: $pagename\n";
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +# wiki_editpage <wiki_page> <wiki_content> <wiki_append> [-c=3D<cate=
gory>] [-s=3D<summary>]
> +#
> +# Edit a page named <wiki_page> with content <wiki_content> on the w=
iki
> +# referenced with the global variable $mw
> +# If <wiki_append> =3D=3D true : append <wiki_content> at the end of=
 the actual
> +# content of the page <wiki_page>
> +# If <wik_page> doesn't exist, that page is created with the <wiki_c=
ontent>
> +sub wiki_editpage {
> + =C2=A0 =C2=A0 =C2=A0 my $wiki_page =3D mediawiki_clean_filename $_[=
0];
> + =C2=A0 =C2=A0 =C2=A0 my $wiki_content =3D $_[1];
> + =C2=A0 =C2=A0 =C2=A0 my $wiki_append =3D $_[2];
> + =C2=A0 =C2=A0 =C2=A0 my $summary =3D "";
> + =C2=A0 =C2=A0 =C2=A0 my ($summ, $cat) =3D ();
> + =C2=A0 =C2=A0 =C2=A0 GetOptions('s=3Ds' =3D> \$summ, 'c=3Ds' =3D> \=
$cat);
> +
> + =C2=A0 =C2=A0 =C2=A0 my $append =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 if (defined($wiki_append) && $wiki_append eq '=
true') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $append=3D1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 my $previous_text =3D"";
> +
> + =C2=A0 =C2=A0 =C2=A0 if ($append) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $ref =3D $mw->g=
et_page( { title =3D> $wiki_page } );
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $previous_text =3D=
 $ref->{'*'};
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 my $text =3D $wiki_content;
> + =C2=A0 =C2=A0 =C2=A0 if (defined($previous_text)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $text=3D"$previous=
_text$text";
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 # Eventually, add this page to a category.
> + =C2=A0 =C2=A0 =C2=A0 if (defined($cat)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $category_name=3D=
"[[Category:$cat]]";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $text=3D"$text\n $=
category_name";
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if(defined($summ)){
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $summary=3D$summ;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 $mw->edit( { action =3D> 'edit', title =3D> $w=
iki_page, summary =3D> $summary, text =3D> "$text"} );
> +}
> +
> +# wiki_getallpagename [<category>]
> +#
> +# Fetch all pages of the wiki referenced by the global variable $mw
> +# and print the names of each one in the file all.txt with a new lin=
e
> +# ("\n") between these.
> +# If the argument <category> is defined, then this function get only=
 the pages
> +# belonging to <category>.
> +sub wiki_getallpagename {
> + =C2=A0 =C2=A0 =C2=A0 # fetch the pages of the wiki
> + =C2=A0 =C2=A0 =C2=A0 if (defined($_[0])) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $mw_pages =3D $=
mw->list ( { action =3D> 'query',
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D> 'categorymembers',
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmtitle =3D> "Category:$_[0]",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmnamespace =3D> 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmlimit=3D> 500 },
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || die $mw->{error=
}->{code}.": ".$mw->{error}->{details};
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open(my $file, ">a=
ll.txt");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 foreach my $page (=
@{$mw_pages}) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 print $file "$page->{title}\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close ($file);
> +
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $mw_pages =3D $=
mw->list({
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D> 'query',
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D> 'allpages',
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aplimit =3D> 500,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 })
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || die $mw->{error=
}->{code}.": ".$mw->{error}->{details};
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open(my $file, ">a=
ll.txt");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 foreach my $page (=
@{$mw_pages}) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 print $file "$page->{title}\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close ($file);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +# Main part of this script: parse the command line arguments
> +# and select which function to execute
> +my $fct_to_call =3D shift;
> +
> +&wiki_login($wiki_admin,$wiki_admin_pass);
> +
> +switch ($fct_to_call) {
> + =C2=A0 =C2=A0 =C2=A0 case "get_page" { &wiki_getpage(@ARGV)}
> + =C2=A0 =C2=A0 =C2=A0 case "delete_page" { &wiki_delete_page(@ARGV)}
> + =C2=A0 =C2=A0 =C2=A0 case "edit_page" { &wiki_editpage(@ARGV)}
> + =C2=A0 =C2=A0 =C2=A0 case "getallpagename" { &wiki_getallpagename(@=
ARGV)}
> + =C2=A0 =C2=A0 =C2=A0 else { die("test-gitmw.pl ERROR: wrong argumen=
t")}
> +}

When you're calling bareword functions you can just call them as as
wiki_login(..) not &wiki_login(..).

Also please don't use Switch.pm at all, it's a source filter, is
deprecated from the Perl core, and it's much better to write this as:

my %functions_to_call =3D qw(
    get_page       wiki_getpage
    delete_page    wiki_delete_page
    edit_page      wiki_editpage
    getallpagename wiki_getallpagename
);
die "$0 ERROR: wrong argument" unless exists $functions_to_call{$fct_to=
_call};
&{$functions_to_call{$fct_to_call}}(@ARGV);
