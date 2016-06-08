From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] bisect--helper: `bisect_reset` shell function in C
Date: Wed, 8 Jun 2016 13:50:33 -0400
Message-ID: <CAPig+cSWJjS6X=Bmet0bWQmWV9kQJS9_qGMM7hu+Rj+7_Ctf=w@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-4-pranit.bauva@gmail.com> <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
 <CAP8UFD2nfcMu7Gmh=asyu+WZh5X2UjhyYSC2Sbp-qsQVjEULcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhcm-0006tX-Ei
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 19:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbcFHRug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 13:50:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34991 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbcFHRuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 13:50:35 -0400
Received: by mail-it0-f65.google.com with SMTP id z123so2211142itg.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Cy78MtxMtrFG5u7ZukYyRx9YX2Bqr2ZEarJyu+AHcSE=;
        b=BC8411pwWbKYpTA+bd6wONgmgsjdeDUzGHKVW9YGjZhc6e3k31yZimpGv0cjcpui1K
         6JmSsIN+v0OF3spFmlXfmptQxJqp6i0wSpv51A+vhnFotNPFnX50EXeCyohvLZBbPnt1
         4+GH+wOfpqVx+7pUCjRdtkH57ClUazFlWXdboMgz9A7Mo7/hZfLkblBmuldkCAHAIQGn
         BHUduEvBW6IFuM+aiDMJ7AlLL2CixCf6g8KxpKAr5DIx5HPNHTNcmCFZPE9Zu6XlhKjG
         uZBYhgrwXvuIecktkZu+z0XArLR0WqE446UZPKDAwN9TjNup21j2KkywEM/Kff1TLDbf
         V4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Cy78MtxMtrFG5u7ZukYyRx9YX2Bqr2ZEarJyu+AHcSE=;
        b=fmJUbU807hpDcOBfLAdz2Pm5LYwvpGE5EIrOwGo0OObOISGnIzjqnNrCjPN8AUh+u/
         bUIDdJEf2uC0uedohim7St4VmG0IJyDWl7TmXAcVjf5sepSI298iW9ED7Wya1yrChhLY
         lzm3/JdkjkxBoozkmRNU7wtDPXIThXL/geQkP3Z6f/aM5QTqQtKwkACicrpdAoVIclPr
         0o6NBj6/b0kdRKha7oEOgB+E6DqWyC49x6Eesd3NUfPi7UMKLQnBCUQzTm8cNe6TqNqA
         foITw3fKKdREUKwSVDGlWq5Fl/XpZ4gIIY3FywiZPFOmIHR4yPEDat10GTjhgLvVbABG
         geCg==
X-Gm-Message-State: ALyK8tJvo5iHBnhW51o0IKV43FITi8IAeGizYtkpQfGizlDRMKTrV9fENQWUauODvGVrc1V5wbnTqEJPY8Uc8w==
X-Received: by 10.36.112.81 with SMTP id f78mr10907691itc.32.1465408234377;
 Wed, 08 Jun 2016 10:50:34 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 10:50:33 -0700 (PDT)
In-Reply-To: <CAP8UFD2nfcMu7Gmh=asyu+WZh5X2UjhyYSC2Sbp-qsQVjEULcw@mail.gmail.com>
X-Google-Sender-Auth: fL8QU8KaewE7Fm6yWT8uwqVgJJk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296819>

On Wed, Jun 8, 2016 at 5:51 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Jun 8, 2016 at 9:59 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +       if (file_size(git_path_bisect_start()) < 1) {
>>
>> This doesn't even care about the size of the file, only if it
>> encountered an error while stat()'ing it. Why not just use
>> file_exists() instead (which you already use elsewhere in this
>> function)? Alternately, if you're trying to be faithful to the shell
>> code, then you *do* need to check that the file has non-zero size
>> before issuing the "not bisecting" diagnostic, so:
>>
>>     if ()
>>         printf("... not bisecting ...");
>
> As file_size() returns an integer, there is no difference between
> "file_size(git_path_bisect_start()) <= 0" and
> "file_size(git_path_bisect_start()) < 1".
> Or am I missing something?

No, you're right. I misread the code as:

    file_size(...) < 0

rather than what it really says:

    file_size(...) < 1

Sorry for the noise.

That it was so easy to misread the code, however, may be a good
argument for making a more special-purpose function, such as
file_empty_or_missing() (or file_not_empty()) as suggested in the
patch 3/4 thread.
