From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 01/12] commit.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 16:46:56 -0700
Message-ID: <CAGZ79kZMsHrw+B29i6e4eWjVhEgH01H8QuNPA9_-CikGmQKVvQ@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<20160516210545.6591-2-gitster@pobox.com>
	<CAGZ79kbeXCsCs35hva2FWUhOD2F37ZDrzupEZLGBVbqnMxPjXQ@mail.gmail.com>
	<CAPc5daXM9a=W2R6YE=4PSuHWKXoZs_-VT+48ajh3mq1RoqYncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 01:47:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2SE2-0008Dt-7n
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 01:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbcEPXq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 19:46:58 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34257 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbcEPXq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 19:46:57 -0400
Received: by mail-io0-f176.google.com with SMTP id 190so3189331iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=t4FOGo9pMGhgmh1FG66xwouvET34dNkhT3cWs0kVM8s=;
        b=ouvhqM/4/g9QMKmH9ni+fRObqfPMwKuZHK2Yj+ZwRm7MxUNIv+4L5H1/eCWuwh2AbT
         8+0PVsGNOHVoVj7P4gOHYfEViBz5J39eRlJOt5dDGZjo9zDUw9UCIOjLFXhzfEUsGks5
         iSUbRtxS2paEZSfCy9A/kAcUezYSSCNIGNiThAFuG8ufEySMH6C1EBxD7ttENcipLJjD
         JIWWUvrCwycRlkxdZ8oESGUYFUaOv9MY0muum7T55kqU4AFwFbwT29Hy4Mobwtq1pQfi
         oSevotASGU6wymSeZ/AOCIg8A6tmP8QnbwWKwnpWDDcVWEqbk9mKI31mBGq1qkLSE1Hk
         fO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=t4FOGo9pMGhgmh1FG66xwouvET34dNkhT3cWs0kVM8s=;
        b=attbq1H7cKhzFACnWnK5ILQ0Se1cGBWX/EGp40OoSSP6+g9MU7QRYxQszQvugyOecr
         RitqfOHohled1AlVh5Lk0zkbULauzxEY2waVYVetpQiLmpVyupzkixxYnsEutgfOghu5
         tWHX3V7FUl9EE4Os6xB1S27naDhPfh0Bajkwu1Nt6JdzMIJlXWCEwq1D1n+UanJxmvF5
         IiECsC4WUDCBLZ2NbXdtekeSqZEl5RMcq3SFZjsYmGClKGvy8ZU0f3ZXGxPIqziOgFk9
         r47dUruzuDqr/VjO4kKW/FARF3qyFURDqnKXtIUngaoIcR6ygjwpjKRMbcMYk9xdx7gr
         ac4w==
X-Gm-Message-State: AOPr4FU9n6l+OHpkGH35zDl2Pd6otZIKwiMduZmJ6Rkfi4XzsaeToa38Ydjf0k9CaAZL/fOCzEnAsFYVWUwn1eqf
X-Received: by 10.36.62.133 with SMTP id s127mr12057983its.98.1463442416909;
 Mon, 16 May 2016 16:46:56 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 16:46:56 -0700 (PDT)
In-Reply-To: <CAPc5daXM9a=W2R6YE=4PSuHWKXoZs_-VT+48ajh3mq1RoqYncA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294822>

On Mon, May 16, 2016 at 4:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, May 16, 2016 at 4:19 PM, Stefan Beller <sbeller@google.com> wrote:
>>>         if (*p) {
>>>                 p += 2;
>>> -               for (eol = p; *eol && *eol != '\n'; eol++)
>>> -                       ; /* do nothing */
>>> +               eol = strchrnul(p, '\n');
>>
>> Nit:
>> You could include the +2 into the arg of  strchrnul,
>> such that you can drop the braces.
>
> You're right. With or without braces,
>
>   eol = strchrnul(p + 2, '\n');
>
> would be easier to understand (I do not know offhand if the value of p
> matters after this part, as I am responding from GMail Web UI without
> access to the wider context in the source, though).

Heh, good point, I did not think it through apparently. `p` matters.
