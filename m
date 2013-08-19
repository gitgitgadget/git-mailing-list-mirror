From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH gitk 0/4] gitk support for git log -L
Date: Mon, 19 Aug 2013 10:21:38 +0200
Message-ID: <874namay5p.fsf@linux-k42r.v.cablecom.net>
References: <cover.1370806329.git.trast@inf.ethz.ch>
	<874nblpamj.fsf@linux-k42r.v.cablecom.net>
	<874nbdnomj.fsf@hexa.v.cablecom.net> <51F6CB7D.1070806@web.de>
	<87siyu98cq.fsf@linux-k42r.v.cablecom.net>
	<20130818115456.GA6772@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>, <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Aug 19 10:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKif-0006up-OT
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 10:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab3HSIVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 04:21:42 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:33092 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab3HSIVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 04:21:41 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 19 Aug
 2013 10:21:36 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 19 Aug 2013 10:21:38 +0200
In-Reply-To: <20130818115456.GA6772@iris.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sun, 18 Aug 2013 21:54:57 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232536>

Paul Mackerras <paulus@samba.org> writes:

> Hi Thomas,
>
> On Wed, Jul 31, 2013 at 03:17:41PM +0200, Thomas Rast wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>> > Am 29.07.2013 21:37, schrieb Thomas Rast:
>> >> Thomas Rast <trast@inf.ethz.ch> writes:
>> >> 
>> >>> Thomas Rast <trast@inf.ethz.ch> writes:
>> >>>
>> >>>> Now that git log -L has hit master, I figure it's time to discuss the
>> >>>> corresponding change to gitk.
[...]
>
> One thing I worry about is having gitk storing in memory not just the
> history graph but also all the diffs (assuming I have understood
> correctly what you're doing).  Gitk's memory consumption is already
> pretty large.  However, I can't see an alternative at this point.

I don't think there is one.  log -L is pretty much an "all or nothing"
thing at this point.  I suppose if we really found that the diffs are
regularly too big to be manageable for gitk, we could invent a porcelain
mode where 'log -L' just prints the detected commits and corresponding
line ranges, and then have a new option to diff-tree to let it again
filter that range.

But note that ordinary 'git log -L' also buffers the entire set of diffs
within less.  The memory consumption of gitk to hold the same diffs in
memory should be only a small factor of what less uses in the same
scenario.  Furthermore, users will typically ask for a small region of
code (one function, or some such), so the diffs themselves are usually
quite small, nowhere near the size of the full commit diffs.

>> Unfortunately it's turning out to be harder than I hoped.  gitk runs the
>> arguments through git-rev-parse, which only knows that -n gets an
>> unstuck argument.  Consequently, gitk accepts an unstuck -n but only
>> stuck forms of -S and -G.
>
> Excuse my ignorance, but what do you mean by "stuck" vs. "unstuck"?

Whether the option value is a separate argument in argv, or directly
stuck to the option.

stuck:   gitk -L:foo:main.c
unstuck: gitk -L :foo:main.c

Existing gitk chokes on 'gitk -S foo', but works with 'git -Sfoo'.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
