From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Wed, 8 Jun 2016 13:16:22 +0530
Message-ID: <CAFZEwPMJbKAOdffWs7QedB+4j32LaBZeV1iGpUuGntMjXeN3hg@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com> <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 09:46:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYC4-0004Mc-BR
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 09:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbcFHHqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 03:46:24 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33448 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbcFHHqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 03:46:23 -0400
Received: by mail-yw0-f193.google.com with SMTP id y6so26287ywe.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/S125fyOQwqDOdrWbT/mLJYlLB9MZPhibr1VR+BRtZE=;
        b=e79sT5sChaLg9TakFuDUE11PSMGbc0V/loQKDOrU0oibkMdk48afCnNuGQvMNZwd82
         EccRhD6HkpqUAkZSkpTkY3UEVirogd/Auz5vD+V3Mdct9Ll+NYMDegazh7H9MzH3LzdM
         Z5q92v7pYS9c/YSuMOBmOySIMBZCIcQKiYZRMLHR5+3IW7tz1H4FndtZX4fFNgc3IvJB
         2EGu+UggkCfmORg7aLOcSctd+DovR5PsXuLEVcsWhdGBkCEZoplGWHsVKgfIXri2u7uh
         gwn9589eVgCjUX19xHHn41VQbrIZAVRXHmQukR6mHF49+9J48HQNENXQkmUEFEEqEx5A
         b4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/S125fyOQwqDOdrWbT/mLJYlLB9MZPhibr1VR+BRtZE=;
        b=JvfwkSRSRQWNXamruQiK9b9CiYg7c4wWRhFpKPFRvT1sWl7YGv8xu9s2t4KGkFCoPZ
         VsTux5xedSMxSp7b8FbZZbbwzC/0cRoosMtBcFyMKODOz/ElrN9s2j9vmHq087tBx8x/
         w1YB2UtClsommFY/7E3rqQ0N64uNDcyInU24FQhn47LRGb11ZmSpxBnsmZPGuQclvxUV
         llqU3p/kXrLZb29wBty/imlzjgxM/zrqDQU0mxiFjGaBZrsybHinOPVhU6lmAp/DT7uD
         RPuBvU5oIqb/ud9w2d1tZNQcVqD80lbYuD9X2UTCDm2JdignJjmYj1dCrix1FSZI2UmV
         7wZg==
X-Gm-Message-State: ALyK8tL9ySckwAtsNKFarFJ0GLcO8u1TzaeKgr3vNBElW3fS3cff6+0X72M62t1P4l4VvX3C4eWXY2tPQe4wNw==
X-Received: by 10.13.224.6 with SMTP id j6mr2040837ywe.72.1465371982820; Wed,
 08 Jun 2016 00:46:22 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 00:46:22 -0700 (PDT)
In-Reply-To: <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296761>

Hey Eric,

On Wed, Jun 8, 2016 at 4:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement `bisect_clean_state` shell function in C and add a
>> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh .
>> [...]
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -78,11 +87,43 @@ static int write_terms(const char *bad, const char *good)
>> +int mark_for_removal(const char *refname, const struct object_id *oid,
>> +                      int flag, void *cb_data)
>> +{
>> +       struct string_list *refs = cb_data;
>> +       char *ref = xstrfmt("refs/bisect/%s", refname);
>
> Here you're allocating a string...
>
>> +       string_list_append(refs, ref);
>> +       return 0;
>> +}
>> +
>> +int bisect_clean_state(void)
>> +{
>> +       int result = 0;
>> +       struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>
> ...and the allocated string gets inserted into a string_list which
> itself duplicates the string (STRING_LIST_INIT_DUP), so this is
> leaking the string you created with xstrfmt(), isn't it?

Yes nice catch. I would prefer using the string_list with
STRING_LIST_INIT_DUP and free the ref.

>> +       string_list_append(&refs_for_removal, "BISECT_HEAD");
>> +       result |= delete_refs(&refs_for_removal);
>
> Not sure I understand the point of using |= here rather than merely =
> since this is the only place 'result' is assigned in this function.

In some initial iterations I assigned value of result before so used
|=. Then I realized it isn't necessary, so removed it. Forgot to
remove |=. Will do it!

>> +       string_list_clear(&refs_for_removal, 0);
>> +       remove_path(git_path_bisect_expected_rev());
>> +       remove_path(git_path_bisect_ancestors_ok());
>> +       remove_path(git_path_bisect_log());
>> +       remove_path(git_path_bisect_names());
>> +       remove_path(git_path_bisect_run());
>> +       remove_path(git_path_bisect_write_terms());
>> +       /* Cleanup head-name if it got left by an old version of git-bisect */
>> +       remove_path(git_path_head_name());
>> +       /* Cleanup BISECT_START last */
>> +       remove_path(git_path_bisect_start());
>
> The BISECT_START comment merely repeats what the code itself already
> says. I realize that you merely copied this from the shell code, but
> it isn't helpful in its current form. Much more helpful would be to
> explain *why* this needs to be done last. Perhaps the commit message
> of the commit which introduced the comment originally would give a
> clue (I haven't checked).

The commit(4796e823a) by Jon Seymour (4 Aug, 2011) explains this. I am
not sure how I would frame the sentence as that commit introduces a
concept whose by-product is the comment. I do want to include it in
the commit message otherwise it would be passed on as "you have to do
it but no one knows why".

>> +       return result;
>> +}
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> @@ -430,27 +430,7 @@ bisect_reset() {
>> -bisect_clean_state() {
>> -       # There may be some refs packed during bisection.
>
> This comment doesn't seem to be reproduced in the C version. Should it
> be? Is it no longer relevant in the C version? What does it mean
> exactly?

git-bisect itself never packs refs on its own. But there is a
possibility that the user might have packed the refs in the bisection
state. This was introduced by Christian ( 15 Nov, 2007) in commit
947a604b01.

>> -       git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
>> -       while read ref hash
>> -       do
>> -               git update-ref -d $ref $hash || exit
>> -       done
>> -       rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
>> -       rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
>> -       rm -f "$GIT_DIR/BISECT_LOG" &&
>> -       rm -f "$GIT_DIR/BISECT_NAMES" &&
>> -       rm -f "$GIT_DIR/BISECT_RUN" &&
>> -       rm -f "$GIT_DIR/BISECT_TERMS" &&
>> -       # Cleanup head-name if it got left by an old version of git-bisect
>> -       rm -f "$GIT_DIR/head-name" &&
>> -       git update-ref -d --no-deref BISECT_HEAD &&
>> -       # clean up BISECT_START last
>> -       rm -f "$GIT_DIR/BISECT_START"
>> +       git bisect--helper --bisect-clean-state || exit
>>  }

I will also include static in function declaration. Thanks!

Regards,
Pranit Bauva
