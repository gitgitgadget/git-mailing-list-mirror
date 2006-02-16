From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Wed, 15 Feb 2006 23:56:38 -0700
Message-ID: <m1ek23rduh.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
	<7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
	<1139685031.4183.31.camel@evo.keithp.com> <43EEAEF3.7040202@op5.se>
	<1139717510.4183.34.camel@evo.keithp.com> <43EF15D1.1050609@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Feb 16 07:58:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9d5Y-0004xA-8D
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 07:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWBPG6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 01:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWBPG6A
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 01:58:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30620 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932478AbWBPG57 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 01:57:59 -0500
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k1G6ug82030636;
	Wed, 15 Feb 2006 23:56:42 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k1G6uc9D030635;
	Wed, 15 Feb 2006 23:56:38 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43EF15D1.1050609@op5.se> (Andreas Ericsson's message of "Sun,
 12 Feb 2006 12:02:41 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16275>

Andreas Ericsson <ae@op5.se> writes:

> Keith Packard wrote:
>> On Sun, 2006-02-12 at 04:43 +0100, Andreas Ericsson wrote:
>>
>>>A weird oddity; Cloning is faster over rsync, day-to-day pulling is not.
>> Precisely. If the protocol could deliver existing packs instead of
>> unpacking and repacking them, then git would be as fast as rsync and I
>> wouldn't have to worry about supporting two protocols.
>>
>
> Caching features have been discussed, but that means the daemon needs to have
> write-access to some directory within the repository. It would also work poorly
> for projects that see very rapid development unless the cached pack-files can be
> amended to. A sort of "create packs on demand". It shouldn't be too difficult,
> really.

Actually for the clone case we don't need a writable directory for the
git-daemon. 

If we assume that a repository up for download is reasonably packed,
we can just lob all of the packs in the current repository, and then
pack the few remaining objects and send them.

I don't know how well multiple packs will work with the current git
protocol but it should be pretty natural, and the clone case is easy
detect as there are no heads in common.  Can that be detected quickly?

I don't have a patch but it feels like a pretty straight forward thing
to implement.

Eric
