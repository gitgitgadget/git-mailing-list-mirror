From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 20:38:14 +0700
Message-ID: <CACsJy8DbyxOj6Qt-VrW7qzPHGCrrwqaq_oUon5zUsACyFRt8Lw@mail.gmail.com>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net>
 <4F8F1BC1.3030607@ramsay1.demon.co.uk> <4F8FADCF.5000006@viscovery.net>
 <4F8FB4A0.7090403@viscovery.net> <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
 <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com>
 <CACsJy8DDLmKkBMW_P8RyGTRw=i6OKWZNf-SHoGkVWnJgfK7cVQ@mail.gmail.com> <CABPQNSb9BSfmGu2bYtZUndgkTom=r+Ho_CKsDr7wo=jfxiXEjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 19 15:38:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKrZT-0000nJ-On
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 15:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab2DSNir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 09:38:47 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50950 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab2DSNir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 09:38:47 -0400
Received: by wibhj6 with SMTP id hj6so1791715wib.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7S+Buu9w0ZD0H74NstGRsZ7iElEjsFIZqhblICNghI4=;
        b=lLzzUTTEVproxFfGnURXsRy6NmNahnuDfCDr7obTh9aRsRF89DEJLP0TCje2rzlnxJ
         QWu2w9lFfzoQ9d+rHthey17Ip3rS9dAOcOUsD6y8K8HJxKXwzqux0r35V1/ogJMQpJ2U
         S9oIM/+Fn6z92K1VNmLXe50qgLoJ11AS42ECbypmu0azeTrSrnV+zuClWt2uWJV+woNe
         veXRFZobVn6lUkEyobhzYU4jgx3nzcaLhTggU4wkPaxNoWOLVJhRpTlXjUMCsQCTY493
         XOrY+Lx6mOOQv8FxDMoqtGu5fLXAR6XSsZleGtPojB5glSLU5SO1grpky3YflN7SnZso
         DJtA==
Received: by 10.180.95.37 with SMTP id dh5mr26486866wib.8.1334842725726; Thu,
 19 Apr 2012 06:38:45 -0700 (PDT)
Received: by 10.223.16.194 with HTTP; Thu, 19 Apr 2012 06:38:14 -0700 (PDT)
In-Reply-To: <CABPQNSb9BSfmGu2bYtZUndgkTom=r+Ho_CKsDr7wo=jfxiXEjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195944>

On Thu, Apr 19, 2012 at 8:31 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Thu, Apr 19, 2012 at 3:18 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Thu, Apr 19, 2012 at 7:58 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> This approach has the problem that file-operations apart from pread
>>> might (at least in theory) modify the position. To prevent that, we'd
>>> either need to use the same locking-mechanism as the CRT use, or use
>>> ReadFile with an OVERLAPPED struct, which allows us specify the offset
>>> explicitly. The latter seems better to me, and should look something
>>> like this (note: untested):
>>
>> Yeah. I read about ReadFile [1] but dismissed it when I got to async
>> i/o mode. Reading again, sync i/o ReadFile with OVERLAPPED struct
>> should work fine. It's not clear though if file offset is changed
>> (pread man page says it does not change).
>>
>
> A quick test shows that it does not:
> ...
>
> So this looks fine to me.

Great. We now wait for good news from Johannes then.

>> Also this approach deals with Windows only. There's still another
>> NO_PREAD user, HP-UX something, and NO_PREAD comment mentions cygwin
>> before v1.5.22. I personally don't care, just wanted to point out.
>
> Yeah. Other platforms are still an issue. You didn't address those
> either in your patch,

No I didn't. Your patch made me see that.

> even though it would be possible to modify it to
> deal with them by checking the NO_PREAD and NO_PTHREADS defines.
>
> But they would still have the problem with the file-pointer racing for
> non-pread operations. Perhaps simply disabling threading is the better
> choice for these?

That sounds like a safe choice. I'll make a patch to do that.
-- 
Duy
