From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Thu, 26 Apr 2012 19:26:33 +0200
Message-ID: <87ehrawgja.fsf@rho.meyering.net>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
	<xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
	<87d36uxzfw.fsf@rho.meyering.net>
	<xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
	<CAKPyHN1mFGiZd7dDH-stUmr3H1JHwxcP1DkjCYNXZd6Bt-P7+w@mail.gmail.com>
	<87y5piwjay.fsf@rho.meyering.net>
	<CAKPyHN2VkBo6OKgbhTNSu-LFwabGkFFKAF595rJuXbhWwdte+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Marcus Karlsson <mk@acc.umu.se>, git list <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 19:27:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNST4-0002JI-K4
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 19:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab2DZR0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 13:26:44 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:50692 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161Ab2DZR0m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 13:26:42 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 47405D480BB
	for <git@vger.kernel.org>; Thu, 26 Apr 2012 19:26:34 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id AB3D16009F;
	Thu, 26 Apr 2012 19:26:33 +0200 (CEST)
In-Reply-To: <CAKPyHN2VkBo6OKgbhTNSu-LFwabGkFFKAF595rJuXbhWwdte+g@mail.gmail.com>
	(Bert Wesarg's message of "Thu, 26 Apr 2012 18:53:07 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196384>

Bert Wesarg wrote:
> On Thu, Apr 26, 2012 at 18:26, Jim Meyering <jim@meyering.net> wrote:
>> Bert Wesarg wrote:
>>> On Thu, Apr 26, 2012 at 18:13, Junio C Hamano <gitster@pobox.com> w=
rote:
>>>> Jim Meyering <jim@meyering.net> writes:
>>> strbuf_ensure_terminator(struct strbuf* buf, int term, int always)?
>>
>> Nice! =A0So far, that's the name I prefer.
>> But why the third parameter?
>
> See the second part of my reply:

Oh.  I missed that.

>>>> ------------------------------------
>>>> builtin/branch.c-     if (!buf.len || buf.buf[buf.len-1] !=3D '\n'=
)
>>>> builtin/branch.c:             strbuf_addch(&buf, '\n');
>>>> --
>>>> strbuf.h-     if (sb->len && sb->buf[sb->len - 1] !=3D '\n')
>>>> strbuf.h:             strbuf_addch(sb, '\n');
>>
>> Please note, that while they are checking the .len, they both behave
>> differently if .len =3D=3D 0 or not.
>> The first always append a '\n', the latter only, if the string isn't=
 empty.

Glad you noticed the difference.
However, is one exception worth complicating the interface?
