From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git bisect Vs branch
Date: Fri, 23 Oct 2009 10:34:10 +0200
Message-ID: <4AE16A82.1010103@viscovery.net>
References: <4AE07EEB.2010101@maxim-ic.com> <adf1fd3d0910220950s50ccf8efwda891374e6480a30@mail.gmail.com> <4AE156A9.9060809@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?B?U2FudGkgQsOpamE=?= =?UTF-8?B?cg==?= <santi@agolina.net>
To: =?UTF-8?B?R3LDqWdvcnkgUm9tw6k=?= <gregory.rome@maxim-ic.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 10:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1FbL-0003F0-0Q
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 10:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbZJWIeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 04:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbZJWIeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 04:34:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10331 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZJWIeI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 04:34:08 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N1Fb8-0004hN-FI; Fri, 23 Oct 2009 10:34:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 33E0BBC81; Fri, 23 Oct 2009 10:34:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AE156A9.9060809@maxim-ic.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131097>

Gr=C3=A9gory Rom=C3=A9 schrieb:
> Thanks Santi but I have a problem, due to the fact that the commit wh=
ich
> has an impact on my code is in origin/master or first-origin/master
>=20
> When bisect checkout a commit from those branch I have none of my own
> modifications... So I can' test if my code is good or bad excepted if=
 I
> can merge my commits in the bisect branch...
>                                                     =E1=90=81
> first-origin/master  *---A---------B----------------o------C-
>                           \         \                       \
> origin/master              ----------B'----------U-----------C'-
>                                       \           \           \
> master                                 ------------U'----------C''-

C" is the commit that merges upstream changes into your changes. You ar=
e
saying that your changes alone (before the merge) are good, and that
upstream before the merge is also good (since it doesn't contain your
changes, it is good by definition, more or less). That indeed means tha=
t
the merge commit is the first bad one; i.e., this is exactly the situat=
ion
that the user manual describes.

You should do:

  $ git checkout -b tmp master   # master is at C"
  $ git rebase origin/master
  $ git bisect start tmp orgin/master

That is, you rebuild your history on top of origin/master in a linear
fashion. (If you had merge conflicts in U', then you will see them agai=
n.)
Then you bisect the linearized history. This will point you to the bad
commit and you will understand what is going wrong.

With this new knowledge, go back to master (C") and fix the problem.

-- Hannes
