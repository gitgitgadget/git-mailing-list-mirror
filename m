From: David Kastrup <dak@gnu.org>
Subject: Re: Profiling support?
Date: Tue, 11 Feb 2014 21:53:31 +0100
Message-ID: <87zjlx9xro.fsf@fencepost.gnu.org>
References: <87d2itc2zv.fsf@fencepost.gnu.org>
	<CACsJy8BAD3cm2BLSapJ2fhkGiYjDKqW1TQ1yu0XPwTyEfL2oLQ@mail.gmail.com>
	<878uthbtjg.fsf@fencepost.gnu.org>
	<20140211151451.GA15032@serenity.lan>
	<874n45brs4.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 11 21:54:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDKLW-0001Mu-PK
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 21:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbaBKUyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 15:54:16 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:60930 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbaBKUyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 15:54:12 -0500
Received: from localhost ([127.0.0.1]:59971 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDKLL-00064S-M0; Tue, 11 Feb 2014 15:54:11 -0500
Received: by lola (Postfix, from userid 1000)
	id E734EE0846; Tue, 11 Feb 2014 21:53:31 +0100 (CET)
In-Reply-To: <874n45brs4.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 11 Feb 2014 16:19:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241961>

David Kastrup <dak@gnu.org> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> On Tue, Feb 11, 2014 at 03:41:55PM +0100, David Kastrup wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>> > Would perf help? No changes required, and almost no overhead, I think.
>>> 
>>> Not useful.  It would be probably nice for nailing down the performance
>>> gains when the work is finished so that future regressions will be
>>> noticeable.  It's reasonable easy to create a test case that will take
>>> hours with the current git-blame and would finish in seconds with the
>>> improved one.
>>> 
>>> But it's not useful at all for figuring out the hotspots within the
>>> git-blame binary.
>>
>> I would have thought the annotation described at [1] is exactly what
>> you're looking for, isn't it?
>>
>> Alternatively, I've had some success with callgrind and kCachegrind in
>> the past.
>>
>> [1]
>> https://perf.wiki.kernel.org/index.php/Tutorial#Source_level_analysis_with_perf_annotate
>
> Misunderstanding on my part.  I thought this was about the "make perf"
> Makefile target.  I'll have to take a look at what the perf utility
> does.
>
> Thanks for the clarification.

Looks indeed like it could be useful.  In the currently working code
from me (last of the complex patch series), significant time is spent in
moving and allocating memory.  It might make sense not to continue
ignoring the patch I proposed to get rid of the absurd realloc series in
builtin/blame.c.  While it may not be responsible for all of avoidable
allocation churn, it's still large and untypical enough to mask further
culprits.

-- 
David Kastrup
