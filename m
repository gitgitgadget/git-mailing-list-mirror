From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git format-patch doesn't exclude merged hunks
Date: Wed, 16 May 2012 12:12:27 -0700
Message-ID: <7v8vgsc544.fsf@alter.siamese.dyndns.org>
References: <4FB3CAE3.6040608@draigBrady.com>
 <7vhavgc660.fsf@alter.siamese.dyndns.org> <4FB3FA59.1010707@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
X-From: git-owner@vger.kernel.org Wed May 16 21:12:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUjeJ-0007Ii-0d
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 21:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760269Ab2EPTMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 15:12:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758644Ab2EPTMc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 15:12:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711C08595;
	Wed, 16 May 2012 15:12:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ww2RSu7oFysG
	UZEKxgNyElSqztQ=; b=ljFaR5Jpc0fkINd1376VrTdKWXQ/tny+dQ42rxJNN0GU
	8xs1YyJhXh35N5X+gQkeB9UsEx7YeuXH8X6fWG3MKGA9/iQGTt2FeE4DtOH7yYFx
	66tcbMCgLYJRtOm0Gw2Macj6z01bJqmGHybLLoKMyDs4bp9HZSfDkJfiIDuqfbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r47Ueb
	6jI0Hy1Keog08efVspGi69J/IMNPe7JA18hMNzjO0TNcilQliQo6PmwcJsQXS05J
	YkL0EsvPdyR/i1puij9yLRVASfOvDLmuN30xVh+FzBDU+F15Fk6fyGwyY7reg74z
	gdz84WCSh8DH9d8AiXI3xD4A5bdR9VybrikxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6627F8593;
	Wed, 16 May 2012 15:12:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A03668592; Wed, 16 May 2012
 15:12:28 -0400 (EDT)
In-Reply-To: <4FB3FA59.1010707@draigBrady.com> (=?utf-8?Q?=22P=C3=A1draig?=
 Brady"'s message of "Wed, 16 May 2012 20:04:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 143D6806-9F8B-11E1-AE96-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197894>

P=C3=A1draig Brady <P@draigBrady.com> writes:

> On 05/16/2012 07:49 PM, Junio C Hamano wrote:
>=20
>> I am not fundamentally opposed to the idea of (optionally) detecting=
 and
>> selectively dropping parts of a patch to an entire file or even hunk=
s that
>> have already applied, but it needs to have a way remind the user som=
ewhere
>> in the workflow that it did so and the log message may no longer des=
cribe
>> what the change does.  Most likely it would have to be done when pro=
ducing
>> format-patch output, but an approach to make it a responsibility to =
notice
>> and fix the resulting log message to the person who applies the outp=
ut, I
>> would imagine.
>
> Yep agreed, it would have to be optional.
> Maybe --ignore-duplicate-changes ?
>
> Appending a marker to the commit message of the adjusted patch would =
make sense,
> similar to how a 'Conflicts:' list is auto generated for commit messa=
ges.

These existing "conflicts:" are offered when recording manual resolutio=
ns
of a conflicting merge, and the user is actively thrown into an editor
when running "git commit" to record the result.

A patch that is reduced in a way you propose will apply to the receivin=
g
tree cleanly without stopping, and does not offer an editor session to
adjust the log before making a commit.  "The user has a chance to notic=
e
and correct" is not sufficient---nobody will spend extra effort to noti=
ce
let alone correct.  The reminder has to be a lot stronger than that, I
think, to cause the patch application to "fail" and require the user to
actively look at the situation.
