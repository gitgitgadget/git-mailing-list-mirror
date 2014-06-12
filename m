From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "t0001: test git init when run via an alias"
Date: Thu, 12 Jun 2014 10:11:33 -0700
Message-ID: <xmqqr42u6oje.fsf@gitster.dls.corp.google.com>
References: <20140606110935.GA14446@lanh>
	<1402220230-799-1-git-send-email-pclouds@gmail.com>
	<xmqq4mzsa9ej.fsf@gitster.dls.corp.google.com>
	<CACsJy8Dh9miVOGM0JLWXs6kzzEnum1ggnc2qm0gKaCwX+9iZYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	David Turner <dturner@twopensource.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 19:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8XR-0004vc-5q
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbaFLRLl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2014 13:11:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56900 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017AbaFLRLk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 13:11:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9886A1BA75;
	Thu, 12 Jun 2014 13:11:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U/bQTGOiTGq2
	N19ZPTW/42vPOUE=; b=rdEnktzfyYUx9GZ+Gqo8sHPpiW4Srm+89c69iETwJ3f7
	xrYhZP6udq3Ejoiau5vmo7+Ajp2zFV1Ct+931HDvPsIuo56+5vX3n7368vE/wpIC
	PCbSxW0ngTF/egAMJfQwh97E9G3SioKm4LKUjBNWXOZRnedOb7I0GZtgsf7o2kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s61dl/
	S8sz74SKITVi3yX08SpTDkd+XSFMG7xhx7poaUi5jvbh2+Lsuhgl8JqYt8uZHMFN
	k/VWcbUimFtovzeTa4T/Pdz+sFY02VhLe/Li0HEBlqIsChHRVEoY08yKbNBH3IYk
	VGQ8wlZe5yCF5mpuSCBxrZui7pCeiDZlZlCs8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E8B21BA74;
	Thu, 12 Jun 2014 13:11:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7E7111BA70;
	Thu, 12 Jun 2014 13:11:35 -0400 (EDT)
In-Reply-To: <CACsJy8Dh9miVOGM0JLWXs6kzzEnum1ggnc2qm0gKaCwX+9iZYQ@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 11 Jun 2014 17:57:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9BBD53F4-F254-11E3-B95A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251415>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jun 11, 2014 at 1:48 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Commit 4ad8332 (t0001: test git init when run via an alias -
>>> 2010-11-26) noted breakages when running init via alias. The proble=
m
>>> is for alias to be used, $GIT_DIR must be searched, but 'init' and
>>> 'clone' are not happy with that. So we start a new process like an
>>> external command, with clean environment in this case. Env variable=
s
>>> that are set by command line (e.g. "git --git-dir=3D.. ") are kept.
>>>
>>> This should also fix autocorrecting a command typo to "init" becaus=
e
>>> it's the same problem: aliases are read, then "init" is unhappy wit=
h
>>> $GIT_DIR already set up because of that.
>>>
>>> Reminded-by: David Turner <dturner@twopensource.com>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  git.c           | 52 +++++++++++++++++++++++++++++++++++++++++++++=
+++----
>>
>> This goes far deeper than "Fix t0001", doesn't it?
>
> I followed the way git-revert creates the subject line, thinking that
> this fixes an old commit so do similarly. Probably better rephrase it=
=2E

Yeah, I didn't realize the whole thing was in dq and by that you
meant that you are referring to the commit.

>> That does not sound so bad.  Even though I wonder if that "save and
>> then restore" sequence logically belongs around handle_alias(), you
>> would not have sufficient clue to let you cheat by not restoring the
>> environment for commands that you happen to know that they do not
>> care, so that may be a reasonable optimization.
>
> The save code definitely belongs to handle_alias(). I'm not so
> confident about always restoring at the end of handle_alias().

Oh, I am not saying we should restore unconditionally.  I was just
reading your patch that does not have the restore at the end of
handle_alias and trying to rationalize it myself---that code does
not know (yet) if the command to be run wants to get the environment
restored.

> The
> restore procedure is just enough not to propagate wrong info to the
> child process. For that purpose, guarding cwd and environm are enough=
=2E
> If after we return from handle_alias() and we run the builtin command
> anyway, that' may not be clean enough (e.g. static variables may be
> already initialized..)

Very true.  The "contamination" by the discovery process has got
bad enough over time.

>> Is it too brittle a solution to force people to mark problematic
>> subcommands with NO_SETUP, though?  What kind of change to a
>> subcommand that currently does not have to be marked with NO_SETUP
>> would make it necessary to mark it with NO_SETUP?
>
> If I had a clear answer here, I could have undone the setup effects
> caused by handle_alias() and not resort to spawning a new process :)
> So my answer is mostly trial and error. We have evidence that clone
> and init do not work with contaminated environment. So we fix them an=
d
> wait for new bugs to show up.

OK.
