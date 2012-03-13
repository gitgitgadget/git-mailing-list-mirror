From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] diff: Introduce diff.algorithm variable
Date: Tue, 13 Mar 2012 22:42:50 +0800
Message-ID: <CALUzUxpR_bPLvnHRJrQ2wVpqJD6Ccg6r3RMa_sCDKHTapnJsdw@mail.gmail.com>
References: <06652d553040ad6b25608dc69d632f1ee38eaeca.1331300343.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	peff@peff.net, Lawrence.Holding@cubic.com
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 15:43:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7SwD-00074Q-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 15:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab2CMOmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 10:42:52 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43813 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab2CMOmv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 10:42:51 -0400
Received: by wejx9 with SMTP id x9so593694wej.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HewW8P6W4N5CklHlUqUuG6BIiv65CxdIz91MT5AIcO4=;
        b=WZgAVcLIJ9V2tNXuwezVWbtlAVE42CVR0Iw+8WRIbpuAHwJOVUaQsxqP0A+lhVgRMU
         /9MZkATF/WdMfls4TBOLoq6PqvjP18nsExDVlVIyOpPXqcEvieZBJkn5+OB897rIo68j
         /wS1YE8Cbnantqe3H9srhH9SrPew/a0Nq0d3GGaNzUjcNYyWhd2BdktmynJYo6wUwoy6
         bsnO0abgkqVGG+SRqEc9Zs2UroREq8UuSX0H0kcqXM8V2p7dVqQCDBxVGDAIm4Y5jCoq
         UT052qOVa8DSMwsD/Siuxmpp4M7aUagTynXjl9UpGO3/qZvoFZtGfhBNh6v1gUAE/ZY/
         /Nrg==
Received: by 10.180.107.162 with SMTP id hd2mr8095694wib.8.1331649770644; Tue,
 13 Mar 2012 07:42:50 -0700 (PDT)
Received: by 10.223.89.67 with HTTP; Tue, 13 Mar 2012 07:42:50 -0700 (PDT)
In-Reply-To: <06652d553040ad6b25608dc69d632f1ee38eaeca.1331300343.git.mprivozn@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193029>

On Fri, Mar 9, 2012 at 9:48 PM, Michal Privoznik <mprivozn@redhat.com> =
wrote:
> Some users have preference over various diff algorithms. However,
> now they are forced to use appropriate argument every time they
> run git-diff and tools using it. This is impractical. Therefore
> create new variable which can set preferred algorithm. Of course,
> this can be overridden on command line via --diff-algorithm=3D*.
> Accepted values are myers (default), histogram, minimal, patience.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
> This is basically v2 for:
>
> =A0 http://www.spinics.net/lists/git/msg176100.html
>
> As we agreed on list, I've switched from diff.patience to
> diff.algorithm and created new argument --diff-algorithm.
>
> Please keep me CC'ed as I am not signed into the list.
>
> =A0Documentation/diff-config.txt =A0 =A0 =A0 =A0 =A0| =A0 21 ++++++++=
+++++++++++
> =A0Documentation/diff-options.txt =A0 =A0 =A0 =A0 | =A0 23 ++++++++++=
+++++++++++
> =A0contrib/completion/git-completion.bash | =A0 13 +++++++++++
> =A0diff.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 35 ++++++++++++++++++++++++++++++++
> =A04 files changed, 92 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-confi=
g.txt
> index 6aa1be0..1047e81 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -1,3 +1,24 @@
> +diff.algorithm::
> + =A0 =A0Choose a diff algorithm. =A0The variants are as follows:
> ++
> +--
> +histogram::
> + =A0 =A0This is the fastest algorithm.
> +
> +myers::
> + =A0 =A0The classical Myers diff algorithm. This is the default.
> +
> +minimal::
> + =A0 =A0Like 'myers', but spend extra time making sure that the diff
> + =A0 =A0is the shortest possible for the set of changes performed.
> +
> +patience::
> + =A0 =A0The patience diff algorithm, which first matches unique line=
s
> + =A0 =A0with each other. =A0This sometimes results in more readable =
(if
> + =A0 =A0longer) patches than the other algorithms.
> +--
> ++
> +

Considering that --minimal isn't really an algorithm, could this be
instead made to a "default options to always pass to diff" config? I
imagine this would make the codepath involved in this patch much
simpler (just reuse the argc/argv opt parsing machinery).

Additionally, it would be useful for users who want to, say, set the
context to 5 lines always.

--=20
Cheers,
Ray Chuan
