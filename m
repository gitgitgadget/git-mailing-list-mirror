From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Sat, 06 Jul 2013 21:12:31 -0700
Message-ID: <7vppuv57ps.fsf@alter.siamese.dyndns.org>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
	<1373025947-26495-3-git-send-email-artagnon@gmail.com>
	<20130705124536.GU862789@vauxhall.crustytoothpaste.net>
	<7vobag7wl0.fsf@alter.siamese.dyndns.org>
	<20130705174730.GM9161@serenity.lan>
	<7vehbc7tcc.fsf@alter.siamese.dyndns.org>
	<20130705184333.GN9161@serenity.lan>
	<7v1u7c6w7z.fsf@alter.siamese.dyndns.org>
	<20130706114600.GP9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jul 07 06:12:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvgLF-0004wC-FA
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 06:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277Ab3GGEMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 00:12:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3GGEMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 00:12:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C165925E60;
	Sun,  7 Jul 2013 04:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QjVZq6RKarBMRwj+6/OQWRF9qxA=; b=ySmUIL
	kPxZ2XaynA88Kajza/SmMXLGD/bTJUwB4Ho8Uung+MpwGTO/qb54NLzbf2qBwsi7
	2J9mbwcUgL7uRVR4nDG8Wn6QOPb+PkJOykMR9AnVdrEvhAAJg0uS4jYrj1nvGj/X
	ijOZHXjndN+lnMbkTfo+3H395A5zO14NuYE1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=euJVNY0tnVHaMmzGC05VSFHFKwLG/bRR
	kJWtfVCN0ElD5BKu7+nPsQ2M7LD/4ZHxuWt6cq9iCbwZ6ToXtR1Z2wpoLOga4Ac7
	uEqoUxdnel3cNUR0edjafvB0HhBXI6o4eHnT7MOxLad9duz8uf0aus17yF6Zjpzk
	nl7PpcmCi0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7CDA25E5F;
	Sun,  7 Jul 2013 04:12:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 396CF25E5B;
	Sun,  7 Jul 2013 04:12:33 +0000 (UTC)
In-Reply-To: <20130706114600.GP9161@serenity.lan> (John Keeping's message of
	"Sat, 6 Jul 2013 12:46:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72B7AB3A-E6BB-11E2-8E38-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229726>

John Keeping <john@keeping.me.uk> writes:

> @@ -1096,19 +1101,18 @@ sub smtp_auth_maybe {
>  # Helper to come up with SSL/TLS certification validation params
>  # and warn when doing no verification
>  sub ssl_verify_params {
> -	use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
> -
> -	if (!defined $smtp_ssl_cert_path) {
> -		$smtp_ssl_cert_path = "/etc/ssl/certs";
> +	if ($smtp_ssl_verify == 0) {
> +		return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_NONE);

I do not see any "use IO::Socket::SSL" anywhere after applying this
patch.  Is this expected to work?
