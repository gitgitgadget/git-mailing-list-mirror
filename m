From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v2] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 11:48:36 -0800
Message-ID: <CAO2U3QgmuwatfDDO8f461cwq2SctPx+owL8gDMBpNyDcaxaWGQ@mail.gmail.com>
References: <1415918419-20807-1-git-send-email-blume.mike@gmail.com> <546656C8.3070009@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:49:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpMre-0004PU-2F
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 20:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161830AbaKNTs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 14:48:58 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:41616 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161304AbaKNTs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 14:48:58 -0500
Received: by mail-ob0-f170.google.com with SMTP id nt9so14243561obb.15
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 11:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ON18wyQkv9pozZx2gsDvrdZph9WBDa3uBxDqAGN5PJQ=;
        b=I65knC5zSNmz7zeh68SOFaU3BX1fulZo/zDh7BzMLRQ02oqp2NdmK/I9hGGEs/zQZ1
         jFxO+IqDZu4iD1oOFhImA+cp/wkHR+scIC4VK+nUlvfGlCXMrHFtfGDsjbI6LQm8qgU5
         sHlsJbnZaOSDONCggOvyHKR/v1o3psn9Go8yuOM2SLXQoF8f7Ce9qZ57Lyjrv0KGbxkG
         yhMdA1k6siyp9VYrBExk1CuB1Rw7OOSpW2HRhC0iWR/jPFMnEmI0rtbMk+uwtngWauuO
         p8CyrPABTQXk1JSOajLud5BVQiqbxRM/zd9aeNr+jYKoxF1FbBDqj3nsPIt0Nx/dFeEE
         y2Lg==
X-Received: by 10.182.125.3 with SMTP id mm3mr9297285obb.7.1415994537305; Fri,
 14 Nov 2014 11:48:57 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Fri, 14 Nov 2014 11:48:36 -0800 (PST)
In-Reply-To: <546656C8.3070009@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My understanding is that && and || have equal precedence, and this
seems to be borne out in testing at my shell. If the if/then method is
clearer I'm happy to go with that.

On Fri, Nov 14, 2014 at 11:23 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 13.11.2014 um 23:40 schrieb Mike Blume:
>> listed bug doesn't reproduce on Mac OS Yosemite. For now, just enable
>> TTY on Yosemite and higher
>>
>> Signed-off-by: Mike Blume <blume.mike@gmail.com>
>> Improved-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  t/lib-terminal.sh | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
>> index 5184549..6395a34 100644
>> --- a/t/lib-terminal.sh
>> +++ b/t/lib-terminal.sh
>> @@ -29,7 +29,10 @@ test_lazy_prereq TTY '
>>       # After 2000 iterations or so it hangs.
>>       # https://rt.cpan.org/Ticket/Display.html?id=65692
>>       #
>> -     test "$(uname -s)" != Darwin &&
>> +     # Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
>> +     # appears to be gone.
>> +     #
>> +     test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1)" -ge 14 &&
>
> This is part of an &&-chain; you can't just throw in a || in the middle.
>
> How about
>
>         if test "$(uname -s)" = Darwin
>         then
>                 test "$(uname -r | cut -d. -f1)" -ge 14
>         fi &&
>
>>
>>       perl "$TEST_DIRECTORY"/test-terminal.perl \
>>               sh -c "test -t 1 && test -t 2"
>>
>
> -- Hannes
>
