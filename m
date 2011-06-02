From: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Subject: Re: [RFC/PATCH] Added a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 2 Jun 2011 22:58:44 +0200
Message-ID: <BANLkTimCONrGyX=v39RXL4pxGWbkLVROPA@mail.gmail.com>
References: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr> <7vy61kcdu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?J=E9r=E9mie_Nikaes?= 
	<jeremie.nikaes@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Sylvain_Boulm=E9?= <sylvain.boulme@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 22:59:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSEz6-0003la-0d
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 22:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab1FBU7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 16:59:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43837 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab1FBU7G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 16:59:06 -0400
Received: by vws1 with SMTP id 1so948267vws.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=R/gtTJDKgci0hlBFwerfhwIC+sAPNhASeNuVX8ccPcs=;
        b=SwxdZMH0K8+O0W3Hbjpz3CHhvph82gSv1yC+Ez9ZjfgQ9e8aum7hTJHBEdLvCIju9L
         KGQm0ClorUJ2s5Gw0XjzczvX7SdgrmA6bd6i3mh10HpbyTovzmSSDPESgfFuAXXeOrz2
         ZTMyrp3WMan3tJfnITrq3mZmlpc9iu2ZxQbpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=INpbtATY+OcDEMvjdjxJSs96Rl/EQ+AK3/Lwkwdmh12dz83yQdC+wHcc06CBCSMTka
         FHiDGZwoSXlsKdkYfgYdkQpyG93tt2GnteeLcw10bXoTZczepvUN38yKgB1J2MgHn9U+
         IKJsnVj068fkyetBvcIi79Fl/2hkWzPaZ/Foo=
Received: by 10.220.48.71 with SMTP id q7mr390375vcf.8.1307048344124; Thu, 02
 Jun 2011 13:59:04 -0700 (PDT)
Received: by 10.220.189.8 with HTTP; Thu, 2 Jun 2011 13:58:44 -0700 (PDT)
In-Reply-To: <7vy61kcdu8.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 1RkLKnsPb2-EnO3NURj-diJKS5U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174979>

2011/6/2 Junio C Hamano <gitster@pobox.com>:
> Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr> writes:
>
>> =A0contrib/mw-to-git/git-remote-mediawiki =A0 =A0 | =A0252 +++++++++=
+++++++++++++++++++
>> =A0contrib/mw-to-git/git-remote-mediawiki.txt | =A0 =A07 +
>> =A02 files changed, 259 insertions(+), 0 deletions(-)
>
> It is pleasing to see that a half of a custom backend can be done in =
just
> 250 lines of code. =A0I understand that this is a work-in-progress wi=
th many
> unnecessary lines spitting debugging output to STDERR, whose removal =
will
> further shrink the code?

To give you an idea, the whole thing with the other part is about 400
lines for now.
There are a lot of output to STDERR that will be eventually removed.
We still have to
decide what "option verbosity" should display before removing to many o=
f them.


>> +# commands parser
>> +my $loop =3D 1;
>> +my $entry;
>> +my @cmd;
>> +while ($loop) {
>
> This is somewhat unusual-looking loop control.
>
> Wouldn't "while (1) { ...; last if (...); if (...) { last; } }" do?

Ok for that loop control.

>> + =A0 =A0 $| =3D 1; #flush STDOUT
>> + =A0 =A0 $entry =3D <STDIN>;
>> + =A0 =A0 print STDERR $entry;
>> + =A0 =A0 chomp($entry);
>> + =A0 =A0 @cmd =3D undef;
>> + =A0 =A0 @cmd =3D split(/ /,$entry);
>> + =A0 =A0 switch ($cmd[0]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case "capabilities" {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($cmd[1] eq "") {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mw_capabil=
ities();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$loop =3D 0=
;
>
> I presume that this is "We were expecting to read capabilities comman=
d but
> found something unexpected; let's abort". Don't you want to say somet=
hing
> to the user here, perhaps on STDERR?
>

Actually, we based that "no error messages displayed" policy on the
git-remote-http which aborts if something unexpected is found. We could=
 add an
error message though.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 case "option" {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mw_option($cmd[1],$cmd[2])=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> No error checking only for this one?

There should be one. That's a miss.



>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my @pushargs =3D split(/:/=
,$cmd[1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($pushargs[1] ne "" && =
$pushargs[2] eq ""
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (substr($pushargs[0],0,=
1) eq "+")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mw_push(su=
bstr($pushargs[0],1),$pushargs[1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$loop =3D 0=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Is "push" always forcing?

The tests are done in the mw_push function which is still being impleme=
nted.
The push will abort if there is something to pull, just like git acts.

>> +sub mw_import {
>> + =A0 =A0 my @wiki_name =3D split(/:\/\//,$url);
>> + =A0 =A0 my $wiki_name =3D $wiki_name[1];
>> +
>> + =A0 =A0 my $mediawiki =3D MediaWiki::API->new;
>> + =A0 =A0 $mediawiki->{config}->{api_url} =3D "$url/api.php";
>> +
>> + =A0 =A0 my $pages =3D $mediawiki->list({
>> + =A0 =A0 =A0 =A0 =A0 =A0 action =3D> 'query',
>> + =A0 =A0 =A0 =A0 =A0 =A0 list =3D> 'allpages',
>> + =A0 =A0 =A0 =A0 =A0 =A0 aplimit =3D> 500,
>> + =A0 =A0 });
>> + =A0 =A0 if ($pages =3D=3D undef) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "fatal: '$url' does not appea=
r to be a mediawiki\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "fatal: make sure '$url/api.p=
hp' is a valid page\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 exit;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 my @revisions;
>> + =A0 =A0 print STDERR "Searching revisions...\n";
>> + =A0 =A0 my $fetch_from =3D get_last_local_revision() + 1;
>> + =A0 =A0 my $n =3D 1;
>> + =A0 =A0 foreach my $page (@$pages) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $id =3D $page->{pageid};
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "$n/", scalar(@$pages), ": $p=
age->{title}\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 $n++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $query =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D> 'query',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D> 'revisions',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rvprop =3D> 'ids',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rvdir =3D> 'newer',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rvstartid =3D> $fetch_from=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rvlimit =3D> 500,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pageids =3D> $page->{pagei=
d},
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $revnum =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 # Get 500 revisions at a time due to the m=
ediawiki api limit
>
> It's nice that you can dig deeper with rvlimit increments. I wonder i=
f
> 'allpages' also let's you retrieve more than 500 pages in total by so=
mehow
> iterating over the set of pages.

Yes it is possible. And works with the removal of the "\n" peff
pointed out in the previous message.

>> + =A0 =A0 # Creation of the fast-import stream
>> + =A0 =A0 print STDERR "Fetching & writing export data...\n";
>> + =A0 =A0 binmode STDOUT, ':binary';
>> + =A0 =A0 $n =3D 0;
>> +
>> + =A0 =A0 foreach my $pagerevids (sort {$a->{revid} <=3D> $b->{revid=
}} @revisions) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 #fetch the content of the pages
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $query =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D> 'query',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D> 'revisions',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rvprop =3D> 'content|times=
tamp|comment|user|ids',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 revids =3D> $pagerevids->{=
revid},
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $result =3D $mediawiki->api($query);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $rev =3D pop(@{$result->{query}->{pages=
}->{$pagerevids->{pageid}}->{revisions}});
>
> Is the list of per-page revisions guaranteed to be sorted (not a
> rhetorical question; just asking)?

Yes it is.


>> + =A0 =A0 =A0 =A0 =A0 =A0 print "commit refs/mediawiki/$remotename/m=
aster\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "mark :$n\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "committer $user <$user\@$wiki_name>=
 ", $dt->epoch, " +0000\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "data ", bytes::length(encode_utf8($=
comment)), "\n", encode_utf8($comment);
>
> Calling encode_utf8() twice on the same data? =A0How big is this $com=
ment
> typically? =A0Or does encode_utf8() somehow memoize?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 # If it's not a clone, needs to know where=
 to start from
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($fetch_from !=3D 1 && $n =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "from refs/mediawiki=
/$remotename/master^0\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "M 644 inline $title.wiki\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "data ", bytes::length(encode_utf8($=
content)), "\n", encode_utf8($content);
>
> Same for $content, which presumably is larger than $comment...
>
> Perhaps a small helper
>
> =A0 =A0 =A0 =A0sub literal_data {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my ($content) =3D @_;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "data ", bytes::length($content)=
, "\n", $content;
> =A0 =A0 =A0 =A0}
>
> would help here, above, and below where you create a "note" on this
> commit?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 # mediawiki revision number in the git not=
e
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $note_comment =3D encode_utf8("note add=
ed by git-mediawiki");
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $note_comment_length =3D bytes::length(=
$note_comment);
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $note_content =3D encode_utf8("mediawik=
i_revision: " . $pagerevids->{revid} . "\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $note_content_length =3D bytes::length(=
$note_content);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($fetch_from =3D=3D 1 && $n =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "reset refs/notes/co=
mmits\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "commit refs/notes/commits\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "committer $user <user\@example.com>=
 ", $dt->epoch, " +0000\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "data ", $note_comment_length, "\n",=
 $note_comment;
>
> With that, this will become
>
> =A0 =A0 =A0 =A0literal_data(encode_utf8("note added by git-mediawiki"=
));
>
> and you don't need two extra variables. =A0Same for $note_content*.

Thank you very much for this helper, it'll help factoring the code and
reducing the number of variables.


Thank you very much for your help and comments on that project.

Regards

--=20
Arnaud Lacurie
