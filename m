From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Adding "--ignore-submodules" switch to git-describe
Date: Fri, 01 Mar 2013 20:40:43 +0100
Message-ID: <5131043B.8000701@web.de>
References: <CAC9WiBjHEoX154Y2q1NxEB1my78Gqf__+v-KR5jNVqT-MN9ZaQ@mail.gmail.com> <7v621bggi5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 20:41:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBVpW-00045f-OU
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 20:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab3CATkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 14:40:53 -0500
Received: from mout.web.de ([212.227.15.4]:51245 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308Ab3CATkw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 14:40:52 -0500
Received: from [192.168.178.41] ([79.193.88.71]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LtnvF-1UuZYG2rTR-010rAU; Fri, 01 Mar 2013 20:40:46
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7v621bggi5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:SSDD8rbOtoFxz9cAoJ1UiiQBtrXvKt0dniAIpVbYrho
 ozAeCJUF3DKaCyLA0yNbNQ1+JL/PMN/FlzIbtki+EDGzLHLCam
 E0h8qkS/ZX2MV53KZGVJC3oCYG0IL4+He2t60FQ2bhcAauSMLE
 XOKOGcUb8xa2kdoTGqnyufXud18H014lFfuIaG8qc0qUrE91dh
 PrMKGxovrBGGDuu9FmOYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217288>

Am 01.03.2013 18:46, schrieb Junio C Hamano:
> I think what is missing from "--dirty" is not "--ignore-submodules",
> but "--do-not-ignore-untracked" option [*1*].  "describe --dirty"
> ignores untracked files in the superproject by default, and we
> should ignore untracked files in submodule working trees, but the
> current code does not.  Fixing that is (1) above.
>
> And then when "--do-not-ignore-untracked" is in effect, we should
> report a "dirty" revision when the working tree of the superproject
> or any of the submodule working trees has untracked cruft.

I agree with your analysis. What about teaching describe the
"-u|--untracked-files" option which status already knows? The
two modes could be "no" and "yes" here (as the distinction
between "normal" and "all" doesn't make any sense for describe).
Current default would be "no", using "-u" alone would set mode to
"yes".

> You might want to argue, in the longer term, that the default should
> be "--do-not-ignore-untracked" and people who want the current
> toplevel behaviour should ask it with "--ignore-untracked".  I am
> somewhat sympathetic to that position, but I do not think it is
> practical.  People are not perfect and they do keep untracked and
> unignored paths in the working tree; ignoring untracked paths does
> have an excuse to be the default from practical point of view.

I think the default mostly depends on the habits of the people
using a repo. Personally I would lean towards making "-uyes" the
default, because in my experience untracked files can make a huge
difference when you later try to reproduce a certain version and
its behavior (and additionally that is just what status already
uses as default). But I won't care that much about the default if
we would just reuse the "status.showUntrackedFiles" config option
to set the default for describe too. This should allow to set the
policy per repo or globally to peoples taste. Does that make sense?

> But when we ignore untracked paths in the superproject, we should
> ignore untracked paths in submodule working trees consistently.

Definitely (we fixed that for status some time ago in 3bfc45047).
