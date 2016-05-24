From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Small rerere in rebase regression
Date: Tue, 24 May 2016 15:18:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605241510370.4449@virtualbox>
References: <57434572.6030306@kdbg.org> <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com> <57437693.3030106@kdbg.org> <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 15:27:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5CN6-0007C3-0K
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 15:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbcEXN1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 09:27:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:50169 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367AbcEXN1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 09:27:36 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LzbXq-1bad703Guw-014mpf; Tue, 24 May 2016 15:27:08
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:3UAi0F0AYub32FZJxWK9g/w3+eUyk9E0ypsywjkRR31Ym6Ky8O3
 FdPWbzNh1MoJ+4gCSN+cQL3dNOWO5SFUjkQC7tP3jDvfhjwL3/vbiYBjIlwR+jn9OzxtmI8
 yjfoZ33DQnxUDLspyHGRd5nWkE1c4GN2A9j3yXilPmaXtCKEySM+xiyB+2Xzb83wkPNk046
 C8oa+vDGQHFBN0Q0doefg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z5tdQn0faA0=:mHB3yqedDI11cwqKXvi8nI
 1Qldu+pR7W7ssx0PzPWuzCuQlprsCl7+mSMAuAIclKxul5SVC/RlBBFMIhwnyR1JMS5pUf/DU
 chNIKElOzDaF3RcpI7jUgTPtZD+rbEajYWN5rZSoUqzyXpKwtaG6lGIaYQCNxzVcdE6369Jrj
 g6YVCY4beyvNKXLwekI7oH/zPKBQe/F15elOoKeB0dL0O/xDNUaJjW8wioSBIpbG66DA7owfS
 lpqhG0D9SnkeVuVNo4ptzPx2jUpEaPbgLWtleOdlP7nrmBLQL96w5lA3FiHO+BM/nR+cZLaVW
 D8SWmnUQwZj6Dh7sZlGu2TpeZW7tLlHDrZtIdMP0AzBulpxddeFkhzzk3paHQcQYU5QrlEKjl
 epkLLYx5HfpoI7jFV2kv23eIl+ew07m49ic/Gu768FxYjAiWKToisGrJAFhZ80QYvnf/05plv
 WgFIiJypA5bN5eIxXa2uxXztOF2/54k7uk8RMsv96vIP2cc13ogdQJPMxBu5ZOTI37Lz2QKib
 2M/fOjluTELDWMR1W3GuJvgj93AVe8v9JtU7gd4JRP16wa955RSQShydfmAvjQr1HGbuOa0tz
 tpsFMVruiH4oRTaPOZUFq3j40NOrltG/7Fd2XZK74UkfZWxrIQYD69Mvww9vH4jBnqvOheDeU
 MNJeozSiRhdBK2UB8fNrDlZ5TKzLtXziek7ZRxA4/XRth+9dx/1iNKp+2usBUcWxoGwmLBgl0
 uCS5iUkbVmATlIADB4foywksls3eQr62Wc8lWv0Fiwsku37L3b285AOlgrXKq3ENy/1rodJR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295494>

Hi,

On Mon, 23 May 2016, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > I also come to the conclusion that die_with_patch shouldn't have to
> > have a call to "git rerere". die_with_patch can be called after "git
> > cherry-pick", "git merge", "git commit", all of which have their own
> > rerere() invocation.
> >
> > However, calling "git rerere" after a failed "git commit" may be
> > destructive: it would record a resolution even though the commit has
> > not be completed. Think of an squash commit being aborted because the
> > user notices an error in the last minute. If that error is in a
> > conflict resolution, that wrong resolution would be recorded.
> 
> So, the behaviour change you observed uncovered a small bug in "rebase
> -i" that was covered by the old limitation of "rerere" that refrained
> from creating preimage when there already is one?
> 
> I think removing the call to "git rerere" there is a safe and sensible
> thing regardless, but perhaps authors of "rebase -i" had their own
> reasons.  I dunno (it is unlikely I'll have a chance to do blame and
> digging today).

I introduced this in ecfe72ff658124ea301ec7b2bb8b987689303685, as a (late)
answer to f131dd492f098f9f565df93df13e35c734284590.

Hannes, could you quickly test whether
https://github.com/dscho/git/tree/interactive-rebase calls rerere twice,
too? (Please call interactive rebase with the GIT_USE_REBASE_HELPER=true
to avoid running the interactive rebase twice.)

I have a hunch that it does not call rerere twice, which would be a nice
bonus in that patch thicket (so far, I split the patches into seven patch
series, in addition to the ones I already sent, still have to do one
thorough review before I'll continue submitting them).

Ciao,
Dscho
