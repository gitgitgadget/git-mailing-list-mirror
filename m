From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 07/22] git-remote-mediawiki: Change style of some
 regular expressions
Date: Fri, 7 Jun 2013 20:12:15 -0400
Message-ID: <CAPig+cQ6MZpC2hGZUSf_9Xs7zFOgZG9EsNEDw1J-R48xvNQLNg@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-8-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 02:12:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul6la-0008Tf-5E
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 02:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939Ab3FHAMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 20:12:18 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52786 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FHAMR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 20:12:17 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so2750907lbi.33
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j6lL8nktfbDLXcsJ2gFEOdJ6lHjbb3aYtMDjFWf/2tg=;
        b=ArtGAmyiH9Zx6NAz3PN0dSEdGDbyQPDEJgcyamuJqtxjxs3DvgdYRBCCFsSpc7v681
         0XBSlBwWAio5NbuWrjFos6qmOtoQ6xeF3NxWaoPZVMmB6kEYPt3svz4BMv1fAr6Do7Vd
         SYYhHTmbNnoxr7Bm4YRzVLo8KNjVst6iL4SoqdbW+N+BvSFsgsu6Jvoyf2Vyh+BGD9ZH
         DWDtJrcRp58Xhw3FbiYo0u7vF1QePKHf5ACqAZtlp1ejvr/lMJbaDj6BsCpOMlthXJ9g
         R3m+RkZpj2YMB1qokoXnTipVhd5ToFEpjuIrIVnFp2FacOTy2GCbpaCWDDTXLD3B2gW+
         BD1g==
X-Received: by 10.112.219.133 with SMTP id po5mr2148009lbc.80.1370650336046;
 Fri, 07 Jun 2013 17:12:16 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 7 Jun 2013 17:12:15 -0700 (PDT)
In-Reply-To: <1370641344-4253-8-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: Tot1J1o1cS4PAvX6KvUUGmVISEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226768>

On Fri, Jun 7, 2013 at 5:42 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> - Remove m modifier when useless (m// and // was used randomly; this =
makes the
> code more coherent)
> - Remove stringy split (split('c', ...) instead of split(/c/, ...))
> - Use {}{} instead of /// when slashes are used inside the regexp so =
as not to
> escape it.

When you split up 1/22 from v1 into distinct patches, review became
much easier. The same can be done here (IMHO). The above bullet points
are each conceptually distinct (even if they may happen to overlap
textually in some cases).

> A "split ' '" is turned into a "split / /", which changes its behavio=
ur: the old
> method matched a run of whtespaces (/\s*/), while the new one will ma=
tch a
> single whitespace, which is what we want here.

The phrase "which is what we want here" does not convey much. Taking a
hint from Junio's responses explaining why he finds this subtle change
acceptable, perhaps a paragraph like this might be appropriate:

  Note the special case split(' ') for which Perl splits on runs of
  whitespace, whereas split(/ /) splits on exactly one space.  In
  other contexts, changing split(' ') to split(/ /) could potentially
  be a regression, however, here, when parsing the output of
  "rev-list --parents", whose output SHA-1's are each separated by a
  single space, splitting on a single space is perfectly correct.

More comments below.

> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   20 ++++++++++-------=
---
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index a5c963b..482cd95 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -121,7 +121,7 @@ chomp($dumb_push);
>  $dumb_push =3D ($dumb_push eq "true");
>
>  my $wiki_name =3D $url;
> -$wiki_name =3D~ s/[^\/]*:\/\///;
> +$wiki_name =3D~ s{[^/]*://}{};
>  # If URL is like http://user:password@example.com/, we clearly don't
>  # want the password in $wiki_name. While we're there, also remove us=
er
>  # and '@' sign, to avoid author like MWUser@HTTPUser@host.com
> @@ -565,7 +565,7 @@ sub mediawiki_smudge {
>
>  sub mediawiki_clean_filename {
>         my $filename =3D shift;
> -       $filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
> +       $filename =3D~ s{$SLASH_REPLACEMENT}{/}g;

The change from SLASH_REPLACEMENT to $SLASH_REPLACEMENT should have
happened in patch 2/22 where 'constant' was replaced with 'Readonly'.

>         # [, ], |, {, and } are forbidden by MediaWiki, even URL-enco=
ded.
>         # Do a variant of URL-encoding, i.e. looks like URL-encoding,
>         # but with _ added to prevent MediaWiki from thinking this is
> @@ -579,7 +579,7 @@ sub mediawiki_clean_filename {
>
>  sub mediawiki_smudge_filename {
>         my $filename =3D shift;
> -       $filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
> +       $filename =3D~ s{/}{$SLASH_REPLACEMENT}g;

Ditto regarding patch 2/22.

>         $filename =3D~ s/ /_/g;
>         # Decode forbidden characters encoded in mediawiki_clean_file=
name
>         $filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", he=
x($1))/ge;
> @@ -762,7 +762,7 @@ sub get_more_refs {
>         my @refs;
>         while (1) {
>                 my $line =3D <STDIN>;
> -               if ($line =3D~ m/^$cmd (.*)$/) {
> +               if ($line =3D~ /^$cmd (.*)$/) {
>                         push(@refs, $1);
>                 } elsif ($line eq "\n") {
>                         return @refs;
> @@ -1168,11 +1168,11 @@ sub mw_push_revision {
>                 my @local_ancestry =3D split(/\n/, run_git("rev-list =
--boundary --parents $local ^$parsed_sha1"));
>                 my %local_ancestry;
>                 foreach my $line (@local_ancestry) {
> -                       if (my ($child, $parents) =3D $line =3D~ m/^-=
?([a-f0-9]+) ([a-f0-9 ]+)/) {
> -                               foreach my $parent (split(' ', $paren=
ts)) {
> +                       if (my ($child, $parents) =3D $line =3D~ /^-?=
([a-f0-9]+) ([a-f0-9 ]+)/) {
> +                               foreach my $parent (split(/ /, $paren=
ts)) {
>                                         $local_ancestry{$parent} =3D =
$child;
>                                 }
> -                       } elsif (!$line =3D~ m/^([a-f0-9]+)/) {
> +                       } elsif (!$line =3D~ /^([a-f0-9]+)/) {
>                                 die "Unexpected output from git rev-l=
ist: $line";
>                         }
>                 }
> @@ -1190,10 +1190,10 @@ sub mw_push_revision {
>                 # history (linearized with --first-parent)
>                 print STDERR "Warning: no common ancestor, pushing co=
mplete history\n";
>                 my $history =3D run_git("rev-list --first-parent --ch=
ildren $local");
> -               my @history =3D split('\n', $history);
> +               my @history =3D split(/\n/, $history);

This looks fishy. In Perl, '\n' is not a newline, but instead a
literal backslash followed by an "n". The output of "rev-list
--first-parent" is line-oriented, so this looks like a bug in the
original code, which you may want to fix it in a separate patch to
make it clear that this is an actual bug fix, distinct from the
otherwise mechanical change of split('x') to split(/x/).

>                 @history =3D @history[1..$#history];
>                 foreach my $line (reverse @history) {
> -                       my @commit_info_split =3D split(/ |\n/, $line=
);
> +                       my @commit_info_split =3D split(/[ \n]/, $lin=
e);
>                         push(@commit_pairs, \@commit_info_split);
>                 }
>         }
> @@ -1272,7 +1272,7 @@ sub get_mw_namespace_id {
>                 # Look at configuration file, if the record for that =
namespace is
>                 # already cached. Namespaces are stored in form:
>                 # "Name_of_namespace:Id_namespace", ex.: "File:6".
> -               my @temp =3D split(/[\n]/, run_git("config --get-all =
remote."
> +               my @temp =3D split(/\n/, run_git("config --get-all re=
mote."
>                                                 . $remotename .".name=
spaceCache"));
>                 chomp(@temp);
>                 foreach my $ns (@temp) {
> --
