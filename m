From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/4] parse-remote: function to get the tracking branch  to be merge
Date: Tue, 09 Jun 2009 01:28:45 -0700
Message-ID: <7veittrete.fsf@alter.siamese.dyndns.org>
References: <1244451651-22651-2-git-send-email-santi@agolina.net>
	<7v8wk2wbfs.fsf@alter.siamese.dyndns.org>
	<adf1fd3d0906090029s2aa7fe19j7b1005997d70b92c@mail.gmail.com>
	<adf1fd3d0906090107w994de3chb39071e5911a59ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:29:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDwhb-0003Zu-51
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 10:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758759AbZFII2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 04:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758873AbZFII2u
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 04:28:50 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51850 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757589AbZFII2r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 04:28:47 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609082845.NVJI2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Tue, 9 Jun 2009 04:28:45 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1kUl1c0024aMwMQ04kUlRr; Tue, 09 Jun 2009 04:28:45 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=U35mGT9P0hAA:10 a=eDh-fbTsmFgA:10
 a=3yCQnsJiAAAA:8 a=LJzz24My68sfbW6PLwEA:9 a=XIxt-zf7glQKxi_nj4oA:7
 a=-emurs6BfMCchZn3lckxX7VqvIUA:4 a=cdoSpQTWPqQA:10
X-CM-Score: 0.00
In-Reply-To: <adf1fd3d0906090107w994de3chb39071e5911a59ae@mail.gmail.com>
 ("Santi =?utf-8?Q?B=C3=A9jar=22's?= message of "Tue\, 9 Jun 2009 10\:07\:22
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121155>

Santi B=C3=A9jar <santi@agolina.net> writes:

>> git pull --rebase tags v1.6.0
>
> In fact: git pull --rebase remote tags v1.6.0
>
> But this still works because oldremoteref defaults to defaults_merge.
> So the only behavior change is when a remote branch is
> rebased/retagged, and you have worst problems then. I think noone use=
d
> the rebased functionality in this way, so I don't think it is worth t=
o
> support it. But if someone think it is important I'll do it.

I personally do not think supporting such a form of input is absolutely
necessary.  Even though technically it might be a regression, if it is =
so
rare a form, we can simply say "this strange form used to work, but now=
 it
does not; you can use this form instead to do the same thing", and move
on.

However, at least we should describe the change, both in the commit log
and documentation.  Simply saying "No behaviour change" is not acceptab=
le,
when the code clearly is doing something else.  It needs to be backed b=
y
some explanation, e.g. "Even though this returns different results from
the original, the caller behaves the same because of such and such
reasons".

What caught my attention was not the difference between the new code an=
d
the original codepath, but your "FIXME" comment that said "Currently on=
ly
works with the default mapping".  My initial reaction was "What?  The n=
ew
code that introduces a function for the specific task of figuring out t=
he
mapping does not work if the user uses a custom mapping?  What kind of
improvement is that???".

The reaction was followed by "Even if that were the case, if the origin=
al
code did not work in the case anyway, then it is not a regression.  The
proposed commit log message claims that there is no behaviour change, s=
o
that FIXME might not be so grave an offense.  Is it really the case?  W=
as
the original broken?"

While trying to figure it out, I noticed that the new code does quite a
different thing (I still haven't figured out the answer to my original
question about FIXME, by the way).

In any case, if we were changing behaviour by deprecating support for a
rarely-if-ever used syntax, it would be nice if we at least diagnosed i=
t,
instead of failing, or worse yet, silently doing something different fr=
om
the old behaviour.
