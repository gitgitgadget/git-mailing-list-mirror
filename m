From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Tue, 01 Nov 2011 11:12:49 -0700
Message-ID: <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 19:12:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLIpW-0008QR-Ii
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 19:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339Ab1KASMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 14:12:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555Ab1KASMw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2011 14:12:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D03B76868;
	Tue,  1 Nov 2011 14:12:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xz2ryiC0Z/iz
	UJcMk6zPtYhwO0w=; b=eoeaetCe+A9+qm2YU7Mt98MlSwaUNMllNaEGty/8O8vI
	8vwFR3JWRXs2DIAQA5pm8O3S4eNH9lMwdmk+31G9DQ6RNzYB0uoGzzGOJY17y4sm
	JnOhNmGuLl6AavCeTHMDJUvlBKxZOKkNnhYbR1uMkf439/De14RV3CRlm9PNlSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eTeNVi
	LGxNLC0UfYSbPGQFEJDrMWa5p3f86tokbNnREazen8R0wMkMUCyFZXpIJ9nS2WxT
	VW9t/TUgTZAwUHXHxi1Lx0ZiQpweT3O6JjQnvb/gJy1c2K1i8ty2deTRdgqpbH7y
	VsdPc93zxKQNwUIhskrlnBPZmm/FXCdhZ4xq0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C821F6867;
	Tue,  1 Nov 2011 14:12:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D6266866; Tue,  1 Nov 2011
 14:12:51 -0400 (EDT)
In-Reply-To: <4EAFC18A.1070502@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message of "Tue, 01 Nov 2011 10:53:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C9A11FA-04B5-11E1-97A1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184577>

[administrivia: dropped the kernel mailing list from and added Peff to =
Cc]

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

>>>  * HTTP transport did not use pushurl correctly, and also did not t=
ell
>>>    what host it is trying to authenticate with when asking for
>>>    credentials.
>>>    (merge deba493 jk/http-auth later to maint).
>>=20
>> This seems to break pushing with https for me.
>> It never uses values from my '~/.netrc'.
>> I'll come up with a detailed scenario later.
>
> Update:
>
> git push prompts for the password but just pressing return succeeds.
>
> Weird...

There are only handful of commits that even remotely touch http related
codepath between v1.7.7 and v1.7.8-rc0:

  * deba493 http_init: accept separate URL parameter

  This could change the URL string given to http_auth_init().

  * 070b4dd http: use hostname in credential description

  This only changes the prompt string; as far as I understand it, the
  condition the password is prompted in the callsites of git_getpass()
  has not changed.

  * 6cdf022 remote-curl: Fix warning after HTTP failure
  * be22d92 http: avoid empty error messages for some curl errors
  * 8abc508 http: remove extra newline in error message
  * 8d677ed http: retry authentication failures for all http requests
  * 28d0c10 remote-curl: don't retry auth failures with dumb protocol

  These shouldn't affect anything wrt prompting, unless you are somehow
  internally reauthenticating.

Could you try reverting deba493 and retest, and then if the behaviour i=
s
the same "need ENTER", further revert 070b4dd and retest?
