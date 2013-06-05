From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 07/11] t2100: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Wed, 05 Jun 2013 22:23:02 +0200
Message-ID: <51AF9E26.4050809@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org> <e232ae3efc6f7b282d4402e6e6976b34d34ab3e7.1370076477.git.j6t@kdbg.org> <7v8v2p5y7o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 22:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkKEg-0004uq-PD
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 22:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757338Ab3FEUXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 16:23:05 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:50698 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757234Ab3FEUXF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 16:23:05 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F129F130045;
	Wed,  5 Jun 2013 22:23:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 798C219F5E4;
	Wed,  5 Jun 2013 22:23:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7v8v2p5y7o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226469>

Am 05.06.2013 00:04, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> @@ -62,12 +57,7 @@ test_expect_success 'git update-index to add conflicting file path2 should fail'
>>  
>>  test_expect_success 'git update-index to add conflicting symlink path3 should fail' '
>>  
>> -	if test_have_prereq SYMLINKS
>> -	then
>> -		ln -s xyzzy path3
>> -	else
>> -		date >path3
>> -	fi &&
>> +	test_ln_s xyzzy path3 &&
>>  	test_must_fail git update-index --add -- path3
>>  '
> 
> This is also borderline questionable.  With path2, we are already
> testing that adding a regular file (one variant of "non directory")
> at a path that the index expects to see a directory (the index has
> path2/file2 in it at this point) fails,...

You are right, of course. But again, the issue is not new with this patch.

> If we want to really test the equivalent on a filesystem without
> symbolic links, it would be a more faithful test to attempt to add
> it using "--add --cacheinfo" and see it fail, i.e.
> 
>    test_must_fail_to_ln_s_add xyzzy path3
> 
> which would be a copy of test_ln_s_add but has test_must_fail before
> two calls to git_update_index it makes.

That's not necessary, IMO. We can just add an unconditional --cache-info
test here and add SYMLINKS to the above test.

> I think all the test_ln_s_add conversion in the series make sense,
> but many uses of test_ln_s are questionable, and I suspect it would
> invite similar confusion down the road.

Incidentally, I've been running the test_ln_s_add conversions since,
whoa!, two years now, but added test_ln_s only when I cleaned up the
patch for submission. Perhaps it's better when I rip out test_ln_s again.

-- Hannes
