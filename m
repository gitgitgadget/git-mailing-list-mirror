From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 02/10] ref-filter: add option to pad atoms to the right
Date: Thu, 30 Jul 2015 15:48:17 +0530
Message-ID: <CAOLa=ZR2z1JJnNZr1qr-Bk6JL0p9ghnEAkCKvrvrkQaBOBsyHg@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438065211-3777-1-git-send-email-Karthik.188@gmail.com> <1438065211-3777-2-git-send-email-Karthik.188@gmail.com>
 <CAPig+cS4zVT2=kuV3yc860vp4fKrqzvM_phyNngSUho9zTzStA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"Matthieu.Moy@grenoble-inp.fr" <Matthieu.Moy@grenoble-inp.fr>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 12:18:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKkvN-0004tt-Fi
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 12:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbbG3KSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 06:18:48 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33635 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571AbbG3KSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 06:18:47 -0400
Received: by obdeg2 with SMTP id eg2so27457330obd.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xss3WbV025rBNs6Gy9lKLHXsXN5P7gLzY4Wn8bUpSpM=;
        b=nTxZRSV9EZEsoAP4WNyEDrHBK16vpd9gszndczfvVJ5Vg31U9DeB+js7CZyzkyI+6U
         ffz9TYlCP9w7k4v5nbL+uGfqdmvRuoN/eFoOBiE86cK7iXQYROXOcLc1Fj5455lQvJ2q
         +RKOeWGEY+CxNk9tg3lM9yMcEzcohjibMc1QM1PPuuIlX04lfgs9y8keqjGdEGmW2q0b
         BHPPhCTzAkLnhNCddLr/Ej0gM/mqn7IhNFuV6h3T0nl7ls7P2qihKZJIPn6x9u6K+Pl3
         L8pwc6rgngcsffqXBGeSaBy79rEhxcM0jJYiqPrr3G8AGYMy+FWbIffNT0AAkGzHxVpm
         tx4Q==
X-Received: by 10.182.153.161 with SMTP id vh1mr44209584obb.34.1438251526595;
 Thu, 30 Jul 2015 03:18:46 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 30 Jul 2015 03:18:17 -0700 (PDT)
In-Reply-To: <CAPig+cS4zVT2=kuV3yc860vp4fKrqzvM_phyNngSUho9zTzStA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274980>

On Thu, Jul 30, 2015 at 12:59 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tuesday, July 28, 2015, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a new atom "padright" and support %(padright:X) where X is a
>> number.  This will align the succeeding atom value to the left
>> followed by spaces for a total length of X characters. If X is less
>> than the item size, the entire atom value is printed.
>>
>> Add tests and documentation for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> index 505a360..19ac480 100755
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -81,4 +81,20 @@ test_expect_success 'filtering with --contains' '
>>         test_cmp expect actual
>>  '
>>
>> +test_expect_success 'padding to the right using `padright`' '
>> +       cat >expect <<-\EOF &&
>> +       refs/heads/master|refs/heads/master        |refs/heads/master|
>> +       refs/heads/side|refs/heads/side          |refs/heads/side|
>> +       refs/odd/spot|refs/odd/spot            |refs/odd/spot|
>> +       refs/tags/double-tag|refs/tags/double-tag     |refs/tags/double-tag|
>> +       refs/tags/four|refs/tags/four           |refs/tags/four|
>> +       refs/tags/one|refs/tags/one            |refs/tags/one|
>> +       refs/tags/signed-tag|refs/tags/signed-tag     |refs/tags/signed-tag|
>> +       refs/tags/three|refs/tags/three          |refs/tags/three|
>> +       refs/tags/two|refs/tags/two            |refs/tags/two|
>> +       EOF
>> +       git for-each-ref --format="%(refname)%(padright:25)|%(refname)|%(refname)|" >actual &&
>
> This fails to test the important case when the atom length is greater
> than the padright value (in which case no padding should be done, and
> the atom text should extend beyond the 'padright' column).
>

Will add a test for the same, thanks :)

-- 
Regards,
Karthik Nayak
