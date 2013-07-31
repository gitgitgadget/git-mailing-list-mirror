From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH gitk 0/4] gitk support for git log -L
Date: Wed, 31 Jul 2013 15:17:41 +0200
Message-ID: <87siyu98cq.fsf@linux-k42r.v.cablecom.net>
References: <cover.1370806329.git.trast@inf.ethz.ch>
	<874nblpamj.fsf@linux-k42r.v.cablecom.net>
	<874nbdnomj.fsf@hexa.v.cablecom.net> <51F6CB7D.1070806@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 31 15:17:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4WHk-0006zG-LM
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 15:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab3GaNRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 09:17:44 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:46823 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310Ab3GaNRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 09:17:43 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 15:17:37 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 31 Jul 2013 15:17:41 +0200
In-Reply-To: <51F6CB7D.1070806@web.de> (Jens Lehmann's message of "Mon, 29 Jul
	2013 22:07:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231419>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 29.07.2013 21:37, schrieb Thomas Rast:
>> Thomas Rast <trast@inf.ethz.ch> writes:
>> 
>>> Thomas Rast <trast@inf.ethz.ch> writes:
>>>
>>>> Now that git log -L has hit master, I figure it's time to discuss the
>>>> corresponding change to gitk.
>>>
>>> Paul, any news on this?  Any chance we can get it into the next release,
>>> since that will also be the first release to ship with 'git log -L'?
>> 
>> Jens pointed out privately that the handling of unstuck -L options is
>> unfortunate, to put it mildly.  I'll send a reroll.
>
> But as soon as that is fixed I'd really like to see this applied, as
> I think gitk is the perfect tool to show history information.

Unfortunately it's turning out to be harder than I hoped.  gitk runs the
arguments through git-rev-parse, which only knows that -n gets an
unstuck argument.  Consequently, gitk accepts an unstuck -n but only
stuck forms of -S and -G.

Fixing it through git-rev-parse feels wrong; rev-parse is supposed to
know about rev-list options, but -S and -G only make sense in
diff-generating walks, and -L only makes any sense at all for git-log.

I'm tempted to leave it at the existing patches for now.  That does mean
that -L can only be used in the stuck form; it's the same for -S and -G
already.  Then in a later series we can change gitk's argument parsing
to properly treat the options directly, passing only the remaining
arguments through to rev-parse to use the usual revision/filename
distinction logic.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
