From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/completion: suppress stderror in bash
Date: Tue, 10 Feb 2015 10:31:11 -0800
Message-ID: <xmqqegpxwrdc.fsf@gitster.dls.corp.google.com>
References: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com>
	<xmqqy4o6aj1w.fsf@gitster.dls.corp.google.com>
	<20150210031008.Horde.1WYJ_81O2E96Rgv2xrVmqw1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Korostoff <mkorostoff@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:31:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLFam-000112-VI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 19:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbbBJSbV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2015 13:31:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752881AbbBJSbU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2015 13:31:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E66B737C94;
	Tue, 10 Feb 2015 13:31:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Aqy0Vit84/yR
	Hn4B09rlvBaqkTs=; b=OVZ/g/yrRfTmW6/r6AFbmdlpMpze8IOoR8/8qTGXgnEQ
	ssF3gqJDu6B/XfwsEo739qt1jYP+rTW4vqBtclnmdm01SwTsvsaNSUFHEf/8doGZ
	MAyIJ6YRl7oy9ihnf+nFHWQA3IQizw85v9njzRjwJwprGMg3T84JrF1VWmQ6aCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sx4Z9D
	hluPoGCwJ0WWcPWlEnQMNN2jPjbGhrkbwVHdVigXh9sIelMRU49cSn4K1FADjjSM
	BlaFWcXubdrxdnVfN55FJ5HwZOV9lDLYCNhqim9GIdNY8Hcait6iS2RKY9++NBhz
	1KuIg86oZaZirXeuW5kmwD2fiLfYl/nzS6yl8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C179137C93;
	Tue, 10 Feb 2015 13:31:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1ED2237C92;
	Tue, 10 Feb 2015 13:31:13 -0500 (EST)
In-Reply-To: <20150210031008.Horde.1WYJ_81O2E96Rgv2xrVmqw1@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 10 Feb 2015 03:10:08
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDCBC0CC-B152-11E4-931D-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263638>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>>> @@ -412,7 +412,7 @@ __git_refs_remotes ()
>>>  __git_remotes ()
>>>  {
>>>  	local i IFS=3D$'\n' d=3D"$(__gitdir)"
>>> -	test -d "$d/remotes" && ls -1 "$d/remotes"
>>> +	test -d "$d/remotes" && ls -1 "$d/remotes" 2>/dev/null
>>>  	for i in $(git --git-dir=3D"$d" config --get-regexp
>>> 'remote\..*\.url' 2>/dev/null); do
>>>  		i=3D"${i#remote.}"
>>>  		echo "${i/.url*/}"
>
> Do I smell some bitrotting here?
>
> This function just lists all the defined remotes, first by listing th=
e =20
> directories under refs/remotes to get the "legacy" remotes and then =20
> loops over 'git config's output to get the "modern" ones.  This =20
> predates the arrival of the 'git remote' command in January 2007, so =
=20
> it was really a long time ago.
>
> We should just run 'git remote' instead, shouldn't we?

Perhaps.  Is it sufficient to just make __git_remotes() a thin
wrapper around, i.e.

	__git_remotes ()
	{
		git remotes
	}

or do we need to munge its output further (I didn't look)?
