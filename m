From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Fri, 13 May 2011 11:41:46 -0700
Message-ID: <BANLkTi=smoaARKyzWxFjid-E7qehmyAX8w@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
 <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com> <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com>
 <BANLkTi=NdVUUZ=_bACzyeMGS3JWs0EMbWA@mail.gmail.com> <BANLkTimE2GkkhcFZtNrYZASWp0LDhUx=GQ@mail.gmail.com>
 <BANLkTinyzBnksHk_rt8K2pmg90q5WyZX3w@mail.gmail.com> <BANLkTinVT=9+-HhwXcyLBwrnhX9F9Qz3ww@mail.gmail.com>
 <4DCD79A0.7000500@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Lutomirski <luto@mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org, Shuang He <shuang.he@intel.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 20:42:49 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKxK4-0007uQ-Sm
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 20:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359Ab1EMSml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 14:42:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53495 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061Ab1EMSmj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 14:42:39 -0400
Received: from mail-vw0-f46.google.com (mail-vw0-f46.google.com [209.85.212.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4DIg7U4015764
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL);
	Fri, 13 May 2011 11:42:08 -0700
Received: by vws1 with SMTP id 1so2024371vws.19
        for <multiple recipients>; Fri, 13 May 2011 11:42:06 -0700 (PDT)
Received: by 10.52.176.136 with SMTP id ci8mr2413046vdc.234.1305312126058;
 Fri, 13 May 2011 11:42:06 -0700 (PDT)
Received: by 10.52.181.98 with HTTP; Fri, 13 May 2011 11:41:46 -0700 (PDT)
In-Reply-To: <4DCD79A0.7000500@kdbg.org>
X-Spam-Status: No, hits=-102.977 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173559>

On Fri, May 13, 2011 at 11:34 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 13.05.2011 19:54, schrieb Linus Torvalds:
>> For example, in your case, since you had certain requirements of
>> support that simply didn't exist earlier, something like
>>
>> =A0 =A0git bisect requires v2.6.38
>>
>> would have been really useful - telling git bisect that any commit
>> that cannot reach that required commit is not even worth testing.
>
> You can already have this with
>
> =A0 git bisect good v2.6.38
>
> It sounds a bit unintuitive, but with a slight mind-twist it can even=
 be
> regarded as correct in a mathematical sense: when the precondition is
> false, the result is true. ;-)

No. That's not the same thing AT ALL.

When you say that v2.6.38 is good, that means that everything that can
be reached from 2.6.38 is good.

NOT AT ALL the same thing as "git bisect requires v2.6.38" would be.

The "requires v2.6.38" would basically say that anything that doesn't
contain v2.6.38 is "off-limits". It's fine to call them "good", but
that's not the same thing as "git bisect good v2.6.38".

Why?

Think about it. It's the "reachable from v2.6.38" vs "cannot reach
v2.6.38" difference. That's a HUGE difference.

                       Linus
