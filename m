From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 02/15] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Tue, 8 Mar 2016 11:39:53 +0530
Message-ID: <CAOLa=ZRs92gH-tRqk4S_ALrJxcQPzcxzUr_G86zQRxbN7Qq6CA@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
 <1457265902-7949-3-git-send-email-Karthik.188@gmail.com> <xmqq7fhdoqd3.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZSFD39HXSw8jo1=ehiKpeqjLUSfc0NkRJD0BSbqAvDwuQ@mail.gmail.com> <CAPc5daVvD53KcX3RQkLiUtc5fe+hksYtQw7dK5+C=1eQdTT24w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 07:10:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adAqj-0008Hs-QF
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 07:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbcCHGKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 01:10:25 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34320 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbcCHGKY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 01:10:24 -0500
Received: by mail-vk0-f65.google.com with SMTP id e6so493010vkh.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 22:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=InpqKW1XFsVUukE5PMpm9eqRNGNvhhq3CVjuZpPEr0Y=;
        b=tOD5IZ+2XE1LOmWKDVomxst7mH55Y6lydaOTGl35ru2qGtwO+FJYb0DECvuREMZd9g
         GWyOo4mjLrw4bPibT8rPgop77iFAKN1a2linbw6UoRhNAfq/F2d7bvPmUnNvcFjhA+MU
         H7togT0FOoDc52WdLLb7hzMV5OgV3Zwm80iJnCEucRkAC0YxjaLhvulWySEru9vzFdC1
         5cxKGG2xLo50eqd0NXfeVGwJtS0u+JRJRNZ6Cj0I1vX8i+M1rMD2sW4gTLnbm7a4ykIP
         tAdLS94pO49FDpjLWAvj5CGh9d/OtrFr5mZxGP08eUZHTzHJ6tsLGwa7Koa72u63dQYg
         EJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=InpqKW1XFsVUukE5PMpm9eqRNGNvhhq3CVjuZpPEr0Y=;
        b=CxuFx1MFcwVwHLQ8FrmA7ofzkAnUiT4yH0m1LYIg4Njr+KdPjG95Ae1UES/pYVMzaA
         p1/6vJ+tIUZLxDW9ya8gHWzszr2EXXrUfECVVrjbepV+lM7NPrR47vcmmy+CENYq2hi3
         muLNzvpbMPm9s0zw+nRTB9hI0c5Bg83lTpWP5uHq1PqOnPH0NXrL5m2Vu2hGnUHjaBvU
         7CdzURuc7hXmfzXkudiU83QNYHCMt+pukKSDVpRXhq3sraXZ/8pd9wrZ02vlxYTSsGuO
         dLKMYwTe3hw51AVv3CnoCXcb8aZBds0Ga3cipM+GXqrXQgf1qREBg3m6NYf+uPBiixcc
         pqDQ==
X-Gm-Message-State: AD7BkJLByx8DwUihcGDx6jN6jEaFij+tOzqMcfUPx4qm9pjD2l7I2X6qEBiAT+wljXA48K6iPc0D77VqJXigPg==
X-Received: by 10.31.149.3 with SMTP id x3mr24362111vkd.46.1457417422924; Mon,
 07 Mar 2016 22:10:22 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Mon, 7 Mar 2016 22:09:53 -0800 (PST)
In-Reply-To: <CAPc5daVvD53KcX3RQkLiUtc5fe+hksYtQw7dK5+C=1eQdTT24w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288419>

On Tue, Mar 8, 2016 at 11:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Mar 7, 2016 at 9:41 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> You're correct, the "handler" functions run once for each "ref". But WRT
>> to the %(if)...%(then)...%(else)...%(end) atoms, it needs to be. Because
>> each outcome of these atoms depend on the current outcome of the fields
>> used between then WRT to the current ref.
>
> Yeah, there is no argument against that part at all.  My comment was purely
> about preparsing the if_equals field. All other fields are preparsed in *parse()
> helper functions and it looked strange that only these two are scanned in the
> handle() function every time it is evaluated for each ref, only to yield the
> same result.

True, I definitely agree, will fix that in the next iteration, thanks.

-- 
Regards,
Karthik Nayak
