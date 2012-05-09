From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/19] completion: use $__git_dir instead of $(__gitdir)
Date: Wed, 09 May 2012 13:56:02 -0700
Message-ID: <7vmx5hqdjx.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-9-git-send-email-szeder@ira.uka.de>
 <7vaa1hrvh6.fsf@alter.siamese.dyndns.org> <20120509202220.GB7824@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 22:56:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDvl-0000u6-3H
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354Ab2EIU4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 16:56:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932347Ab2EIU4L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 16:56:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D38B16A62;
	Wed,  9 May 2012 16:56:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fo4WacicB1jX
	YXHMiWfGSWleMXw=; b=n5EBMD0EBryHSPtIR1J30ZK7dLqW/KMdwAWMii5QetXJ
	chyW0yqrGNqmH089FhiOVwuVXrT4A6aVTppD5V3UgxpjsguaIhkWJihQuL3INpXN
	q2/m2tEII9cB+v2gWm2WfuROPNCWCkwLtgUNt7uaALWaJureVC4rsVmuoJB/jCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u5ukml
	1EWxWNAOJ99okObLAxZfAJMHiKlELhP0PMal/rATC4jXgke1EVyIP4qE9pKeaMld
	ga57a7597g9naxma3zXC8AaSXqSWUg+SfXpCj9TA6SD6YZYqo6sjhNbMWxwbvtcS
	+G5I5qN4PCK4quvXw7lR7ICg8j+a4T8+HuHfk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A38616A60;
	Wed,  9 May 2012 16:56:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A52536A5A; Wed,  9 May 2012
 16:56:03 -0400 (EDT)
In-Reply-To: <20120509202220.GB7824@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Wed, 9 May 2012 22:22:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63E532FC-9A19-11E1-BB85-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197512>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> > @@ -962,7 +967,8 @@ __git_aliases ()
>> >  # __git_aliased_command requires 1 argument
>> >  __git_aliased_command ()
>> >  {
>> > -	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
>> > +	__gitdir >/dev/null
>> > +	local word cmdline=3D$(git --git-dir=3D"$__git_dir" \
>> >  		config --get "alias.$1")
>> >  	for word in $cmdline; do
>> >  		case "$word" in
>>=20
>> Now this worries me.  The way I read 07/19 was that the local __git_=
dir=3D""
>> declarations in __git_ps1 and __git were what protected this whole
>> machinery to protect us against surprises from user doing "cd" betwe=
en
>> interactive commands, but you have the same __gitdir call to set up =
the
>> global $__git_dir variable there, without the initialization to "".
>>=20
>> Having to have a call to __gitdir seems to indicate to me that you c=
annot
>> assume that the other initialization sites may not have been called =
before
>> we get to this point.  Then why is 'local __git_dir=3D""' unneeded h=
ere?
>
> Your comments to the previous patch apply here.

Not really.  __git_ps1 and __gitk seems to do __gitdir very early to ma=
ke
sure anybody that use $__git_dir can rely on it, but having to sprinkle
"set up $__git_dir variable" everywhere means anybody who wants to upda=
te
need to know if it is already called, which defeats the point of "we ca=
n
use $__git_dir instead of calling $(__gitdir)" from maintainability's
point of view.
