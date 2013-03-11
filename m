From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A bug or unhandled case
Date: Mon, 11 Mar 2013 09:29:33 -0700
Message-ID: <7vvc8xaoia.fsf@alter.siamese.dyndns.org>
References: <CABB6UqEfx=ssbiD1+2HA3AtmSrFeJeg5fmU3z1SKukNsKvd4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Janiszewski <janisozaur@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 17:30:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5bv-0006Zs-CQ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310Ab3CKQ3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Mar 2013 12:29:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306Ab3CKQ3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 12:29:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19BCDA34C;
	Mon, 11 Mar 2013 12:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OpGaAigF32MT
	9giGlcqKEGzdV3I=; b=Co8GxUVIDAdT3VJWGq5XX+eeo+5dzfErRibwS1NmkKs6
	PzuA+53q7drmFR3j5uJQfziQyNJRXrt29d9qT4J2SafBmPOalzILzHrFbHIV0JML
	2NEk0JT+6ybCA3OVx6QU1Jpnhu1D01qe58C+M4rF34uMROsfR4DXgz4hfSjNLxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EDUvuL
	DQyzAUKaeQiZRUQdYLUVkkOOWP93d9QKujO1GeTvw5/WFgrNtV+xP95AFOhgc4hf
	xmhHWkNCNzNiy5dyrBWIyaJxCHi+Qr6gsn5Z82gzftXw6whRf5XZZi+ecZa43ScI
	npUWeSVP48gBIlyEgXkPembmvY3Ia2LChTwrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3D6FA34A;
	Mon, 11 Mar 2013 12:29:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71C2FA345; Mon, 11 Mar 2013
 12:29:35 -0400 (EDT)
In-Reply-To: <CABB6UqEfx=ssbiD1+2HA3AtmSrFeJeg5fmU3z1SKukNsKvd4qw@mail.gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Janiszewski"'s message of "Mon, 11 Mar 2013
 17:06:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC7A28E0-8A68-11E2-B5A6-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217885>

Micha=C5=82 Janiszewski <janisozaur@gmail.com> writes:

> Hi,
> I think I've found a bug in git or at least a use case that is not ha=
ndled.
> In few words it can be described like this: if you push a remote
> branch to another remote, which is bare repository, you cannot remove
> that branch from said bare repository.
> Here is a recipe how to reproduce that with git 1.8.0:
> git init foo
> git init --bare bar.git
> git init --bare baz.git
> cd foo
> echo test > file
> git commit -am "initial commit"

Nothing added, nothing committed, at this point.
I'd assume there is "git add file" before this commit.

> git remote add bar ../bar.git
> git remote add baz ../baz.git
> git push bar master
> cd ..
> git clone bar.git bax
> cd bax
> git checkout -b "test_branch"
> echo evil > file
> git commit -am "evil commit"
> git push origin test-branch

error: src refspec test-branch does not match any.
error: failed to push some refs to '...../bar.git'

I'd assume that is test_branch

> cd ../foo
> git fetch bar
> git push baz bar/test_branch
> cd ../baz.git
>
> ###
> # on that point in baz.git there is only one branch:

Correct.

> # remotes/bar/test_branch 8b96ffe evil commit
> # trying to remove that branch yields no results:
> $ git branch -D refs/remotes/bar/test_branch

That is not the way to remove the remote tracking branch test_branch
you have from remote bar, is it?

	git branch -r -D bar/test_branch
