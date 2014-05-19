From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 09/31] refs.c: allow multiple reflog updates during a
 single transaction
Date: Mon, 19 May 2014 15:58:11 -0700
Message-ID: <CAL=YDWmuOy=1ghkW6CZcywGGiFJZbptF-EycYsLomcr9m2=Xyw@mail.gmail.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-10-git-send-email-sahlberg@google.com>
	<xmqqppjd8l13.fsf@gitster.dls.corp.google.com>
	<CAPig+cSXt3FDS1XtHBq2y5NLQxKrVM4sp=YbRa2skJX=RrOyTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 20 00:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWVd-0007I8-4K
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 00:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbaESW6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 18:58:13 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:57815 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaESW6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 18:58:12 -0400
Received: by mail-vc0-f176.google.com with SMTP id lg15so10337421vcb.21
        for <git@vger.kernel.org>; Mon, 19 May 2014 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wBpX7fus1znfVuabVL0NY98xScMlwaFFl3ASYZAYV4E=;
        b=HoncEplZw/22/KzNgSw3RBMQrTxG9WiboexHgMuBzJOQK1R84GpHHUFOIASKHi7GmG
         rr30bvYhlGYiF6UwSWrTavjGyNLo5VAXo+bC+onbXW0yum7ML9jXctbMnGT3AzTrlder
         NwjDQjYa6nLM1YTXBtelePAOQfsT8mPtEDf+iZI2rI6tq0/yRA8S/W3XFuce/Kren0hk
         ROU82DjSQSB0WkHhuAk+2OwBa1PARpgWv36UI7tKNGmDIHTsB4v+XiGuJs8Dh+gL6qNB
         yMf9JbVBac0lT/Q0Pi6e/3XFbsXLtR8CWa/yV8eyXoNsCiz7J4MVpTVrUr2IImH3U6Np
         Vpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wBpX7fus1znfVuabVL0NY98xScMlwaFFl3ASYZAYV4E=;
        b=PoF/NKhf1RKiclAr3ohU81RciJdiKlXXDCZocvdh/4CxMkm9JsWhhvXQ0++wqiADBo
         uqHUcY/G8rY9IIyu+tzyIH9TqFXGUeOq+UQJcGNjsiR5ML+zg7zqH3edlbXsdcBxdCGz
         zI3U16b14S4d/uvQKoDq3BlBfUVyj4LiVpx9lOVdqQLLCKJrqB0x+U2PdE8MoRnOt+Hq
         b2QKjylK11DZaoK8t4I7yDbi57XDqGHxg3vdrl4PdK9MNG8lnROAMy7b7bGmnxvieZJs
         yHznqRMo6BFYUpnc2Jqw1I07kdZn/qTidbzlEqjiMXsfNI7Jn625slHbp9JJjo15V2CG
         CmEA==
X-Gm-Message-State: ALoCoQnoJ/T60hITnt4mhImoZn6JvH6jWD8wsdLX0aZR98m9M1yiewrKgLyzWyBbVVoL7lpzxaFt
X-Received: by 10.220.105.4 with SMTP id r4mr564576vco.27.1400540292016; Mon,
 19 May 2014 15:58:12 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 15:58:11 -0700 (PDT)
In-Reply-To: <CAPig+cSXt3FDS1XtHBq2y5NLQxKrVM4sp=YbRa2skJX=RrOyTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249633>

On Fri, May 16, 2014 at 3:01 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, May 16, 2014 at 5:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ronnie Sahlberg <sahlberg@google.com> writes:
>>
>>> Allow to make multiple reflog updates to the same ref during a transaction.
>>> This means we only need to lock the reflog once, during the first update that
>>> touches the reflog, and that all further updates can just write the reflog
>>> entry since the reflog is already locked.
>>>
>>> This allows us to write code such as:
>>>
>>> t = transaction_begin()
>>> transaction_reflog_update(t, "foo", REFLOG_TRUNCATE, NULL);
>>> loop-over-somehting...
>>>    transaction_reflog_update(t, "foo", 0, <message>);
>>> transaction_commit(t)
>>
>> OK, so you are now doing not just "refs" but also "reflogs", you
>> felt that "ref_transaction()" does not cover the latter.  Is that
>> the reason for the rename in the earlier step?
>>
>> I am sort-of on the fence.
>>
>> Calling the begin "ref_transaction_begin" and then calling the new
>> function "ref_transaction_log_update" would still allow us to
>> differentiate transactions on refs and reflogs, while allowing other
>> kinds of transactions that are not related to refs at all to employ
>> a mechanism that is different from the one that is used to implement
>> the transactions on refs and reflogs you are building here.
>>
>> But I think I am OK with the generic "transaction-begin" now.
>> Having one mechanism for refs and reflogs, and then having another
>> completely different mechanism for other things, will not let us
>> coordinate between the two easily, so "allow transactions that are
>> not related to refs at all to be built on a different mechanism" may
>> not be a worthwhile goal to pursue in the first place.  Please
>> consider the question on the naming in the earlier one dropped.
>>
>>>
>>> where we first truncate the reflog and then build the new content one line at a
>>> time.
>>>
>>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>>> ---
>>>  refs.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---------
>>>  1 file changed, 49 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/refs.c b/refs.c
>>> index a3f60ad..e7ede03 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -37,6 +37,10 @@ static inline int bad_ref_char(int ch)
>>>   *  need to lock the loose ref during the transaction.
>>>   */
>>>  #define REF_ISPACKONLY       0x0200
>>> +/** Only the first reflog update needs to lock the reflog file. Further updates
>>> + *  just use the lock taken by the first update.
>>> + */
>>
>> Style.
>>
>>> @@ -3349,8 +3355,23 @@ int transaction_update_reflog(struct ref_transaction *transaction,
>>>                             int flags)
>>>  {
>>>       struct ref_update *update;
>>> +     int i;
>>>
>>>       update = add_update(transaction, refname, UPDATE_LOG);
>>> +     update->flags = flags;
>>> +     for (i = 0; i < transaction->nr - 1; i++) {
>>> +             if (transaction->updates[i]->update_type != UPDATE_LOG)
>>> +                     continue;
>>> +             if (!strcmp(transaction->updates[i]->refname,
>>> +                         update->refname)) {
>>> +                     update->flags |= UPDATE_REFLOG_NOLOCK;
>>> +                     update->orig_update = transaction->updates[i];
>>> +                     break;
>>> +             }
>>> +     }
>>> +     if (!(update->flags & UPDATE_REFLOG_NOLOCK))
>>> +       update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
>>
>> So with two calls to transaction-update-reflog, we make two calls to
>> add-update, and each holds a separate lock?  If we write two entries
>> to record two updates of the same ref, would we still want to do so?
>
> Also, indent with tabs rather than spaces (the line following the 'if').

Done.

>
>>> +     /* Rollback any reflog files that are still open */
>>> +     for (i = 0; i < n; i++) {
>>> +             struct ref_update *update = updates[i];
>>> +
>>> +             if (update->update_type != UPDATE_LOG)
>>> +                     continue;
>>> +             if (update->flags & UPDATE_REFLOG_NOLOCK)
>>> +                     continue;
>>> +             if (update->reflog_fd == -1)
>>> +                     continue;
>>> +             rollback_lock_file(update->reflog_lock);
>>> +     }
>>>       transaction->status = ret ? REF_TRANSACTION_ERROR
>>>         : REF_TRANSACTION_CLOSED;
>
> Indent with tabs.

Done. Thanks.
