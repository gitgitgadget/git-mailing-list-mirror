From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/22] rollback_lock_file(): set fd to -1
Date: Sun, 06 Apr 2014 23:45:06 +0200
Message-ID: <5341CAE2.8040600@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>	<1396367910-7299-5-git-send-email-mhagger@alum.mit.edu>	<20140401195930.GC21715@sigill.intra.peff.net> <xmqqtxabwtw8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 23:45:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWusP-0005sE-9G
	for gcvg-git-2@plane.gmane.org; Sun, 06 Apr 2014 23:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbaDFVpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 17:45:13 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53674 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754571AbaDFVpK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 17:45:10 -0400
X-AuditID: 12074411-f79ab6d000002f0e-dd-5341cae59428
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 94.FD.12046.5EAC1435; Sun,  6 Apr 2014 17:45:09 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36Lj7jL006868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 17:45:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqqtxabwtw8.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqPv0lGOwwb4bRhZdV7qZLBp6rzBb
	/GjpYXZg9njWu4fR4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDNePrAruMVf0Xm7mbWB8TZP
	FyMnh4SAicSmI9uZIWwxiQv31rN1MXJxCAlcZpT4fHERlHOOSeLirV0sIFW8AtoS036uB+tg
	EVCV+L7sKzuIzSagK7Gop5mpi5GDQ1QgSOLPWUWIckGJkzOfgLWKCDhKnHhwnRWkhFlAXKL/
	H1hYWMBWYs+xl6wQq24ySuxfdhBsJKeAtUTroXOMIPUSQPU9jUEgYWYBHYl3fQ+YIWx5ie1v
	5zBPYBSchWTbLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pSuokR
	Es6COxhnnJQ7xCjAwajEw7vikGOwEGtiWXFl7iFGSQ4mJVHe7pNAIb6k/JTKjMTijPii0pzU
	4kOMEhzMSiK8miZAOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBO86
	kKGCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiNLwbGL0iKB2jvCZB23uKCxFyg
	KETrKUZdjg3b1jQyCbHk5eelSonzBoMUCYAUZZTmwa2AJa9XjOJAHwvzTgGp4gEmPrhJr4CW
	MAEtaQizA1lSkoiQkmpgFFrMvXxuqdhM69aDzb06MWf9w0uVzt2VWKBW1aZbtsjwIN/5f4Hd
	DE/Pxq9xyebtv1h5Qf/4/6MrNk6eWaQmyPDpbdD8AvlrIVL+Ws/Mr3i3Giku8lZ/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245793>

On 04/02/2014 06:58 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Apr 01, 2014 at 05:58:12PM +0200, Michael Haggerty wrote:
>>
>>> When rolling back the lockfile, call close_lock_file() so that the
>>> lock_file's fd field gets set back to -1.  This could help prevent
>>> confusion in the face of hypothetical future programming errors.
>>
>> This also solves a race. We could be in the middle of rollback_lock_file
>> when we get a signal, and double-close. It's probably not a big deal,
>> though, since nobody could have opened a new descriptor in the interim
>> that got the same number (so the second close will just fail silently).
>>
>> Still, this seems like a definite improvement.
> 
> This is probably related to my comments on 2/22, but is "fd" the
> only thing that has a non-zero safe value?  Perhaps lock_file_init()
> that clears the structure fields to 0/NULL and fd to -1, and a
> convenience function lock_file_alloc() that does xmalloc() and then
> calls lock_file_init() may help us a bit when the lockfile structure
> is reused?

The first use of a lock_file object necessarily passes through
lock_file().  The only precondition for that function is that the
on_list field is zero, which is satisfied by a xcalloc()ed object.

Subsequent uses of a lock_file object must *not* zero the object.
lock_file objects are added to the lock_file_list and never removed.  So
zeroing a lock_file object would discard the rest of the linked list.
But subsequent uses must also pass through lock_file(), which sees that
on_list is set, and assumes that the object is in a self-consistent
state as left by commit_lock_file() or rollback_lock_file().

At least that's how it is supposed to work.  But lock_file objects are
in fact not cleaned up correctly in all circumstances.  The next version
of this patch series will work to fix that.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
