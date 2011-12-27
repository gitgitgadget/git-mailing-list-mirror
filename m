From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add central method for prompting a user using
 GIT_ASKPASS or SSH_ASKPASS
Date: Tue, 27 Dec 2011 15:35:07 -0800
Message-ID: <7vaa6d4mhg.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ECC0.606@tu-clausthal.de> <7vwr9h68t9.fsf@alter.siamese.dyndns.org>
 <CA+39Oz5J82GVyLfzWbWz20VS=Gp=8q9WsHQY33GuOKT1PyFCbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Wed Dec 28 00:35:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfgY8-00086F-6E
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 00:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab1L0XfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Dec 2011 18:35:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab1L0XfJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2011 18:35:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A40050EF;
	Tue, 27 Dec 2011 18:35:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+NhD/iYVbDZH
	x+MRWuGWza6zFxw=; b=UOST9pWU1JNe+AQ/KQK5x2jzdydxStyYfSNPgy5gCplC
	ymy2CuHl4fENiyNBwsoG0x+98plZ3lbkNkzD8k3emsuuKw2H1VlKUYxQ3UVXMBVb
	JkZuT40JAuVA4GcfpOqAoVN/k+D3rkiI+i5ujPOw8VpZohMxyWTnPvHCYkb5tkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DWLxS/
	vCpKWyBq1E6/CQxzzp26chODDAmOveljiKGfBNosBEWwl7i8yqRUugu+fcTmQYJw
	NZoANwu0j9UZhjoavgGUJRmt+Giu2+zmYoCynh8l/cTKhMfWZyJ5VuHFBYBV8QLg
	zWlVztO4/mg1tvp+a8kMhG+p78lq9FfyqBRFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3052C50EE;
	Tue, 27 Dec 2011 18:35:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A06AD50EB; Tue, 27 Dec 2011
 18:35:08 -0500 (EST)
In-Reply-To: <CA+39Oz5J82GVyLfzWbWz20VS=Gp=8q9WsHQY33GuOKT1PyFCbQ@mail.gmail.com> (Thomas
 Adam's message of "Tue, 27 Dec 2011 23:12:04 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69B03E24-30E3-11E1-95D9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187737>

Thomas Adam <thomas@xteddy.org> writes:

> On 27 December 2011 20:47, Junio C Hamano <gitster@pobox.com> wrote:
>> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
>>> +sub askpass_prompt {
>>> + =C2=A0 =C2=A0 my ($self, $prompt) =3D _maybe_self(@_);
>>> + =C2=A0 =C2=A0 if (exists $ENV{'GIT_ASKPASS'}) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return _askpass_prompt(=
$ENV{'GIT_ASKPASS'}, $prompt);
>>> + =C2=A0 =C2=A0 } elsif (exists $ENV{'SSH_ASKPASS'}) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return _askpass_prompt(=
$ENV{'SSH_ASKPASS'}, $prompt);
>>> + =C2=A0 =C2=A0 } else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return undef;
>>
>> Two problems with this if/elsif/else cascade.
>>
>> =C2=A0- If _askpass_prompt() fails to open the pipe to ENV{'GIT_ASKP=
ASS'}, it
>> =C2=A0 will return 'undef' to us. Don't we want to fall back to SSH_=
ASKPASS in
>> =C2=A0 such a case?
>>
>> =C2=A0- The last "return undef" makes all callers of this method to =
implement a
>> =C2=A0 fall-back way somehow. I find it very likely that they will w=
ant to use
>
> Not only that, "return undef" will have nasty side-effects if this
> subroutine is called in list-context -- it's usually discouraged to
> have explicit returns of "undef", where in scalar context that might
> be OK, but in list context, the caller will see:
>
> (undef)
>
> and not:
>
> ()
>
> i.e., the empty list.

Well, for this particular function whose interface is "I'll give you a
prompt, use it to interact with the user and give me what the user gave=
 us
in response", a scalar caller would do

	my $response =3D askpass_prompt("What is your password?");

while a list context caller would instead do

	my ($response) =3D askpass_prompt("What is your password?");

or

	my @answer =3D askpass_prompt("What is your password?");
        my $response =3D $answer[0];

and all three callers would get "undef" in $response. I suspect returni=
ng
(undef) is a better thing to do, than relying that

        my @answer =3D ();
        my $response =3D $answer[0];

happes to give undef to $response because the access goes beyond the en=
d
of the array, no?
