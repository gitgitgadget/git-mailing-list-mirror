From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4 2/2] submodule: port init from shell to C
Date: Fri, 22 Jan 2016 14:32:45 -0800
Message-ID: <CAGZ79ka6YwWpsU1KF9K8VAz=NhOVRJ9uYMAGTArGE7NXfbJ9Ag@mail.gmail.com>
References: <1453260274-31005-1-git-send-email-sbeller@google.com>
	<1453418323-29587-1-git-send-email-sbeller@google.com>
	<xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:32:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkGA-0002Iz-UV
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbcAVWcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:32:48 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:35033 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbcAVWcq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:32:46 -0500
Received: by mail-io0-f182.google.com with SMTP id 77so102349615ioc.2
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 14:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ii4E/CGGDFDLHoYnKrnwaPo4hC3ut7tbU7l7ky05edg=;
        b=LRGYJwj3Ao4+pFEdDd8SPRaHN5t2a97jNkTFhtkN0n3SNkTgyn1E7c+PbqBfZlME6F
         lBkmO0vBW8vxSNgBLaZ2emwfn0E8kVsk7RhUoLKvzm/GDwJ1BvSwIRkpc7iJr6FRJGmD
         QljxPdyc/3j45CDvGs9XSwymMeUoFcT7aRfzpoDi5uvxQmxyS36vaxl1I9Tmfs8vJ8CS
         Rw52T7NiJfMyi3nObK8o97A5TCPI/zICmecrwNRniNc7f3FQzrFfihBS+nPHbrb0NOeB
         i5RgSNiLcEKOj8QdSf/DT6wRa5LAj/JHwlZbNF6nFkQJeA7jfwqwi2z+DTfLmmlTaOXU
         5uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ii4E/CGGDFDLHoYnKrnwaPo4hC3ut7tbU7l7ky05edg=;
        b=L+9bRDHASKEXPOG8OOfarlhAAAVWaS2/qq+RWFT0QuYrsQUMA5NEZp+m4GFxf4uBW0
         Hap7e/fmK+UhJrH7qWnP/PnBHgM1w5/97BMHZ8E9TT+VhjA5r78Rlt7/hFRYK3sVzkJg
         8shBUJpSnFVHGUaG5+7TiWa1oWyMIgOOXmWUgAsR7AclI45SBUJt2JpDoQfPZY8xElfg
         xBAn+pYU58IG++t5aePl/UzBfwJOEwnaMRn9UHkKHINUwAkf8Ph8AD/dMAwXfTktNG9R
         Gc7iejQXQ3FJCyEquWRogOmU9cOqfddrOSwJcgKYaCaHSLX6t1gtHbNnk3RM+tN4xoUN
         lMlw==
X-Gm-Message-State: AG10YOTHxbecoKeJCoQLaBNkT2shMWPcOd9cC4ydwXoLAHAU65Rj2/Gcx3j57Zt9RpdmZe6Gyx38U/1/kmEFMgMC
X-Received: by 10.107.129.149 with SMTP id l21mr5682976ioi.174.1453501965933;
 Fri, 22 Jan 2016 14:32:45 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Fri, 22 Jan 2016 14:32:45 -0800 (PST)
In-Reply-To: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284599>

On Fri, Jan 22, 2016 at 2:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> By having the `init` functionality in C, we can reference it easier
>> from other parts in the code.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Hi Junio,
>>
>> please replace the top-most patch of sb/submodule-init with this patch.
>
> Will do, but it seems that you'd have to be replacing 1/2 as well,
> so perhaps send both when that happens?

I'll resend the series later tonight indeed, so no need to pickup that patch.


>
