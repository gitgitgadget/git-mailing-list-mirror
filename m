From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: RFC: Between git-subtree and git-submodules
Date: Sat, 24 Jul 2010 10:33:38 +0200
Message-ID: <AANLkTinYXrWSXSX8EOsb-YH_KGcmtAKB9nWZyRzBwZw5@mail.gmail.com>
References: <AANLkTi=tDRfgzzcbp0jV=+hQ+Cs2fhNF0vK8JL1COoFu@mail.gmail.com> 
	<AANLkTinyjinsGS2ddyMOW=3zDN1ThJcpF+dc4cBE6L9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 10:34:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcaBM-0005OC-8w
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 10:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab0GXIeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 04:34:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52916 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab0GXId7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 04:33:59 -0400
Received: by fxm14 with SMTP id 14so5388368fxm.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 01:33:58 -0700 (PDT)
Received: by 10.103.181.10 with SMTP id i10mr857482mup.99.1279960438142; Sat, 
	24 Jul 2010 01:33:58 -0700 (PDT)
Received: by 10.102.58.11 with HTTP; Sat, 24 Jul 2010 01:33:38 -0700 (PDT)
In-Reply-To: <AANLkTinyjinsGS2ddyMOW=3zDN1ThJcpF+dc4cBE6L9D@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151607>

On Sat, Jul 24, 2010 at 2:57 AM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Fri, Jul 23, 2010 at 8:13 PM, Santi B=E9jar <santi@agolina.net> wr=
ote:
>> =A0First my requirements:
>>
>> 1) Everything[a] must be available from the same repository/branch (=
so I'm not
>> =A0 worried about repository size)
>> 2) The history must be as clean as possible
>> 3) The directory content must be equal to the external module, at le=
ast when
>> =A0 you add/update it[b]
>> 4) The external module should be able to switch back and forth betwe=
en
>> =A0 different versions.
>>
>> [a] Everything means all that you need to checkout all the commits i=
n the
>> superproject not in the submodule.
>> [b] A consequence of #3 is that I lose all
>> change I've made in the subdirectory, if they are important I have t=
o extract
>> them, apply them and add the module back.
>>
>> git-submodule is rule out because of #1 but accomplish #2, #3 and
>> #4. git-subtree is rule out because of #2 (even with --squash).
>> [It fails at] #3 and #4
>> without --squash but accomplish #1 and #4 with --squash. So I need s=
omething
>> in between or a mixture of both.
>
> I admit to having had some trouble parsing the above, so I moved some
> punctuation marks around. =A0Please let me know if I've made a mistak=
e.
>
> If I understand correctly, you're claiming (indirectly) that
> git-subtree without --squash does not accomplish #1. =A0I don't see h=
ow
> this is the case. =A0Am I misreading? =A0I think git-subtree accompli=
shes
> #1 in both modes.

Yes, git-subtree accomplishes #1 in both modes. --squash only applies t=
o #4.

>
> I don't understand what you mean when you say (#2) git-subtree doesn'=
t
> keep your history "as clean as possible." =A0What is "as clean as
> possible" and what part of git-subtree's history results don't you
> like? =A0(Of course it's very different with and without --squash.)

With git-subtree you always have the subtree history (even if it is
squashed). So when you merge a second time the submodule you get the al=
ways
the history of the subtree (even with --squash). So you basically alway=
s have
at least two branches while examining the history. Compare this
squashed history:

$ git log --graph --oneline
*   bb2dc25 (HEAD, master) Merge commit
'08b917ee90ecfd7b666364fe4ebb92aee5cdd2f7'
|\
| * 08b917e Squashed 'latex/' changes from ea35faf..895916a
* |   9de91f1 Merge commit 'b1b4c36bb8358582a6a20bb500bf98421428e2ca' a=
s 'latex'
|\|
| * b1b4c36 Squashed 'latex/' content from commit ea35faf
* ea35faf Indent, whitespaces,...

with this pruned history:

$ git log --graph --oneline
* 8703aec (HEAD, master) Subtree 'latex/': 895916a Add files subcommand
* a942284 Subtree 'latex/': ea35faf Indent, whitespaces,...
* ea35faf Indent, whitespaces,...

But I understand that it can only be this way because of #3.

>
> With #3, I can see that you want something different than I do; you
> want to silently revert your own patches out of the submodule's
> history, when you upgrade the submodule to a new version. =A0Personal=
ly,
> I find this concept a bit objectionable (it's like "git merge -s
> ours"), but okay, it's pretty easy to implement, and you've submitted
> a patch to git-subtree that does it. =A0My question is: why would you
> want this? =A0Isn't it clearer to 'git revert' the patches you don't
> want?

I prefer to do all the modifications in an external repository, even if=
 at the
end it is really a fork of the upstream repository. I think the proper =
place
to modify the files in a subtree is in an external repository.

>
> And for #4, it's true that git-subtree without --squash does not allo=
w
> you to easily rewind to an older version of the submodule, while with
> --squash it does.
>
> It sounds to me like, if we added your patch to git-subtree, then
> git-subtree --squash would solve #1, #3, and #4. =A0And maybe we coul=
d
> fix #2 as well. Correct?

My patch does not change the behavior of --squash, it adds --prune.

Thanks,
Santi
