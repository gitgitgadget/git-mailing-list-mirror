From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Generate a warning message if we find an unrecognized
 option.
Date: Mon, 08 Feb 2010 16:59:12 -0800
Message-ID: <7vvde7z0kf.fsf@alter.siamese.dyndns.org>
References: <4B70913F.7060809@winehq.org>
 <20100209004514.GB4065@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremy White <jwhite@winehq.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeeRv-0005tN-Cv
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab0BIA7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 19:59:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0BIA7W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 19:59:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A77F98335;
	Mon,  8 Feb 2010 19:59:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JnEdZ4s6dl49
	Xwd7hNmrw+HQi5U=; b=KQtSecm9CpTMp0psyjV382OagzHntKCxLXKRwWAj9LK+
	U4uePzozt76yG5f2dG3M9hg8sPUGkFOXzbqxaCinLc8Hjxu++YracLMOBjDczswg
	XPLSSKl1w6wRLPLT7F+nO24DEK1VWGI0Ypq8aIEL4TXoRDAy6Uxe7EAs6MTXAPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pV0YTn
	B0v+RTn1VZjN/wbtjqcAm345AHcQD7RbEU8aLBkmHfW7HBvsquaFAc92UkyrtVAB
	stE/Kw4KWOPxL0Wv2vaR+TF7z/H8o8UtZaro3L93hjWCqcHd3Lgw6pi8BL4QOdx8
	iHSRnKVJEmnxm9l/syS8gJwGy22eG05/NuEd4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38A9998334;
	Mon,  8 Feb 2010 19:59:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67DA298333; Mon,  8 Feb
 2010 19:59:14 -0500 (EST)
In-Reply-To: <20100209004514.GB4065@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 8 Feb 2010 19\:45\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59A6A62A-1516-11DF-A46E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139346>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 08, 2010 at 04:33:35PM -0600, Jeremy White wrote:
>
>> diff --git a/imap-send.c b/imap-send.c
>> index 51f371b..885da22 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -1360,6 +1360,7 @@ static int git_imap_config(const char *key, co=
nst char *val, void *cb)
>>  		server.ssl_verify =3D git_config_bool(key, val);
>>  	else if (!strcmp("preformattedHTML", key))
>>  		server.use_html =3D git_config_bool(key, val);
>> +        else imap_info("Unknown imap configuration option '%s'\n", =
key);
>>  	return 0;
>>  }
>
> Slight NAK from me on this. When we later add new options, it makes
> using the same config for multiple versions of git difficult (the old
> versions will complain about the unknown option).
>
> And obviously that is weighed against the ability to notice things li=
ke
> typos. But if we are going to start complaining about unknown config,=
 we
> would probably do better to complain about _all_ unknown config, and =
not
> just this one subsection.

We would probably want something like:

	static int do_warn_unknown_config;

	void warn_unknown_config(const char *key)
        {
		if (do_warn_unknown_config)
                	warn("Unknown configuration variable %s", key);
        }

and sprinkle that everywhere.

An interesting issue is where to flip do_warn_unknown_config.  A na=C3=AF=
ve
and obvious implementation would do:

        static int git_default_core_config(const char *var, const char =
*value)
        {
		...
		if (!strcmp(var, "core.warnunknownconfig")) {
			do_warn_unknown_config =3D git_config_bool(var, value);
			return 0;
		}
		...
	}

but that means the definition of this variable has to come very early i=
n
the configuration file to be effective.
