From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating
 to true
Date: Thu, 15 Aug 2013 22:38:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308152236250.14472@syhkavp.arg>
References: <CAPig+cQmdPo4mo69DsDmUURcw+HbxkAoNEqY08qiuJs8S+=bvQ@mail.gmail.com>
 <1376602462-32339-1-git-send-email-stefanbeller@googlemail.com>
 <CAPig+cQ5Y9irLk=9Bhz09c=5yzZEcyMKn2kbhcrO_zDpgmkhGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 04:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA9wQ-0005k9-Pd
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 04:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab3HPCjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 22:39:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50023 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab3HPCi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 22:38:59 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MRL0008DRCS8AC0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Aug 2013 22:38:53 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id B241F2DA0203; Thu, 15 Aug 2013 22:38:52 -0400 (EDT)
In-reply-to: <CAPig+cQ5Y9irLk=9Bhz09c=5yzZEcyMKn2kbhcrO_zDpgmkhGw@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232397>

On Thu, 15 Aug 2013, Eric Sunshine wrote:

> On Thu, Aug 15, 2013 at 5:34 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
> > When checking the previous lines in that function, we can deduce that
> > hsize must always be smaller than (1u<<31), since 506049c7df2c6
> > (fix >4GiB source delta assertion failure), because entries is
> > capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
> > value of 0x3fffffff, which is smaller than (1u<<31), so the value of
> > 'i' will never be larger than 31.
> >
> > Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> > ---
> >
> > Eric, thanks for reviewing my patch.
> >
> > I applied the first 2 proposals (deduce, entries), but I disagree on
> > the third, so I reformulated the sentence, as I really meant the variable
> > i and not it as a pronoun.
> 
> Thanks. Adding the quotes around 'i' makes your meaning clear. Without
> the quotes, apparently it was ambiguous, and my brain read it as a
> misspelling of 'it'.
> 
> > Do I understand right, you're suggesting to remove the
> > source code comment? I did this now, but I have a bad feeling with it.
> >
> > The change of this patch surely removes dead code as of now and makes it
> > more readable. But also it could become alive again, once somebody
> > changes things nearby and forgets about the assumption, hsize not
> > exceeding a certain size. That's why I put a comment in there, so
> > the future changes nearby may be more careful.
> 
> Indeed, I feel uncomfortable with the patch in general for the very
> reason that you state: it might become live again. Without the patch,
> the code remains safe without any extra effort. With this patch, even
> with the in-code comment, someone making changes needs to take special
> care. Sometimes it makes sense to leave safeties in place, even if
> they can't be triggered _today_; and safeties (such as i < 31) also
> serve as documentation.

That's also a valid argument.  I don't think this loop is going to 
appear on any trace profile either.

I personally have no strong opinion here.


Nicolas
