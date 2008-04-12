From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [StGit PATCH] Remove broken branch creation subtest
Date: Sat, 12 Apr 2008 11:06:13 -0700
Message-ID: <7vabjzhrsa.fsf@gitster.siamese.dyndns.org>
References: <20080412124212.27748.21332.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 20:07:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkk85-0005rT-R2
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 20:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbYDLSG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 14:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756043AbYDLSG2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 14:06:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756986AbYDLSG2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Apr 2008 14:06:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 511A724F1;
	Sat, 12 Apr 2008 14:06:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6196124EC; Sat, 12 Apr 2008 14:06:21 -0400 (EDT)
In-Reply-To: <20080412124212.27748.21332.stgit@yoghurt> (Karl =?utf-8?Q?Ha?=
 =?utf-8?Q?sselstr=C3=B6m's?= message of "Sat, 12 Apr 2008 14:44:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79372>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> This subtest has started to cause subsequent subtests to fail with
> recent versions of git. And I don't think we can blame this one on
> git. What the subtest does is:
>
>   1. Remove all files or directories called "foo" under .git/. This i=
s
>      supposed to delete the "foo" branch and associated StGit files,
>      but what about packed refs? This isn't actually malfunctioning
>      yet as far as I can tell, but it's a ticking bomb.

With an additional "git branch -D foo" perhaps upfront before you manua=
lly
"corrupt" the repository, this can be resurrected without disabling the
test, can't it?

>   2. Create an empty file .git/refs/heads/foo. This is supposed to be
>      a "broken branch", and indeed it is -- for example, git show-ref
>      barfs on such a repository even if asked to only show a branch
>      other than foo!

You got me worried here.

 * "git show-ref" issues "error: refs/heads/foo points nowhere!" in all
   cases, which is not bad.

 * broken foo does not prevent "git show-ref" (no patterns) from carryi=
ng
   out its primary task.  It goes on showing others.  There is no bad h=
ere
   either.

 * "git show-ref refs/heads/foo" errors out with 1, which is Ok.

 * "git show-ref master" shows all the ones ending with "master", exits
   with 0, which is Ok.

>   3. Makes sure that stg branch won't successfully create a "foo"
>      branch. I'm pretty sure this fails because git thinks the repo i=
s
>      broken, not because stg handles it gracefully. This is what the
>      test is supposed to be testing, but if we wanted that, we'd need
>      a more detailed test.
>
>   4. Doesn't clean up the broken ref, which causes some subsequent
>      subtests to fail.

It may be worth fixing the test than working it around, if only cleanin=
g
up is the issue.
