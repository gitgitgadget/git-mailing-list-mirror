From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression in ref advertisement
Date: Mon, 25 Feb 2013 12:07:14 -0800
Message-ID: <7v1uc4ximl.fsf@alter.siamese.dyndns.org>
References: <1361811516.3212.14.camel@centaur.cmartin.tk>
 <7vvc9gxn2y.fsf@alter.siamese.dyndns.org>
 <1361819916.24515.5.camel@centaur.cmartin.tk>
 <7vip5gxkgy.fsf@alter.siamese.dyndns.org>
 <1361822092.30765.12.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA4Kt-0001zH-4l
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 21:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759547Ab3BYUHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 15:07:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505Ab3BYUHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 15:07:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F1E7AA7B;
	Mon, 25 Feb 2013 15:07:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/Kmg+QDDFtzW
	d7bMLM16Urty/rI=; b=mKqqXzfGVqWB+ehT4d5m6IekdglxhbSmYMSqyWBuQvCb
	O0cohHHy6tNOLjdIXhKDAJsVSjTDkRmARH/dyV6UkaS0qq7mQ6xv2pErNrvjJhQE
	Lt60QX0vZjjvIkoZvjDHZejAKG0Lvz9k2G6HMFGuR5LwrFAofktkBWHSMixTt3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mwfgIL
	E0+1jq0LxCuqT7Jx32pLQc9r+haJhH4yaHQkmiKEIVIMpRPJ8Je49rLQ49SeCMKg
	T7s41BaESpaTGQL3vFjEWQgWs5pRO8bfhH2eq56ryLMbfZp453GtFHRDAlEE9ePb
	OfCPmoQber0ax2mB6BSwbdxA0j3jVOBcR+6/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5FB0AA7A;
	Mon, 25 Feb 2013 15:07:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C066AA79; Mon, 25 Feb 2013
 15:07:16 -0500 (EST)
In-Reply-To: <1361822092.30765.12.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 25 Feb 2013 20:54:52
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3903728-7F86-11E2-BFEF-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217100>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>> A shot in the dark, as I do not seem to be able to reproduce the iss=
ue
>> with anything that contains the commit.  Perhaps your .git/packed-re=
fs
>> is corrupt?
>
> My packed-refs file did not end with LF. It seems it must or the pars=
er
> won't consider the last tag in the file to have a peeled target and m=
ine
> didn't. I don't how the ended up this way but it looks like there's i=
s a
> bug in the parser (or does the format force you to have LF at the end=
?)

It is unclear what kind of corruption your packed-refs file had, as
there are multiple ways for a file not to "end with LF", but anyway.

As packed-refs file is expected to be a text file, it is not
surprising to get an undefined result if the it ends with an
incomplete line.

I do not offhand recall if we tolerate lines with CRLF endings; as
far as I know we do not _write_ CRLF out, and because we do not
expect people to muck directly with editor bypassing "pack-refs", I
would not be surprised if we didn't do anything special for people
who make the lines end with with CRLF the file, either.

I'd be more worried about the possibly lost entries after that
incomplete line (and also possibly truncated end part of the tagname
on the last, incomplete line).  Perhaps fsck should diagnose such an
anomaly as repository corruption?  Perhaps we should enhance the
file format a bit (right now, the first "capability" line should say
something like "# pack-refs with: peeled" to say it was created with
the version of pack-refs that can record peeled tags, but we can add
other capabilities to extend the format) to add checksums to detect
corruption?
