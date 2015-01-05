From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv9 1/9] receive-pack.c: shorten the execute_commands loop
 over all commands
Date: Mon, 5 Jan 2015 10:02:23 -0800
Message-ID: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
	<1419982898-23108-2-git-send-email-sbeller@google.com>
	<20150103022004.GI29365@google.com>
	<CACsJy8DGS2KN5Vd=UY2nUBH1Nc9rMiTt84HNB9K=8z2H0m4zVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 19:02:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Bz7-0003Wh-PH
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 19:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbbAESC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 13:02:27 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50410 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbbAESCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 13:02:24 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so19969381iec.29
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NT3oKZf6gFijVwg3H2QkV3k/dAoBc2dL9f2sDc7pvww=;
        b=o2dQ2scwaj6Fo00ujXF/KHx/OKrenDmZXhtKyv4Am8vRzMgxmxRNXB5xDaENOqulBb
         IbUFOg+fByNuNax4WdU8xitq6CHMJ3aQGyvYS3dLYg41ppHfDj30Y3plz9LxWnlbpoxG
         eRYK4eL/ndXlyGmDEZYh5xrxyEpLVQs2KnBTFmwH3cpUALXCrfTAyuTq0tZi3xu2cOTo
         Rvp9ExgFhsKE/wqvEOcXPAxk/YHvJ+CahUkj7Ar+Hg/JM2oj9LlACnpHYYB0xp6IRAn1
         NSpC+yvYDT0GqBJiX5hqNq4mJvBNS3Cmlezx6u8uWgs1Eet8/5MAMJTm1Ixej2vsArPc
         rTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NT3oKZf6gFijVwg3H2QkV3k/dAoBc2dL9f2sDc7pvww=;
        b=FbC6Mdo8vlkbQMtFWCttFrITIvTnZPeAhzVhAo0EqH4eE+vR2/23b4JLjCSaxGJHJP
         vf4O0mWnLxzE3cidOHkSVlNG0y6NMeiUVcnKdXb8xNvHWX/kS6YeFk3phd1LOoRsQmJN
         vS6ATBXiKfB5rm8nBXQmEcjF+x88LiIb9wmz6ZVVYuUyXYJjjravaPt+EM+ibgTU/IQg
         bhKK5mlwW3g8cOb0AGUisXs8kI5Eyq1kqlx7wE+YBk6AdAsy2052SFEAR3LLQqCP3wfB
         kOIKjwP/83YmD1bpKXqS9eu1X3fiCi0pUiHBjAqIKg2xwoYh14Sy3BfvtMk/RIQ5jkLG
         DQrg==
X-Gm-Message-State: ALoCoQnPwsb077LjyUFtRKxPRkZTsybQRYze1PD8YALT4tNxjc5Kj69M2pPcEPNIMkC5S2Xdv+LL
X-Received: by 10.43.154.196 with SMTP id lf4mr67687041icc.95.1420480943438;
 Mon, 05 Jan 2015 10:02:23 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 5 Jan 2015 10:02:23 -0800 (PST)
In-Reply-To: <CACsJy8DGS2KN5Vd=UY2nUBH1Nc9rMiTt84HNB9K=8z2H0m4zVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262023>

On Sat, Jan 3, 2015 at 1:53 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jan 3, 2015 at 9:20 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> -     if (shallow_update && !checked_connectivity)
>>> -             error("BUG: run 'git fsck' for safety.\n"
>>> -                   "If there are errors, try to remove "
>>> -                   "the reported refs above");
>>> +     if (shallow_update)
>>> +             check_shallow_bugs(commands, si);
>>
>> In the same spirit of saving the reader from having to look at the
>> body of check_shallow_bugs, would it make sense for the part that reacts
>> to an error to be kept in the caller?  E.g.:
>>
>>         if (shallow_update && warn_if_skipped_connectivity_check(commands, si))

The intention of that patch is to move the code unrelated to executing commands
out of execute_commands. And I feel this error checking is not the core task of
executing commands, hence it should be moved out completely. Having one part
in  warn_if_skipped_connectivity_check and then the other error part
triggered by
an unsuccessful return doesn't improve the situation IMHO.

I think about moving the check for shallow_update inside that function and
to have a

        if (!shallow_update)
                return;

and additionally renaming the function to be more precise:

        assure_shallow_connectivity_checked();

These changes I can put into this patch.

Replacing error by a die command will go in an extra patch on top.
So I am understanding your answers such that we definitely want to prevent
a push if this future bug happen. Instead of incorporating that into
later patches
of the series to abort in case of this possible bug, we could just go
with s/error/die/
and the problem is solved.

>>                 error("BUG: run 'git fsck for safety.\n"
>>                       "If there are errors, try removing the refs reported above");
>>
>> Is this error possible, by the way?
>
> That code is to prevent bugs in future. The whole operation is spread
> out in many functions/steps and people may overlook.
>

Then this patch also helps with introducing a dedicated function to assure
the connectivity which we can reuse maybe.

Thanks,
Stefan
