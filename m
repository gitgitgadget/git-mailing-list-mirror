From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 17:49:24 -0500
Message-ID: <CAMP44s2iTBW3P25RCDQCoM02K1JTs9v6-8SG91MJeUxh4b1qEQ@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7vwqrlezcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 00:49:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWwt0-00025v-JT
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 00:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759245Ab3D2Wt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 18:49:26 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:34505 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233Ab3D2WtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 18:49:25 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so5881250lab.21
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vwoK8qlCXi67MIrJGuZSzvC1HQXjILFFffC+aBglE4c=;
        b=Cq11vmxk9/fREov6V3Twq5x8VF+BZWaHuQvnHFIcGXawGgQmZl9DLJZpz5sql0z8di
         Xb8sBYwxOspk7LwRn3VsjDCYCTc/EeMVBltsdzlpPlYedgJhqd6jTYN2tlb5yepybYIk
         0XCdd1vVNEk1ccvd3HPgG9jLmGuUcCuB7CQksp5QVeyDOGykV32kr9+nfh4z1xDsIYTD
         5D4fbl+OYVyQ/gILj/84p0I8iqKxorgRywO9uwNyDKkmZixir2YqkLtpOoH+i9aTk8z0
         3lYP536b+MIfrzM4t/PbEWt4xs5xO1rGb/J6Ku5Hf0RaLPuY4n6pVO7fA+k2JPqSrMa4
         7AIg==
X-Received: by 10.112.135.70 with SMTP id pq6mr986996lbb.82.1367275764238;
 Mon, 29 Apr 2013 15:49:24 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 15:49:24 -0700 (PDT)
In-Reply-To: <7vwqrlezcs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222873>

On Mon, Apr 29, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
>> index 813cc1b..426c63f 100755
>> --- a/t/t1503-rev-parse-verify.sh
>> +++ b/t/t1503-rev-parse-verify.sh
>> @@ -115,4 +115,13 @@ test_expect_success 'master@{n} for various n' '
>>       test_must_fail git rev-parse --verify master@{$Np1}
>>  '
>>
>> +test_expect_success 'empty @' '
>> +     rev_hash=$(git rev-parse --verify @) &&
>> +     test "$rev_hash" = "$HASH4" &&
>> +     rev_hash=$(git rev-parse --verify HEAD@) &&
>> +     test "$rev_hash" = "$HASH4" &&
>> +     rev_hash=$(git rev-parse --verify master@) &&
>> +     test "$rev_hash" = "$HASH4"
>> +'
>
> Don't we have different refs that resolve to something other than
> $HASH4 at this point in the test?

No.

> Otherwise we wouldn't notice a
> breakage because we cannot tell if HEAD@ and master@ are interpreted
> correctly or all of these happen to yield $HASH4 because a version
> somebody else patches to break the implementation in this patch
> discards any string before @ that is not followed by {stuff}.

        rev_hash=$(git rev-parse --verify HEAD@) &&
        test "$rev_hash" = "$HASH4" &&
        rev_hash=$(git rev-parse --verify master@) &&
-       test "$rev_hash" = "$HASH4"
+       test "$rev_hash" = "$HASH4" &&
+       test_must_fail git rev-parse --verify foo@

-- 
Felipe Contreras
