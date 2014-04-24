From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 3/3] fetch.c: use a single ref transaction for all ref updates
Date: Thu, 24 Apr 2014 08:23:52 -0700
Message-ID: <CAL=YDWkVEvDY2fbne1VomqFxyZ3tfnykd+k_y8aA6vx7Bu0Gpg@mail.gmail.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
	<1398192327-21302-4-git-send-email-sahlberg@google.com>
	<CAPig+cTxT3gZn+pOwCOyKVVzYrFO7CMeLP_TuCrRsUOQRFYz5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 17:24:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdLVK-0007al-Da
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 17:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758125AbaDXPX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 11:23:56 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:40125 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757616AbaDXPXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 11:23:53 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so3224049veb.28
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ysWqy2svYjplWE7lXvXeTtH16Oxpxf4mnOo0tInTHFc=;
        b=P1ZDQBpSh2cL4CjsXUL8ZOtjoNjb74aeEkG8+oMZEWVs6HI6j/uEsqSJYEV4yA+w5R
         pd1us4Y/xze1MjkHz8qBwresuGZrsNMxoq1xPPdlhYr0+tarv093c0XVikerL9uUCT0K
         ++cBdf3YxrPUGKVuhnVD0yRhlZR3lJxgcgBG98oO0wfNHAGqtlN8lSQbuKIwC/7+FHLG
         s39LDdrsSjexOZvWlhERqYjcQn9S7tCEvaGcLx0sbLYyDk3EzndvVSDLXyUzXT6TYNbz
         6/JOrpUOqzs/4lD05jDTNNMUk5Pu1xYeVxJqTeWLir/Gae0epJQFfGYQrnVKCzNvUZBY
         JDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ysWqy2svYjplWE7lXvXeTtH16Oxpxf4mnOo0tInTHFc=;
        b=diFAE0TQ30esOjhmOuS2Wl/wUHT/fJR/Ka3qmebdPgNRA0XGiPl0EBpYKusMOz+8tp
         qwDEBcb3iGPfwcx+7nx9GsfCOkcLZDr4pXlWEvwETgEL1kXusEah6WCKN7Im/n8jZtyL
         7MEZMx7uvr79gSS441ui1K5BDH1KYvF0Ice+kEX3jldikPaJsEOUIAZdmZ45wxRd1ds/
         NsIrDBdziHwypQJS6rimpAm0aF6frVspFm7kdn+Divb+NAVeFyFPixQNv/ZPP80ccXKQ
         n81cdppdjzSXXOducrt85mYdby4Jywvpjjhod+VIPgLdFbAYvE7/WBSBTk84fOy0kDus
         vMfA==
X-Gm-Message-State: ALoCoQmKiiHut+aKijRi2jLlpLgjg1bDWYAuEdWnadsDkW14qlJ4uqLKy/F5G8mVyXHyhW5r6AuXCAL3R837+0E3fV9U/3mZ3VnSyFY9RRopR5oD9DpYsk6dBifVDKp7GOeaDecWtiEn8Iusx9UmW0UpGIZerJyC/1qFefMNHTgo+rp/4dV6HszVJxK5PtVeJQI3AQ6OhUrn
X-Received: by 10.58.178.130 with SMTP id cy2mr282030vec.55.1398353032734;
 Thu, 24 Apr 2014 08:23:52 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Thu, 24 Apr 2014 08:23:52 -0700 (PDT)
In-Reply-To: <CAPig+cTxT3gZn+pOwCOyKVVzYrFO7CMeLP_TuCrRsUOQRFYz5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246974>

Fixed, thanks!

On Wed, Apr 23, 2014 at 1:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 22, 2014 at 2:45 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> Change store_updated_refs to use a single ref transaction for all refs that
>> are updated during the fetch. This makes the fetch more atomic when update
>> failures occur.
>>
>> Since ref update failures will now no longer occur in the code path for
>> updating a single ref in s_update_ref, we no longer have as detailed error
>> message logging the exact reference and the ref log action as in the old code.
>> Instead since we fail the entire transaction we log a much more generic
>> message. But since we commit the transaction using MSG_ON_ERR we will log
>> an error containing the ref name if either locking of writing the ref would
>> so the regression in the log message is minor.
>>
>> This will also change the order in which errors are checked for and logged
>> which may alter which error will be logged if there are multiple errors
>> occuring during a fetch.
>>
>> For example, assuming we have a fetch for two refs that both would fail.
>
> s/assuming/assume/ perhaps?
>
>> Where the first ref would fail with ENOTDIR due to a directory in the ref
>> path not existing, and the second ref in the fetch would fail due to
>> the check in update_logical_ref():
>>         if (current_branch &&
>>             !strcmp(ref->name, current_branch->name) &&
>>             !(update_head_ok || is_bare_repository()) &&
>>             !is_null_sha1(ref->old_sha1)) {
>>                 /*
>>                  * If this is the head, and it's not okay to update
>>                  * the head, and the old value of the head isn't empty...
>>                  */
>>
>> In the old code sicne we would update the refs one ref at a time we would
>
> s/sicne/since/
>
>> first fail the ENOTDIR and then fail the second update of HEAD as well.
>> But since the first ref failed with ENOTDIR we would eventually fail the whole
>> fetch with STORE_REF_ERROR_DF_CONFLICT
>>
>> In the new code, since we defer committing the transaction until all refs
>> has been processed, we would now detect that the second ref was bad and
>
> s/has/have/
>
>> rollback the transaction before we would even try start writing the update to
>> disk and thus we would not return STORE_REF_ERROR_DF_CONFLICT for this case.
>>
>> I think this new behaviour is more correct, since if there was a problem
>> we would not even try to commit the transaction but need to highlight this
>> change in how/what errors are reported.
>> This change in what error is returned only occurs if there are multiple
>> refs that fail to update and only some, but not all, of them fail due to
>> ENOTDIR.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
