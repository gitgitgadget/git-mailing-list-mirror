From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4 5/6] Git.pm: add interface for git credential command
Date: Wed, 27 Feb 2013 15:18:46 +0100
Message-ID: <vpqppzl4z7d.fsf@grenoble-inp.fr>
References: <cover.1360677646.git.mina86@mina86.com>
	<cover.1360677646.git.mina86@mina86.com>
	<e5834c9b5ccb66a88b64b3d07982ad41205fb97e.1360677646.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, gitster@pobox.com, git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 15:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAhr1-0006BS-AN
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 15:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760001Ab3B0OTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 09:19:04 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59838 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756792Ab3B0OTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 09:19:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1REIjYC030484
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Feb 2013 15:18:45 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UAhqI-0005f3-P4; Wed, 27 Feb 2013 15:18:46 +0100
In-Reply-To: <e5834c9b5ccb66a88b64b3d07982ad41205fb97e.1360677646.git.mina86@mina86.com>
	(Michal Nazarewicz's message of "Tue, 12 Feb 2013 15:02:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 Feb 2013 15:18:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1REIjYC030484
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362579530.76131@6isSxcQ6OGuVjSDg/uNETQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217204>

Michal Nazarewicz <mpn@google.com> writes:

> +=item credential_read( FILEHANDLE )
> +
> +Reads credential key-value pairs from C<FILEHANDLE>.  Reading stops at EOF or
> +when an empty line is encountered.  Each line must be of the form C<key=value>
> +with a non-empty key.  Function returns hash with all read values.  Any white
> +space (other then new-line character) is preserved.

Typo: other then -> than.

> +sub credential_read {
> +	my ($self, $reader) = _maybe_self(@_);
> +	my %credential;
> +	while (<$reader>) {
> +		chomp;
> +		if ($_ eq '') {
> +			last;
> +		} elsif (!/^([^=]+)=(.*)$/) {

Good.

> +	# Check if $credential is valid prior to writing anything
> +	while (($key, $value) = each %$credential) {
> +		if (!defined $key || !length $key) {
> +			throw Error::Simple("credential key empty or undefined");
> +		} elsif ($key =~ /[=\n\0]/) {
> +			throw Error::Simple("credential key contains invalid characters: $key");
> +		} elsif (defined $value && $value =~ /[\n\0]/) {
> +			throw Error::Simple("credential value for key=$key contains invalid characters: $value");
> +		}
> +	}

Good.

These checks seem to address all the points raised during discussion
about when the API should reject values.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
