From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads, refs/remotes and refs/tags
Date: Tue, 24 Feb 2009 09:39:42 +0100
Message-ID: <87fxi4ut2p.fsf@krank.kagedal.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtId-0005UH-8b
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbZBXJId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 04:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752AbZBXJIc
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:08:32 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:36548 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbZBXJI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:08:28 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id D598240009;
	Tue, 24 Feb 2009 09:39:35 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id CB32D4000E; Tue, 24 Feb 2009 09:39:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 9D1B240009;
	Tue, 24 Feb 2009 09:39:35 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id B37E2DC488; Tue, 24 Feb 2009 09:39:42 +0100 (CET)
In-Reply-To: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
 ("David =?utf-8?Q?K=C3=A5gedal=22's?= message of "Tue\, 24 Feb 2009
 09\:32\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111243>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Otherwise it will pick up e.g. lots of irrelevant stuff from
> refs/bisect, refs/stash or refs/patches (for StGit users).
>
> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> ---
>  contrib/emacs/git.el |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index feb229c..125e684 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -1388,7 +1388,10 @@ With a prefix arg, diff the marked files inste=
ad."
>  (defun git-read-commit-name (prompt &optional default)
>    "Ask for a commit name, with completion for local branch, remote b=
ranch and tag."
>    (completing-read prompt
> -                   (list* "HEAD" "ORIG_HEAD" "FETCH_HEAD" (mapcar #'=
car (git-for-each-ref)))
> +                   (list* "HEAD" "ORIG_HEAD" "FETCH_HEAD"

Sorry, I didn't check this properly. I thought I was fixing inside the
git-checkout function, but this is git-read-commit-name which is used
in more than one place.

But for git-checkout, I would like to see a much shorter list of named
commits, namely those that can be called "branches". I'll come up with
a better patch.

> +                          (mapcar #'car (git-for-each-ref "refs/head=
s"
> +                                                          "refs/remo=
tes"
> +                                                          "refs/tags=
")))
>  		   nil nil nil nil default))
> =20
>  (defun git-checkout (branch &optional merge)

--=20
David K=C3=A5gedal
