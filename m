From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Fix tail option problem in test
Date: Mon, 23 Apr 2007 20:29:17 -0400
Message-ID: <462D4F5D.7010605@gmail.com>
References: <462D47CA.7010806@gmail.com> <7v4pn6d459.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 02:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8uM-00016i-FP
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030928AbXDXA3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030937AbXDXA3X
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:29:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:14920 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030928AbXDXA3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:29:22 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1992061wxd
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 17:29:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=di1aitidWAYLal8eeJBoSroxCydvo24Et42zqlbBBvPp5yXhsXEAaLF2wINWjhsr+ySRUr91h/LZUcCsn/g/ho+8Keb1QwBZS4li7/V/QcGBPOTfBJU5kiy3XdjxhoXefqGJgCNpQ+vz66BJk88KY9jwkXBC7tJkfEko37HtdaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EXZoB3Q++JDMs2RazB50BYkK+dRS6SOqV6PBR0b+4a2JOf8ACrRn4kT94e5z0T6B70+JE4x1jvc4IlVaSiVS7rzqXkMvuEsMS8uL84LJvDwjfDxdEjm7aD8Dkl2003kXoUy394EiOLFERNfG41ZxpQUVfkroNuI88DneEBXkFiI=
Received: by 10.70.129.5 with SMTP id b5mr3369736wxd.1177374562069;
        Mon, 23 Apr 2007 17:29:22 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id h8sm6941202wxd.2007.04.23.17.29.18;
        Mon, 23 Apr 2007 17:29:21 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7v4pn6d459.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45391>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> The tail command on my system complains:
>>
>> 	tail: cannot open `8192' for reading: No such file or directory
>>
>> if there is any whitespace between the '-c' option and the byte count.
>>
>> Signed-off-by: A Large Angry SCM <Gitzilla@gmail.com>
>> ---
>>
>>  t/t5302-pack-index.sh |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
>> index 232e5f1..b7870a8 100755
>> --- a/t/t5302-pack-index.sh
>> +++ b/t/t5302-pack-index.sh
>> @@ -16,7 +16,7 @@ test_expect_success \
>>           test-genrandom "$i" 8192 >>file_$i &&
>>           git-update-index --add file_$i || return 1
>>       done &&
>> -     echo 101 >file_101 && tail -c 8192 file_100 >>file_101 &&
>> +     echo 101 >file_101 && tail -c8192 file_100 >>file_101 &&
>>       git-update-index --add file_101 &&
>>       tree=`git-write-tree` &&
>>       commit=`git-commit-tree $tree </dev/null` && {
> 
> I do not like using tail to do a byte-oriented thing like this
> to begin with.  How about using the plain old trustworthy and
> portable program, "dd", instead?

It's not as easy to get the last X bytes of a file with dd.
