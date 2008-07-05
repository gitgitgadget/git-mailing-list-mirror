From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH/RFC] Fix some warnings (on cygwin) to allow -Werror
Date: Sat, 05 Jul 2008 21:35:59 +0100
Message-ID: <486FDB2F.3050800@ramsay1.demon.co.uk>
References: <486CF5A9.5060104@ramsay1.demon.co.uk> <7vskuquisp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 00:37:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFGNd-0008EB-ON
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 00:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbYGEWgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 18:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYGEWgX
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 18:36:23 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:4048 "EHLO
	anchor-post-35.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752270AbYGEWgX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jul 2008 18:36:23 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.67)
	id 1KFGDo-0005Zh-JG; Sat, 05 Jul 2008 22:27:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vskuquisp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87474>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Despite the subject line, this should be useful on any system for
>> which uint32_t is defined to be unsigned long rather than
>> unsigned int. (and where the return type of htonl() is similarly
>> defined).
> 
> Correct.  Perhaps "Use %PRIu32 and such to print integers of fixed length"?
> 
> The only worry I have with this patch is with systems with not-so-ANSI
> headers; as you noticed, we already have:
> 
>         #ifndef PRIuMAX
>         #define PRIuMAX "llu"
>         #endif
> 
> in git-compat-util.h, which does include <inttypes.h>, so PRIu32 and
> friends could be problematic on these platforms.
> 

Yes, I had the same worry, since I did not know which system(s) required
the above #ifdef and, perhaps more important, why.  Having said that, I
suspect (hope?) that the affected system(s) are somewhat rare.  I guess
it would not be long before someone complained otherwise...

[Note: I can't just blame the above #ifdef because I don't have a real
git repo ;-) - it would simply blame me!]

>> @@ -1718,7 +1720,8 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
>>  static void prepare_pack(int window, int depth)
>>  {
>>  	struct object_entry **delta_list;
>> -	uint32_t i, n, nr_deltas;
>> +	uint32_t i, nr_deltas;
>> +	unsigned n;
> 
> Hmm.  Is this change necessary?
> 

Yes, otherwise:

builtin-pack-objects.c: In function `prepare_pack':
builtin-pack-objects.c:1760: warning: passing arg 2 of `find_deltas' from incompatible pointer type
make: *** [builtin-pack-objects.o] Error 1

Note that ll_find_deltas() is #defined to find_deltas() in the #else arm
of #ifdef THREADED_DELTA_SEARCH, and find_deltas() takes an "unsigned *"

ATB,

Ramsay Jones
