From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 2 Apr 2006 20:26:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604022022390.10401@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 05:27:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQFio-0001AN-Ml
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 05:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWDCD1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 23:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWDCD1D
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 23:27:03 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:38060 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751199AbWDCD1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 23:27:02 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C8397> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 2 Apr 2006 20:26:58 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18304>

On Sun, 2 Apr 2006, Linus Torvalds wrote:

>
>
> On Sun, 2 Apr 2006, Davide Libenzi wrote:
>>
>> Yes, it does even vanilla libxdiff ;) It's not a problem though, since it is
>> created in xdl_cleanup_records() that tries to do a fast pass over the records
>> to try to simplify the real diff operation. In trying to be fast, only hashes
>> are compared, and it happens that the hash for "'')" collides with another one
>> (try to replace one of the "'')" chars with another one). Why is this not a
>> problem? Because what this lead to is only lines to be marked as changed, with
>> a probability of about N/2^(8 * sizeof(long) - 1), even though they are not.
>> And this happens only during sequential groups of lines changed, that is when
>> the hash-colliding line is either at the begin or the end of the run.
>
> Hmm. It's still ugly, though. No possibility to have a "clean up identical
> initial and final lines" stage to get rid of extraneous bogus diffs?

It does ;) If you make the second hunk (the one with the '') line) to be 
the first, the shrink-initial-and-final lines optimizations will make it 
eat the '') line.


> I look at diffs a lot, and while this may be rare, if I were to end up
> having to wonder what the difference is and it turns out that it's just
> due to a libxdelta thing, I'd be a bit irritated and wish it gave me a
> proper diff..

Tomorrow I'll take a look at it.


- Davide
