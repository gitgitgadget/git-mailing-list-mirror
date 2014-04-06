From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/22] lock_file(): always add lock_file object to lock_file_list
Date: Sun, 06 Apr 2014 23:54:59 +0200
Message-ID: <5341CD33.3000205@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-8-git-send-email-mhagger@alum.mit.edu> <20140401201659.GE21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 23:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWv2c-0007SS-7x
	for gcvg-git-2@plane.gmane.org; Sun, 06 Apr 2014 23:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbaDFVzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 17:55:04 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61656 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575AbaDFVzC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 17:55:02 -0400
X-AuditID: 12074412-f79d46d000002e58-f7-5341cd35d69f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E3.6C.11864.53DC1435; Sun,  6 Apr 2014 17:55:01 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36Lsx9f007307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 17:55:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140401201659.GE21715@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqGt61jHYYMJmaYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BlT3u9gLtgqXDH12x/2BsY5
	/F2MnBwSAiYS9xa9ZIewxSQu3FvP1sXIxSEkcJlRYseCUywQzjkmibnv+plAqngFtCUmX53I
	CmKzCKhKtG/rYwOx2QR0JRb1NAPVcHCICgRJ/DmrCFEuKHFy5hMWEFtEQFbi++GNjCA2s4C1
	xIrXh8FGCguESjxsOcIEsWsVo0TvoSvMIHM4gYr+/coBMSUExCV6GoNATGYBdYn184QgpshL
	bH87h3kCo+AsJMtmIVTNQlK1gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrp
	JkZIMAvtYFx/Uu4QowAHoxIP74pDjsFCrIllxZW5hxglOZiURHnVzgCF+JLyUyozEosz4otK
	c1KLDzFKcDArifBqmgDleFMSK6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbBZGU4OJQk
	ePeBDBUsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxW58MTB6QVI8QHungbTzFhck
	5gJFIVpPMepybNi2ppFJiCUvPy9VSpxXHaRIAKQoozQPbgUsdb1iFAf6WJh3AUgVDzDtwU16
	BbSECWhJQ5gdyJKSRISUFDA5nQx+3PX+xPtNO1It4oOabbItQj0mTLKXmHu/+Nt3mx7f4GvZ
	l8xDpA8dT9ORzDh1JepAtMz8006FsQFvpxQd2VuYf4xLprM6/bGJZ66deNs9tvvf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245794>

On 04/01/2014 10:16 PM, Jeff King wrote:
> On Tue, Apr 01, 2014 at 05:58:15PM +0200, Michael Haggerty wrote:
> 
>> diff --git a/lockfile.c b/lockfile.c
>> index e679e4c..c989f6c 100644
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -130,6 +130,22 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>>  	 */
>>  	static const size_t max_path_len = sizeof(lk->filename) - 5;
>>  
>> +	if (!lock_file_list) {
>> +		/* One-time initialization */
>> +		sigchain_push_common(remove_lock_file_on_signal);
>> +		atexit(remove_lock_file);
>> +	}
>> +
>> +	lk->owner = getpid();
>> +	if (!lk->on_list) {
>> +		/* Initialize *lk and add it to lock_file_list: */
>> +		lk->fd = -1;
>> +		lk->on_list = 1;
>> +		lk->filename[0] = 0;
>> +		lk->next = lock_file_list;
>> +		lock_file_list = lk;
>> +	}
> 
> Initializing here is good, since we might be interrupted by a signal at
> any time. But what about during the locking procedure? We do:
> 
>     strcpy(lk->filename, path);
>     if (!(flags & LOCK_NODEREF))
>             resolve_symlink(lk->filename, max_path_len);
>     strcat(lk->filename, ".lock");
> 
> So for a moment, lk->filename contains the name of the valuable file we
> are locking.  If we get a signal at that moment, do we accidentally
> delete it in remove_lock_file?
> 
> I think the answer is "no", because we check lk->owner before deleting,
> which will not match our pid (it should generally be zero due to xcalloc
> or static initialization, though perhaps we should clear it here).
> 
> But that makes me wonder about the case of a reused lock. It will have
> lk->owner set from a previous invocation, and would potentially suffer
> from this problem. In other words, I think the change you are
> introducing does not have the problem, but the existing code does. :-/

Good point.  Yes, I agree that this is a problem in the existing code
and that it wasn't improved by my work.

> I didn't reproduce it experimentally, though.  We should be able to just
> 
>     lk->owner = 0;
> 
> before the initial strcpy to fix it, I would think.

I think that using the owner field to avoid this problem is a bit
indirect, so I will soon submit a fix that involves adding a flag to
lock_file objects indicating whether the filename field currently
contains the name of a file that needs to be deleted.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
