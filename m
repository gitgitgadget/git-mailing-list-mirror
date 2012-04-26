From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Thu, 26 Apr 2012 18:26:45 +0200
Message-ID: <87y5piwjay.fsf@rho.meyering.net>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
	<xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
	<87d36uxzfw.fsf@rho.meyering.net>
	<xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
	<CAKPyHN1mFGiZd7dDH-stUmr3H1JHwxcP1DkjCYNXZd6Bt-P7+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Marcus Karlsson <mk@acc.umu.se>, git list <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 18:28:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNRYQ-0008Hh-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 18:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757718Ab2DZQ0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 12:26:54 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:40891 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2DZQ0y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 12:26:54 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 4DF73D48218
	for <git@vger.kernel.org>; Thu, 26 Apr 2012 18:26:47 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id BAD3C60055;
	Thu, 26 Apr 2012 18:26:45 +0200 (CEST)
In-Reply-To: <CAKPyHN1mFGiZd7dDH-stUmr3H1JHwxcP1DkjCYNXZd6Bt-P7+w@mail.gmail.com>
	(Bert Wesarg's message of "Thu, 26 Apr 2012 18:21:33 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196380>

Bert Wesarg wrote:
> On Thu, Apr 26, 2012 at 18:13, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Jim Meyering <jim@meyering.net> writes:
>>
>>> What do you think about replacing those two append-if-needed two-li=
ners:
>>>
>>> =A0 =A0 if (buffer2.len && buffer2.buf[buffer2.len - 1] !=3D '/')
>>> =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(&buffer2, '/');
>>>
>>> by something that readably encapsulates the idiom:
>>>
>>> =A0 =A0 strbuf_append_if_absent (&buffer2, '/');
>>>
>>> (though the name isn't particularly apt, because you might
>>> take "absent" to mean "not anywhere in the string," so maybe
>>> =A0 strbuf_append_if_not_already_at_end (ugly) or
>>> =A0 strbuf_append_uniq
>>> )
>>
>> I am not good at names, but strbuf_terminate_with(&buffer2, '/')
>> perhaps?
>
> strbuf_ensure_terminator(struct strbuf* buf, int term, int always)?

Nice!  So far, that's the name I prefer.
But why the third parameter?
