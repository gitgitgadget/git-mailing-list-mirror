From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 12/22] delete_ref_loose(): don't muck around in the lock_file's
 filename
Date: Wed, 02 Apr 2014 13:50:46 +0200
Message-ID: <533BF996.7010804@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-13-git-send-email-mhagger@alum.mit.edu> <20140401202118.GG21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:32:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeNO-0000xS-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758613AbaDBLuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 07:50:51 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:62876 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758407AbaDBLuu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 07:50:50 -0400
X-AuditID: 1207440d-f79d86d0000043db-3f-533bf999f83c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 47.D7.17371.999FB335; Wed,  2 Apr 2014 07:50:49 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s32Bok4U020611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 07:50:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <20140401202118.GG21715@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqDvzp3Wwwbad7BZdV7qZLBp6rzBb
	/GjpYXZg9njWu4fR4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDNOPG5jLbjNWXFqxxXWBsYr
	7F2MnBwSAiYS/+b3skLYYhIX7q1n62Lk4hASuMwo8frMOWYI5xyTxPfXjcwgVbwC2hIb1rwG
	6uDgYBFQlVjVpAcSZhPQlVjU08wEYosKBEkc3nCKFaJcUOLkzCcsILaIgKzE98MbGUFsZgFr
	iRWvDzOBjBEWiJPoWakAsWo1o0Tb9mY2kBpOoJq1T/8wg9RICIhL9DQGgZjMAuoS6+cJQUyR
	l9j+dg7zBEbBWUiWzUKomoWkagEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU
	0k2MkGDm3cH4f53MIUYBDkYlHt6D562ChVgTy4orcw8xSnIwKYnyHvhhHSzEl5SfUpmRWJwR
	X1Sak1p8iFGCg1lJhHfSJ6Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaD
	Q0mC9y7IUMGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQ7MYXA6MXJMUDtPfYd5C9
	xQWJuUBRiNZTjLocG7ataWQSYsnLz0uVEuf1BNkhAFKUUZoHtwKWul4xigN9LMx7BKSKB5j2
	4Ca9AlrCBLSEe50VyJKSRISUVANj8Y69+2wCG3/fNbvacyXfIabYi1HFTCB7j/2ud1fr1JPk
	FPY6rd++9L2lBdOE72e2JB7aqH93d+md7+eYDRNPnb1d/LkotTh6Xf21/stH4+Yn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245681>

On 04/01/2014 10:21 PM, Jeff King wrote:
> On Tue, Apr 01, 2014 at 05:58:20PM +0200, Michael Haggerty wrote:
> 
>> It's bad manners.  Especially since, if unlink_or_warn() failed, the
>> memory wasn't restored to its original contents.
>>
>> So make our own copy to work with.
> 
> Sounds good...
> 
>>  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>> -		/* loose */
>> -		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
>> -
>> -		lock->lk->filename[i] = 0;
>> -		err = unlink_or_warn(lock->lk->filename);
>> -		lock->lk->filename[i] = '.';
>> +		/*
>> +		 * loose.  The loose file name is the same as the
>> +		 * lockfile name, minus ".lock":
>> +		 */
>> +		char *loose_filename = xmemdupz(lock->lk->filename,
>> +						strlen(lock->lk->filename) - 5);
>> +		int err = unlink_or_warn(loose_filename);
>> +		free(loose_filename);
> 
> Should we be using LOCK_SUFFIX_LEN from the previous commit here?

LOCK_SUFFIX_LEN is not in scope to this file, and I think it should stay
that way.  But never fear; this figuring-out-filename-from-lockfile-name
nonsense is gone by the end of the patch series.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
