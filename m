From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Fri, 23 Dec 2011 23:49:49 +0100
Message-ID: <87mxaihpiq.fsf@thomas.inf.ethz.ch>
References: <cover.1322830368.git.trast@student.ethz.ch>
	<5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
	<CACBZZX6hboo4wu3fOs+CHnxsdmedxw72GFMVttQzmHzpcZbqoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 23:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReDwB-0006Nf-Ow
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 23:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900Ab1LWWt7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Dec 2011 17:49:59 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:15337 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757873Ab1LWWt6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Dec 2011 17:49:58 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Dec
 2011 23:49:53 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Dec
 2011 23:49:55 +0100
In-Reply-To: <CACBZZX6hboo4wu3fOs+CHnxsdmedxw72GFMVttQzmHzpcZbqoQ@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 23 Dec
 2011 23:37:55
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187644>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Dec 2, 2011 at 14:07, Thomas Rast <trast@student.ethz.ch> wro=
te:
>
>> I conjecture that this is caused by contention on
>> read_sha1_mutex. [...] So disable threading entirely when not
>> scanning the worktree
>
> Why does git-grep even need to keep a mutex to call read_sha1_file()?
> It's inherently a read-only operation isn't it? If the lock is needed
> because data is being shared between threads in sha1_file.c shouldn't
> we tackle that instead of completely disabling threading?

The problem is that all sorts of data is shared.  See

  http://thread.gmane.org/gmane.comp.version-control.git/186618

But I need to go through it again, there are some races and double lock=
s
in the posted version.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
