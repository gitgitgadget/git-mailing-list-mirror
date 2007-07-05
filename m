From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] WIP per-path attribute based hunk header selection.
Date: Thu, 05 Jul 2007 09:43:31 -0700
Message-ID: <7vwsxedcng.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
	<7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
	<7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707051223520.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 18:44:10 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6UR7-00021E-H4
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 18:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758573AbXGEQne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 12:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758703AbXGEQne
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 12:43:34 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58544 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758380AbXGEQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 12:43:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705164333.KARO1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Jul 2007 12:43:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KsjY1X00C1kojtg0000000; Thu, 05 Jul 2007 12:43:32 -0400
In-Reply-To: <Pine.LNX.4.64.0707051223520.9789@racer.site> (Johannes
	Schindelin's message of "Thu, 5 Jul 2007 12:25:36 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51683>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 4 Jul 2007, Junio C Hamano wrote:
>
>> diff --git a/diff.c b/diff.c
>> index 552f7c0..0c7d2c6 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -3011,21 +3079,6 @@ void diffcore_std(struct diff_options *options)
>>  	if (options->quiet)
>>  		return;
>>  
>> -	/*
>> -	 * break/rename count similarity differently depending on
>> -	 * the binary-ness.
>> -	 */
>> -	if ((options->break_opt != -1) || (options->detect_rename)) {
>> -		struct diff_queue_struct *q = &diff_queued_diff;
>> -		int i;
>> -
>> -		for (i = 0; i < q->nr; i++) {
>> -			struct diff_filepair *p = q->queue[i];
>> -			p->one->is_binary = file_is_binary(p->one);
>> -			p->two->is_binary = file_is_binary(p->two);
>> -		}
>> -	}
>> -
>>  	if (options->break_opt != -1)
>>  		diffcore_break(options->break_opt);
>>  	if (options->detect_rename)
>> diff --git a/diffcore-delta.c b/diffcore-delta.c
>> index a038b16..d9729e5 100644
>> --- a/diffcore-delta.c
>> +++ b/diffcore-delta.c
>> @@ -129,7 +129,7 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
>>  	struct spanhash_top *hash;
>>  	unsigned char *buf = one->data;
>>  	unsigned int sz = one->size;
>> -	int is_text = !one->is_binary;
>> +	int is_text = !diff_filespec_is_binary(one);
>>  
>>  	i = INITIAL_HASH_SIZE;
>>  	hash = xmalloc(sizeof(*hash) + sizeof(struct spanhash) * (1<<i));
>
> It is quite cute to hide this in the funcname patch...

That is why it is marked as WIP.
