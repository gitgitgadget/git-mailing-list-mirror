From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Mon, 14 May 2012 11:13:01 -0700
Message-ID: <7vmx5ahbrm.fsf@alter.siamese.dyndns.org>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
 <7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
 <CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 20:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STzlh-0003mr-Fu
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 20:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab2ENSNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 14:13:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932066Ab2ENSNG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 14:13:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D684B898E;
	Mon, 14 May 2012 14:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1qQELF2nU5O4
	OAQl1jqCrxaYwFQ=; b=UGQdWhiY4lRnT1U3s6c5sojLHc9M5UOw/GEVUvuY8qYm
	rP0U6RSLhWzvO44dw5Cv8FAoyFKHfBou55PPOzupGQ/Ogt68TtPyYpx4D2qnbB86
	XYmHXnbV2CMOrG1x4CM+OJe/sV4Un5SF6myuR1vc+yUy9WfmAHCKaIiBPzcwk4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dQczBb
	y819m809yvJmYjOJh06S2fBB7LnujswlGQtknnsmthLQA3VW+Yp0OJlmkFBTpNm6
	VUqXzKoQETxMpxxHQt5x963wKbsLTcFu/UzEgbphsCdOSYpAn10QBrUX7k9vwKsT
	bPj3DyF0tWUUEern51rg+yhjgJSWVkkpuOork=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE613898D;
	Mon, 14 May 2012 14:13:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F70C898C; Mon, 14 May 2012
 14:13:04 -0400 (EDT)
In-Reply-To: <CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 14 May 2012 19:55:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72D4680C-9DF0-11E1-8A8D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197795>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

>>> +__git_func_wrap ()
>>> +{
>>> + =C2=A0 =C2=A0 if [[ -n ${ZSH_VERSION-} ]]; then
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emulate -L bash
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setopt KSH_TYPESET
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug =
that leaves 'words' as a special
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # variable in versions =
< 4.3.12
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h words
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug =
that quotes spaces in the COMPREPLY
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # array if IFS doesn't =
contain spaces.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h IFS
>>> + =C2=A0 =C2=A0 fi
>>> + =C2=A0 =C2=A0 local cur words cword prev
>>> + =C2=A0 =C2=A0 _get_comp_words_by_ref -n =3D: cur words cword prev
>>> + =C2=A0 =C2=A0 $1
>>> +}
>>> +
>>> +# Setup completion for certain functions defined above by setting =
common
>>> +# variables and workarounds.
>>> +# This is NOT a public function; use at your own risk.
>>> +__git_complete ()
>>> +{
>>> + =C2=A0 =C2=A0 local wrapper=3D"__git_wrap${2}"
>>> + =C2=A0 =C2=A0 eval "$wrapper () { __git_func_wrap $2 ; }"
>>> + =C2=A0 =C2=A0 complete -o bashdefault -o default -o nospace -F $w=
rapper $1 2>/dev/null \
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o default =
-o nospace -F $wrapper $1
>>> +}
>>> +
>>> +__git_complete git _git
>>> +__git_complete gitk _gitk
>>
>> It makes my stomach queasy whenever I see $var not in double quotes =
that
>> forces me to guess (and trace to verify if the codepath is what I re=
ally
>> care about) if any value with $IFS in it could be used there, so eve=
n when
>> they are known to be safe, I'd prefer to see either explicit quotes =
or
>> comment that says what are expected in $1 and $2.
>
> Which ones?

All of them ;-)

Here is my attempt to explain why none of them needs to be quoted:

 # Setup completion for certain functions defined above by setting comm=
on
 # variables and workarounds.
 # It takes two parameters:
 #  - the first is the command name on the command line to complete its
 #    arguments for the user;
 #  - the second is a name of the completion function
 # This is NOT a public function; use at your own risk.
 #
 # Note that none of the variable reference in the implementation of th=
is
 # function needs dq around it.
 #
 # wrapper: the name of an internal shell function that wraps the
 #          completion function $2, formed by prefixing "__git_wrap"
 #          in front of it.  As it has to be usable as a name of a
 #          shell function, by definition there won't be $IFS character=
s
 #          in it.
 # $1:      the command name on the command line---ditto.
 # $2:      the shell function name that implements the completion-ditt=
o.

Once there is such an explanation, the answer to the next question woul=
d
become...

>>> + =C2=A0 =C2=A0 $1
>>> + =C2=A0 =C2=A0 complete -o bashdefault -o default -o nospace -F $w=
rapper $1 2>/dev/null \
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o default =
-o nospace -F $wrapper $1
>
> So you want:
>
>   "$1"

=2E.. Not really.
