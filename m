From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: Add simple email aliases format
Date: Thu, 21 May 2015 21:05:12 -0400
Message-ID: <CAPig+cQ8Gw3Q1QcJ=k4647LW1gBZ3fuJBYpOCE=AxA0ZWtktmQ@mail.gmail.com>
References: <4b56f6ab3c14aff7752804d11917b1f330f55f40.1432252898.git.allenbh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 03:05:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvbOp-0007ic-9V
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 03:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbbEVBFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 21:05:14 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35548 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbbEVBFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 21:05:13 -0400
Received: by iesa3 with SMTP id a3so21155789ies.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 18:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=D2bfyloBY+z8DZk6xsno/7ez7q6qLE3vp7SH/x5T15A=;
        b=aa61ov/LylVDSz6n06+uOzWcFQCuAZeGr35mGYEyoshleXT0C3doCmQtfBn+Dc/xhf
         W0NsGKO6ijr8TZGGl7QOJFPYxbDXu818sdNvgJ1NgmbWA8iNfJTpxs+IF4Y2pPbwL/AG
         AzBlmbVuNH4K2adklHDtD45Qn7684YiKbYGDA1ERfgpSNLge2FGyYWWTlHw3HMsLAL72
         PRTEgdsrpNKY0EJF6ze5dqog/olGomyoPWQStIBWR3Ic7beKcmmXoUGPg0UHZHchQyFv
         cUwOXqmfKldVsOZ8SFtX+Ulj/p2rdn0IYBAVOdkbfcMs5aaVPjN1QsxSYrdYPCvxd+et
         iV0A==
X-Received: by 10.107.31.134 with SMTP id f128mr7230866iof.19.1432256712269;
 Thu, 21 May 2015 18:05:12 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 18:05:12 -0700 (PDT)
In-Reply-To: <4b56f6ab3c14aff7752804d11917b1f330f55f40.1432252898.git.allenbh@gmail.com>
X-Google-Sender-Auth: F1ldfg7JpC1DHnQF7-8Wg0Tl40A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269682>

On Thu, May 21, 2015 at 8:16 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> This format is more simple than the other alias file formats, so it may
> be preferred by some users.  The format is as follows.
>
> <alias>: <address|alias>[, <address|alias>...]
>
> Aliases are specified one per line.  There is no line splitting.
>
> Example:
>         alice: Alice W Land <awol@example.com>
>         bob: Robert Bobbyton <bob@example.com>
>         chloe: chloe@example.com
>         abgroup: alice, bob
>         bcgrp: bob, chloe, Other <o@example.com>
>
> Signed-off-by: Allen Hubbe <allenbh@gmail.com>
> ---
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

It's perhaps somewhat unfortunate that the formats of the other alias
file types aren't described here, however, the reader can at least
look them up. But the new "simple" format is never described anywhere
in the documentation, so it's effectively unusable. Most users will be
unable or unwilling to consult the source code or the commit message
to figure out how to use this format. The description you wrote for
the commit message might be sufficient as proper documentation (with
proper Asciidoc formatting, of course).

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

I imagine that users would appreciate being able to add comments to
their aliases file, and the implementation complexity to support
comment lines and blank lines (as described in the Postfix aliases
documentation you cited earlier[1]) would be so minor that I'm rather
surprised you chose not to do so.

[1]: http://www.postfix.org/aliases.5.html

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

A here-doc would be easier to maintain and read:

    cat >~/.tmp-email-aliases <<-\EOF &&
        alice: Alice W Land <awol@example.com>
        bob: Robert Bobbyton <bob@example.com>
        ...
    EOF

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
