From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: possible bug when pushing with multiple remote repos.
Date: Fri, 22 Oct 2010 11:36:52 +0200
Message-ID: <AANLkTimeiBOHdgbVvN2Bi3SAP5_fXR8QTz3pHpad-cfU@mail.gmail.com>
References: <1287738771.13348.34.camel@amolinux> <AANLkTikkBoJ-dHSZ7H3_LGdzEmpQw5A2Q723tmY_kiPZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 11:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9E3s-00077R-J9
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 11:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab0JVJhO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 05:37:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46378 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab0JVJhN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 05:37:13 -0400
Received: by gxk23 with SMTP id 23so226106gxk.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 02:37:12 -0700 (PDT)
Received: by 10.229.249.3 with SMTP id mi3mr1989393qcb.287.1287740232614; Fri,
 22 Oct 2010 02:37:12 -0700 (PDT)
Received: by 10.229.232.4 with HTTP; Fri, 22 Oct 2010 02:36:52 -0700 (PDT)
In-Reply-To: <AANLkTikkBoJ-dHSZ7H3_LGdzEmpQw5A2Q723tmY_kiPZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159672>

On Fri, Oct 22, 2010 at 11:32 AM, Santi B=E9jar <santi@agolina.net> wro=
te:
> On Fri, Oct 22, 2010 at 11:12 AM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com> wrote:
>> Hi,
>>
>> I found a behavior which is, at least, different from what "git help
>> push" seems to declare.
>> basically:
>> - if I have 2 remotes : 'origin' and 'remote_B'
>> - if I checkout with tracking a branch of 'remote_B'
>> - if I do "git push remote" or "git push" or "git push -repo=3Dremot=
e_B"
>> then git try to push all my branches of "origin" to remote_B.
>>
>> I check with latest git 1.7.3.2, and the issue is still here.
>>
>> strangely:
>> - git checkout master
>> - git push =A0=3D> =A0this is OK, and doesn't try to push any remote=
_B
>> references to origin.
>>
>> I found this is particularity error prone as origin/master can be a =
fast
>> forward of remote_B/master, and in this case nobody will complains..
>> (that's what happened to me ;-) )
>
> This is because "git push" pushes matching branches by default if you
> don't specify the refspec. From the git push manpage:
>
> =A0 =A0 =A0 <refspec>...
> ...
> =A0 =A0 =A0 =A0 =A0 The special refspec : (or +: to allow non-fast-fo=
rward updates)
> =A0 =A0 =A0 =A0 =A0 directs git to push "matching" branches: for ever=
y branch that
> =A0 =A0 =A0 =A0 =A0 exists on the local side, the remote side is upda=
ted if a branch of
> =A0 =A0 =A0 =A0 =A0 the same name already exists on the remote side. =
This is the
> =A0 =A0 =A0 =A0 =A0 default operation mode if no explicit refspec is =
found (that is
> =A0 =A0 =A0 =A0 =A0 neither on the command line nor in any Push line =
of the
> =A0 =A0 =A0 =A0 =A0 corresponding remotes file---see below).
>

Ups, I forgot to tell you that you can change the default behavior
with push.default config.

push.default::
        Defines the action git push should take if no refspec is given
        on the command line, no refspec is configured in the remote, an=
d
        no refspec is implied by any of the options given on the comman=
d
        line. Possible values are:
+
* `nothing` - do not push anything.
* `matching` - push all matching branches.
  All branches having the same name in both ends are considered to be
  matching. This is the default.
* `tracking` - push the current branch to its upstream branch.
* `current` - push the current branch to a branch of the same name.

HTH,
Santi


> It may be worth pointing this out in the description.
>
> (I hope the scissor patch is well formated, and the mua doesn't mangl=
e it)
> -----8<-----
> Doc: git-push: Specify the default mode in the description
>
> Signed-off-by: Santi B=E9jar <santi@agolina.net>
> ---
> =A0Documentation/git-push.txt | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index e11660a..9a2a93e 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -23,6 +23,8 @@ You can make interesting things happen to a reposit=
ory
> =A0every time you push into it, by setting up 'hooks' there. =A0See
> =A0documentation for linkgit:git-receive-pack[1].
>
> +The default operation mode if no explicit refspec is found is
> +to push "matching" branches, see below.
>
> =A0OPTIONS[[OPTIONS]]
> =A0------------------
> --
> 1.7.3.rc1.227.gee5c7b
>
