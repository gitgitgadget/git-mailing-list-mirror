From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_sha1: support relative path ":path" syntax
Date: Mon, 15 Nov 2010 09:29:42 -0800
Message-ID: <7v4obimr5l.fsf@alter.siamese.dyndns.org>
References: <AANLkTimJKQ=xc7az+FEM+18aTxQ5zQ24q7pfChnSwt6f@mail.gmail.com>
 <1289793369-10653-1-git-send-email-pclouds@gmail.com>
 <AANLkTi=aVyOiRkE-+y8DDwcBQK36bVFrAX5PFw3TjCey@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, tfransosi@gmail.com,
	Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 18:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI2sa-0000SU-Ms
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 18:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010Ab0KORaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 12:30:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932985Ab0KOR37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 12:29:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B321839C5;
	Mon, 15 Nov 2010 12:30:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zB8duQtdcxUY
	hC5XAEz076WWSv8=; b=DdXu17ApNuzDr547O0OoJKMB2hWWOYd9VEkVDmEcF7XA
	UCBrdaaTPudR/B5jav66yIvlPrUdKfr7uWlPkzpz671SOIE6vycDMK8hyEz+2W7M
	P9pumg6TyN0Lvo7MR56ZUtNClbotwJn5Pi5sZjUUM9NGY4RoqUgV/eAYGQB2zPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XNIIXc
	MJ2VioAGv+D5j0tCf1m3E9IqlolX3Qozyvy2j7fIP878LqhR0LAxSMw9EsnKnpM6
	x5p2qT5ZnvcLtGnEXH7usVzjLyDyr06Mnxy2bn7jPWmnfthXpLK5hfVlelksEXRi
	coMLCkBHTFa9890RHRM+cqMBLM8OHZOWnxZEQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55B0939BE;
	Mon, 15 Nov 2010 12:30:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9064F39BA; Mon, 15 Nov 2010
 12:29:52 -0500 (EST)
In-Reply-To: <AANLkTi=aVyOiRkE-+y8DDwcBQK36bVFrAX5PFw3TjCey@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 15 Nov 2010 15\:56\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F929E420-F0DD-11DF-93E2-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161496>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> 2010/11/15 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
>> +               die("Relative path syntax is not supported in this c=
ommand.\n"
>> +                   "Please report to git@vger.kernel.org.");
>
> Might it save us a lot of debugging hassle later if we report what
> "this command" is? E.g., if the user is using some internal tool that
> happens to dispatch to a command that doesn't support this, it could
> help us to know what command is being used?

In the absence of programming errors, should all git command support
<tree>:./<path> syntax to name an object, or are there cases where the
relative does not make any sense?

What I am trying to get at is that if this is diagnosing a user error, =
or
if this is showing that the mechanism to implement the relative path is
unnecessarily hard for the programmers to misuse.

=46or example, if "git show HEAD:./Makefile" in a bare repository is a =
user
error, it is not "not supported in this command" but "not supported in
this situation (more specifically, in a bare repository)", so the first
line is wrong, and more importantly, if that is a user error, there is
nothing to report to the list.

If on the other hand, a command that ought to allow use of relative pat=
h
didn't set up necessary startup_info, this is diagnosing a programming
error.  But if that is the case, shouldn't we be able to do much better=
 to
avoid such mistakes in the first place than triggering a BUG() here whe=
n
the user happens to try using this particular feature?  In other words,
even when this "feature" isn't used in a particular invocation of a
command, a command that is capable of supporting the feature should alw=
ays
be setting up startup_info, perhaps by the time its cmd_foo() is called=
,
no?  Shouldn't we be putting a BUG() somewhere higher and more visible =
in
the callchain to help catching such bugs?
