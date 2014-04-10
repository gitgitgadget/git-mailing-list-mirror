From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 4/4] refs.c: sort the refs by new_sha1 and merge the two
 update/delete loops into one
Date: Thu, 10 Apr 2014 12:40:30 -0700
Message-ID: <CAL=YDWnADZmCa3v1gk37bbcQcnnAZ=+hi-OSFVdneWrP4_Lv0A@mail.gmail.com>
References: <1397154625-11884-1-git-send-email-sahlberg@google.com>
	<1397154625-11884-5-git-send-email-sahlberg@google.com>
	<xmqqy4zdvwjg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:40:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKpx-0002sa-8c
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758717AbaDJTkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:40:33 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:34047 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbaDJTkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:40:31 -0400
Received: by mail-ve0-f172.google.com with SMTP id jx11so3835331veb.17
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NZzSyu7jjFCuYK3ktPNtz3+uOHlV7bVSzDduLkyP0D0=;
        b=cIs6G4tfEizqwGuob0zKcuuMZQAWx95M146Ehr2Ev1QL8vaCAeCrcHHFaCe8bN3ZJu
         r0c4eyLyHUcNCimxLNtETQYtNy02Ocw4WT/k1rWYiDPxkH4JzNkIzxkQ6z6/h6sCcqv1
         /4LQQV4ovJXPkb0mL9kpaERn2FjKqsQbcVChGxvhuko5ZPY/0XXk57ugs7E0KkoQLg8S
         hrxYGjWmDBesiAhYQvw9u86as2hbLkAPh7CYaFRlpd3ujuoB6faEE6QhEPAUTSNGAuGo
         OiHN1jdCNq2MqtC4lQkcu3ZNls8wStq+wy3jQfPi7hIUTWZlbj6KmQ3lwRjozGp1VaHQ
         5OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NZzSyu7jjFCuYK3ktPNtz3+uOHlV7bVSzDduLkyP0D0=;
        b=U0ILLYWucX840y6H/RVSASfXlOkC32/mjRWdkSQYReUe5goXjgxWhiSbn79Zt7Oy3X
         qo+Ro0nzPSR0GG1dXGXLng0yCHQq1qCh00uvool3EcynuQ+fmYtbp32UwOs7DDRAG3/1
         CIW7SWZ9GUwG6VraYR3qs4pgvgMGv0z9piDwGWoszw9UhO7etbwDBqwOm7guuDTtpH31
         3eXl0RDsGwnU1P+EJajkm7RRBoXybdFVc9ZJN8E3dDVndqhmH4UZKHsRLbjgfhP+N5zt
         UAJQ1mG9mZRcKCiESRZns2dmAczZ527lBccycs9W8vf5DWIqYQfD4EuNNkHuMGu7IfHs
         /tFQ==
X-Gm-Message-State: ALoCoQnvw/bZRvkxCaPBfL1UigRwIZ3hTsA5u4FIf2zjQXrcgpj3c5Opx2AiV6bdyIAhOIlj0eqN0XYQS0RUVddZ6+/Y94M+UlsZ+DXvbycRXSRD93at+JHSusr5eemkViy3dSHrE1+RhXZcNWOu/O/adl1sGH2ZSjU7nC6CAyHqkqCszIbCJWcT2fm/6SsmKiP91tKZ55o1
X-Received: by 10.58.202.106 with SMTP id kh10mr1663182vec.31.1397158830716;
 Thu, 10 Apr 2014 12:40:30 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Thu, 10 Apr 2014 12:40:30 -0700 (PDT)
In-Reply-To: <xmqqy4zdvwjg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246052>

On Thu, Apr 10, 2014 at 12:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> We want to make sure that we update all refs before we delete any refs
>> so that there is no point in time where the tips may not be reachable
>> from any ref in the system.
>> We currently acheive this by first looping over all updates and applying
>> them before we run a second loop and perform all the deletes.
>>
>> If we sort the new sha1 for all the refs so that a deleted ref,
>> with sha1 0{40} comes at the end of the array, then we can just run
>> a single loop and still guarantee that all updates happen before
>> any deletes.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 1678e12..453318e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3309,6 +3309,15 @@ static int ref_update_compare(const void *r1, const void *r2)
>>       return strcmp((*u1)->ref_name, (*u2)->ref_name);
>>  }
>>
>> +static int ref_delete_compare(const void *r1, const void *r2)
>> +{
>> +     const struct ref_update * const *u1 = r1;
>> +     const struct ref_update * const *u2 = r2;
>> +
>> +     /* -strcmp so that 0{40} sorts to the end */
>> +     return -strcmp((*u1)->new_sha1, (*u2)->new_sha1);
>
> Two glitches:
>
>  - Didn't you mean hashcmp()?
>
>  - Don't you have an explicit ->delete_ref field that is a more
>    direct way, than relying on the convention "updating to 0{40}
>    is to delte", to express this?
>
> In other words, wouldn't it be more like
>
>         return !(*u1)->delete_ref - !(*u2)->delete_ref;
>
> or something (I may be wrong about the sign, tho---I didn't think
> carefully)?

I don't have access to delete_ref from 'struct ref_update'.

But much worse is that the patch is completely bogus.
Sorting and changing the order of the items in the updates[] array
does not affect the ordering of the items in the locks[] array
so this can not work.

I will delete this bogus patch from any new version of the patch series.


regards
ronnie sahlberg

>
>
>> +}
>> +
>>  static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>>                                       enum action_on_err onerr)
>>  {
>> @@ -3388,13 +3397,8 @@ int update_refs(const char *action, const struct ref_update **updates_orig,
>>               unlink_or_warn(git_path("logs/%s", delnames[i]));
>>       clear_loose_ref_cache(&ref_cache);
>>
>> -     /* Perform updates first so live commits remain referenced */
>> -     for (i = 0; i < n; i++)
>> -             if (locks[i] && !locks[i]->delete_ref) {
>> -                     ret |= commit_ref_lock(locks[i]);
>> -                     locks[i] = NULL;
>> -             }
>> -     /* And finally perform all deletes */
>> +     /* Sort the array so that we perform all updates before any deletes */
>> +     qsort(updates, n, sizeof(*updates), ref_delete_compare);
>>       for (i = 0; i < n; i++)
>>               if (locks[i]) {
>>                       ret |= commit_ref_lock(locks[i]);
