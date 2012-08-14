From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 22:12:23 +0200
Message-ID: <87lihh8c7s.fsf@thomas.inf.ethz.ch>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
	<87zk5x6fox.fsf@thomas.inf.ethz.ch>
	<CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
	<7v628lbdcw.fsf@alter.siamese.dyndns.org>
	<CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:12:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1NTf-0002vc-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab2HNUM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:12:29 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16825 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756336Ab2HNUM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:12:28 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 22:12:25 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 22:12:25 +0200
In-Reply-To: <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 14 Aug 2012 11:32:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203442>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> On 14 August 2012 10:19, Junio C Hamano <gitster@pobox.com> wrote:
>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>
>>> On 14 August 2012 01:27, Thomas Rast <trast@student.ethz.ch> wrote:
>>>> [git pull with two args] it's ok if you use it with an URL instead
>>>> of a remote nickname
>>>
>>> Why would that be okay? What is the difference? Isn't the nickname
>>> just an alias for a URL?
>>
>> As long as you tell what refspecs to use on the command line, the
>> remote nickname behaves as "just an alias for a URL", so yes,
>> because Thomas is discussing "two-arg pull or fetch", one arg being
>> either nickname or URL and the other is an explicit refspec on the
>> command line, it would be okay because there is no difference in
>> that case.
>
> I suppose I'm not entirely clear on how this two step process is
> "safer". Doing "git fetch" would seem to be harmless, right? So the
> problem is with "git merge" but master should always be "behind"
> origin/master so that "git merge" should just FF to origin/master
> which *should* be completely safe. Does that make sense? Especially
> given our use of master as an integration branch?
>
> [Given the trouble I have with getting people to use Git properly, I
> prefer things as simple as possible. :-) ]

I meant something else than Junio hinted at.  Saying

  git fetch origin master
  # or by extension
  git pull origin master

does not update the origin/* namespace, not even origin/master.  All
fetching happens only into FETCH_HEAD.  This leads to confusion such as
yours because origin/master and thus the upstream tracking displays will
not know about the change.

If you use it with an URL, such as one that might be sent with a pull
request:

} The following changes since commit 62bc83349d52be49b037d2c800a7f4064cfbc5b5:
} 
}   The sixth batch of topics graduated to 'master' (2012-04-27 14:12:56 -0700)
} 
} are available in the git repository at:
} 
}   https://github.com/git-l10n/git-po/ master

(I picked a random pull request from the l10n coordinator, Jiang Xin)
you would say

  git pull https://github.com/git-l10n/git-po/ master

and you would not have a reasonable expectation of git updating your
remotes/*, even if you had a remote 'l10n' that points at that exact
URL.  So you would not be confused if you pulled from there, but
l10n/master didn't move.


In some sense this is a really bad case of wrong UI design, because we
(this happens on #git a lot) have to teach users not to use the command
so they won't trip over this problem.  It would be better to fix the
real issue instead.  IIRC it was even on the 1.8.0 wishlist...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
