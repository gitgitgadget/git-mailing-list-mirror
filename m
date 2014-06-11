From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v14 08/40] refs.c: add an err argument to delete_ref_loose
Date: Wed, 11 Jun 2014 11:21:27 -0700
Message-ID: <CAL=YDWm+L3tRq8CGr_QG_fYY1abTBfTAb4=YuaaEWzvHUeGaHA@mail.gmail.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
	<1402093758-3162-9-git-send-email-sahlberg@google.com>
	<20140610224937.GA8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:21:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wun9R-000168-BC
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 20:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbaFKSV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 14:21:29 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:62222 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbaFKSV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 14:21:28 -0400
Received: by mail-ve0-f180.google.com with SMTP id jw12so261375veb.39
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D8y94KuJe5mZEcJU5sWFAlhA99yjmoKH0nAgKoGnySc=;
        b=mmgopvFoD8r9tksh6vytqpOovu36hXy5xua+BR3kZ/JCf85iVK/3CmUXbrY2zrNuzq
         aDNEWKvxkP6kfqm2ZCYnVL8rwXBbgtLroKKQzzttVZtmbOI+86Caf6sKBbB2MrXCU4/L
         MPx3ll9v8c7gz9d8GvYAqVEo1SNgGDYGOVLon6c31ej+3dSHP8RCxS2O4qjHqwz4islG
         nULVdPO6iuIkZr+AGZHezPev+wP3t4rtRc4zB6R9eFyAirv8neI8egrR+TDZSp0I1Tlc
         acptw5TJCnQVuY1KtOwdl2t8zSanjnZOSJLF3ZNKzuOynexPfeElTdAtzw8TmXeMcPRg
         4tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=D8y94KuJe5mZEcJU5sWFAlhA99yjmoKH0nAgKoGnySc=;
        b=FLy02QWQM5swAPV+RJKlWMgXsSgcrS6Sy300vF3y7sHzoNu5KY5ZOCzFr1FN/PGNMR
         LmCSWDPd8mV96wEefz+gkYZoowu0rWz3MC6w1C/vJE5Itqh2DCjxnsIUr+xWMHWvSmdJ
         m86TvUiUFccCXYr4sTAa4zmRL8WgOhBuPiXmX0EIy0ip/sjYqZVdlPoMaWPPUqxAGQR7
         rRe6ZLYpqhJA0JVkJkepUx5WY6MXG8ZqVULTm58zrARqlFnTs4oFFowxcWk6AmGsOQqj
         AjH0t+trJ1188iYSd0miGGk2gTFrKCfXDogL1IMCl3O+yVb/CeW23W8Z/i3TAYrJ64Ys
         owLg==
X-Gm-Message-State: ALoCoQnY56Sp1isn5Ywkbl/WHMpRZypI9Y/rpvwSf1d6NUowqhimRBgjLnvldIm8VzH5xQuE3Bfo
X-Received: by 10.58.178.167 with SMTP id cz7mr4335935vec.33.1402510887818;
 Wed, 11 Jun 2014 11:21:27 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Wed, 11 Jun 2014 11:21:27 -0700 (PDT)
In-Reply-To: <20140610224937.GA8557@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251375>

Done.

Thanks.

On Tue, Jun 10, 2014 at 3:49 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2510,16 +2510,38 @@ static int repack_without_ref(const char *refname)
> [...]
>> +static int unlink_or_err(const char *file, struct strbuf *err)
>> +{
>> +     if (err)
>> +             return add_err_if_unremovable("unlink", file, err,
>> +                                           unlink(file));
>> +     else
>> +             return unlink_or_warn(file);
>> +}
>
> This has two different return value conventions (my fault, I know): it
> returns -1 for ENOENT when err == NULL but 0 for ENOENT when not.  The
> usual reason to call unlink_or_warn / remove_or_warn is to be silent
> about ENOENT so it seems simplest to fix them at the same time, as
> below.  The only callers that could mind:
>
>  * unpack-trees.c::unlink_entry, where this would be fixing a minor bug
>  * builtin/apply.c::remove_file, likewise
>  * delete_ref_loose, which checks errno so this should have no effect there
>
>  refs.c    |  2 +-
>  wrapper.c | 14 ++++++--------
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git i/refs.c w/refs.c
> index dd498cf..e32aa97 100644
> --- i/refs.c
> +++ w/refs.c
> @@ -2541,7 +2541,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>                 lock->lk->filename[i] = 0;
>                 res = unlink_or_err(lock->lk->filename, err);
>                 lock->lk->filename[i] = '.';
> -               if (res && errno != ENOENT)
> +               if (res)
>                         return 1;
>         }
>         return 0;
> diff --git i/wrapper.c w/wrapper.c
> index bc1bfb8..c9605cd 100644
> --- i/wrapper.c
> +++ w/wrapper.c
> @@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
>
>  static int warn_if_unremovable(const char *op, const char *file, int rc)
>  {
> -       if (rc < 0) {
> -               int err = errno;
> -               if (ENOENT != err) {
> -                       warning("unable to %s %s: %s",
> -                               op, file, strerror(errno));
> -                       errno = err;
> -               }
> -       }
> +       int err;
> +       if (!rc || errno == ENOENT)
> +               return 0;
> +       err = errno;
> +       warning("unable to %s %s: %s", op, file, strerror(errno));
> +       errno = err;
>         return rc;
>  }
>
