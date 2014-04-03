From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Improve diffs when filenames contain problem characters
Date: Thu, 3 Apr 2014 08:18:34 +0000
Message-ID: <CANQwDwdfDQthiYa+-PemzBAgDLDZDDDf_pRzn1vV-7NRH9bjGw@mail.gmail.com>
References: <A60B35D8-0981-45C8-B7D9-B89C729A837D@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Krzesimir Nowak <krzesimir@endocode.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:08:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVf2W-00026s-4P
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162532AbaDCITU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2014 04:19:20 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:53360 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162466AbaDCITP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2014 04:19:15 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so1564920obc.38
        for <git@vger.kernel.org>; Thu, 03 Apr 2014 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yf/egcdeHcMCTPAJMeE9J13tozqnR863JV/ltYoo4mg=;
        b=SHCf0FeXPB0DN7jjwZA6ZyLe9scrQqUHZJrA/M1RMf1o4qqag+fQx2G1BvX71yFPk9
         VvnSoTLh9fupjttBScxM7HAOU57pJFKB5sKyMmbeLRdfyADKgA9DMPI5fbrpZvKxEut8
         EF9ndII1/2hLWStY31WOXlhUUxi5yO/fa8C5e/aRHIiCDVmXudFKqauKJGyxiEouISYF
         +381Bx1LMVQR4zzNMdDianNDHLMTkJi9bLiwssnbeYPpor5gdmLVo8kpp13WN7nnmhDj
         91QxpyCrPZ6tD7PErGviOn+cKXyOhfU5g4cY547GdlTGs4GhlfiKuqCVhl4m9OrcEBkR
         hb0g==
X-Received: by 10.60.115.68 with SMTP id jm4mr2031281oeb.45.1396513154636;
 Thu, 03 Apr 2014 01:19:14 -0700 (PDT)
Received: by 10.76.8.98 with HTTP; Thu, 3 Apr 2014 01:18:34 -0700 (PDT)
In-Reply-To: <A60B35D8-0981-45C8-B7D9-B89C729A837D@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245705>

[Forgot to hit Reply-to-all instead of Reply. Andrew, I'm sorry for
duplicate email]

On Sat, Mar 29, 2014 at 2:53 PM, Andrew Keller <andrew@kellerfarm.com> =
wrote:
>
> When formatting a diff header line, be sure to escape the raw output =
from git
> for use as HTML.  This ensures that when "problem characters" (&, <, =
>, ?, etc.)
> exist in filenames, gitweb displays them as text, rather than letting=
 the
> browser interpret them as HTML.

Actually gitweb tries to do the right thing, and in most cases it does
HTML escaping correctly. The problem is only with *binary* files (this =
fact
should IMHO have been mentioned in commit message).

This issue is caused by two problems / errors. First, gitweb misclassif=
y
"Binary files a/foo and b/bar differ" as diff header, while it is untyp=
ical
but it is diff contents. Second, gitweb doesn't HTML-escape unknown
diff headers, assuming that it knows about all possible types.

I have had those changes in my git repository, but I do not know if
I have pushed it before the PC went down, and if I have it in backup.

>
> Reported-by: Dongsheng Song <dongsheng.song@gmail.com>
> Signed-off-by: Andrew Keller <andrew@kellerfarm.com>

Thank you for your work.

> ---
> Steps to reproduce:
>
> 1)  Create a repository that contains a commit that adds a file:
>     * with an ampersand in the filename
>     * with binary contents
> 2)  Make the repository visible to gitweb
> 3)  In gitweb, navigate to the page that shows the diff for the commi=
t
>     that added the file
>
> Behavior without patch:

Page contains unescaped '&' instead of '&amp;'

>                                   Page stops rendering when it gets t=
o one of
> the instances of the filename (in the diff header, to be specific), a=
nd
> a light-red box appears a the top of the page, saying something like
> this:
>
> This page contains the following errors:
>
> error on line 67 at column 22: xmlParseEntityRef: no name
>
> Below is a rendering of the page up to the first error.
>
>
> (This particular error is what you get with an unescaped ampersand)

This is caused by the fact that some browsers use strict XML validation
mode when receiving 'application/xml+xhtml' contents, and not 'text/htm=
l'.
So one might not notice it...

> Behavior with patch: You see the ampersand in the file name, and the
> page renders as one would expect.

A question: it does not escapes HTML twice, i.e. you don't see
'&amp;' in rendered output ('&amp;amp;' in page source)?

> Other notes:
>
> Several helper methods exist for escaping HTML, and I was unsure
> about which one to use.  Although this patch fixes the problem,
> it is possible that it may be more correct to use, for example, the
> 'esc_html' helper method instead of interacting with $cgi directly.

It is preferred to use esc_html instead of $cgi->escapeHTML.
Even better use esc_path to escape pathnames.

> The first hunk in the diff seems to be all that's required to experie=
nce
> the good behavior, however upon inspecting the code, it seems
> prudent to also include the second one.  It's a nearby section of cod=
e,
> doing similar work, and is called from the same function as the
> former, and with similar arguments.

I wonder if it would not interfere with processing of diff contents
by gitweb, for example adding links to pre-image and post-image
version of a file.

>  gitweb/gitweb.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 79057b7..6c559f8 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2223,6 +2223,8 @@ sub format_git_diff_header_line {
>   my $diffinfo =3D shift;
>   my ($from, $to) =3D @_;
>
> + $line =3D $cgi->escapeHTML($line);
> +
>   if ($diffinfo->{'nparents'}) {
>   # combined diff
>   $line =3D~ s!^(diff (.*?) )"?.*$!$1!;
> @@ -2259,6 +2261,8 @@ sub format_extended_diff_header_line {
>   my $diffinfo =3D shift;
>   my ($from, $to) =3D @_;
>
> + $line =3D $cgi->escapeHTML($line);
> +
>   # match <path>
>   if ($line =3D~ s!^((copy|rename) from ).*$!$1! && $from->{'href'}) =
{
>   $line .=3D $cgi->a({-href=3D>$from->{'href'}, -class=3D>"path"},

I'd have to examine code flow to check where it lands...

--=20
Jakub Nar=C4=99bski
