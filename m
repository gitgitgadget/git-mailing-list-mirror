From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-merge.sh: better handling of combined
 --squash,--no-ff,--no-commit options
Date: Sun, 02 Mar 2008 15:50:46 -0800
Message-ID: <7vir04n0rt.fsf@gitster.siamese.dyndns.org>
References: <20080302175820.31385.qmail@9e9c5b8314ca7b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 00:51:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVxxy-00082N-91
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 00:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbYCBXvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 18:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbYCBXvA
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 18:51:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYCBXu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 18:50:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 293772D51;
	Sun,  2 Mar 2008 18:50:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7D1322D4E; Sun,  2 Mar 2008 18:50:53 -0500 (EST)
In-Reply-To: <20080302175820.31385.qmail@9e9c5b8314ca7b.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Sun, 2 Mar 2008 17:58:19 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75858>

Gerrit Pape <pape@smarden.org> writes:

> git-merge used to use either the --squash,--no-squash, --no-ff,--ff,
> --no-commit,--commit option, whichever came last in the command line.
> This lead to some un-intuitive behavior, having
>
>  git merge --no-commit --no-ff <branch>
>
> actually commit the merge.  Now git-merge respects --no-commit together
> with --no-ff, as well as other combinations of the options.  However,
> this broke a selftest in t/t7600-merge.sh which expected to have --no-ff
> completely override the --squash option, so that
>
>  git merge --squash --no-ff <branch>
>
> fast-forwards, and makes a merge commit; now it prepares a squash ...

Both make sense when they make sense (i.e. if you and the other side are
not fast-forward nor up-to-date and need a real merge).

> ...  Combining --squash with --no-ff doesn't seem to make sense

Yeah, I think forbidding this combination would make much more sense.  The
former asks there be _no_ merge (the user does not want to have a merge
ever), while the other one asks to create a merge even when there is no
need to (the user does want a merge).

Are there other combinations that we should forbid?

