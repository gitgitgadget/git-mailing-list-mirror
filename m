From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PATCH] Documentation: Tweak use case in "git stash save
 --keep-index"
Date: Mon, 07 Jul 2008 22:39:58 -0700
Message-ID: <7vlk0dvsr5.fsf@gitster.siamese.dyndns.org>
References: <279b37b20807072218o19dabd97y2c4edc62fb980ca4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, szeder@ira.uka.de
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 07:41:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG5wv-00040j-G1
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 07:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbYGHFkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 01:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbYGHFkO
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 01:40:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbYGHFkN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 01:40:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C36D528968;
	Tue,  8 Jul 2008 01:40:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DE20928919; Tue,  8 Jul 2008 01:40:05 -0400 (EDT)
In-Reply-To: <279b37b20807072218o19dabd97y2c4edc62fb980ca4@mail.gmail.com>
 (Eric Raible's message of "Mon, 7 Jul 2008 22:18:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5493636A-4CB0-11DD-B073-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87718>

"Eric Raible" <raible@gmail.com> writes:

> The documentation suggests using "git stash apply" in the
> --keep-index workflow even though doing so will lead to clutter
> in the stash.  And given that the changes are about to be
> committed anyway "git stash pop" is more sensible.

Yeah, I was pondering about this myself.  After popping the remaining
part, you would "git add -p" the next batch, the same "stash save -k-i" to
save the remaining bits away, and continue.  Will queue.

BUT

It is very likely that in this workflow you would sometimes find that what
you staged (and left in the working tree after "save -k-i") is faulty and
you need to tweak it in place to make it into a good enough shape for
committing.  The example probably should talk about what happens.
Editing, testing and committing is fine, but then what?  Will the "pop"
wipe that unplanned change you made after "save -k-i" out? (the answer is
no and this is safe, but the reader of the documentaiton needs it
explained)

Also this may be a good way to split an existing commit into five during a
"rebase -i" session, and the example in the documentation might want to
talk about it in that larger picture.

>  Documentation/git-stash.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index df26901..bf241da 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -201,9 +201,10 @@ $ git add --patch foo
>  $ git stash save --keep-index
>  $ build && run tests
>  $ git commit -m 'First part'
> -$ git stash apply
> +$ git stash pop
> +... repeat above five steps until one commit remains ...
>  $ build && run tests
> -$ git commit -a -m 'Second part'
> +$ git commit foo -m 'Remaining parts'
>  ----------------------------------------------------------------
