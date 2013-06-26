From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 16:12:45 -0700
Message-ID: <87vc50lb4i.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-10-git-send-email-tanoku@gmail.com>
	<87y59xlvt7.fsf@linux-k42r.v.cablecom.net>
	<CAFFjANQ_PoTT5bUrZ_0oARz=oZysJdMC1MAsHR2MCZVubfSbsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 01:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrytV-0000Vl-FL
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 01:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab3FZXMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 19:12:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42889 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab3FZXMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jun 2013 19:12:51 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 27 Jun
 2013 01:12:42 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (204.16.157.26) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 27 Jun 2013 01:12:47 +0200
In-Reply-To: <CAFFjANQ_PoTT5bUrZ_0oARz=oZysJdMC1MAsHR2MCZVubfSbsw@mail.gmail.com>
	("Vicent \=\?utf-8\?Q\?Mart\=C3\=AD\=22's\?\= message of "Wed, 26 Jun 2013 00:30:06
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [204.16.157.26]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229069>

Vicent Mart=C3=AD <tanoku@gmail.com> writes:

> On Tue, Jun 25, 2013 at 5:58 PM, Thomas Rast <trast@inf.ethz.ch> wrot=
e:
>>
>> Please document the RLW format here.
>
> Har har. I was going to comment on your review of the Ewah patchset,
> but might as well do it here: the only thing I know about Ewah bitmap=
s
> is that they work. And I know this because I did extensive fuzz
> testing of my C port. Unfortunately, the original Java code I ported
> from has 0 comments, so any documentation here would have to be
> reverse-engineered.

I think the below would be a reasonable documentation, to be appended
after your description of the EWAH format.  Maybe Colby can correct me
if I got anything wrong.  You can basically read this off from the
implementation of ewah_each_bit() and the helper functions it uses.

-- 8< --
The compressed bitmap is stored in a form of run-length encoding, as
follows.  It consists of a concatenation of an arbitrary number of
chunks.  Each chunk consists of one or more 64-bit words

     H  L_1  L_2  L_3 .... L_M

H is called RLW (run length word).  It consists of (from lower to highe=
r
order bits):

     - 1 bit: the repeated bit B

     - 32 bits: repetition count K (unsigned)

     - 31 bits: literal word count M (unsigned)

The bitstream represented by the above chunk is then:

     - K repetitions of B

     - The bits stored in `L_1` through `L_M`.  Within a word, bits at
       lower order come earlier in the stream than those at higher
       order.

The next word after `L_M` (if any) must again be a RLW, for the next
chunk.  For efficient appending to the bitstream, the EWAH stores a
format to the last RLW in the stream.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
