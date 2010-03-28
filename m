From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/2] Allow git gui to display the diff with the HEAD in 
	the case of conflicts. [ amended ]
Date: Sun, 28 Mar 2010 13:58:24 +1100
Message-ID: <2cfc40321003271958v2912a349ld9ca610755195f19@mail.gmail.com>
References: <2cfc40321003271919kd939540n7354546a95515a8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 04:58:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvii2-000452-Vb
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 04:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab0C1C6Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 22:58:25 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47119 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0C1C6Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 22:58:25 -0400
Received: by pva18 with SMTP id 18so1995936pva.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 19:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D7Yglg1VHO8eutf01QGOIijo5kJOBWauQw++g3PQ+Rk=;
        b=xkaO4DmO5saqJlNGYiNAIk430pQdM35ur9Atv5n7luf50+nPaVSHq1FC47vaAADEkL
         Y43F1jH0ogQqJt7pkjXZ+wRqzxSEyw4eGmMCQc2aU4sKpVGfRci9f8aTfukC4InSlgmN
         W4hMy9dM9chCEMMpgzl6gpMKdCKS1tnrYyFto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P1ag/7ouVlQrPdzfkKfiwjmK+JbPXAouPbRCuy7Zdzy//f61wE3jOBStwUH2mefRe5
         te+lOwgmkyCdCo1FDKPwDyh6v2c7yR+I9WQPEfkUMVYY1D+VYi4wc6tMtzfhxukAW95i
         vY8/sBCVKdjP8XRrUzVelzEdqnlhf7V19Al0k=
Received: by 10.115.89.7 with HTTP; Sat, 27 Mar 2010 19:58:24 -0700 (PDT)
In-Reply-To: <2cfc40321003271919kd939540n7354546a95515a8d@mail.gmail.com>
Received: by 10.114.7.18 with SMTP id 18mr3239888wag.0.1269745104163; Sat, 27 
	Mar 2010 19:58:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143374>

Sorry, I realise that this patch has some whitespace issues. I'll fix
that in the next iteration.

I would welcome discussion about whether the optionally configured
behaviour should, in fact, be the default behaviour for conflicted
paths.

The reason is that both "Use Local Version" and "Stage to commit" both
make unexpected and irreversible changes to the index in the case that
a conflicted path has a mixture of conflicted hunks and successfully
merged remote hunks. By always displaying a diff between the working
tree and the HEAD the user will know  exactly what the consequences of
"Use Local Version" and "Stage to commit" would be. This is not
currently true.

My next iteration of this patch will move the configurable behaviour
into a separate patch so that this patch can be discarded if the
consensus is that the behaviour described above is reasonable default
behaviour.

jon.

On Sun, Mar 28, 2010 at 1:19 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> If the configuration variable gui.conflictsdiffwithhead is true,
> then the diff displayed for conflicted paths will be the difference
> between the working tree and the HEAD.
>
> The rationale for this change is that the previous behaviour did not =
allow
> the user to make an informed decision about whether "Use Local Versio=
n"
> was safe since non-conflicting changes in the remote branch were alre=
ady
> in the index and thus not visible from git gui.
>
> With this change, the gui displays what the index would contain if
> the current working tree copy (including diff markers) was staged
> to the index as is. If there are successfully merged hunks from the r=
emote
> branch in the index, then these will be visible in diff.
>
> | Amended Use Remote Version -> Use Local Version
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
> =A0Documentation/config.txt | =A0 =A09 +++++++++
> =A0git-gui/lib/diff.tcl =A0 =A0 | =A0 =A06 +++++-
> =A02 files changed, 14 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 06b2f82..a03c050 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1032,6 +1032,15 @@ gui.commitmsgwidth::
> =A0 =A0 =A0 =A0Defines how wide the commit message window is in the
> =A0 =A0 =A0 =A0linkgit:git-gui[1]. "75" is the default.
>
> +gui.conflictsdiffwithhead::
> + =A0 =A0 =A0 If set to "true", then the diff displayed by the gui fo=
r unstaged conflicted
> + =A0 =A0 =A0 changes is the diff between the working tree and the HE=
AD. This mode
> + =A0 =A0 =A0 of operation allows the user to assess whether use of "=
Use Local
> Version" is safe
> + =A0 =A0 =A0 or will discard successfully merged hunks from the remo=
te branch.
> + =A0 =A0 =A0 If set to "false", the diff shown for all unstaged chan=
ges is the difference
> + =A0 =A0 =A0 between the working tree and the index. Default: "false=
".
> +
> +
> =A0gui.diffcontext::
> =A0 =A0 =A0 =A0Specifies how many context lines should be used in cal=
ls to diff
> =A0 =A0 =A0 =A0made by the linkgit:git-gui[1]. The default is "5".
> diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
> index e7b1986..7aeb98d 100644
> --- a/git-gui/lib/diff.tcl
> +++ b/git-gui/lib/diff.tcl
> @@ -300,7 +300,11 @@ proc start_show_diff {cont_info {add_opts {}}} {
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if {$w eq $ui_index} {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lappend cmd [PARENT]
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0if {$is_unmerged && [is_config_true gui.conf=
lictsdiffwithhead]} {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lappend cmd "HEAD"
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if {$add_opts ne {}} {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eval lappend cmd $add_opts
> =A0 =A0 =A0 =A0} else {
> --
> 1.6.6.1
>
