From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Tue, 28 Aug 2012 10:12:57 +0200
Message-ID: <877gsjmo3a.fsf@thomas.inf.ethz.ch>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
	<878vd5k7uu.fsf@thomas.inf.ethz.ch>
	<7va9xfpyyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:13:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6GvF-0007oO-ET
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab2H1INI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:13:08 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:43309 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab2H1INF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:13:05 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 28 Aug
 2012 10:13:01 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 28 Aug
 2012 10:13:01 +0200
In-Reply-To: <7va9xfpyyf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 27 Aug 2012 18:50:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204400>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> diff --git i/commit.c w/commit.c
>> index 65a8485..70427ab 100644
>> --- i/commit.c
>> +++ w/commit.c
>> @@ -837,10 +837,13 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
>>  	struct commit_list *bases, *b;
>>  	int ret = 0;
>>  
>> -	if (num == 1)
>> -		bases = get_merge_bases(commit, *reference, 1);
>> -	else
>> +	if (num != 1)
>>  		die("not yet");
>> +
>> +	bases = merge_bases_many(commit, 1, reference);
>> +	clear_commit_marks(commit, all_flags);
>> +	clear_commit_marks(*reference, all_flags);
>> +	
>>  	for (b = bases; b; b = b->next) {
>>  		if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
>>  			ret = 1;
>
> This ended up being part of the series I sent earlier, and I want to
> assign authorship to you. As you did this as part of the discussion,
> naturally the patch came without a sign-off.  Can we consider it
> signed off?  Just saying "ok" is fine.

Sure:

  ok

;-)

I'm also mildly surprised that it ended up being correct, albeit with
some extra work from you :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
