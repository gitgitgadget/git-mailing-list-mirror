From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Fri, 3 May 2013 17:19:44 -0500
Message-ID: <CAMP44s2o2EvmSwB0P_WkudxQWigUV20+ECio1rUGPt8qF5=0Ow@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<7v61yzyavo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 04 00:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYOKg-0006eg-G4
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 00:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760475Ab3ECWTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 18:19:47 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:56791 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab3ECWTq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 18:19:46 -0400
Received: by mail-lb0-f176.google.com with SMTP id v20so1952379lbc.21
        for <git@vger.kernel.org>; Fri, 03 May 2013 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=N6wXg5hkGO/c7aWvfuJiij3G/U+irgwoDb2m/AoVHDw=;
        b=xxPm6NfDh+b4MeNMutxgqlnMWQPiRiQz7wXenR5KXKshAzZeGW9AHl/ElFgwWK1sXl
         VDbgnT0jiA56at1jx2jjqamaHb+s1GpCdCtn1fopqGgQlmBH76uGvr6LnWvXQyxzFftt
         GX6DxMFevRuNhfAj+3Aj89tRUKik0nYUuyK4WmLXUUiqcSPhfCP61EYlr+3J6ob4lxJq
         fksG6WwsCFX+V/QrfI6kD25oPv8YJRTQ3jiDLbSedkBnlKViPWTd1ZoavjBnntltLvlO
         VGis4gAQCmSKyUupBaLbTrkd8W5cRPbMsstD0PKljVFLuOkkIL09K0EISVXl0f5Ql2cm
         vOWw==
X-Received: by 10.112.145.72 with SMTP id ss8mr4224594lbb.12.1367619584848;
 Fri, 03 May 2013 15:19:44 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 3 May 2013 15:19:44 -0700 (PDT)
In-Reply-To: <7v61yzyavo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223329>

On Fri, May 3, 2013 at 5:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> IIUC, you are unconditionally storing only marks to commit objects.
>>
>> Are you allowed to do that at this point?  I notice that
>> git-fast-export(1) says
>>
>>    --export-marks=<file>
>>        Dumps the internal marks table to <file> when complete. Marks are
>>        written one per line as :markid SHA-1. Only marks for revisions
>>        are dumped[...]
>>
>> But git-fast-import(1) says nothing of the sort; I would even claim that
>>
>>    --export-marks=<file>
>>        Dumps the internal marks table to <file> when complete.
>>
>> means that the *full* marks table is dumped.
>>
>> How do we know that this doesn't break any users of fast-import?  Your
>> comment isn't very reassuring:
>>
>>> the vast majority of them will never be used again
>>
>> So what's with the minority?
>>
>> In any case, if this does go in, please update the documentation to
>> match, probably by copying the sentence from git-fast-export(1).
>
> A safe and sane approach may be to teach these an option to tell
> them to omit non-commits or to emit all kinds, and make remote-bzr
> use that to exclude non-commits.

This has nothing to do with remote-bzr, or any remote helper. These
objects are not useful, not even to 'git fast-export'.

> If the defaults is matched to the
> current behaviour, nobody will get hurt

Changing nothing always ensures that nobody will get hurt, but that
doesn't improve anything either.

-- 
Felipe Contreras
