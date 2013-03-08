From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 08 Mar 2013 00:15:17 -0800
Message-ID: <7v7glijoiy.fsf@alter.siamese.dyndns.org>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
 <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
 <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh>
 <7vhaljudos.fsf@alter.siamese.dyndns.org>
 <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
 <513911B3.7010903@web.de> <7vr4jqkb9g.fsf@alter.siamese.dyndns.org>
 <51398CD5.1070603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 08 09:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDsT4-0001JF-By
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 09:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab3CHIPV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 03:15:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab3CHIPU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Mar 2013 03:15:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FB8CB896;
	Fri,  8 Mar 2013 03:15:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fgc2n0Gx1s6b
	Fl2pf05xuw4Sac4=; b=aUpjaHM7GwfnsghvmgdIf+zI65c6gabshDakOUCLDhh+
	2HdOcUKHLQ9rafQP3tfsOXX19NBGM01t991pwXr54IwLLAIP4WcpyALXOdndcLoi
	1lr7em9pTkH0cNh5K+aJ0YHjpILrxVS8splg05A/1ZboZciaDg7d4Ad3q9YjVug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=io6dZB
	7ufmv8diqbJcCJnomqzPubaxlZWfYIrl2efhNmnLbXyKi6BwGgckEtAXPN6AxhDj
	TH+rLoGLnAY5OJe0yoOwpkMRCBhNbYPekGio+k+9ZRx6lvCWrMCAYhPCWUoRrk/N
	a40SWm3PCeuxEM4WVNLo/op2royir1Li8xWH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D75B894;
	Fri,  8 Mar 2013 03:15:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F62DB892; Fri,  8 Mar 2013
 03:15:19 -0500 (EST)
In-Reply-To: <51398CD5.1070603@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Fri, 08 Mar 2013 08:01:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50CCCC6E-87C8-11E2-8696-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217646>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Doesn't this make one wonder why a separate bit and implementation
>> is necessary to say "I am not interested in untracked files" when
>> "-uno" option is already there?
> ...
> I need to admit that I wasn't aware about "git status -uno".

Not so fast.  I did not ask you "Why do you need a new one to solve
the same problem -uno already solves?"

> Thinking about it, how many git users are aware of the speed penalty
> when running git status to find out which (tracked) files they had ch=
anged?
>
> Or to put it the other way, when a developer wants a quick overview
> about the files she changed, then git status -uno may be a good and f=
ast friend.
>
> Does it make sence to stress put that someway in the documentation?
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.=
txt
> index 9f1ef9a..360d813 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -51,13 +51,18 @@ default is 'normal', i.e. show untracked files an=
d directori
>  +
>  The possible options are:
>  +
> -       - 'no'     - Show no untracked files
> +       - 'no'     - Show no untracked files (this is fastest)

There is a trade-off around the use of -uno between safety and
performance.  The default is not to use -uno so that you will not
forget to add a file you newly created (i.e safety).  You would pay
for the safety with the cost to find such untracked files (i.e.
performance).

I suspect that the documentation was written with the assumption
that at least for the people who are reading this part of the
documentation, the trade-off is obvious.  In order to find more
information, you naturally need to spend more cycles.

If the trade-off is not so obvious, however, I do not object at all
to describing it. But if we are to do so, I do object to mentioning
only one side of the trade-off.  People who choose "fastest" needs
to be made very aware that they are disabling "safety".

That brings us back to the "Why a separate implementation when -uno
is there?" question.

Your patch adds new code; it does not just enables the same logic as
what the existing -uno does with a new flag.  Does the new compute
different things?  Does it find more stuff by spending extra cycles?
Does it find less stuff by being extra faster?

These questions are important.

If the new option strikes the trade-off between safety and
performance at a point different from the point where the existing
-uno option does, it _might_ still be worth adding as a separate
option.  I didn't get that impression when I saw the patch, but I
admit that I did not follow the code carefully myself.

That is the reason why I was wondering why a separate bit and
implementation had to be added by the patch.
