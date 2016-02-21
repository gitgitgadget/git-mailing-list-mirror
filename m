From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Sat, 20 Feb 2016 23:36:05 -0800
Message-ID: <xmqqbn7aa522.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
	<1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
	<xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
	<87fuwnd4u7.fsf@freja.aidecoe.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:32:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXsB-0004Cc-WD
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbcBURck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 12:32:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751917AbcBURcj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 12:32:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3B4E3BCAA;
	Sun, 21 Feb 2016 02:36:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R4QAl9jDyc8j
	At8wu1Z0Xjhudvs=; b=xbbKmJIIFT8A/rIU74SgHh62Dn2XTLjLe0rwvsSjz3UO
	pPecObY/AJpT52gniZ634CTn3iiQfYIDSW1LhFXJKVeKz+JQFmy0gcblAPnuHOsw
	vX/P0F1D/T0ADMMs9thH5LIMFj6OqQ5y6h0KVR1Gxq9D3P7ytHpE9Oui8b11qrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Jg5Ymx
	bQrFw5um/YFYrFm7SWEFq1IcLmyAETOtPRPgQagc10AbwV7G8yHd0gaFTzbV+i98
	1SuILwJoAqvRWdWAnbZ7G5gQlYg757aYSKIHtt1ky84fVGD5afy0bTwnnDDK3nnh
	VMfwyxvUPHGZ7GqukGeCYMMcxIG5HXs5qtSJM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA9DE3BCA9;
	Sun, 21 Feb 2016 02:36:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 36B7B3BCA7;
	Sun, 21 Feb 2016 02:36:07 -0500 (EST)
In-Reply-To: <87fuwnd4u7.fsf@freja.aidecoe.name> ("Amadeusz =?utf-8?B?xbtv?=
 =?utf-8?B?xYJub3dza2kiJ3M=?=
	message of "Sat, 20 Feb 2016 11:00:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4F9F05A-D86D-11E5-AE9C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286803>

Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name> writes:

> To submit changes from master branch to Perforce, new commits should =
be
> based on a remote branch p4/master:
>
> (1)
>                   E'---F' master
>                  /
>     A---B---C---D p4/master
>
> Commits from A to D map to Perforce changelists. These commits includ=
e
> additional metadata in commit message which most important is changel=
ist
> number.
>
> On submit git-p4 prepares changelists for commits E'-F' and submits
> these to Perforce repository. After this operation it syncs back remo=
te
> branch p4/master. This is the common part for both bare and non-bare
> repository.
>
> (2)
>                   E'---F' master
>                  /
>     A---B---C---D---E---F p4/master
>
> In non-bare repository git rebase is performed and it results in
> following state:
>
> (3)
>     A---B---C---D---E---F p4/master, master

That is because you would want your further work to be built on top
of F, not F'.

> In bare repository this operation cannot be performed, so it remains =
in
> state (2).

And that is what made me wonder.

> With special care state (2) can be transformed to state (3) with manu=
al
> update of refs/heads/master with refs/remotes/p4/master.

What do you mean by transforming with special care?  Do you mean runnin=
g

    $ git update-ref master remotes/p4/master

or does it involve something else?  Is it a fairly involved
procedure, I wonder if it makes sense to just silently allowing
submit without rebasing, and without telling the user how to clean
it up.

And if it is really is the matter of update-ref, wouldn't that
procedure apply equally well to a submit made from a non-bare
repository?

> I understand that implementing rebase for bare repository is unsafe a=
nd
> it wouldn't be appreciated. Therefore we have to resort to such a
> barbarity and git-p4 submit shouldn't attempt to perform a rebase
> operation itself. Especially because it performs other operations bef=
ore
> and we end up in the intermediate state (2) anyway.
>
> Is this explanation satisfactory?

Not quite yet.  It is better than no explanation, but it does not
quite convince me (a non-git-p4 user) that it makes sense to allow
submitting in a bare repository in the first place.

This is not an informed objection; I want to first understand why
doing this is safe and does not hurt the end users.
