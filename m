From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 30/48] refs.c: change update_ref to use a transaction
Date: Mon, 14 Jul 2014 11:49:00 -0700
Message-ID: <CAL=YDWnoXBXKaEFV8F_gGEALY3A4Bx3OKmHe8h4=VQgPN+me=Q@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-31-git-send-email-sahlberg@google.com>
	<53BBEA04.5040103@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 20:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6lJD-0001Vz-LI
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 20:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbaGNStE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 14:49:04 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:43807 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbaGNStB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 14:49:01 -0400
Received: by mail-vc0-f171.google.com with SMTP id id10so8246074vcb.30
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u4l9fxKQdg62powktasZIpj4sG0ikGpM4ovQkVzPDVs=;
        b=YB28DuCMNlb4NJjDfnKNNk+9g91Bh3e/LpUoc0UnPe40MB8bhjp+kpBJtl2Pycwxdl
         N0vwGOe7J0PrKmx1/Fc4cdRTzpaqV8CO6j3uq7QwwhpceljzobWOBqbcmPPPD1fIXE5m
         1EjTqn0pmw8/wWtC/wi5LbDEsp8P90svSulF/XLIpy9m/HBM0lWcwKvXwEnREW0kTUXm
         yFe6aFc97hz8imu8Yj5Ihai5epwFrfAQ5I3Xz0iQW00bKY062rmnrJARWSeyQRWgAvg9
         u29lszREN7A0cAxG3kZuJ0MnNJJ5moBXOw0QIlCLML85L5SA1XMIM3oWVxLaWmdAgjrB
         9pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=u4l9fxKQdg62powktasZIpj4sG0ikGpM4ovQkVzPDVs=;
        b=O1kW1QTAWlq5s5GvNaqL74ejM07FH6m87eUFOB60sxyntvk+xztwKsN+GTlrPxtoqL
         qahbMs1kXQkdlZ//lnoub8yDpZp2KzppLCvL3rhArEJpoFSNJuwLfDghh7xumwVpSl+A
         WxWNfgyQDq4iOF8z+KAJ3B08Xv+LS8UOK7SMZJkllciE4OaToLpymJEQ7GkUJeM/b42W
         yxRbTF0eN73+kbkr/kcsXlpSKM4huwTpjHxaRC32ku2IQOetAhK05T4eAafHGGr2QB+o
         J6qX4Or1DdIYFW8PMcseU0jQ8vRa/nCtQynM86bBcrKUsZSpfPtd+gBe3BLUzE8uIemM
         Rjdw==
X-Gm-Message-State: ALoCoQlY2IHik1lfZFmkTtFP+FG01E+mQNuoPvSxjX1QK5muVDNJNq/27r0CeWBUUxhN52gfaZ8z
X-Received: by 10.53.13.200 with SMTP id fa8mr1371565vdd.57.1405363740847;
 Mon, 14 Jul 2014 11:49:00 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 11:49:00 -0700 (PDT)
In-Reply-To: <53BBEA04.5040103@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253508>

On Tue, Jul 8, 2014 at 5:54 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Change the update_ref helper function to use a ref transaction internally.
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 28 ++++++++++++++++++++++++----
>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 8c695ba..4bdccc5 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3524,11 +3524,31 @@ int update_ref(const char *action, const char *refname,
>>              const unsigned char *sha1, const unsigned char *oldval,
>>              int flags, enum action_on_err onerr)
>>  {
>> -     struct ref_lock *lock;
>> -     lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
>> -     if (!lock)
>> +     struct ref_transaction *t;
>> +     struct strbuf err = STRBUF_INIT;
>> +
>> +     t = ref_transaction_begin(&err);
>> +     if (!t ||
>> +         ref_transaction_update(t, refname, sha1, oldval, flags,
>> +                                !!oldval, &err) ||
>> +         ref_transaction_commit(t, action, &err)) {
>> +             const char *str = "update_ref failed for ref '%s': %s";
>> +
>> +             ref_transaction_free(t);
>> +             switch (onerr) {
>> +             case UPDATE_REFS_MSG_ON_ERR:
>> +                     error(str, refname, err.buf);
>> +                     break;
>> +             case UPDATE_REFS_DIE_ON_ERR:
>> +                     die(str, refname, err.buf);
>> +                     break;
>> +             case UPDATE_REFS_QUIET_ON_ERR:
>> +                     break;
>> +             }
>> +             strbuf_release(&err);
>>               return 1;
>> -     return update_ref_write(action, refname, sha1, lock, NULL, onerr);
>> +     }
>> +     return 0;
>>  }
>>
>
> Should this function be scheduled for the "take strbuf *err argument"
> treatment instead of continuing to use an action_on_err parameter?
> (Maybe you've changed this later in the patch series?)
>
> I'm not saying this change has to be part of the current patch series,
> but let's consider it for the future.

There is a patch that does that in a later series. At that stage we
get rid of all action_on_err arguments.


>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
