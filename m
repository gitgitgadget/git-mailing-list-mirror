From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: add a library to detect an en_US.UTF-8 locale
Date: Fri, 07 Jan 2011 10:37:40 -0800
Message-ID: <7vy66w7e6j.fsf@alter.siamese.dyndns.org>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
 <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost>
 <1274720888.4838.13.camel@localhost> <cover.1294312018.git.yann@droneaud.fr>
 <4490926da28dcbfedc779cd32c5a59e20a1b55a2.1294312018.git.yann@droneaud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:37:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHCG-000446-3I
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab1AGShv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:37:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab1AGShu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:37:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EB352D1B;
	Fri,  7 Jan 2011 13:38:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U3aVzuLxCRbM6QF8lhY0R65sb8k=; b=o3X9Hr
	90yQj+fFiczasswXuCLm0mb7wtNYDjFZ7tRV2orKlyNaTllTtECUcNueC5C42SlJ
	HhtbqrAvyS+DzlNnOkaqVdozf0IesDOXEITbC2moUsHkr9Le725bvmKbQTHrpDl2
	B+lXBi7wYvGOyuuZiC5oiqqv+oVWX75j+PPN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XNvVrk5ge/2Th+LTO/MzFloFtrHuG7go
	fXzOrwVgx+cDBmWwEOtvuIi2id62YY/WJ3Ro6lecEAy5jAR2p3vNtK5GWNl9nsVv
	3rOFhOzCdA1Ge5UE/c1Lz7yhbCcMUkbWoy71VfXBrryhKgf9IUIa6kTgvh1CR6NT
	2Wb25zpiJ9U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 093D82D16;
	Fri,  7 Jan 2011 13:38:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC7AD2D15; Fri,  7 Jan 2011
 13:38:21 -0500 (EST)
In-Reply-To: <4490926da28dcbfedc779cd32c5a59e20a1b55a2.1294312018.git.yann@droneaud.fr>
 (Yann Droneaud's message of "Thu\,  6 Jan 2011 15\:22\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FA41BE4-1A8D-11E0-B484-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164734>

Yann Droneaud <yann@droneaud.fr> writes:

Yann Droneaud <yann@droneaud.fr> writes:

> Since one can't rely on "locale" command availability nor its -a output,
> perl script t/lib-locale.pl first use setlocale() and langinfo(CODESET)
> to search for a working en_US.UTF-8 locale among many name variants.
>
> If this fail, the script fallback to "locale" usage with two steps:
> - try the "charmap" keyword, for example LC_ALL=en_US locale charmap
> - then try "-a" option and match a pattern looking to the
>   locale names
>
> Signed-off-by: Yann Droneaud <yann@droneaud.fr>
> ---
>  t/lib-locale.pl |  167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 167 insertions(+), 0 deletions(-)
>  create mode 100755 t/lib-locale.pl

The remainder of the series looks more or less sane, but a new 170-line
script somehow feels a bit overengineered solution to a minor problem that
has already been solved in a much simpler way.

> +# try to execute "locale -a" command
> +# this command is not always available and
> +# output format is not normalized
> +#
> +use IPC::Open3;
> +use File::Spec;
> +
> +open(NULLR, "<", File::Spec->devnull) || die "Can't open devnull: $!";
> +open(NULLW, ">", File::Spec->devnull) || die "Can't open devnull: $!";
> +
> +my $pid = open3("<&NULLR", \*LOCALES, ">&NULLW" , "locale", "-a") || die "Can't launch locale -a: $!";
> +
> +while(<LOCALES>) {
> +     chomp;
> +     if (/(en_US\.([\w-]+))/i) {
> +	 if (codeset_check($2)) {
> +	     $locale = $1;
> +	     last;
> +	 }
> +     }
> +}
> +
> +waitpid($pid, 0);

You are trying to buy something with the complexity of Open3 for doing
this logic, over a bog-naive "for (`locale -a`) { ... }", but is that
something really worth the money?

"lib-locale.pl" is a gross misnomer for this script.

It may be a good helper to be used in 2/4 (test_utf8), but later people
may want to have more helper feature in something called "lib-locale", not
just "pick a single UTF-8 locale randomly from available ones on the
system" (especially when ab/i18n starts moving again).  I'd suggest either
to (1) rename it "pick-utf8-locale.pl" (i.e. honest naming) or (2) prepare
the helper command to be extensible from the beginning, i.e. require a
command word e.g. "lib-locale.pl pick-utf8-locale" to trigger the
currently implemented feature (i.e. forward looking naming).
