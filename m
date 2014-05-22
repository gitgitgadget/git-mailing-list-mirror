From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 30/44] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Thu, 22 May 2014 10:15:16 -0700
Message-ID: <CAL=YDW=5FozayJY2=_+eBn_fUsNQZuHhDKaSvzTiHOMJPA_JMw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-31-git-send-email-sahlberg@google.com>
	<20140521220035.GE12314@google.com>
	<CAL=YDW=Vpc8XGLGUTgKQc4yP5v+ViN02EeLzgRipntskok+fbw@mail.gmail.com>
	<20140521222201.GI12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 19:15:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnWaS-00029g-A5
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 19:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbaEVRPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 13:15:19 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:48594 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbaEVRPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 13:15:18 -0400
Received: by mail-ve0-f176.google.com with SMTP id jz11so4752006veb.7
        for <git@vger.kernel.org>; Thu, 22 May 2014 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=loxNRbsM/ZdIsIDDPRgWYBMLwQmmZld/PZ76QOsQQXU=;
        b=pnepbMGid9noWEwooBPIZBibKu52gbRhI7+xEm39pWLNE0V2J7O7vVaoJNc7G5viKi
         4+x1P/1CYOLHWc/mBofHNpIvstGLdlsbDWhMzmq1nHiYWnBG754rj3L0zeuJJUIucDPM
         s8Z0aE/rjZCyxFpCDF4IOEJ1SM8YKMuo7NcWYpNONRpRglutXidnW8zd3bIBN49bkRD8
         R5bYAWGjxY/lNRFoFuXJssKQms2nKVTuiThiZJtS/0K56s0+ojtpxYhjHHauEALAS8fa
         0A7tftVwEf1GEZZR/nDg+gDh8M8hLqVNBgJyGzMD2Nsrk9YwotQMc6rC7USuW8V287jo
         upNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=loxNRbsM/ZdIsIDDPRgWYBMLwQmmZld/PZ76QOsQQXU=;
        b=ChDiAv5qaNyvoIzC3GNPA/MjYRuMRxdupbG6CaAGHVe9dRD4NSC9IeZjIZr6Enhn00
         iLcDWLKEomXigWgiHuWKIbwgmeCoaZ0y0OrjOKqvSWx3KNwl8PdD84WmYapxR4C7Or+t
         nRx0BDoQuybz+9PJY/oY8+ytke1ubgLcyaWuP/eo/cfxZD8hCcBse2ba0ZSCuGGdc+fJ
         IyCO7CSqHwpXCNyGg9YwavCKcnTOBcO4s9W9CTVwCQA5QBlnwTeVc9GKc5wCDNiViaPS
         g0gRnLx2QDvxvRFbIp2BsF6fH4QNdWj06B8jbYsVR3ZIsO/2qkvOZbFRARM1Y5yU5nYW
         G5AQ==
X-Gm-Message-State: ALoCoQmFx0xah7kMSv7PMn6ozdORbCNyX0ektxpz0SHiCPxt2VK5JEHJEOmP9l83b6ahEfKtrVog
X-Received: by 10.221.4.66 with SMTP id ob2mr17164971vcb.28.1400778916600;
 Thu, 22 May 2014 10:15:16 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 10:15:16 -0700 (PDT)
In-Reply-To: <20140521222201.GI12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249919>

On Wed, May 21, 2014 at 3:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Please pull my ref-transactions branch.
>
> I'm at bd5736cb (2014-05-21 13:46) now.
>
>> On Wed, May 21, 2014 at 3:00 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Ronnie Sahlberg wrote:
>
>>>> --- a/refs.c
>>>> +++ b/refs.c
>>>> @@ -3308,6 +3308,12 @@ struct ref_update {
>>>>       const char refname[FLEX_ARRAY];
>>>>  };
>>>>
>>>> +enum ref_transaction_status {
>>>> +     REF_TRANSACTION_OPEN   = 0,
>>>> +     REF_TRANSACTION_CLOSED = 1,
>>>> +     REF_TRANSACTION_ERROR  = 2,
>>>
>>> What is the difference between _TRANSACTION_CLOSED and
>>> _TRANSACTION_ERROR?
>>
>> Closed is a transaction that has been committed successfully, and
>> which we can not do any more updates onto.
>> Error is a transaction that has failed, and which we can not do any
>> more updates onto.
>
> That means that both mean the caller cannot do any more updates,
> right?  Why not call them both _CLOSED?
>
>> The distinction could be useful if in the future we add support to
>> reuse a transaction
>
> If the distinction becomes useful in the future, wouldn't that
> be the moment to add a new state?
>
> I don't mean that there has to be a big useful distinction.  E.g.,
> maybe the idea is that when using a debugger it can be useful to see
> the difference between _ERROR and _CLOSED or something, and I think
> that would be fine as long as the intended meaning is documented
> (e.g., using comments).  My only complaint is that it's hard to
> understand the code and keep track of which status should be used in a
> given place unless there is some distinction between them.

I have documented the transaction states in refs.c

Thanks.
ronnie sahlberg
