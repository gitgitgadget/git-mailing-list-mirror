From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 31/44] builtin-am: implement -S/--gpg-sign, commit.gpgsign
Date: Wed, 1 Jul 2015 09:43:59 -0700
Message-ID: <CAGZ79kYSWn61HT7K--AcYfJe3r8QZA2GarJPtCnqLP5aoUCWzQ@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-32-git-send-email-pyokagan@gmail.com>
	<CAGZ79kZSNXRfgngA6QsVwYiM=4nqk9rkuHxMOD-sPcaHKOPSkQ@mail.gmail.com>
	<CACRoPnQBhCObCaksfpmN9zcDxp676SkxEJqjcaKi1B3JRMeXVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:44:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAL7H-00020Y-Cy
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 18:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbbGAQoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 12:44:03 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34845 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbGAQoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 12:44:00 -0400
Received: by ykdy1 with SMTP id y1so44332417ykd.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=na1ppa8PlcBjpSkDga9qW8CwjC7irTPN7pn293JY8GQ=;
        b=IO61+QM8MXPeWU/1M+pIed5/CjiOirrKtWs76tVYbdEgt5GMagXulDb3Phn3qwhEbc
         pUanQY7P6yJWe+7vTIo1BvXUpz7IzTGDqmPhHLBu0Gh3THo12cAOrUdnXg+Wr1w+Fag/
         pE0JE7EEqvxnAVYs1cTM1M2b1iiTMQeIyz0vmdgJsWx6PJI2qyNUXdp98AyptH2tvldZ
         XXuQltMm1q7/tCsWN3SY2jk1oWstEJ4nu39oyENcLMrazEglER13q1Spl0Y0aKdk/mwN
         lMni8UbgE+qkzb0FyR2/2Y+dbILSU0gGEtk2WL+Z1UUzIlk5akGT7GPsij1dt3l8LAS4
         sEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=na1ppa8PlcBjpSkDga9qW8CwjC7irTPN7pn293JY8GQ=;
        b=YpE4Z2f7CoL/yOh1ZOJPhpHr3s/3+5tJfEolYEImA1G/btLP49NbcT8/mejp+i/646
         rnnSH3zAElqDQZZgb2ERV/6DX/95a1mhiErZ2diZfghI/348P0lFwh05P4a5FYpiNuwU
         QC9Pi+DZhoZoctP0pb1ViKjlRxTjG1oXnVvtrLMpAFiDdHfCbtdNGy3AnpNdOBJD02yZ
         ON1/t0WISq4uvMXzj4AODqTWLqFuWxjmBTVmzmCWpWO/rfEEwQ8vQFDoluLQzaW94NSD
         flyk6iZ63im/OA+CFWeq4OVDR/r0IyB9Ddglsy9IjrQXIUdnYq1GTNa6o5qry8E7SFTW
         SQqw==
X-Gm-Message-State: ALoCoQkU869+fJ2OZPsFSq2SGaw9OdLOAt9cTA0XfOVA1jmQaXcZRmqH4lqkxAtjWfqCV6BgxFjt
X-Received: by 10.13.247.3 with SMTP id h3mr34464592ywf.142.1435769039999;
 Wed, 01 Jul 2015 09:43:59 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Wed, 1 Jul 2015 09:43:59 -0700 (PDT)
In-Reply-To: <CACRoPnQBhCObCaksfpmN9zcDxp676SkxEJqjcaKi1B3JRMeXVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273162>

On Wed, Jul 1, 2015 at 1:01 AM, Paul Tan <pyokagan@gmail.com> wrote:
> On Tue, Jun 30, 2015 at 7:51 AM, Stefan Beller <sbeller@google.com> wrote:
>> I needed to read this patch a few times as this patch introduces `sign_commit`
>> twice. This is mostly a review problem I'd guess as in the code it
>> just affects this
>> method and you'd see all the code of the method easily compared to hunks sent
>> via email. But renaming this variable doesn't hurt.
>
> OK. What variable name do you want? Would "gpgsign" (to match
> commit.gpgsign) do?

Fine with me.

Thanks,
Stefan
