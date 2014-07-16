From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 40/48] refs.c: add an err argument to delete_ref_loose
Date: Wed, 16 Jul 2014 11:53:33 -0700
Message-ID: <CAL=YDW=kJNb0E3ARMeKpcJiybM=pbpBjO2-494QKoY+oV-5q6Q@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-41-git-send-email-sahlberg@google.com>
	<53BBFDFE.5060902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:53:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7UKk-0003Id-LB
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 20:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbaGPSxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 14:53:37 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:51306 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485AbaGPSxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 14:53:35 -0400
Received: by mail-vc0-f176.google.com with SMTP id ik5so2463161vcb.21
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZXFjQxQGPJt67mM3HLhbTrpmLJzyciSG7z6i6nGim+Q=;
        b=cJkZCQnBOmYTv34+0eJUCjQJBb9QPhqEM502Pv5Wa9cogIPfa8v4lOa7dHBpI1jgee
         0/s3VA3q6A1LaP/IiydGiwhCeOGNNF0E4aS1C3xSUDMjOBvsmn+FNAFQyPGyVGkNONQv
         W8Oa81K+t3SlnayYTRLdnjk8tUmZFk42uIvgpg438jI0tTeGrM9Iaj1io7DRADbxcR/V
         CD7Q/ad/GVqMRWa6hShAvtmFr7ELSoD5GAv5Do0IE1nq/W2EoP/WFO0KLAH8IMDemoIk
         bMgKUdZGBXxZUJhGxVLnTDlrcGqzwyVQ7XYBcUkNyAfJycoQH7NkB3uUmaTNYCyLu/8/
         JRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZXFjQxQGPJt67mM3HLhbTrpmLJzyciSG7z6i6nGim+Q=;
        b=JyRhDqvEB7uZhvtEIQW63TNa+njMrNpsn1xFCPmTdJtY7aWDWiaSKGvSbseVJM+M3r
         LagXqQHpbZjRW//zNYpZlFei+SHXwlNYE4a/z+HZBkB2EDH4fXXMgwhmvTzlZMf68RzD
         f7tdxR4o6Z2N4vuO5nw2Je2BYjZ8l0rYdKen4m0ISfO8gdbMfBmEi1JhloXxZtlO32yX
         rSp3BDZao0VoEWGzvI/dQyAls3PuXe40xsNorps1c/mJMWs/+kV2QVvMBbpYShdCTuZr
         JcKqNUaeqoKqDjDs5Sf/OUiW6xoU1dXb7/u34R+gc+Vf2ijh8JUFNwXPbB3ph/l7VDuW
         5Lxg==
X-Gm-Message-State: ALoCoQnRQbtQMgGKCuKMHv5xX0hc/nptXFaiTFNcsMUYoySDM5ijKh2omjR9ytNMASKFWgFdNdPo
X-Received: by 10.52.113.37 with SMTP id iv5mr9053972vdb.51.1405536813792;
 Wed, 16 Jul 2014 11:53:33 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Wed, 16 Jul 2014 11:53:33 -0700 (PDT)
In-Reply-To: <53BBFDFE.5060902@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253683>

On Tue, Jul 8, 2014 at 7:19 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Add an err argument to delete_loose_ref so that we can pass a descriptive
>> error string back to the caller. Pass the err argument from transaction
>> commit to this function so that transaction users will have a nice error
>> string if the transaction failed due to delete_loose_ref.
>>
>> Add a new function unlink_or_err that we can call from delete_ref_loose. This
>> function is similar to unlink_or_warn except that we can pass it an err
>> argument. If err is non-NULL the function will populate err instead of
>> printing a warning().
>>
>> Simplify warn_if_unremovable.
>
> The change to warn_if_unremovable() is orthogonal to the rest of the
> commit and should be a separate commit.

Done.
I split it into three patches.
One patch for the warn_if_removable change
another patch to add unlink_or_msg to wrapper.c
and a final patch to change delete_loose_ref.

>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c    | 33 ++++++++++++++++++++++++++++-----
>>  wrapper.c | 14 ++++++--------
>>  2 files changed, 34 insertions(+), 13 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 92a06d4..c7d1f3e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2544,16 +2544,38 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>>       return ret;
>>  }
>>
>> -static int delete_ref_loose(struct ref_lock *lock, int flag)
>> +static int add_err_if_unremovable(const char *op, const char *file,
>> +                               struct strbuf *e, int rc)
>
> This function is only used once.  Given also that its purpose is not
> that obvious from its signature, it seems to me that the code would be
> easier to read if it were inlined.
>
>> +{
>> +     int err = errno;
>> +     if (rc < 0 && errno != ENOENT) {
>> +             strbuf_addf(e, "unable to %s %s: %s",
>> +                         op, file, strerror(errno));
>> +             errno = err;
>> +             return -1;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int unlink_or_err(const char *file, struct strbuf *err)
>
> The name of this function is misleading; it sounds like it will try to
> unlink the file and if not possible call error().  Maybe a name like
> "unlink_or_report" would be less prejudicial.
>
> It might also make sense to move this function to wrapper.c and
> implement unlink_or_warn() in terms of it rather than vice versa.
>
>> +{
>> +     if (err)
>> +             return add_err_if_unremovable("unlink", file, err,
>> +                                           unlink(file));
>> +     else
>> +             return unlink_or_warn(file);
>> +}
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
>> +             if (res)
>>                       return 1;
>>       }
>>       return 0;
>> @@ -3603,7 +3625,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>               struct ref_update *update = updates[i];
>>
>>               if (update->lock) {
>> -                     ret |= delete_ref_loose(update->lock, update->type);
>> +                     ret |= delete_ref_loose(update->lock, update->type,
>> +                                             err);
>>                       if (!(update->flags & REF_ISPRUNING))
>>                               delnames[delnum++] = update->lock->ref_name;
>>               }
>> diff --git a/wrapper.c b/wrapper.c
>> index bc1bfb8..740e193 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
>>
>>  static int warn_if_unremovable(const char *op, const char *file, int rc)
>>  {
>> -     if (rc < 0) {
>> -             int err = errno;
>> -             if (ENOENT != err) {
>> -                     warning("unable to %s %s: %s",
>> -                             op, file, strerror(errno));
>> -                     errno = err;
>> -             }
>> -     }
>> +     int err;
>> +     if (rc >= 0 || errno == ENOENT)
>> +             return rc;
>> +     err = errno;
>> +     warning("unable to %s %s: %s", op, file, strerror(errno));
>> +     errno = err;
>>       return rc;
>>  }
>>
>>
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
