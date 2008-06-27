From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] stash: introduce 'stash save --keep-index' option
Date: Fri, 27 Jun 2008 11:26:11 -0700
Message-ID: <7vlk0qrayk.fsf@gitster.siamese.dyndns.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
 <20080627071014.GA12344@atjola.homenet> <20080627143715.GD6747@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Robert Anderson <rwa000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:27:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCIfV-0001KW-UZ
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762953AbYF0S02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762918AbYF0S02
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:26:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759687AbYF0S00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2008 14:26:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C303AA0B;
	Fri, 27 Jun 2008 14:26:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 404EDAA04; Fri, 27 Jun 2008 14:26:19 -0400 (EDT)
In-Reply-To: <20080627143715.GD6747@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Fri, 27 Jun 2008 16:37:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C39288C-4476-11DD-9093-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86620>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> 'git stash save' saves local modifications to a new stash, and runs '=
git
> reset --hard' to revert them to a clean index and work tree.  When th=
e
> '--keep-index' option is specified, after that 'git reset --hard' the
> previous contents of the index is restored and the work tree is updat=
ed
> to match the index.  This option is useful if the user wants to commi=
t
> only parts of his local modifications, but wants to test those parts
> before committing.

Please do not describe how it does, before what it does and what it is
good for.  Here is an example:

	When preparing for a partial commit (iow, committing only part of
	the changes you made in your work tree), you would use various
	forms of "git add" to prepare the index to a shape you think is
	appropriate for committing, and finally run "git commit".

	This workflow however has a flaw in that you are committing
	something that you could never have tested as a whole (and without
	any other modification) in your work tree.

	With the new "--keep-index" option, "git stash" takes a snapshot
	of your index and the work tree state, and updates the work tree
	to match your index, i.e. what you are about to commit.  This way,
	you can commit with confidence, knowing that you are committing
	what you saw (and hopefully tested) as a whole in your work tree.

	After making that initial commit, "git stash pop" will bring the
	work tree state back without touching the index, so you can start
	the next cycle of "git add" to prepare the second batch.

I do not know if your --keep-index implementation would actually allow =
the
above workflow; I haven't read the patch.
