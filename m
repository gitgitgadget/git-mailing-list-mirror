From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 2/6] Test environment of git-remote-mediawiki
Date: Wed, 13 Jun 2012 19:00:15 +0200
Message-ID: <4FD8C71F.1070508@ensimag.imag.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr> <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1339535563-18958-2-git-send-email-simon.cathebras@ensimag.imag.fr> <CACBZZX5v_cZTddWB3vPsepL2LPzP8zd+pOC5w+=SV8aYJpL3HA@mail.gmail.com>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:00:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seqvv-0005md-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 19:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab2FMRAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 13:00:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38493 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab2FMRAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 13:00:34 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5DGpHPD021811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jun 2012 18:51:17 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5DH0F5P014736;
	Wed, 13 Jun 2012 19:00:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CACBZZX5v_cZTddWB3vPsepL2LPzP8zd+pOC5w+=SV8aYJpL3HA@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Jun 2012 18:51:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5DGpHPD021811
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340211078.96705@EUZqEUm3Ivsyw4xZhj+wLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199901>



On 13/06/2012 12:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jun 12, 2012 at 11:12 PM, Simon Cathebras
> <simon.cathebras@ensimag.imag.fr>  wrote:
>
> Some comments on your perl style:
>
>> +use Switch;
>> +use encoding 'utf8';
>> +use DateTime::Format::ISO8601;
>> +use open ':encoding(utf8)';
>> +use constant SLASH_REPLACEMENT =3D>  "%2F";
>> +
>> +#Parsing of the config file
>> +
>> +my $configfile =3D "$ENV{'CURR_DIR'}/test.config";
>> +my %config;
>> +open (CONFIG,"<  $configfile") || die "can't open $configfile: $!";
>> +while (<CONFIG>)
> You probably want to use lexical filehandles instead:
>
>      open my $config, "<", $configfile or die "...";
>      while (<$config>)
>
> And also note the three-arg open I'm using, might want to change the
> rest to use that.

We corrected it. The correction will appears in our next patch.

>> +{
>> +        chomp;
>> +        s/#.*//;
>> +        s/^\s+//;
>> +        s/\s+$//;
>> +        next unless length;
>> +        my ($key, $value) =3D split (/\s*=3D\s*/,$_, 2);
>> +        $config{$key} =3D $value;
>> +       last if ($key eq 'LIGHTTPD' and $value eq 'false');
>> +       last if ($key eq 'PORT');
>> +}
> And add:
>
>      close $config or die "can't close $configfile: $!";
>
> Also you can do:
>
>      while (my $line =3D<$config>) {
>          chomp $line;
>
> Which IMO makes any code that's more than 2-3 lines long less
> confusing as there's no doubt what $_ refers to.

Same.

>> +my $wiki_address =3D "http://$config{'SERVER_ADDR'}".":"."$config{'=
PORT'}";
>> +my $wiki_url =3D "$wiki_address/$config{'WIKI_DIR_NAME'}/api.php";
>> +my $wiki_admin =3D "$config{'WIKI_ADMIN'}";
>> +my $wiki_admin_pass =3D "$config{'WIKI_PASSW'}";
>> +my $mw =3D MediaWiki::API->new;
>> +$mw->{config}->{api_url} =3D $wiki_url;
>> +
>> +sub mediawiki_clean_filename {
>> +       my $filename =3D shift;
>> +       $filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
>> +       # [, ], |, {, and } are forbidden by MediaWiki, even URL-enc=
oded.
>> +       # Do a variant of URL-encoding, i.e. looks like URL-encoding=
,
>> +       # but with _ added to prevent MediaWiki from thinking this i=
s
>> +       # an actual special character.
>> +       $filename =3D~ s/[\[\]\{\}\|]/sprintf("_%%_%x", ord($&))/ge;
>> +       # If we use the uri escape before
>> +       # we should unescape here, before anything
>> +
>> +       return $filename;
>> +}
>> +
>> +sub mediawiki_smudge_filename {
>> +       my $filename =3D shift;
>> +       $filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
>> +       $filename =3D~ s/ /_/g;
>> +       # Decode forbidden characters encoded in mediawiki_clean_fil=
ename
>> +       $filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", h=
ex($1))/ge;
>> +       return $filename;
>> +}
> I don't how in the big picture you're aiming to encode article names
> as filenames but if you can at all avoid doing so (i.e. the user
> doesn't need to be exposed to those files) it's much simpler just to
> take the article name, sha1sum it and use the first 5-10 bytes of tha=
t
> as the filename.
>
> With all the filesystems and OS's out there and their odd rules it ca=
n
> be tricky to write code that takes an arbitrary string and attempts t=
o
> cast it to a valid filename or path.

Actually, we copy paste this code from git-remote-mediawiki. As a test=20
environment, this strategy appears to be a bad one (in addition of the=20
copy paste itself...).
Anyway, we decided to remove this code and modify our tests.

As a matter this code's purpose in git-remote-mediawiki is to change th=
e=20
forbidden character in page name for wiki's, into understandable ones.=20
So, in my opinion, using sha1sum would be useless.

>> +# wiki_login<name>  <password>
>> +#
>> +# Logs the user with<name>  and<password>  in the global variable
>> +# of the mediawiki $mw
>> +sub wiki_login {
>> +       $mw->login( { lgname =3D>  "$_[0]",lgpassword =3D>  "$_[1]" =
} )
>> +       || die "getpage: login failed";
>> +}
>> +
>> +# wiki_getpage<wiki_page>  <dest_path>
>> +#
>> +# fetch a page<wiki_page>  from the wiki referenced in the global v=
ariable
>> +# $mw and copies its content in directory dest_path
>> +sub wiki_getpage {
>> +       my $pagename =3D $_[0];
>> +       my $destdir =3D $_[1];
>> +
>> +       my $page =3D $mw->get_page( { title =3D>  $pagename } );
>> +       if (!defined($page)) {
>> +               die "getpage: wiki does not exist";
>> +       }
>> +
>> +       my $content =3D $page->{'*'};
>> +       if (!defined($content)) {
>> +               die "getpage: page does not exist";
>> +       }
>> +
>> +       # Replace spaces by underscore in the page name
>> +       $pagename=3D$page->{'title'};
>> +       $pagename =3D mediawiki_smudge_filename $pagename;
>> +       open(my $file, ">$destdir/$pagename.mw");
>> +       print $file "$content";
>> +       close ($file);
>> +
>> +}
>> +
>> +# wiki_delete_page<page_name>
>> +#
>> +# delete the page with name<page_name>  from the wiki referenced
>> +# in the global variable $mw
>> +sub wiki_delete_page {
>> +       my $pagename =3D $_[0];
>> +
>> +       my $exist=3D$mw->get_page({title =3D>  $pagename});
>> +
>> +       if (defined($exist->{'*'})){
>> +               $mw->edit({ action =3D>  'delete',
>> +                               title =3D>  $pagename})
>> +               || die $mw->{error}->{code} . ": " . $mw->{error}->{=
details};
>> +       } else {
>> +               die "no page with such name found: $pagename\n";
>> +       }
>> +}
>> +
>> +# wiki_editpage<wiki_page>  <wiki_content>  <wiki_append>  [-c=3D<c=
ategory>] [-s=3D<summary>]
>> +#
>> +# Edit a page named<wiki_page>  with content<wiki_content>  on the =
wiki
>> +# referenced with the global variable $mw
>> +# If<wiki_append>  =3D=3D true : append<wiki_content>  at the end o=
f the actual
>> +# content of the page<wiki_page>
>> +# If<wik_page>  doesn't exist, that page is created with the<wiki_c=
ontent>
>> +sub wiki_editpage {
>> +       my $wiki_page =3D mediawiki_clean_filename $_[0];
>> +       my $wiki_content =3D $_[1];
>> +       my $wiki_append =3D $_[2];
>> +       my $summary =3D "";
>> +       my ($summ, $cat) =3D ();
>> +       GetOptions('s=3Ds' =3D>  \$summ, 'c=3Ds' =3D>  \$cat);
>> +
>> +       my $append =3D 0;
>> +       if (defined($wiki_append)&&  $wiki_append eq 'true') {
>> +               $append=3D1;
>> +       }
>> +
>> +       my $previous_text =3D"";
>> +
>> +       if ($append) {
>> +               my $ref =3D $mw->get_page( { title =3D>  $wiki_page =
} );
>> +               $previous_text =3D $ref->{'*'};
>> +       }
>> +
>> +       my $text =3D $wiki_content;
>> +       if (defined($previous_text)) {
>> +               $text=3D"$previous_text$text";
>> +       }
>> +
>> +       # Eventually, add this page to a category.
>> +       if (defined($cat)) {
>> +               my $category_name=3D"[[Category:$cat]]";
>> +               $text=3D"$text\n $category_name";
>> +       }
>> +       if(defined($summ)){
>> +               $summary=3D$summ;
>> +       }
>> +
>> +       $mw->edit( { action =3D>  'edit', title =3D>  $wiki_page, su=
mmary =3D>  $summary, text =3D>  "$text"} );
>> +}
>> +
>> +# wiki_getallpagename [<category>]
>> +#
>> +# Fetch all pages of the wiki referenced by the global variable $mw
>> +# and print the names of each one in the file all.txt with a new li=
ne
>> +# ("\n") between these.
>> +# If the argument<category>  is defined, then this function get onl=
y the pages
>> +# belonging to<category>.
>> +sub wiki_getallpagename {
>> +       # fetch the pages of the wiki
>> +       if (defined($_[0])) {
>> +               my $mw_pages =3D $mw->list ( { action =3D>  'query',
>> +                               list =3D>  'categorymembers',
>> +                               cmtitle =3D>  "Category:$_[0]",
>> +                               cmnamespace =3D>  0,
>> +                               cmlimit=3D>  500 },
>> +               )
>> +               || die $mw->{error}->{code}.": ".$mw->{error}->{deta=
ils};
>> +               open(my $file, ">all.txt");
>> +               foreach my $page (@{$mw_pages}) {
>> +                       print $file "$page->{title}\n";
>> +               }
>> +               close ($file);
>> +
>> +       } else {
>> +               my $mw_pages =3D $mw->list({
>> +                               action =3D>  'query',
>> +                               list =3D>  'allpages',
>> +                               aplimit =3D>  500,
>> +                       })
>> +               || die $mw->{error}->{code}.": ".$mw->{error}->{deta=
ils};
>> +               open(my $file, ">all.txt");
>> +               foreach my $page (@{$mw_pages}) {
>> +                       print $file "$page->{title}\n";
>> +               }
>> +               close ($file);
>> +       }
>> +}
>> +
>> +# Main part of this script: parse the command line arguments
>> +# and select which function to execute
>> +my $fct_to_call =3D shift;
>> +
>> +&wiki_login($wiki_admin,$wiki_admin_pass);
>> +
>> +switch ($fct_to_call) {
>> +       case "get_page" {&wiki_getpage(@ARGV)}
>> +       case "delete_page" {&wiki_delete_page(@ARGV)}
>> +       case "edit_page" {&wiki_editpage(@ARGV)}
>> +       case "getallpagename" {&wiki_getallpagename(@ARGV)}
>> +       else { die("test-gitmw.pl ERROR: wrong argument")}
>> +}
> When you're calling bareword functions you can just call them as as
> wiki_login(..) not&wiki_login(..).
>
> Also please don't use Switch.pm at all, it's a source filter, is
> deprecated from the Perl core, and it's much better to write this as:
>
> my %functions_to_call =3D qw(
>      get_page       wiki_getpage
>      delete_page    wiki_delete_page
>      edit_page      wiki_editpage
>      getallpagename wiki_getallpagename
> );
> die "$0 ERROR: wrong argument" unless exists $functions_to_call{$fct_=
to_call};
> &{$functions_to_call{$fct_to_call}}(@ARGV);
Corrected

Thanks ! :)

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=C3=A8re Ing=C3=A9ni=C3=A9rie des Syst=C3=A8mes d'Information
Membre Bug-Buster
