From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 3/8] t5520: test for failure if index has unresolved entries
Date: Thu, 21 May 2015 16:15:24 +0800
Message-ID: <CACRoPnT8qLnjW2BAsOeqWQUPZPSmLgXOtnyVZg0Pn-ijweowZA@mail.gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
	<1431955978-17890-4-git-send-email-pyokagan@gmail.com>
	<d3f29ef8736ae4c077b754ec6e410308@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 10:15:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvLdo-0002TE-SX
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 10:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbbEUIPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 04:15:35 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:32979 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbbEUIPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 04:15:25 -0400
Received: by lagr1 with SMTP id r1so96763805lag.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PrbvXR2bxxypl4dXD8lwojdEk5DWf0jLOdw0icIHSHw=;
        b=bVGVWp1hdmVx73TavSFcDUyMTq1hoqAAeyursKXaJdVklEUv7qoWCFd9cRYmH5r9Wb
         T03NHHIgcridqLSvZPnl8HpFJw9wkpL3kovlZOJYFxEPTKe6UScPKD7+K1UIM/El6MuF
         eMqZ6AIwRHy1Ga6Yzpx+XpWF1vt3iLdh6hE4cwnFPgH2w9nPw6mC9eBWEqzyJU4qQxzV
         jOsOQ3cxS6w828y+WzNH0GTj2+beymBB5HUT+PHfnBsp59Ijw43ndYE3dRF41nH+GvQB
         8MqOvfkuurWInWH7i7i7IGf8rTLJIjDsBcsTetvddn2pi2FgsWBa9MMXpA9rPZ9s3HBs
         4V5g==
X-Received: by 10.152.6.105 with SMTP id z9mr1174522laz.98.1432196124155; Thu,
 21 May 2015 01:15:24 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 21 May 2015 01:15:24 -0700 (PDT)
In-Reply-To: <d3f29ef8736ae4c077b754ec6e410308@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269568>

Hi,

On Mon, May 18, 2015 at 11:13 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Paul,
>
> On 2015-05-18 15:32, Paul Tan wrote:
>
>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index 4a2c0a1..3bc0594 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -164,6 +164,26 @@ test_expect_success 'fail if upstream branch does
>> not exist' '
>>       test "$(cat file)" = file
>>  '
>>
>> +test_expect_success 'fail if the index has unresolved entries' '
>> +     git checkout -b third second^ &&
>> +     test_when_finished "git checkout -f copy && git branch -D third" &&
>
> If you agree with my argument in 2/8, it would be nice to drop this line, too.

As mentioned by Junio in 2/8 the cleanup functions will not run under
--immediate mode.

Besides, the use of test_when_finished is to send a clear signal that
the "third" branch is temporary and is not meant to be used by other
test cases. Furthermore, subsequent tests assume that the current
branch is "copy", so it's best to preserve that.

>> +     test "$(cat file)" = file &&
>> +     echo modified2 >file &&
>> +     git commit -a -m modified2 &&
>
> These two lines could be combined into "test_commit modified2 file".

Fixed, thanks.

Regards,
Paul
