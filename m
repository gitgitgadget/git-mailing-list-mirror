From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Thu, 25 Apr 2013 21:59:13 +0200
Message-ID: <87bo92nzzi.fsf@hexa.v.cablecom.net>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<7vliaxwa9p.fsf@alter.siamese.dyndns.org>
	<CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
	<51781455.9090600@gmail.com>
	<87sj2f6n1u.fsf@linux-k42r.v.cablecom.net>
	<CAKXa9=rvDQ7DXwCiTp9PTc55gNTW2UDZ4auaYG5tbboomrDAGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSK9-0001Qg-Pl
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801Ab3DYT7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:59:17 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:24472 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317Ab3DYT7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:59:16 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 21:59:11 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 21:59:14 +0200
In-Reply-To: <CAKXa9=rvDQ7DXwCiTp9PTc55gNTW2UDZ4auaYG5tbboomrDAGQ@mail.gmail.com>
	(Robert Zeh's message of "Thu, 25 Apr 2013 14:37:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222427>

Robert Zeh <robert.allan.zeh@gmail.com> writes:

> On Thu, Apr 25, 2013 at 3:18 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>
>> I don't get this bit.  The lstat() are run over all files listed in the
>> index.  So shouldn't your daemon watch exactly those (or rather, all
>> dirnames of such files)?
> I believe that fill_directory is handling watching only files in the index.
> I had some problems a while back when I was only watching the
> directory with some of the inotify structures coming back empty, which
> is why I started watching each individual file.

This probably doesn't scale well enough.  For example on my system the
maximum number of watches I can set[1] is 64k.  linux.git contains 38k
files and the total number of files in all repos of an android clone I
have lying around is almost 300k.

Can you clarify what went wrong if you only watch directories?  After
all the events should be the same, except that you need to reassemble
the actual filename from the 'name' field in inotify_event and the
directory name associated with the watch descriptor.

I'll keep the rest of your mail for another reply ;-)

[1]  /proc/sys/fs/inotify/max_user_watches

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
