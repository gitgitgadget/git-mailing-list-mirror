From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: verify-tag is not plumbing
Date: Sun, 31 Jan 2016 14:37:59 +0100
Message-ID: <20160131143759.Horde.Ylcq6ydVoLduXCzBPzVjZMh@webmail.informatik.kit.edu>
References: <60839686604d60632e1c80ef4fdd51eacb6b9290.1454244258.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 31 14:38:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPsCs-0000sW-8v
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 14:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbcAaNiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2016 08:38:18 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45795 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757371AbcAaNiS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 08:38:18 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aPsCm-0007Kj-Kf; Sun, 31 Jan 2016 14:38:16 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aPsCV-0003Ti-D6; Sun, 31 Jan 2016 14:37:59 +0100
Received: from x590d5d01.dyn.telefonica.de (x590d5d01.dyn.telefonica.de
 [89.13.93.1]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sun, 31 Jan 2016 14:37:59 +0100
In-Reply-To: <60839686604d60632e1c80ef4fdd51eacb6b9290.1454244258.git.john@keeping.me.uk>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1454247496.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285147>


Quoting John Keeping <john@keeping.me.uk>:

> According to command-list.txt, verify-tag is an ancillary interrogato=
r,
> which means that it should be completed by "git verify-<TAB>" in the
> same way as verify-commit.
>
> Remove it from the list of plumbing commands so that it is treated as
> porcelain and completed.

I'm not sure.  There are commands among the ancillary interrogators =20
that are basically porcelains (e.g. blame), while some are more like =20
plumbing (e.g. rerere, rev-parse).  In general the completion script =20
supports the former but not the latter commands.

Now, the real porcelain-ish way to verify a tag is via 'git tag =20
-v|--verify', and according to a925c6f165a3 (bash: Classify more =20
commends out of completion., 2007-02-04), the commit removing =20
verify-tag from the completed commands, verify-tag was kept around for =
=20
backwards compatibility reasons.  OTOH verify-commit was introduced in =
=20
d07b00b7f31d (verify-commit: scriptable commit signature verification, =
=20
2014-06-23), and as the subject line states it was intended more as a =20
plumbing command.

So I think we should keep excluding verify-tag from the list of =20
porcelain commands in the completion script, and it was an oversight =20
not to exclude verify-commit as well when it was introduced.


G=C3=A1bor

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  contrib/completion/git-completion.bash | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash =20
> b/contrib/completion/git-completion.bash
> index 51f5223..250788a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -728,7 +728,6 @@ __git_list_porcelain_commands ()
>  		write-tree)       : plumbing;;
>  		var)              : infrequent;;
>  		verify-pack)      : infrequent;;
> -		verify-tag)       : plumbing;;
>  		*) echo $i;;
>  		esac
>  	done
> --=20
> 2.7.0
