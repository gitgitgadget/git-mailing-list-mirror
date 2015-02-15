From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/2] git-send-email.perl: support no- prefix with older GetOptions
Date: Sat, 14 Feb 2015 22:32:31 -0800
Message-ID: <CA+sFfMdVBgqV6Ar53eo_PEzHSLMc+Z_fA_ND5CBEtX8=pKvk_Q@mail.gmail.com>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
	<1423858769-1565-1-git-send-email-gitster@pobox.com>
	<1423858769-1565-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 07:32:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMsku-0001rJ-SU
	for gcvg-git-2@plane.gmane.org; Sun, 15 Feb 2015 07:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbbBOGcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 01:32:32 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41302 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbBOGcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 01:32:31 -0500
Received: by iecrd18 with SMTP id rd18so27992033iec.8
        for <git@vger.kernel.org>; Sat, 14 Feb 2015 22:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FiO/HrCJS/iFk9JANlNWTnqpJFOoox9MrF2/DJCciC4=;
        b=EL5gYuCzzWw3pRFS3DsaErO6mDA9+Ub9WJXfjqwcZ9AmKWHoPEQJMBi4uZJmZII4WG
         hVsACkl5n7kSSFlY9Jw2JvLiA0R1WvvZ6bO+LC1W4ieNmmr2xs7qsz/o9qV75UxdhxZo
         nuug0viLkAadbAw4aMCeNRb72bgepD+nLzbVwnoD3BUuP06/l0IelGLIfw9csplzh726
         Ebx3Df6lJ7A/o7XkHMbdUcgCZd5j0Qq90yC/fW6MmYEXPIRzGgu8cjgOQTTaw1PsV9Mn
         gQH1gKJDWcqpSe2yt4YmK3m82ZCWhX5bgLFtGHavuFhhYv5kTBZHFRZ8kwRl9GoHod9r
         OpLw==
X-Received: by 10.107.34.149 with SMTP id i143mr22683873ioi.1.1423981951164;
 Sat, 14 Feb 2015 22:32:31 -0800 (PST)
Received: by 10.64.58.201 with HTTP; Sat, 14 Feb 2015 22:32:31 -0800 (PST)
In-Reply-To: <1423858769-1565-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263852>

On Fri, Feb 13, 2015 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> From: "Kyle J. McKay" <mackyle@gmail.com>
>
> Only Perl version 5.8.0 or later is required, but that comes with
> an older Getopt::Long (2.32) that does not support the 'no-'
> prefix.  Support for that was added in Getopt::Long version 2.33.
>
> Since the help only mentions the 'no-' prefix and not the 'no'
> prefix, add explicit support for the 'no-' prefix when running
> with older GetOptions versions.

ultra-ultra-nit: s/when running/for when running/  The current wording
makes it sound like the explicit support is only enabled when running
with older GetOpt versions.

> Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-send-email.perl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3092ab3..a18a795 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -299,6 +299,7 @@ sub signal_handler {
>                     "bcc=s" => \@bcclist,
>                     "no-bcc" => \$no_bcc,
>                     "chain-reply-to!" => \$chain_reply_to,
> +                   "no-chain-reply-to" => sub {$chain_reply_to = 0},
>                     "smtp-server=s" => \$smtp_server,
>                     "smtp-server-option=s" => \@smtp_server_options,
>                     "smtp-server-port=s" => \$smtp_server_port,
> @@ -311,25 +312,34 @@ sub signal_handler {
>                     "smtp-domain:s" => \$smtp_domain,
>                     "identity=s" => \$identity,
>                     "annotate!" => \$annotate,
> +                   "no-annotate" => sub {$annotate = 0},
>                     "compose" => \$compose,
>                     "quiet" => \$quiet,
>                     "cc-cmd=s" => \$cc_cmd,
>                     "suppress-from!" => \$suppress_from,
> +                   "no-suppress-from" => sub {$suppress_from = 0},
>                     "suppress-cc=s" => \@suppress_cc,
>                     "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
> +                   "no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
>                     "cc-cover|cc-cover!" => \$cover_cc,

I know it's not part of this patch, but does the above duplication of
"cc-cover" do something I'm not aware of?  Or should it just be
"cc-cover!"?

> +                   "no-cc-cover" => sub {$cover_cc = 0},
>                     "to-cover|to-cover!" => \$cover_to,

Here (above) too.

> +                   "no-to-cover" => sub {$cover_to = 0},
>                     "confirm=s" => \$confirm,
>                     "dry-run" => \$dry_run,
>                     "envelope-sender=s" => \$envelope_sender,
>                     "thread!" => \$thread,
> +                   "no-thread" => sub {$thread = 0},
>                     "validate!" => \$validate,
> +                   "no-validate" => sub {$validate = 0},
>                     "transfer-encoding=s" => \$target_xfer_encoding,
>                     "format-patch!" => \$format_patch,
> +                   "no-format-patch" => sub {$format_patch = 0},
>                     "8bit-encoding=s" => \$auto_8bit_encoding,
>                     "compose-encoding=s" => \$compose_encoding,
>                     "force" => \$force,
>                     "xmailer!" => \$use_xmailer,
> +                   "no-xmailer" => sub {$use_xmailer = 0},
>          );
>
>  usage() if $help;

Looks fine to me.

-Brandon
