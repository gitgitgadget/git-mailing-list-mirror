From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 13:53:14 +0100
Message-ID: <7E3714CE-0073-4E42-A455-36D595946A6C@zib.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> 
 <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 13:53:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFqih-0004Am-T1
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 13:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbYARMw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 07:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757287AbYARMw3
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 07:52:29 -0500
Received: from mailer.zib.de ([130.73.108.11]:56368 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759331AbYARMw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 07:52:28 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0ICqEPd021140;
	Fri, 18 Jan 2008 13:52:14 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0ICqAEe008571
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 18 Jan 2008 13:52:14 +0100 (MET)
In-Reply-To: <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71011>


On Jan 18, 2008, at 11:40 AM, Junio C Hamano wrote:

> Here is an update to the list I sent earlier.  Topics that I
> thought may deserve attention, discussion and eventual inclusion
> but are not 1.5.4 material.
>
> I think some of them actually have a slight chance of being
> 1.5.4 material, if interested parties present good enough
> arguments that they are actually good and safe bugfixes.
>
[...]
>
>  * crlf (Steffen Prohaska and Dmitry Potapov)


I am working on an alternative to the patch I sent last week.
I hope I can present the two approaches soon.

The first approach is a lazy check in crlf_to_git() that warns
about an irreversible conversion; or dies if safecrlf=true.  This
is relatively simple code but at least for git-add a workaround
is needed to suppress printing a warning twice.  The runtime
overhead is negligible.

The second approach adds a new machinery is_worktree_crlfsafe()
that could be run independently of the crlf_to_git() conversion.
The code doing the conversion would stay unmodified.  The
advantage is that the whole work tree could be verified before
any conversion actually happens and we could die() after printing
all the warnings instead of printing only the first one.  The
drawback is that this approach most likely needs more code and
will introduce runtime overhead.  A straight forward
implementation would add another pass over the work tree running
the stats in convert.c.  So the stats would be run twice.
And for a simple "git add <file>" the situation is even worse:
the full work tree would be verified even is only a single file
is to be added.

I haven't found time during the week, so I'll continue to work
on this over the weekend.  Maybe even more time is needed to
discuss the two alternatives.

I do not expect that this topic will be ready for 1.5.4.

	Steffen
