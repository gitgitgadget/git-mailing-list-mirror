From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] send-email: Add CCs from additional commit tags
Date: Tue, 10 Mar 2015 19:00:13 -0400
Message-ID: <CAPig+cSJkGQ8YHb7D5XV2DvNCyxdAf4GksRNAqEt-kEXznaNUw@mail.gmail.com>
References: <1425679161-13963-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:00:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVT8O-0004vX-4y
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbbCJXAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:00:16 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33576 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbCJXAO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:00:14 -0400
Received: by ykt10 with SMTP id 10so2296786ykt.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=f8blJhy/eWdmLf+w20n3ep/Mr4EgaRcZvbU5GmcUJyA=;
        b=R7DuooTna7eViq99QoRNu0dA2lqQuBbjssCC4Gd6mK/qgK58zipCCbj+Cr8q1sWVdx
         SuuI4EvN921GlAJPTyq7T6wdwYL8AHtnEgueUYxOJZg9tSGiu8iX4lqbrh70TF89V0Q9
         FVbn+eTbH4PHBORfjgWUvOpuE7aq2dVV9o1NvjqqM7lSdeDWMn1V0/NLynHE8RFFEtEa
         vaVWvsCKoVHIrL7wvjKEAyjw+EfL3atErPpm97uu6BLNpkUh53Uvs08sFNXLF+IgEPER
         ZF+TAMHspbF6l1QeHQDIgcxDKxdylqHC4rCYiXA10xJoBIuYW2Xr2H4u84JYXvzgolVx
         LXiw==
X-Received: by 10.236.63.6 with SMTP id z6mr34424595yhc.65.1426028413517; Tue,
 10 Mar 2015 16:00:13 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 16:00:13 -0700 (PDT)
In-Reply-To: <1425679161-13963-1-git-send-email-soren.brinkmann@xilinx.com>
X-Google-Sender-Auth: EaiqeMCUefK2NGs85_H_LZvAtKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265278>

On Fri, Mar 6, 2015 at 4:59 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> Add email addresses from additional commonly used tags to the CC-list of
> patches. Additional tags are:
>  - Acked-by
>  - Reviewed-by
>  - Tested-by
>  - Reported-by
>  - Reviewed-and-tested-by
>
> --suppress-cc=ack suppresses these additional CCs.

This and similar suggestions have come up a number of times. Rather
than hard-coding an ever-growing list of tags, general consensus seems
to be that it would be better to provide some sort of mechanism for
people to customize the list for their needs. See, for instance, [1].
Such ability would also be a better fit for non-standard, potentially
contested tags, such as Reviewed-and-tested-by:.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/233003/focus=233739

> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  Documentation/git-send-email.txt | 3 +++
>  git-send-email.perl              | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index f248a8665e1f..1b521446ca11 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -293,6 +293,9 @@ Automating
>    patch body (commit message) except for self (use 'self' for that).
>  - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
>     for self (use 'self' for that).
> +- 'ack' will avoid including anyone who acked the  patch (mentioned in
> +  Acked-by, Reviewed-by, Tested-by, Reviewed-and-tested-by lines except for
> +  self (use 'self' for that).
>  - 'cccmd' will avoid running the --cc-cmd.
>  - 'body' is equivalent to 'sob' + 'bodycc'
>  - 'all' will suppress all auto cc values.
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3092ab356c76..18eb8a5139a4 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -407,7 +407,7 @@ my(%suppress_cc);
>  if (@suppress_cc) {
>         foreach my $entry (@suppress_cc) {
>                 die "Unknown --suppress-cc field: '$entry'\n"
> -                       unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
> +                       unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|ack)$/;
>                 $suppress_cc{$entry} = 1;
>         }
>  }
> @@ -1452,7 +1452,7 @@ foreach my $t (@files) {
>         # Now parse the message body
>         while(<$fh>) {
>                 $message .=  $_;
> -               if (/^(Signed-off-by|Cc): (.*)$/i) {
> +               if (/^(Signed-off-by|Cc|Acked-by|Reviewed-by|Tested-by|Reported-by|Reviewed-and-tested-by): (.*)$/i) {
>                         chomp;
>                         my ($what, $c) = ($1, $2);
>                         chomp $c;
> @@ -1462,6 +1462,7 @@ foreach my $t (@files) {
>                         } else {
>                                 next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
>                                 next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
> +                               next if $suppress_cc{'ack'} and $what =~ /(Acked-by|Reviewed-by|Tested-by|Reported-by|Reviewed-and-tested-by)/i;
>                         }
>                         push @cc, $c;
>                         printf("(body) Adding cc: %s from line '%s'\n",
> --
> 2.3.1.2.g90df61e.dirty
