From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] interpret-trailers: add option for in-place editing
Date: Wed, 06 Jan 2016 15:19:45 +0100
Message-ID: <vpqoacylri6.fsf@anie.imag.fr>
References: <1452087258-3893-1-git-send-email-tobias.klauser@zhinst.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>
To: Tobias Klauser <tobias.klauser@zhinst.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 15:20:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGowZ-0003sb-BH
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 15:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbcAFOT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 09:19:59 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55499 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbcAFOT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 09:19:57 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u06EJint002692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 6 Jan 2016 15:19:44 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u06EJjHK029918;
	Wed, 6 Jan 2016 15:19:45 +0100
In-Reply-To: <1452087258-3893-1-git-send-email-tobias.klauser@zhinst.com>
	(Tobias Klauser's message of "Wed, 6 Jan 2016 14:34:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Jan 2016 15:19:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u06EJint002692
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1452694787.217@n6mTtQ+RMdv/LddrNfxFrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283446>

Tobias Klauser <tobias.klauser@zhinst.com> writes:

> From: Tobias Klauser <tklauser@distanz.ch>
>
> Add a command line option --in-place to support in-place editing akin to
> sed -i.  This allows to write commands like the following:

Since -i is a common shortcut for --in-place (perl -i, sed -i), it
probably makes sense to have it here too. OTOH, this is meant for
scripting and perhaps it's best to force script writters to be verbose.

> Also add the corresponding documentation and tests.

This sentence does not harm, but I personnally don't think it's really
helpfull, as it's already clear by the diffstat right below, and the
patch itself.

> -static void print_tok_val(const char *tok, const char *val)
> +static void print_tok_val(FILE *fp, const char *tok, const char *val)
>  {
>  	char c = last_non_space_char(tok);
>  	if (!c)
>  		return;
>  	if (strchr(separators, c))
> -		printf("%s%s\n", tok, val);
> +		fprintf(fp, "%s%s\n", tok, val);
>  	else
> -		printf("%s%c %s\n", tok, separators[0], val);
> +		fprintf(fp, "%s%c %s\n", tok, separators[0], val);
>  }

The patch would be even easier to read if split into a preparatory
refactoring patch "turn printf into fprintf" and then the actual one.
But it's already rather clear, so you can probably leave it as-is.

> -static void print_lines(struct strbuf **lines, int start, int end)
> +static void print_lines(FILE *fp, struct strbuf **lines, int start, int end)

Here and below: it would probably be more readable with a more explicit
name for fp, like "outfile". Especially here:

> -static int process_input_file(struct strbuf **lines,
> +static int process_input_file(FILE *fp,
> +			      struct strbuf **lines,

Where it's tempting to think that a parameter given to
process_input_file is ... the input file!

Other than these minor details, the patch looks good to me. Thanks for
the patch!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
