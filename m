From: Alex Coppens <alex@nativetouch.com>
Subject: Re: [PATCH] rerere: exit silently on "forget" when rerere is disabled
Date: Thu, 14 May 2015 16:51:25 -0400
Message-ID: <CAPt1q6dhZarACvYQM5HFTGg3xA=LjnhF7DP8B6K+Fa1=m2Of9w@mail.gmail.com>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
	<xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
	<20150514191637.GA9329@peff.net>
	<xmqqr3qjj7b6.fsf@gitster.dls.corp.google.com>
	<20150514192052.GB9329@peff.net>
	<xmqqmw17j6oh.fsf@gitster.dls.corp.google.com>
	<20150514202207.GA13541@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 22:51:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt06N-0005Ny-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933731AbbENUv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:51:26 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36786 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933271AbbENUvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:51:25 -0400
Received: by pabsx10 with SMTP id sx10so101962839pab.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RwoLcT1CFyhOe4J7tsvyQOwTQa7tqJRziyNhSkDgD5U=;
        b=XsPlWLeowZxa9jFk/S2shPhiopN8FUpG1rzrFmck1qoZkArlmTMPsKYSlV7cRxSXQW
         sT4ES9f61CVVaJnd/hOu3rpCF9mSBOMkNC4O2WVoeOjI6BhhrFQ5qBlCaPkhpuD3Mpjy
         nUu0AvbVp/dPqimZhq5IuSjfnagLQAMXNcMPUyeQ1KIIWSC9U944FQ8HWHJn/bbHJepv
         /7MUbPnIqkMS72ej7usA0BSZ1wU6CGuExMcKBQUbBYBLFalsM5QcfHOT7sfblcoxAhht
         WRH7OM2MBOjEjkpW2/uSgN2yk9QwO2uVdbsM2V7ruYXdiEfXX/2sXcTYO2aT7og69Gzt
         5Afw==
X-Gm-Message-State: ALoCoQkRqtUm2nzrLl7g6v0ZMfaNDI5MAjPa/r41bV/YcnG1fUe6n3O0c/13XjomhpjsLL9LuMBh
X-Received: by 10.66.188.107 with SMTP id fz11mr11583478pac.85.1431636685079;
 Thu, 14 May 2015 13:51:25 -0700 (PDT)
Received: by 10.70.45.135 with HTTP; Thu, 14 May 2015 13:51:25 -0700 (PDT)
In-Reply-To: <20150514202207.GA13541@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269090>

Here are the outputs I have:

$ ls -d .git/rr-cache
ls: .git/rr-cache: No such file or directory

$ git config rerere.enabled
$

My repository is a ruby on rails project, I am currently on the
development branch. It's a private repository hosted on Github. Not
sure what other information you want.

Alex




On Thu, May 14, 2015 at 4:22 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 14, 2015 at 12:33:02PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > On Thu, May 14, 2015 at 12:19:25PM -0700, Junio C Hamano wrote:
>> >
>> >> > It looks like we need to pay more attention to the return value of
>> >> > setup_rerere, which is what is supposed to take the lock.
>> >>
>> >> Good spotting.  The normal rerere does check, but rerere-forget
>> >> codepath seems to forget it.
>> >
>> > Here's a patch.
>>
>> Thanks.  This is obviously correct to fix your "init -q" one.
>>
>> I am still puzzled by the original, though.  I assumed that rerere
>> was enabled and working correctly (in the sense that it correctly
>> replayed a mistaken resolution recorded earlier, which Alex wanted
>> to correct by forgetting).
>
> Yeah, agreed. I don't see any other code paths that could end up trying
> to commit a lock we haven't taken, though.
>
> Alex, can you tell us more about your repository? And possibly show us
> the output of:
>
>   ls -d .git/rr-cache
>   git config rerere.enabled
>
> in the repository?
>
> -Peff
