From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge/pull: verify GPG signatures of commits being
 merged
Date: Fri, 22 Mar 2013 16:02:47 -0700
Message-ID: <7v4ng3597s.fsf@alter.siamese.dyndns.org>
References: <514CD26C.2070702@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sat Mar 23 00:03:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJAzX-0002V8-1n
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 00:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423468Ab3CVXCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 19:02:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423377Ab3CVXCu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Mar 2013 19:02:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01CADA9BC;
	Fri, 22 Mar 2013 19:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kA+qcdecEF31
	VSnWDGBLvP6BG5g=; b=dR4Di9VAwrwqZQmek+dOssWyu6hXOLygU+W1g8RT3YIV
	j4nMJr6DNHz4Zm1x5Fyg8oMNC1RVAn/RFaPUROCi/tOX74dl2UQSzSQfXEWaMjPA
	Adtrg48/rIJpiXXYZ8VpDdT5bs2Jf08af9yaDfAYCCa3YMK3q8+6tdSTWKF8JRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F9PjrL
	67whIRz+NHtWhHBWNKQyy8R2wCZBl3/w1B12IUWtkG8WNFE7wEGA85Rvy+/TXNYg
	7mLC/lddPmjAHJHCKmOaIdwBeFqVDHhuHXUErWgDB1m4uUibOf7Bu6J7EkX4TJqm
	ambRGfgrdtjORS4UXSkRH8NYQoB7LK2ZK7Wvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EADCBA9BB;
	Fri, 22 Mar 2013 19:02:49 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22B95A9BA; Fri, 22 Mar 2013
 19:02:49 -0400 (EDT)
In-Reply-To: <514CD26C.2070702@physik.tu-berlin.de> ("Sebastian
 =?utf-8?Q?G=C3=B6tte=22's?= message of "Fri, 22 Mar 2013 22:51:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DF24CF8-9344-11E2-AA6F-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218864>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> git merge/pull:
> When --verify-signatures is specified on the command-line of git-merg=
e
> or git-pull, check whether the commits being merged have good gpg
> signatures and abort the merge in case they do not. This allows e.g.
> auto-deployment from untrusted repo hosts.
>
> pretty printing:
> Tell about an "untrusted good signature" in addition to the previous
> "good signature" and "bad signature". In case of a missing signature,
> expand the pretty format string "%G?" to "N" in since this eases the
> wirting of anything parsing git-log output.
>
> Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
> ---
> I moved the commit signature verification code from pretty.c to commi=
t.c
> because it is used from pretty.c and builtin/merge.c. I include that =
pretty
> printing change here because I needed to add the good/untrusted check=
 for the
> merge --verify-signatures option to really make sense.
>
> Those new %G? options are implicitly tested by t7612-merge-verify-sig=
natures.sh
> because %G? is just replaced by the passed-through output of the comm=
it
> verification function.

While I think the new --verify-signature option may be a good
addition, I wonder if you can split this patch down a bit for easier
review and validation.

Perhaps this needs to be done in at least three steps:

    (1) first move the code without changing anything (most
        importantly, do not add 'U' or 'N' at this step); then

    (2) teach 'merge' and 'pull' to understand the new option, and
        finally;

    (3) introduce 'U' and 'N'.

The existing users of '%G?' placeholders are not expecting to see
'N' but turning it into an empty string, so if the third step turns
out to be problematic to these users, we can discard the third step
and still benefit from the first two, for example.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index 105f18a..7297b1b 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -131,7 +131,7 @@ The placeholders are:
>  - '%B': raw body (unwrapped subject and body)
>  - '%N': commit notes
>  - '%GG': raw verification message from GPG for a signed commit
> -- '%G?': show either "G" for Good or "B" for Bad for a signed commit
> +- '%G?': show "G" for a Good signature, "B" for a Bad signature, "U"=
 for a good, untrusted signature and "N" for no signature

Even though this is a source that is turned into html and manpages,
people do read these in the original text format (that is the whole
point of using AsciiDoc as the source format), so please see if you
can avoid this overly long line.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 7c8922c..37ece3d 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -49,7 +49,7 @@ static const char * const builtin_merge_usage[] =3D=
 {
>  static int show_diffstat =3D 1, shortlog_len =3D -1, squash;
>  static int option_commit =3D 1, allow_fast_forward =3D 1;
>  static int fast_forward_only, option_edit =3D -1;
> -static int allow_trivial =3D 1, have_message;
> +static int allow_trivial =3D 1, have_message, verify_signatures =3D =
0;

Avoid initializing static variables to 0, and instead let BSS take
care of them.

> @@ -199,6 +199,8 @@ static struct option builtin_merge_options[] =3D =
{
>  	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
>  		N_("abort if fast-forward is not possible")),
>  	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
> +	OPT_BOOLEAN(0, "verify-signatures", &verify_signatures,
> +		N_("Verify that the named commit has a valid GPG signature")),
>  	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
>  		N_("merge strategy to use"), option_parse_strategy),
>  	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=3Dvalue"),
> @@ -1233,6 +1235,35 @@ int cmd_merge(int argc, const char **argv, con=
st char *prefix)
>  		usage_with_options(builtin_merge_usage,
>  			builtin_merge_options);
> =20
> +	if (verify_signatures) {
> +		//Verify the commit signatures

No // C99/C++ comments.

The rest of the patch not reviewed; expecting a split reroll.

Thanks.
