From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Does Git now have any C struct version history tracking mechanism?
Date: Mon, 19 Aug 2013 10:37:42 +0200
Message-ID: <87y57y84a1.fsf@linux-k42r.v.cablecom.net>
References: <CAHz2CGW_xR4Q193h2itCELdXEpoAxetj324ATstALHM03cSvFg@mail.gmail.com>
	<CAEY4ZpO3x-B7SKQa+Djtt_AfQ7y=nNBZ1sR9Gvv8d3FvQLK1PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zhan Jianyu <nasa4836@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 10:38:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKyP-0008Gs-5U
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 10:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125Ab3HSIh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Aug 2013 04:37:57 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:51848 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab3HSIh4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Aug 2013 04:37:56 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 19 Aug
 2013 10:37:41 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 19 Aug 2013 10:37:42 +0200
In-Reply-To: <CAEY4ZpO3x-B7SKQa+Djtt_AfQ7y=nNBZ1sR9Gvv8d3FvQLK1PA@mail.gmail.com>
	(Nazri Ramliy's message of "Mon, 19 Aug 2013 13:54:08 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232541>

Nazri Ramliy <ayiehere@gmail.com> writes:

> On Sun, Aug 18, 2013 at 6:33 PM, Zhan Jianyu <nasa4836@gmail.com> wro=
te:
>>   Such a requirement came into my mind when I am tracking a gloomy C
>> struct , with lengthy list of elements which are either elaborated o=
r
>> opaque. So I use git blame to track it down and found that its
>> original version is quite simple and intuitive. So I think I could
>> just slice out every snapshot of this struct, reading every changelo=
g
>> , to get a better knowledge of what it is and why it should be like
>> this.
>>
>> It seems quite helpful but the process is quite cumbersome. So I
>> wonder if there is already some mechanism fulfilling my requirement =
in
>> Git.  If it doesn't,  would it be worthy adding one ?
>
> It's already merged to git.git's master quite recently in
> ed73fe56428eecd2b635473f6a517a183c4713a3 (back in June).
>
> You'd invoke git log like this:
>
>     $ git log -L :struct_or_function_name:filename.c
>
> and it will show you the commits and the specific hunks that affect
> the struct or function name.
>
> It's still a bit rough on the edges, for example, doing the following
> in git.git:
>
>     $ git log -L :rev_cmdline_info:revision.h
>
> Shows three commits (a765499, ca92e59 and 281eee4) where the second
> one does not touch the struct at all (if you do "git show ca92e59" yo=
u
> might gain an insight as to how -L works).

Hmm, IIUC that's actually not a bug or even a roughness; it's an
artifact of how the :pattern:file syntax is defined.  It takes the firs=
t
_funcname line_ matching 'pattern', up to (but excluding) the next
funcname line.

The default funcname rule (in the absence of any patterns) does not
match '#define...' on account of the '#'.  The default funcname pattern
for 'cpp' (if you manually configured your git.git repo to set this
attribute; it doesn't by default) never matches a leading '#=C2=B4 eith=
er.
So it's no surprise that the tracked range extends a few more lines
after the struct.

Or is there an issue that I'm missing?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
