From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH jh/notes-merge-in-git-dir-worktree] fixup! t3310 on Windows
Date: Wed, 14 Mar 2012 12:39:35 +0100
Message-ID: <CALKQrgdjYvkSBn8UORSsZecSVyhJbfU5tjU0hPJOYn1OMVxMyw@mail.gmail.com>
References: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
	<1331563647-1909-1-git-send-email-johan@herland.net>
	<1331563647-1909-2-git-send-email-johan@herland.net>
	<4F60593A.5070106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, david@tethera.net,
	pclouds@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 12:39:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7mYT-000381-V0
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 12:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759124Ab2CNLjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 07:39:41 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:53437 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758753Ab2CNLjk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 07:39:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1S7mYN-000Kzf-1b
	for git@vger.kernel.org; Wed, 14 Mar 2012 12:39:39 +0100
Received: by yenl12 with SMTP id l12so1663928yen.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 04:39:35 -0700 (PDT)
Received: by 10.50.6.227 with SMTP id e3mr3988378iga.47.1331725175674; Wed, 14
 Mar 2012 04:39:35 -0700 (PDT)
Received: by 10.43.52.6 with HTTP; Wed, 14 Mar 2012 04:39:35 -0700 (PDT)
In-Reply-To: <4F60593A.5070106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193096>

On Wed, Mar 14, 2012 at 09:39, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> From: Johannes Sixt <j6t@kdbg.org>
>
> On Windows, a directory cannot be removed while it is the working
> directory of a process. "git notes merge --commit" attempts to remove
> .git/NOTES_MERGE_WORKTREE, but during the test the directory was stil=
l
> "occupied" by the shell. Move the command out of the subshell to rele=
ase
> the directory.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> =C2=A0Feel free to squash this into 1/2.
>
> =C2=A0t/t3310-notes-merge-manual-resolve.sh | =C2=A0 =C2=A04 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-me=
rge-manual-resolve.sh
> index d6d6ac6..6351877 100755
> --- a/t/t3310-notes-merge-manual-resolve.sh
> +++ b/t/t3310-notes-merge-manual-resolve.sh
> @@ -565,9 +565,9 @@ test_expect_success 'switch cwd before committing=
 notes merge' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd .git/NOTES_=
MERGE_WORKTREE &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "foo" > $=
(git rev-parse HEAD) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "bar" >> $(gi=
t rev-parse HEAD) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git notes merge --=
commit
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "bar" >> $(gi=
t rev-parse HEAD)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&
> + =C2=A0 =C2=A0 =C2=A0 git notes merge --commit &&

NAK. This defeats the entire purpose of this test. The bug that we're
trying to solve is exactly the situation where the user has changed
into the .git/NOTES_MERGE_WORKTREE directory, and invokes 'git notes
merge --commit' from within. We need to find a different solution for
this on Windows. Maybe we should just abort 'git notes merge
--commit/--abort' if the current directory is within
=2Egit/NOTES_MERGE_WORKTREE (and we're on Windows)?


=2E..Johan


--=20
Johan Herland, <johan@herland.net>
www.herland.net
