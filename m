From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: apply fallback encoding before highlight
Date: Mon, 02 May 2016 10:49:41 -0700
Message-ID: <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
References: <1461151948-38583-1-git-send-email-shin@kojima.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christopher Wilson <cwilson@cdwilson.us>,
	Jakub Narebski <jnareb@gmail.com>
To: Shin Kojima <shin@kojima.org>
X-From: git-owner@vger.kernel.org Mon May 02 19:49:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHyg-0004RV-8M
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbcEBRtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 13:49:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754659AbcEBRtp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 13:49:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A3B11643A;
	Mon,  2 May 2016 13:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RnHv98Neb5Jx
	/5xnJR87oVyZPv4=; b=NANIdAglLlnLFkf52iM27y2HQ7nMEAwoJlTUO4XuQP+P
	0kw52N4QN25jfF60GqexrDJhkzA2H1vm1+n0O+OmFwj0u3uQppUWGeYpGrM03etP
	PCqlCh8OGn0cCvPI8xHKF5OrwS0m3+yCIvF2Oglch0c47QVc81/Dzjo5mgTXTws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iN0uCN
	j13ydVXGmPQGtBv1nZnounLzZpDwYZbCaWeMVpCcrC4hq17J/dvJ+3KbYnVL4ZVC
	kIazStf8H7M1BaJCzxDaiatzaryQ9Xn7mNY4M0EOQMeRT0k93TsGtcVwvu95CUyW
	Tn4p4OlQ0aFZ2Qo/HPXiaCgtTARflln5w77pg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3165B16438;
	Mon,  2 May 2016 13:49:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7ADF416437;
	Mon,  2 May 2016 13:49:43 -0400 (EDT)
In-Reply-To: <1461151948-38583-1-git-send-email-shin@kojima.org> (Shin
	Kojima's message of "Wed, 20 Apr 2016 20:32:28 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4083E8CC-108E-11E6-952E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293250>

Shin Kojima <shin@kojima.org> writes:

> Some multi-byte character encodings (such as Shift_JIS and GBK) have
> characters whose final bytes is an ASCII '\' (0x5c), and they
> will be displayed as funny-characters even if $fallback_encoding is
> correct.  This is because `highlight` command always expects UTF-8
> encoded strings from STDIN.
>
>     $ echo 'my $v =3D "=E7=94=B3";' | highlight --syntax perl | w3m -=
T text/html -dump
>     my $v =3D "=E7=94=B3";
>
>     $ echo 'my $v =3D "=E7=94=B3";' | iconv -f UTF-8 -t Shift_JIS | h=
ighlight \
>         --syntax perl | iconv -f Shift_JIS -t UTF-8 | w3m -T text/htm=
l -dump
>
>     iconv: (stdin):9:135: cannot convert
>     my $v =3D "
>
> This patch prepare git blob objects to be encoded into UTF-8 before
> highlighting in the manner of `to_utf8` subroutine.
> ---

The single liner Perl invoked from the script felt a bit too dense
to my taste but other than that I have no complaints to what the
patched code does.

Jakub, does it look good to you, too?

Please sign-off your patch (see Documentation/SubmittingPatches).

Thanks.


>  gitweb/gitweb.perl | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 05d7910..2fddf75 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3935,6 +3935,9 @@ sub run_highlighter {
> =20
>  	close $fd;
>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | "=
=2E
> +	          quote_command($^X, '-CO', '-MEncode=3Ddecode,FB_DEFAULT',=
 '-pse',
> +	            '$_ =3D decode($fe, $_, FB_DEFAULT) if !utf8::decode($_=
);',
> +	            '--', "-fe=3D$fallback_encoding")." | ".
>  	          quote_command($highlight_bin).
>  	          " --replace-tabs=3D8 --fragment --syntax $syntax |"
>  		or die_error(500, "Couldn't open file or run syntax highlighter");
