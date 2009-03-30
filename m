From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/4] Documentation: branch.*.merge can also afect
 'git-push'
Date: Mon, 30 Mar 2009 09:47:17 -0700
Message-ID: <7vd4bzdkkq.fsf@gitster.siamese.dyndns.org>
References: <1238407903-28020-1-git-send-email-santi@agolina.net>
 <1238407903-28020-4-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 18:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoKfl-0001VR-HK
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 18:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZC3QrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 12:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZC3QrZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 12:47:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbZC3QrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 12:47:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA30EA65A9;
	Mon, 30 Mar 2009 12:47:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A706FA65A6; Mon,
 30 Mar 2009 12:47:19 -0400 (EDT)
In-Reply-To: <1238407903-28020-4-git-send-email-santi@agolina.net> (Santi
 =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 30 Mar 2009 12:11:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70FC2116-1D4A-11DE-A250-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115175>

Santi B=C3=A9jar <santi@agolina.net> writes:

> Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
> ---
>  Documentation/config.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7ae584f..38ab785 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -480,7 +480,7 @@ branch.<name>.remote::
>  branch.<name>.merge::
>  	It defines, together with branch.<name>.remote, the upstream branch
>  	for the given branch. It tells 'git-fetch'/'git-pull' which
> -	branch to merge.
> +	branch to merge and can also afect 'git-push' (see push.default).
>  	When in branch <name>, it tells 'git-fetch' the default
>  	refspec to be marked for merging in FETCH_HEAD. The value is
>  	handled like the remote part of a refspec, and must match a

I'll take [1/4] and [2/4] with minor rewording, and I think [4/4] is no=
t
necessary (push.default is clear enough---and defaultMode won't make it
any clearer to the first time readers anyway as it is unspecified what
kind of "mode" it is talking about).

I do not understand this [3/4].  I did look at push.default but it is
unclear how this variable is involved.

Perhaps it is because the word "tracking" in the description "push the
current branch to the branch it is tracking" is used without explainati=
on.
I think the author meant to say if your local branch frotz by default
merges changes made to the branch nitfol of the remote repository, "fro=
tz
tracks nitfol", but the use of the word "track" for that meaning appear=
s
nowhere in Documentation/glossary-content.txt

When you have:

        [branch "frotz"]
                remote =3D xyzzy
                merge =3D nitfol
        [remote "xyzzy"]
                url =3D ...
                fetch =3D refs/heads/*:refs/remotes/xyzzy/*

we can learn from the glossary the following:

 * refs/remotes/xyzzy/nitfol is a (remote) tracking branch and is used =
to
   follow changes made on "nitfol" branch in another repository "xyzzy"=
=2E

 * refs/heads/*:refs/remotes/xyzzy/* is a refspec.  It shows refs under
   refs/heads/ (aka "local branches") of the "xyzzy" repository are cop=
ied
   to our refs/remotes/xyzzy/ hierarchy.

There is no word defined to describe what "nitfol" is to "frotz".  It i=
s
what "frotz" merges from.  So perhaps the description of push.default
should say that, instead of using the word "track" in a confusing way t=
o
describe unrelated concept.  Saying "merge" might confuse people who wa=
nt
to use "branch.<name>.rebase", so it might be a good idea to say:

	frotz updates with nitfol

To "track" is pretty much about one-way communication.  You track the
other guy, but you do not have to (and often you cannot) update the
upstream with what you do.  branch.<name>.merge may have been "tracking=
"
in that sense, but with the push.default set to tracking, suddenly the
communication becomes bidirectional and it is not about tracking anymor=
e.
