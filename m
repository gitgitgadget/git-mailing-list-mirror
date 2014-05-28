From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 08/41] refs.c: add an err argument to delete_ref_loose
Date: Wed, 28 May 2014 07:43:03 -0700
Message-ID: <CAL=YDWnV+nCLdSJ6k38syV8R=zQD_ox1nCLwvbv9UGky=NLdzA@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-9-git-send-email-sahlberg@google.com>
	<20140528002538.GI12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 16:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpf4R-0004oh-8S
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 16:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbaE1OnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 10:43:07 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:49237 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbaE1OnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 10:43:05 -0400
Received: by mail-ve0-f173.google.com with SMTP id pa12so12695073veb.32
        for <git@vger.kernel.org>; Wed, 28 May 2014 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+PdHwDqsrsq8R5Eyy+0dRKbNa8GFTd6Ai+wrQEUBB+s=;
        b=o7tSftyW/zJY5Sw89VRvM21Ez23SY5b7bw5PihZRt0knQ56B8o/14nSz/cJx06ug3N
         3v7e9HjLy+M366ZRWhN0G9O+P+xYRjevb1FS9lUPv8T1ASKImbkqrQmnFE4YNVw/UXlQ
         Z0nnR4WhN8mF1UqKhzhK0v57HoCdgVVVNH+1d/dExOj31lPyR17PtAmODOhzzuBrX3EY
         4oYtaf+GJJ8X7VRyyowq6QoKa04MKufSJUcOcfNlMX8WRfaCMDNwzKnuekOLE0DWTX8k
         diwPUoPUzI0iRsV6Y5TKJlrlp/aNRFcLTnLzCfChOIYu07XxVuypQQGc5x7JbGzcxJ+2
         kEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+PdHwDqsrsq8R5Eyy+0dRKbNa8GFTd6Ai+wrQEUBB+s=;
        b=LrMApVtwcti/3klwH517fCcDu49nNzIg4SXAufzIZQkuJRVmci5LH1IMYF7vyBdKBh
         n6d2GVgiD8pFrIXCv+ullodu8g5O6PGZKwP5nNv1pR0g9At7o9meanudTxyBQ+GH10MO
         BB1SOMaJU8AeIUQe8IA7slTVZrHfHO3tvrVExPfZAnH8p98PhOEMI6oypnQr5DiEDftb
         LB5BMCmKkqmtguKXHmTokKM9Lxzj8fjQvitO1u9M66xRGn5C6dlCGExW+F3Gnc/DB0YL
         KVp+BATt+NhEQJiO0s1NoeqVVrcVjb9Bqj+3BI0bPfAcm4Czf8bJ63xH1cP3C7t5h6Kz
         2Ccg==
X-Gm-Message-State: ALoCoQmVVhZrcPUehTiGywzhp+J9QN/6TkpmK3B2QgNb+KKOg/nHC2ijK/nLFj3ThlGwzzLrzqUc
X-Received: by 10.220.160.67 with SMTP id m3mr33221vcx.56.1401288184031; Wed,
 28 May 2014 07:43:04 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 07:43:03 -0700 (PDT)
In-Reply-To: <20140528002538.GI12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250285>

On Tue, May 27, 2014 at 5:25 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Comments from http://marc.info/?l=git&m=140079653930751&w=2:
>
> Ronnie Sahlberg wrote:
>
> [...]
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2491,17 +2491,43 @@ static int repack_without_ref(const char *refname)
>>       return repack_without_refs(&refname, 1, NULL);
>>  }
>>
>> -static int delete_ref_loose(struct ref_lock *lock, int flag)
>> +static int add_err_if_unremovable(const char *op, const char *file,
>> +                               struct strbuf *e, int rc)
>> +{
>> +     int err = errno;
>> +     if (rc < 0 && err != ENOENT) {
>> +             strbuf_addf(e, "unable to %s %s: %s",
>> +                         op, file, strerror(errno));
>> +             errno = err;
>> +     }
>> +     return rc;
>> +}
>> +
>> +static int unlink_or_err(const char *file, struct strbuf *err)
>> +{
>> +     if (err)
>> +             return add_err_if_unremovable("unlink", file, err,
>> +                                           unlink(file));
>> +     else
>> +             return unlink_or_warn(file);
>> +}
>
> The new unlink_or_err has an odd contract when the err argument is passed.
> On error:
>
>  * if errno != ENOENT, it will append a message to err and return -1 (good)
>  * if errno == ENOENT, it will not append a message to err but will
>    still return -1.
>
> This means the caller has to check errno to figure out whether err is
> meaningful when it returns an error.
>
> Perhaps it should return 0 when errno == ENOENT.  After all, in that
> case the file does not exist any more, which is all we wanted.

Good idea.
Thanks. Done.

>
>
>> +
>> +static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>>  {
>>       if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>>               /* loose */
>> -             int err, i = strlen(lock->lk->filename) - 5; /* .lock */
>> +             int res, i = strlen(lock->lk->filename) - 5; /* .lock */
>>
>>               lock->lk->filename[i] = 0;
>> -             err = unlink_or_warn(lock->lk->filename);
>> +             res = unlink_or_err(lock->lk->filename, err);
>>               lock->lk->filename[i] = '.';
>> -             if (err && errno != ENOENT)
>> +             if (res && errno != ENOENT) {
>> +                     if (err)
>> +                             strbuf_addf(err,
>> +                                         "failed to delete loose ref '%s'",
>> +                                         lock->lk->filename);
>
> On failure we seem to add our own message to err, too, so the
> resulting message would be something like
>
>         fatal: unable to unlink .git/refs/heads/master: \
>         Permission deniedfailed to delete loose ref '.git/refs/heads/master.lock'
>
> Is the second strbuf_addf a typo?

Yeah, we don't need it.
Removed.

>
> Thanks,
> Jonathan
