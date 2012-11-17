From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/6] completion: consolidate test_completion*() tests
Date: Sat, 17 Nov 2012 21:26:00 +0100
Message-ID: <CAMP44s2ppLttMkqBDQ6ROnMfMyRUUq371LCH+FWOvKX-uE4=SA@mail.gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
	<1352644558-9410-5-git-send-email-felipe.contreras@gmail.com>
	<7v7gplktdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 21:26:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZoy0-0006n6-DG
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 21:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab2KQU0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 15:26:01 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53800 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab2KQU0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 15:26:00 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3813416obb.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JnLpGozJFzhDQS/3mKH6XdEYw1johYuLLzoQHklR9nI=;
        b=hcefSrPyFdB5WT5rWWQGTTWDAkq8RoZFmXpqOVHGwPoyCOZ2Rs4ZiF8FBqvvlCTcsG
         WrxTBCc4wQraH7vMw1gaogDjRgQys57zcpzPhBVmy6+miKiFXFCNBvVbAsNpd6jF9okj
         wcZMEIp5ZZHa1jJ+0slNxzxXD75Q8vUxO4ozP7caOfSVBGMHshl0/J4Kh1+bZfhXYpvj
         JLsYUn8/Ly8J68WMIvs/Ujf4C54a4Sax3LBqDos7pHTrzVPNUOae519mo4yAQZWhlG1e
         FfVGghH+d71vNiNIVbf04ZMFUO4PZUv6kE+jCNuzdT23PMPfb1qXZx1bmOEFrDtDS/YY
         nrRw==
Received: by 10.60.12.233 with SMTP id b9mr7150250oec.95.1353183960172; Sat,
 17 Nov 2012 12:26:00 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 12:26:00 -0800 (PST)
In-Reply-To: <7v7gplktdt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209979>

On Sat, Nov 17, 2012 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> No need to have two versions; if a second argument is specified, use
>> that, otherwise use stdin.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  t/t9902-completion.sh | 30 +++++++++++++-----------------
>>  1 file changed, 13 insertions(+), 17 deletions(-)
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 204c92a..59cdbfd 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -60,19 +60,15 @@ run_completion ()
>>  # 2: expected completion
>>  test_completion ()
>>  {
>> -     test $# -gt 1 && echo "$2" > expected
>> +     if [ $# -gt 1 ]; then
>> +             echo "$2" > expected
>> +     else
>> +             sed -e 's/Z$//' > expected
>> +     fi &&
>
> As "$2" could begin with dash, end with \c, etc. that possibly can
> be misinterpred by echo, I'd rewrite this as
>
>                 printf '%s\n' "$2" >expected
>
> Otherwise looked fine; thanks.

But that was the case before. I would do that in a separate patch.

Cheers.

-- 
Felipe Contreras
