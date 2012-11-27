From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 5/7] push: require force for refs under refs/tags/
Date: Mon, 26 Nov 2012 22:17:49 -0600
Message-ID: <CAEUsAPZTycJS_USj-tYNN2Bpwn8XvYDTd4c7wFMFDYfNeSCUtw@mail.gmail.com>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
	<1353644515-17349-6-git-send-email-chris@rorvick.com>
	<7vfw3wry4d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 05:18:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdCca-0006Fc-Em
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 05:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208Ab2K0ERw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 23:17:52 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:43705 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878Ab2K0ERw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 23:17:52 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so6422925lag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 20:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=KmSXvI3L/QK4clHNxM5UdyWdoBH1xS3BTmSD6IY1ox8=;
        b=eF0q4tbCEmgv5SWYf5TTCd1lvD/h0XW2mdlSwqs2DP22dKxo7BupVjn8jueMl7wIzD
         V8hcw4hoP94ZtVRH9giKYkvPJx0IQTGT6u26lsMahnYZupw8wAWtUsH3LUD3Bm+6r9nR
         8xqwn9pDbVk1mx3+W6vmTMh+XVbUthVbvSVOZ7uA/XjDNjmj75kVx9Q7bAw7L+z6NKKN
         363M7Lds9VDtTS/sChtrgCgPGbPWMIrJ8c3UD+94ccFnLQZ7WL5+NPneIELPpoMvyT11
         o7ZthZl7UD3mqKxHR+0JOqTQcVDMk4GwbZEE47BElub4j5a2SoWW394kPBxbCCdXv1kB
         4Svg==
Received: by 10.112.11.99 with SMTP id p3mr6073038lbb.73.1353989869849; Mon,
 26 Nov 2012 20:17:49 -0800 (PST)
Received: by 10.114.13.2 with HTTP; Mon, 26 Nov 2012 20:17:49 -0800 (PST)
In-Reply-To: <7vfw3wry4d.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: _NVT8oo3Mx91E_zDO3eQqvJjsEE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210530>

On Mon, Nov 26, 2012 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Rorvick <chris@rorvick.com> writes:
>
>> diff --git a/remote.c b/remote.c
>> index 4a6f822..012b52f 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1315,14 +1315,18 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>>                *
>>                * (1) if the old thing does not exist, it is OK.
>>                *
>> -              * (2) if you do not have the old thing, you are not allowed
>> +              * (2) if the destination is under refs/tags/ you are
>> +              *     not allowed to overwrite it; tags are expected
>> +              *     to be static once created
>> +              *
>> +              * (3) if you do not have the old thing, you are not allowed
>>                *     to overwrite it; you would not know what you are losing
>>                *     otherwise.
>>                *
>> -              * (3) if both new and old are commit-ish, and new is a
>> +              * (4) if both new and old are commit-ish, and new is a
>>                *     descendant of old, it is OK.
>>                *
>> -              * (4) regardless of all of the above, removing :B is
>> +              * (5) regardless of all of the above, removing :B is
>>                *     always allowed.
>>                */
>
> We may want to reword (0) to make it clear that --force
> (and +A:B) can be used to defeat all the other rules.

On that note, having (5) be "regardless of all of the above ..." seems
a little awkward.  That would seem to fit better towards the top.
