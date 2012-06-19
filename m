From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v7 0/5] git log -L, all new and shiny
Date: Tue, 19 Jun 2012 12:11:42 +0200
Message-ID: <87wr33wqzl.fsf@thomas.inf.ethz.ch>
References: <cover.1339063659.git.trast@student.ethz.ch>
	<7vlijpchm2.fsf@alter.siamese.dyndns.org>
	<8762as4sax.fsf@thomas.inf.ethz.ch>
	<7v1ulgd2f5.fsf@alter.siamese.dyndns.org>
	<7v1ulf94nq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 12:11:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgvPa-00026B-6y
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 12:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab2FSKLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 06:11:46 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:20628 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab2FSKLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 06:11:45 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 12:11:40 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 12:11:42 +0200
In-Reply-To: <7v1ulf94nq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 15 Jun 2012 23:01:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200193>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> This would be the first backwards coupling between the revision-walk and
>>> the diff generation parts, at least that I know of.
>>
>> I am not convinced if you need to have any unusual back-coupling to
>> begin with, by the way.
>>
>> If you say "git log -p [--options] -- pathspec", the revision
>> machinery does filter commits that do not touch any paths that patch
>> pathspec with the TREESAME logic, but that does not necessarily mean
>> you will see _all_ the commits that are not TREESAME.
[...]
> The revision machinery looks at C and finds its parent B.  It runs
> object level tree comparison and finds that their trees are
> different at path F.  It makes a mental note that it may need to
> show the log message of C, and asks the diff machinery to run
> diff-tree between B and C.  The diff machinery finds that it needs
> to show something even in the presense of -w option by actual
> comparison, and just before showing the very first line of patch
> output, it shows the log message of C (due to the earlier "mental
> note").
>
> Then the revision machinery looks at B.  It does the same between B
> and A, but this time around, the diff machinery finds that, even
> though A and B were _not_ TREESAME at the revision traversal level,
> there is nothing to be shown after filtering with the -w option.
> Hence no patch is shown and log message for B is not shown, either.

Thanks for the great explanations.

Having spent some time letting this sink in (and being busy doing other
things), I think it's actually a good idea.  It forces us to go back and
change it around so that the diff machinery gets a say _before_ we
simplify history.  I think this bit will be important for log -L history
to make sense, and it's a bug waiting to happen for the -w case.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
