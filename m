From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 03/10] replace: add test for --graft
Date: Tue, 08 Jul 2014 07:36:51 +0200 (CEST)
Message-ID: <20140708.073651.595198574881163961.chriscool@tuxfamily.org>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.9611.chriscool@tuxfamily.org>
	<xmqqmwckbyri.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	jnareb@gmail.com, sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 08 07:36:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4O5J-0003So-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 07:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbaGHFgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 01:36:54 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:42326 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbaGHFgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 01:36:53 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 48D8134;
	Tue,  8 Jul 2014 07:36:52 +0200 (CEST)
In-Reply-To: <xmqqmwckbyri.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253003>

From: Junio C Hamano <gitster@pobox.com>

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  t/t6050-replace.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
>> index fb07ad2..d80a89e 100755
>> --- a/t/t6050-replace.sh
>> +++ b/t/t6050-replace.sh
>> @@ -18,6 +18,33 @@ add_and_commit_file()
>>      git commit --quiet -m "$_file: $_msg"
>>  }
>>  
>> +commit_buffer_contains_parents()
> 
> SP before (), perhaps?

Ok.

>> +{
>> +    git cat-file commit "$1" >payload &&
>> +    sed -n -e '/^$/q' -e '/^parent /p' <payload >actual &&
>> +    shift &&
>> +    : >expected &&
>> +    for _parent
>> +    do
>> +	echo "parent $_parent" >>expected || return 1
>> +    done &&
> 
> You can redirect the entire loop to simplify the above 5 lines,
> which would read better, no?
> 
> 	for _parent
>         do
> 		echo "parent $_parent"
> 	done >expect

Ok, thanks.
 
>> +    test_cmp actual expected
> 
> As "test_cmp" normally runs "diff", it is better to compare expect
> with actual, not the other way around; running the test verbosely,
> i.e. "t6050-replace.sh -v", shows how the actual output differs from
> what is expected when diagnosing breakage and would be more useful
> that way.

Ok.

> If your goal is to test both the object contents with this code
> *and* the overall system behaviour with the "$child^$parent" below,
> perhaps they should be in the same "commit_has_parents" function,
> without forcing the caller to choose between the two or call both,
> no?

Yeah, will do.

Thanks,
Christian.
