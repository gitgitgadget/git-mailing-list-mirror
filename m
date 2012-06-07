From: konglu@minatec.inpg.fr
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 21:55:12 +0200
Message-ID: <20120607215512.Horde.RVmScHwdC4BP0QcggMBjKUA@webmail.minatec.grenoble-inp.fr>
References: <4FD0D375.9060902@web.de>
 <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD0EB76.90501@web.de>
 <20120607200731.Horde.xzrpWHwdC4BP0O3jZ46SyWA@webmail.minatec.grenoble-inp.fr>
 <4FD0FCAC.3070408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org
To: Torsten =?iso-8859-1?b?QvZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 07 21:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scinj-00008b-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 21:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab2FGTzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 15:55:18 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:43065 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751788Ab2FGTzR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 15:55:17 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 17F4F1A02FC;
	Thu,  7 Jun 2012 21:55:13 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Thu, 07 Jun
 2012 21:55:12 +0200
In-Reply-To: <4FD0FCAC.3070408@web.de>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199443>


Torsten B=F6gershausen <tboegi@web.de> a =E9crit=A0:

> On 07.06.12 20:07, konglu@minatec.inpg.fr wrote:
>> On which branch are you applying the patch ? It should works on
>> branch master (it works for me) but it won't on branch "pu", as
>> it has already been queued.
>>
>> Lucien Kong
>>
> Thanks, now the patch applies on master.
> But it seems that the problem is still there:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [snip]
> ok 55 - prepare for rebase -i --exec
>
> expecting success:
>     git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
>     (
>         FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
>         export FAKE_LINES &&
>         git rebase -i HEAD~2 >expected
>     ) &&
>     sed 1,9d expected >expect &&
>     mv expect expected &&
>     test_cmp expected actual
>
> sed: 1: "/^pick .*/i\exec  git s ...": extra characters after \ at =20
> the end of i command
> Successfully rebased and updated refs/heads/execute.
> Successfully rebased and updated refs/heads/execute.
> --- expected    2012-06-07 19:07:51.000000000 +0000
> +++ actual    2012-06-07 19:07:50.000000000 +0000
> @@ -1,18 +1,4 @@
> -Rebasing (2/4)
> Executing: git show HEAD
> -commit 8f99a4f1fbbd214b25a070ad34ec5a8f833522cc
> -Author: A U Thor <author@example.com>
> -Date:   Thu Apr 7 15:17:13 2005 -0700
> -
> -    E
> -
> -diff --git a/file3 b/file3
> -new file mode 100644
> -index 0000000..1c50726
> ---- /dev/null
> -+++ b/file3
> -@@ -0,0 +1 @@
> -+E
> -Rebasing (3/4)
> Rebasing (4/4)
> Executing: git show HEAD
> +Rebasing (1/1)
> Executing: git show HEAD
>  commit 925b01e149bd188d43f972ad86d1e4d6611c8fa0
>  Author: A U Thor <author@example.com>
>  Date:   Thu Apr 7 16:10:13 2005 -0700
> not ok - 56 running "git rebase -i --exec git show HEAD"
> [snip]

As you pointed out, the problem seems to come from this line
	tmp=3D$(sed "/^pick .*/i\exec $i" "$1")
I think that the dquote here doesn't work on MacOS, though i've
never tried it. Anyway, even if it's not the problem, this kind
of quoting is quite odd so it will be removed in the next patch
(I do not see other reasons of the issue, as sed's i command should
work on MacOS).
