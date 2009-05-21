From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0 2/3] t/t3400-rebase.sh: add more tests to help migrating git-rebase.sh to C
Date: Thu, 21 May 2009 07:22:37 -0700
Message-ID: <7vr5yibknm.fsf@alter.siamese.dyndns.org>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com>
	<1242899229-27603-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 16:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M79AU-00049P-2p
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 16:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbZEUOWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 10:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZEUOWh
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 10:22:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41411 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbZEUOWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 10:22:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521142237.GUZG20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 May 2009 10:22:37 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id uENd1b0064aMwMQ04ENdts; Thu, 21 May 2009 10:22:37 -0400
X-Authority-Analysis: v=1.0 c=1 a=rx5fn5RtJCkA:10 a=ILK5RQY-hJ4A:10
 a=pGLkceISAAAA:8 a=hRO4xYfcO-DtgFJsTF0A:9 a=D6kQp_l6eXEMIr1YLZ6ZCSJzafQA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1242899229-27603-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\, 21
 May 2009 19\:47\:08 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119683>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +test_expect_success 'rebase on dirty worktree' '
> +     echo dirty >> A &&
> +     ! git rebase master'

It is a good defensive way to use "test_must_fail" instead of "!" when
testing git itself; test_must_fail does not allow the program to termin=
ate
with non-zero value by segfaulting, while "!" does.

> +test_expect_success 'rebase on dirty cache' '
> +     git add  A &&

Two-spaces?

> +     ! git rebase master'
> +
>  test_expect_success 'rebase against master' '
> +     git reset HEAD &&
> +     git checkout -f &&

Hmm, why not "reset --hard HEAD".  Not asking to change (yet), but just
asking if there is a reason.

>       git rebase master'
> =20
> +test_expect_success 'rebase against master twice' '
> +	git rebase master 2>&1|grep "Current branch my-topic-branch is up t=
o date\\."
> +'
> +
> +test_expect_success 'rebase against master twice with --force' '
> +	git rebase --force-rebase master 2>&1|grep "Current branch my-topic=
-branch is up to date, rebase forced"

Do not to use any pipe while testing, i.e.

	git rebase >out 2>err &&
        grep "what you expect in 'out'" out &&
        grep "what you expect in 'err'" err

so that you can catch exit status from the command you placed in the
upstream of the pipe.
