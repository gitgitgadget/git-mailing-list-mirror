From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 6/6] refs.c: enable large transactions
Date: Mon, 26 Jan 2015 11:30:56 -0800
Message-ID: <CAGZ79kbQiVQJyZC8mKaSUnOpY6YJc0TYdX=msuZDXLd7DxmTmQ@mail.gmail.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-7-git-send-email-sbeller@google.com>
	<xmqqy4otnigf.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYbCBHVhL+FvKu-yKMinxGCMwGfqG96rSp+0-7frgO2wQ@mail.gmail.com>
	<xmqqtwzhnhbl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:31:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFpNP-0000jt-AU
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 20:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbbAZTbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 14:31:01 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:53840 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbbAZTa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 14:30:57 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so408660igj.4
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P3stu0CS3XgK4PTrYcV0NiWVukP3KjYmOiwDQSMpF9g=;
        b=P75chFEIxWOrMEf2Mac1gqP0BsD2jp3Lg7vEfvbtyGXJrczgEiPWvC0x72n5TeNOqR
         Wr7yIxQ30YsOEC6NRcUVw3frWlVQcbEERAy79+aHODdtQUigATphNy82J0eleHrcyIBb
         g9/+KQP0AKLz//ttgCEOvgA9iTxpdpHMBH4xZgJ34bM9nuJSJ/C4NHLzo+z+o7B5FtQR
         sLwXNeqY4Zs/0Z9jMZ5ajmCd1ZNEpIThqZw58GzaR9jsf/V5EKlBPu4sNEN7tz4sVcui
         jQFOfkOqI/MdiP/4HUd8O3u6qEF4pWYe9/snwStcXkgqsPUCnX/dsNlbLvv22oIV8y/N
         Z5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=P3stu0CS3XgK4PTrYcV0NiWVukP3KjYmOiwDQSMpF9g=;
        b=Z2GD+huIV6mL/P8PfpwqNrq0+ErKzzkRv64aJCW0/VKYOjW5QKD2FnYrfTJg0/2H/Z
         FNpg7n4Tj+1Dk8eGQL30/yoUr/a4O3ioazm63eLOlZid+4LlSwdv4ogoVSpW9a7o/ksF
         FgNpDrPw2VGaKUds6SL1WQCOzGZgIX7BoKpKAlm5BMSVuuUMB3TEkYPdLsWOFw/+e27B
         HWR+K2PG6opL9C4Y9B94c0WyVcjXKiSaGI1k4cMOjldHBJ+EUbgrEsgaf1zNuZumFO/B
         K443IiHWrNTlZ3owxqRu9c8qtTmwT7I9g1G6srG4qdMrAKywwtexMWWSiECzG1TzmTOd
         BkSQ==
X-Gm-Message-State: ALoCoQmYuzffG6/S7h8ORY0t3HA1jcjjnEU7ansjNA/GldQss5ScIDL5GPypZAZjCJYxaiSUU4JS
X-Received: by 10.50.138.226 with SMTP id qt2mr18104840igb.1.1422300656332;
 Mon, 26 Jan 2015 11:30:56 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 26 Jan 2015 11:30:56 -0800 (PST)
In-Reply-To: <xmqqtwzhnhbl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263042>

On Fri, Jan 23, 2015 at 4:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Jan 23, 2015 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> yeah that's the goal. Though as we're in one transaction, as soon
>> as we have an early exit, the transaction will abort.
>
> An early exit I am talking about is this:
>
> static int write_ref_sha1(struct ref_lock *lock,
>         const unsigned char *sha1, const char *logmsg)
> {
>         static char term = '\n';
>         struct object *o;
>
>         if (!lock) {
>                 errno = EINVAL;
>                 return -1;
>         }
>         if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
>                 return 0;
>
> It returns 0 and then the transaction side has this call in a loop:
>
>                 if (!is_null_sha1(update->new_sha1)) {
>                         if (write_ref_sha1(update->lock, update->new_sha1,
>                                            update->msg)) {
>                                 strbuf_addf(err, "Cannot write to the ref lock '%s'.",
>                                             update->refname);
>                                 ret = TRANSACTION_GENERIC_ERROR;
>                                 goto cleanup;
>                         }
>                 }

And just after this code path there is the new
+               /* Do not keep all lock files open at the same time. */
+               close_ref(update->lock);

So in case we go the zero return path of write_ref_sha1 the loop looks like
    /* Acquire all locks while verifying old values */
    for (all updates) {
        write_ref_sha1(...)
        close_ref(...)
    }

In case we do go the non zero return path, it is
  if (write_ref_sha1(update->lock, update->new_sha1, ..)
    goto cleanup;
...
cleanup:
    for (i = 0; i < n; i++)
        if (updates[i]->lock)
            unlock_ref(updates[i]->lock);

I do not see the problem in the code itself, but rather in understanding
the code. I will send a follow up patch which makes it easier to follow
by removing the early exit with no problem away.

>
>>> If so, shouldn't the write function at least close the file
>>> descriptor even when it knows that the $ref.lock already has the
>>> correct object name?  The call to close_ref() is never made when the
>>> early-return codepath is taken as far as I can see.
>>
>> The  goto cleanup; will take care of unlocking (and closing fds of) all refs
>
> Yes, if write_ref_sha1() returns with non-zero signaling an error,
> then the goto will trigger.
>
> But if it short-cuts and returns zero, that goto will not be
> reached.

Yes, if the goto is not reached we just drop down to
close_ref(update->lock); which should take care of
the open fd.

Thanks,
Stefan
