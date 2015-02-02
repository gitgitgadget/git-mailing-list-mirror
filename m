From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Sun, 01 Feb 2015 17:33:55 -0800
Message-ID: <xmqqmw4x85bw.fsf@gitster.dls.corp.google.com>
References: <54CA3611.1000804@statsbiblioteket.dk>
	<1422599085-11804-1-git-send-email-tgc@statsbiblioteket.dk>
	<20150130230516.GA7867@vauxhall.crustytoothpaste.net>
	<a924a58108ea8ad8aece1ee66cbdc3f@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git mailing list <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 02:34:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI5tv-0001Tr-06
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 02:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbbBBBd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 20:33:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753866AbbBBBd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 20:33:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F53535D3E;
	Sun,  1 Feb 2015 20:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qslEOq+03SIfSoSmaU5+p8xHZDQ=; b=bTuWJe
	Z18fR+f4zJuW/1tKlSrGh8rbLmLg9XOTNRF/dBlLaalpAb8c9h/TXF2zLUPvp3we
	feS0Qp2qbbxc8Sbv2VPb1pl+evpOTrtOairgPWzEl2EEIcSyxP7022IxCklF7Kmj
	ZTGMwasfzEyxF4NRBU/3xexoIEnOimsIcVKDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OmB+XMKjpvmQxNWyLu7m3dUKMKkQZURV
	Z6KJejzPv2K6PWrx1JVKfcSW0RmiQFKnO4FV4SDmhogQ3bni4s6KXWsrtfIheLuB
	jEY/tJeBfTG2znv0gZmpGlwxyn+oDdMD21oj7ACQzqu72WOs/8zZvztIhfWO3NQC
	Du7vbvz+UUM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3315635D3D;
	Sun,  1 Feb 2015 20:33:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B66BE35D3C;
	Sun,  1 Feb 2015 20:33:56 -0500 (EST)
In-Reply-To: <a924a58108ea8ad8aece1ee66cbdc3f@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Fri, 30 Jan 2015 18:40:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8DF90B8E-AA7B-11E4-B55C-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263246>

"Kyle J. McKay" <mackyle@gmail.com> writes:

>> use 5.008;
>
> So either that needs to change or the code should properly deal with  
> the version of Getopt::Long that comes with 5.8.0.
>
> Since it's really not very difficult or invasive to add support for  
> the no- variants, here's a patch to do so:

Doesn't that approach add "what does --no-no-chain-rely-to even
mean?" confusion to the resulting system?  If that is not the case,
then I am all for it, but otherwise, let's not.

People can easily spell --noxmailer if they want to stay at an older
Getopt::Long, and over time these ancient ones will be upgraded
away.



> -- 8< --
> Subject: [PATCH] git-send-email.perl: support no- prefix with older GetOptions
>
> Only Perl version 5.8.0 or later is required, but that comes with
> an older Getopt::Long (2.32) that does not support the 'no-'
> prefix.  Support for that was added in Getopt::Long version 2.33.
>
> Since the help only mentions the 'no-' prefix and not the 'no'
> prefix, add explicit support for the 'no-' prefix when running
> with older GetOptions versions.
>
> Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  git-send-email.perl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3092ab35..a18a7959 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -299,6 +299,7 @@ my $rc = GetOptions("h" => \$help,
>  		    "bcc=s" => \@bcclist,
>  		    "no-bcc" => \$no_bcc,
>  		    "chain-reply-to!" => \$chain_reply_to,
> +		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
>  		    "smtp-server=s" => \$smtp_server,
>  		    "smtp-server-option=s" => \@smtp_server_options,
>  		    "smtp-server-port=s" => \$smtp_server_port,
> @@ -311,25 +312,34 @@ my $rc = GetOptions("h" => \$help,
>  		    "smtp-domain:s" => \$smtp_domain,
>  		    "identity=s" => \$identity,
>  		    "annotate!" => \$annotate,
> +		    "no-annotate" => sub {$annotate = 0},
>  		    "compose" => \$compose,
>  		    "quiet" => \$quiet,
>  		    "cc-cmd=s" => \$cc_cmd,
>  		    "suppress-from!" => \$suppress_from,
> +		    "no-suppress-from" => sub {$suppress_from = 0},
>  		    "suppress-cc=s" => \@suppress_cc,
>  		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
> +		    "no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
>  		    "cc-cover|cc-cover!" => \$cover_cc,
> +		    "no-cc-cover" => sub {$cover_cc = 0},
>  		    "to-cover|to-cover!" => \$cover_to,
> +		    "no-to-cover" => sub {$cover_to = 0},
>  		    "confirm=s" => \$confirm,
>  		    "dry-run" => \$dry_run,
>  		    "envelope-sender=s" => \$envelope_sender,
>  		    "thread!" => \$thread,
> +		    "no-thread" => sub {$thread = 0},
>  		    "validate!" => \$validate,
> +		    "no-validate" => sub {$validate = 0},
>  		    "transfer-encoding=s" => \$target_xfer_encoding,
>  		    "format-patch!" => \$format_patch,
> +		    "no-format-patch" => sub {$format_patch = 0},
>  		    "8bit-encoding=s" => \$auto_8bit_encoding,
>  		    "compose-encoding=s" => \$compose_encoding,
>  		    "force" => \$force,
>  		    "xmailer!" => \$use_xmailer,
> +		    "no-xmailer" => sub {$use_xmailer = 0},
>  	 );
>  
>  usage() if $help;
> --
