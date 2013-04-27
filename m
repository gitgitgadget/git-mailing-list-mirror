From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Sat, 27 Apr 2013 15:51:08 +0200
Message-ID: <87r4hwdqur.fsf@hexa.v.cablecom.net>
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
	<87bo92nzzi.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 15:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW5XA-0004lr-UC
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab3D0NvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 09:51:11 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:10127 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343Ab3D0NvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:51:10 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 27 Apr
 2013 15:51:05 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 27 Apr
 2013 15:51:08 +0200
In-Reply-To: <87bo92nzzi.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Thu, 25 Apr 2013 21:59:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222650>

Thomas Rast <trast@inf.ethz.ch> writes:

> Robert Zeh <robert.allan.zeh@gmail.com> writes:
>
>> On Thu, Apr 25, 2013 at 3:18 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>>
>>> I don't get this bit.  The lstat() are run over all files listed in the
>>> index.  So shouldn't your daemon watch exactly those (or rather, all
>>> dirnames of such files)?
>> I believe that fill_directory is handling watching only files in the index.
>> I had some problems a while back when I was only watching the
>> directory with some of the inotify structures coming back empty, which
>> is why I started watching each individual file.
>
> This probably doesn't scale well enough.  For example on my system the
> maximum number of watches I can set[1] is 64k.  linux.git contains 38k
> files and the total number of files in all repos of an android clone I
> have lying around is almost 300k.

[I just sent something similar as a reply to a mail that I then noticed
was sent off-list, but I meant it to be public.]

I just had a change of heart.  It's probably better for the early work
if you make a very controllable, single-repository daemon.  Perhaps one
that only starts on demand (by running some git command) and runs until
again killed on demand.

That way it's much easier to test, and integrate as an option in the
test suite.  And for single-repo-minded people, like (I guess?) the
kernel and webkit folks, this should already provide some benefit.

The per-user daemon complication can come later; we know even at this
point that it will have to be done *eventually*, but let's go one step
at a time.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
