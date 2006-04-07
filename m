From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Fri, 07 Apr 2006 11:31:47 -0700
Message-ID: <7vhd55jkz0.fsf@assigned-by-dhcp.cox.net>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
	<Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
	<Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
	<7vhd55ls24.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604071002530.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 07 20:31:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRvkT-0006iu-I4
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 20:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWDGSbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 14:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWDGSbv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 14:31:51 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:28559 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964850AbWDGSbu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 14:31:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060407183148.IKVZ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Apr 2006 14:31:48 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604071002530.2215@localhost.localdomain> (Nicolas
	Pitre's message of "Fri, 07 Apr 2006 10:11:38 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18500>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 7 Apr 2006, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@osdl.org> writes:
>> 
>> > On Mon, 3 Apr 2006, Linus Torvalds wrote:
>> >> 
>> >> That said, I think git _does_ have problems with large pack-files. We have 
>> >> some 32-bit issues etc
>> >
>> > I should clarify that. git _itself_ shouldn't have any 32-bit issues, but 
>> > the packfile data structure does. The index has 32-bit offsets into 
>> > individual pack-files. 
>> >
>> > That's not hugely fundamental,...
>> 
>> Linus _does_ understand what he means, but let me clarify and
>> outline a possible future direction.
>
> For the record, the delta code also has 32-bit limitations of its own 
> presently.  It cannot encode a delta against a buffer which is larger 
> than 4GB.
>
> I however made sure the byte 0 could be used as a prefix for future 
> encoding extensions, like 64-bit file offsets for example.

True the delta data representation, not just the "delta code",
has that limitation, but I do not think you issue "insert 0-byte
literal data" command from the deltifier side right now, so we
should be OK.

Maybe we would want to check (cmd == 0) case to detect delta
extension that we do not handle right now?
