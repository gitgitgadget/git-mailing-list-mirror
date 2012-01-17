From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit changes to remote repository
Date: Mon, 16 Jan 2012 16:12:30 -0800
Message-ID: <7vpqejtcep.fsf@alter.siamese.dyndns.org>
References: <1326486589088-7185551.post@n2.nabble.com>
 <20120114113141.GG2850@centaur.lab.cmartin.tk>
 <vpqboq6fjfy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	ruperty <rupert@moonsit.co.uk>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 17 01:12:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmwfG-00076q-Dg
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 01:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067Ab2AQAMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 19:12:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab2AQAMd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 19:12:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2911F5C13;
	Mon, 16 Jan 2012 19:12:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6NqiaUnzMkHq
	8Lh+N0SqFcq3IY8=; b=j4bQ2ODwIiILifJD79IuS+/MGXTSrOTZXh0JQ7TDXzl5
	mLxUb8b6TdKrep8atazh3EvuUzpx8HybYugKB7wNLLpLj4Y0Dv+BwjFaYLyQkyrj
	pCsgewaSTa0xxErdCxzuMmZPPEeQJzqgCJz1adcrUHwBlBlZ+XreO19RMgLfe8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q6Gv85
	2TBiSZp6ogGXGdPltfNOM7HjwdZpLNwvZ9xYB58vXFCTA/k5SxZ1MZ/ocy9m+Jug
	M97Ow1PFjKpUPJbc3ERLsya4Pq7tyhX1bci5Tfs8s865vapMe5uCtey/uzzT+scb
	/Kjczq/OjGugz0AEr+9ssNr8eb89jFtG+h+r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A6B45C12;
	Mon, 16 Jan 2012 19:12:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 944DA5C11; Mon, 16 Jan 2012
 19:12:31 -0500 (EST)
In-Reply-To: <vpqboq6fjfy.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat, 14 Jan 2012 15:27:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2DA2612-409F-11E1-A280-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188678>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>> You're trying to push to a non-bare repository and change the
>> currently active branch, which can cause problems, so git isn't
>> letting you. There's an explanation of bare and non-bare at
>> http://bare-vs-nonbare.gitrecipes.de/ but the short and sweet is tha=
t
>> you should init the repo you want to use as the central point with
>> --bare and do modifications locally and then push there.
>
> An alternative is to push to a temporary, non-checked-out branch.

Or more generally, treat such a push as if you are pulling in the oppos=
ite
direction. So in this example,

> I sometimes do
>
>   laptop$ git push desktop HEAD:incomming
>
> and then
>
>   desktop$ git merge incomming

you pretend as if you are running "git pull" on your desktop in order t=
o
integrate the work done on your laptop. If you did

    desktop$ git pull laptop

you would store where the branches on the laptop are in the remote
tracking branches for "laptop" remote in your desktop's repository.

So a good way to simulate that would be:

    laptop$ git push desktop master:refs/remotes/laptop/master

and then run:

    desktop$ git merge laptop/master

> The push does not disturb the worktree on the desktop, and the merge =
is
> done manually on the receiving machine.
