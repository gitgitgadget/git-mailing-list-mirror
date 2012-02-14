From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git status: small difference between stating whole repository and small subdirectory
Date: Tue, 14 Feb 2012 12:34:07 +0100
Message-ID: <8762f9k5sg.fsf@thomas.inf.ethz.ch>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 12:34:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxGeZ-0005Ud-0q
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 12:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471Ab2BNLeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 06:34:24 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:52713 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755172Ab2BNLeM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 06:34:12 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 14 Feb
 2012 12:34:06 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 14 Feb
 2012 12:34:08 +0100
In-Reply-To: <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	(Piotr Krukowiecki's message of "Fri, 10 Feb 2012 17:18:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190714>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> On Fri, Feb 10, 2012 at 10:42 AM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>> I compared stating whole tree vs one small subdirectory, and I
>> expected that for the subdirectory status will be very very fast.
>> After all, it has only few files to stat. But it's not fast. Why?
>>
>>
>> With cold cache (echo 3 | sudo tee /proc/sys/vm/drop_caches):
>>
>> $ time git status =C2=A0 =C2=A0> /dev/null
>> real =C2=A0 =C2=A00m41.670s
>> user =C2=A0 =C2=A00m0.980s
>> sys =C2=A0 =C2=A0 0m2.908s
>>
>> $ time git status -- src/.../somedir =C2=A0 > /dev/null
>> real =C2=A0 =C2=A00m17.380s
>> user =C2=A0 =C2=A00m0.748s
>> sys =C2=A0 =C2=A0 0m0.328s
[...]
> I can't reproduce this behavior at the moment. 'status' on the
> directory takes about 1.5s instead of 17s. status on whole repository
> takes 27s.
> This is my work repository, so it was changed today.

To me these timings smell like a combination of either a network
filesystem or a slow/busy disk, and non-packed repositories.  Next time
this happens look at 'git count-objects', run 'git gc' and redo the
timings.

If you are indeed on a network filesystem, also look at the
core.preloadIndex setting.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
