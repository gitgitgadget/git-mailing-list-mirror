From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 2 Apr 2006 15:14:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 00:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQAq1-0001ir-8o
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWDBWOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 18:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWDBWOW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 18:14:22 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:30124 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932423AbWDBWOW
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 18:14:22 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C8347> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 2 Apr 2006 15:14:20 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18291>

On Sun, 2 Apr 2006, Junio C Hamano wrote:

> I should have tried your pristine xdiff code myself before
> bothering you, but I haven't (sorry).
>
> The problem is from the "stripped down" version we use in git,
> so you may or may not see the problem in your version.  Attached
> are the files.

Yes, it does even vanilla libxdiff ;) It's not a problem though, since it 
is created in xdl_cleanup_records() that tries to do a fast pass over the 
records to try to simplify the real diff operation. In trying to be fast, 
only hashes are compared, and it happens that the hash for "'')" collides 
with another one (try to replace one of the "'')" chars with another one). 
Why is this not a problem? Because what this lead to is only lines to be 
marked as changed, with a probability of about N/2^(8 * sizeof(long) - 1), 
even though they are not. And this happens only during sequential groups 
of lines changed, that is when the hash-colliding line is either at the 
begin or the end of the run.



- Davide
