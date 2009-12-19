From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: abort cleanly if the editor fails to launch
Date: Sat, 19 Dec 2009 12:44:27 -0800
Message-ID: <7v8wcy7kyc.fsf@alter.siamese.dyndns.org>
References: <4B2CC133.9010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 21:44:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM6AL-0003VD-Nt
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 21:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbZLSUoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Dec 2009 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbZLSUoh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 15:44:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbZLSUog convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Dec 2009 15:44:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 48DAE8995D;
	Sat, 19 Dec 2009 15:44:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U7pVfZeHGRZ0
	rUy3TAjpfmvSPXM=; b=VJkch8pc6WXL3qjO7PCSgW+CrN1YlGGXnpRsykytviZU
	1Kva09GQTZU+9pzsAs1o6+h81l9rzNfedf9d+tbi4RKTTgK3Tcw1crU51GjNHtsP
	cXPlgXh14/uedToeYwabhiqUpD4iNsT32Uf398Mc0TZg3YbQM/E+HSVuVsheHj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xFiMFo
	x684gH8ZG9HvWBF9e60tsjS9IjUCVv6/UoxTS04kmjL2bLHslbNLLMPNhK8EDres
	5UbDkL5bfe0DaLebFSucPEl5xm9IqJ3MP/CGjg6iLLgA6RT1MBcWqupOZp+90Tjf
	Vigsw7lr7lP6TE3CXSbCFn8SOatHRN7vUPQnA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26FB48995C;
	Sat, 19 Dec 2009 15:44:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71A708995B; Sat, 19 Dec
 2009 15:44:29 -0500 (EST)
In-Reply-To: <4B2CC133.9010704@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Sat\, 19 Dec 2009 13\:04\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F60C542-ECDF-11DE-9208-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135500>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> If the user's configured editor is emacsclient, the editor
> will fail to launch if emacs is not running and the git
> command that tried to lanuch the editor will abort. For most
> commands, all you have to do is to start emacs and repeat
> the command.
>
> The "git rebase -i" command, however, aborts without cleaning
> the "$GIT_DIR/rebase-merge" directory if it fails to launch the
> editor, so you'll need to do "git rebase --abort" before
> repeating the rebase command.
>
> Change "git rebase -i" to terminate using "die_abort" (instead of
> with "die") if the initial launch of the editor fails.
>
> Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>

Two questions:

 - Is emacsclient the _only_ editor that can exit with non-zero status =
to
   signal an error condition "the user invoked me to edit an existing
   file, but I ended up not letting the user edit it"?

 - Are there editors that let you exit with non-zero status on demand?

The above is not a complaint to your log message, but is a genuine requ=
est
for information.

An editor that can exit with non-zero status on demand could use this
codepath to abort the rebase, when a user realizes that the edit s/he h=
as
done so far was completely bogus [*1*].  In such a case, the existing
error message "Could not execute editor" may sound funny.

Regardless of that small issue, I think the patch to clean-up makes sen=
se.

Thanks.


[Footnote]

*1* We interpret a completely empty $TODO as a signal from the user to
abort the sequencer (the literal interpretation of such a $TODO would b=
e
to not pick any commits, which could be a source of potential confusion=
),
so it is not an issue in practice if your editor does not allow you to
exit with non-zero status to signal an exception.  You can remove all
lines and exit the editor normally instead.
