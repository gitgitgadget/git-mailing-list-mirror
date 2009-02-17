From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Tue, 17 Feb 2009 10:56:36 -0600
Message-ID: <tJ6pp2ZnBjKVBLynGfYewBaGmSehbwZNLOShEvpXmtkD3IMXRugEKg@cipher.nrlssc.navy.mil>
References: <200902142056.42198.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org> <200902170944.08827.trast@student.ethz.ch> <200902170946.52093.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTHV-0000VW-Hc
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbZBQQ5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 11:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZBQQ5Y
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 11:57:24 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42355 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbZBQQ5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 11:57:24 -0500
Received: by mail.nrlssc.navy.mil id n1HGubEx021136; Tue, 17 Feb 2009 10:56:37 -0600
In-Reply-To: <200902170946.52093.trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Feb 2009 16:56:37.0441 (UTC) FILETIME=[B2605B10:01C99120]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110412>

Thomas Rast wrote:
> Thomas Rast wrote:
>> Junio C Hamano wrote:
>>> Thomas Rast <trast@student.ethz.ch> writes:
>>>
>>>> +	MSG=3 test_must_fail git notes edit
>>> test_must_fail is a shell function, and we have precedence 2d60615 (tests:
>>> Avoid single-shot environment export for shell function invocation,
>>> 2009-01-26) to avoid this construct.
>> I see you took this into the pu branch (currently as 891840b).  I
>> assumed you would simply drop it, given the incompatibility?  I'd
>> rather have the slight chance of missing a segfault while git is
>> trying to execute a shell script (what are the odds that it only does
>> so for git-notes?) than be killed by an angry mob of ash users ;-)
> 
> Oh, you fixed it up locally, and the next one in the series too.
> Thanks, and sorry for the noise!

Yeah, but what's this, introduced by 94859732?

t/t3301-notes.sh line 40:
test_expect_success 'refusing to edit in refs/heads/' '
        (MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
         export MSG= GIT_NOTES_REF=refs/heads/bogus &&
         test_must_fail git notes edit)
'

test_expect_success 'refusing to edit in refs/remotes/' '
        (MSG=1 GIT_NOTES_REF=refs/remotes/bogus &&
         export MSG= GIT_NOTES_REF=refs/heads/bogus &&
         test_must_fail git notes edit)
'


Notice the 'export' lines.  Comparing it to Thomas's v2 5/5 patch, it
looks like the first line which sets the variables is correct and the
export line should just be 'export MSG GIT_NOTES_REF' in both tests.

-brandon
