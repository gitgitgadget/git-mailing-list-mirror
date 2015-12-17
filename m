From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: emulate write(2) that fails with a EPIPE
Date: Thu, 17 Dec 2015 18:08:08 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512171807480.6483@virtualbox>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de> <xmqq7fkedyx7.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1512171037310.6483@virtualbox> <xmqqegelc9k8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 18:08:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9c2N-0000Aj-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 18:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbLQRIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 12:08:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:54753 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbbLQRIP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 12:08:15 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Ma1pn-1ZuxhF109f-00Lp1r; Thu, 17 Dec 2015 18:08:10
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqegelc9k8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:t2elkADLMfP3SMtnTSHyxbtY3AIopPy5kGiatMXBfZHjWpp9/Nw
 TVCBtpg6+JgWs/EMwosq2o1ShlB/VEUIBrf/LOGvdmUPVehA0FJqLPka/9hRb/NGCgBzvdG
 GYBTkfj+5I1ZcT3upP23ZdklFLW13FwpM1hInlr71flUKcjlcmOHxJQn97WcwS8OAl1s9Fq
 4C5dWrVHX4EU+EAKPE4Aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZnbfIbCA348=:QuCO722eG8zAOaKoQBDW8V
 P5RC+PEpYeUcg9adX3f4jHiAReFC3GIsy2loHi4ux8qcW6LXzJdOqBgzJsoO23efegXZYv9CT
 dJ0EqK0uKl5Cb7mZelh2oAEYKKPjuHoplgQlqxnN158fE5rduMWC7g4635y0XgceLhU5jEs5p
 KcLWUnUPwbIf3cnM7YN4g1ZASctvIk0abk7tJCB7ekWlQImOls2ZPIcGTvR+v47REHVZp2Qzx
 NSRPCEQ3sqLFeHFe0d9+wK/VzKih+VLaX6cw6ZIOaic+rFSNxkKjZBF2cNZbH6YUAV+xanmLe
 Aq2BCPwD1qvKgEIv8r/YFFaS3VrRyeqVvA3/24hp4a0xvYvYiDvitpycuVYHAdADgNHN6+9mh
 wtOgNUA7dxYaEhFHOMel1MDEP6J2K7XiaoVlz6ncbkhyfWanBz9YIQYF4VrWbZWdQLfF0HVsZ
 +liMH4ZLqW3anEUofdTBt+dPVCuagfbjnOjKpq/tJ+gE8AbKHyD/cbx7rktR2kYvvWfYYM4r+
 GEB2bUfzWOEMDHqYvuIeQGkoXmtk+TaK7J7DidtxisPssu3O2ftI3ZD1kLru68EJ5usUb2xI+
 5fSD2KUswE74Uq/uacZkZ7COyCjjZrHU7GA7cnAiTUTS0eu6Y7XhRkbpSCXMP8YIzgd2pYOJv
 QISewA+Mg8XcWrl0hSAgXjJz0ILWdqV2xjlc2NfE7gA8xKAB/sojvzm55rRugOr/7vIoKbFK6
 FsWNFZSEl5k+gLessH5XhHqRNA0iTwAv7+pUFKLMjC2ATjeiZUFIx+EKNm/DZmovNxQfttAj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282659>

Hi Junio,

On Thu, 17 Dec 2015, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > My intuition (which I honestly did not verify using performance tests) was
> > that write() is called *much* more often than, say, open(),...
> 
> My gut feeling agrees with yours, but I do not think the frequency
> at which write() is called should be the primary factor when you
> decide to make its wrapper inlined.  Once you call write(2), you
> will hit either the disk or the network doing I/O, and at that point
> I'd expect that the cost of making an extra layer of wrapper call
> would be lost in the noise.  I'd worry a lot more about from how
> many callsites write() is called---by inlining the extra code that
> is run only when the underlying write(2) returns an error to many
> callsites, we would make the program as a whole bigger, and as the
> result other code needs to be evicted out of the instruction cache,
> which also would hurt performance.

That argument convinced me. v2 coming shortly.

Ciao,
Dscho
