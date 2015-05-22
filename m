From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v3] send-email: Add simple email aliases format
Date: Thu, 21 May 2015 23:37:48 -0400
Message-ID: <CAJ80sasiGTLqcu4p7oFY5=xKfFeJvpKgGgvBiX1y0M8Ex+5+Ug@mail.gmail.com>
References: <8bcd133c3595ee6c50dfc815c5901b32eb88d88b.1432265641.git.allenbh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Allen Hubbe <allenbh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 05:37:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvdmV-0007CB-3h
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 05:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbbEVDhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 23:37:51 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37635 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbbEVDhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 23:37:50 -0400
Received: by wibt6 with SMTP id t6so33692238wib.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 20:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3bhNhqB/I7XUNdIGwkAy03hdRCuVIN0r1kC8jnnO3Sg=;
        b=F4VAXIwg7upMTz7Uaqztj7uktETM1WcO5OxJxJd70oJ3KzVNxB8zoKfHSRCHCzTEjx
         6lAdM/gWSBL8cW8lY+3umQ/vNKKRD03ZOBM8FInzcN2w+vTREZK8ERTL6d9LvQ5eKwu7
         FNV0ue3cVCywzoczHj/z52gk4ngfxbkAnK9cQFmUnX8NmSI9/9FKSlTaaSbq9Ty+fofh
         vNCYWmGR21CbY6DcC2FUBlnNwZGcg7/hxci9jLqBeTH3Yd9Z/g7iAiFbom57t952f7cP
         dRMIVgnACQBb5u49SMJYURrXInahg70JbZfknrmQD0FnDWkmIWoNJ/XsxT9kikuEiO5s
         8U7Q==
X-Received: by 10.180.206.229 with SMTP id lr5mr3311840wic.86.1432265868781;
 Thu, 21 May 2015 20:37:48 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Thu, 21 May 2015 20:37:48 -0700 (PDT)
In-Reply-To: <8bcd133c3595ee6c50dfc815c5901b32eb88d88b.1432265641.git.allenbh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269686>

Please ignore v3... this is the same as v2 for some reason.  I will
resend as v4.

On Thu, May 21, 2015 at 11:35 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> This format is more simple than the other alias file formats, so it may
> be preferred by some users.  The format is as follows.
>
>         <alias>: <address|alias>[, <address|alias>...]
>
> Aliases are specified one per line.  There is no line splitting.
> Anything on a line after and including a `#` symbol is considered a
> comment, and is ignored.  Blank lines are ignored.
>
> Example of the 'simple' format:
>
>         alice: Alice W Land <awol@example.com>
>         bob: Robert Bobbyton <bob@example.com>
>         # this is a comment
>            # this is also a comment
>         chloe: chloe@example.com
>         abgroup: alice, bob # comment after an alias
>         bcgrp: bob, chloe, Other <o@example.com>
>
> Signed-off-by: Allen Hubbe <allenbh@gmail.com>
> ---
>
> Notes:
>     This v3 extends the syntax to allow blank lines, and comments.  The test
>     case is extended with comments added to alias file input.
>
>     The Documentation/git-send-email.txt is updated with a description of
>     the simple format.  A note is added for the other formats, directing
>     readers to check the documentation of the email clients for a
>     description.
>
>  Documentation/git-send-email.txt |  2 +-
>  git-send-email.perl              |  6 +++++-
>  t/t9001-send-email.sh            | 24 ++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 804554609def..99583c4f8969 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -383,7 +383,7 @@ sendemail.aliasesFile::
>
>  sendemail.aliasFileType::
>         Format of the file(s) specified in sendemail.aliasesFile. Must be
> -       one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
> +       one of 'mutt', 'mailrc', 'pine', 'elm', 'gnus', or 'simple'.
>
>  sendemail.multiEdit::
>         If true (default), a single editor instance will be spawned to edit
> diff --git a/git-send-email.perl b/git-send-email.perl
> index e1e9b1460ced..25d72e8db8bf 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -515,7 +515,11 @@ my %parse_alias = (
>                                $aliases{$alias} = [ split_addrs($addr) ];
>                           }
>                       } },
> -
> +       simple => sub { my $fh = shift; while (<$fh>) {
> +               if (/^\s*(\S+)\s*:\s*(.+)$/) {
> +                       my ($alias, $addr) = ($1, $2);
> +                       $aliases{$alias} = [ split_addrs($addr) ];
> +               }}},
>         gnus => sub { my $fh = shift; while (<$fh>) {
>                 if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
>                         $aliases{$1} = [ $2 ];
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 7be14a4e37f7..bbb73cdf8bec 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1548,6 +1548,30 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
>                 2>errors >out &&
>         grep "^!someone@example\.org!$" commandline1
>  '
> +test_expect_success $PREREQ 'sendemail.aliasfiletype=simple' '
> +       clean_fake_sendmail && rm -fr outdir &&
> +       git format-patch -1 -o outdir &&
> +       {
> +               echo "alice: Alice W Land <awol@example.com>"
> +               echo "bob: Robert Bobbyton <bob@example.com>"
> +               echo "chloe: chloe@example.com"
> +               echo "abgroup: alice, bob"
> +               echo "bcgrp: bob, chloe, Other <o@example.com>"
> +       } >~/.tmp-email-aliases &&
> +       git config --replace-all sendemail.aliasesfile \
> +               "$(pwd)/.tmp-email-aliases" &&
> +       git config sendemail.aliasfiletype simple &&
> +       git send-email \
> +               --from="Example <nobody@example.com>" \
> +               --to=alice --to=bcgrp \
> +               --smtp-server="$(pwd)/fake.sendmail" \
> +               outdir/0001-*.patch \
> +               2>errors >out &&
> +       grep "^!awol@example\.com!$" commandline1 &&
> +       grep "^!bob@example\.com!$" commandline1 &&
> +       grep "^!chloe@example\.com!$" commandline1 &&
> +       grep "^!o@example\.com!$" commandline1
> +'
>
>  do_xmailer_test () {
>         expected=$1 params=$2 &&
> --
> 2.3.4
>
