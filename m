From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/6] bisect--helper: `bisect_clean_state` shell
 function in C
Date: Wed, 15 Jun 2016 16:22:44 -0400
Message-ID: <CAPig+cQavSpojzrbWbz-W6yRjdJX-kBfUa5XtMWCO2B2CZmryg@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-2-pranit.bauva@gmail.com>
 <CAPig+cRfYS4FX+z4Yn-He_LctWdh7Ua56JU2HJs2C2+nTi5YyA@mail.gmail.com> <CAFZEwPNtWkG54dpcLz+E=QjED8ftJqemyNKFwFKdty6HiPtNDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 22:22:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDHKt-00034u-G3
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 22:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbcFOUWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 16:22:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34912 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbcFOUWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 16:22:46 -0400
Received: by mail-io0-f196.google.com with SMTP id n127so4273355iof.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rI7Oc2Ur0Ydt9zVTnnIjhcZqwTGHzjon6xUKgPA6MDw=;
        b=sVkLQsL0oGdHCOW7xcZd2xpk6VAQirLXDY4Q6kD7PvH7ccoPpYsD7PuE5BZAGm2MxI
         HRVtELHNdN/GB5Z8kfW3wMOrFy8Jno+QQzUcDNI70e7XdmS1gq56zhFPuNbQoNo54Ix2
         39qwG8dHvZWhTCjfD/yv7yesHLNzeaUXBQGO9oOtjWVd0e5yJ7nSydea9uqhf7g/YRXT
         bq3Z8CMYcOgf7lb2AINTDtHq/VeT+Rp0YDQk9CzyLASZ++QvQmy5xsJQiUskwoE+FtYf
         CdM3k+yUY1aQQ9NopHFVHhWI1JGel8+j3PRo6kQIy4pallaXRvx1UaISViQA9f4PwOBa
         w37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rI7Oc2Ur0Ydt9zVTnnIjhcZqwTGHzjon6xUKgPA6MDw=;
        b=C112MnHpbdDStf0ZG/2q1lismSPFOU0hO+LGCvGhyePgDQqSfgrvEN0rQYRTX2uvNM
         CS4YX2whZNFqQiXxPsv2HGLTlgGmNdijiPQBReEXnEBIKBrbvHEXZnp54i2vcQT5Y0cJ
         XHa5ojEzCXd/VP7Xkf+MA6OMZIoRudug+34za/ckCj7iDtaNmYeV35vlTRunEsHtTzvk
         5f79PP+0NHGt3pJWOWtrBWGm3zbolUAG1HJT8nHspYor5qUZsniD5BVFVgWiUHHgtHfN
         DhvMWqks5FpnVWbxVWqUZI64n3n0ysQVs62wNDM5e7R3Ue2zwDJVHH1xQVP4/TOeNkT/
         rDHQ==
X-Gm-Message-State: ALyK8tLQdfuquvVUfwVPnDW8IlO+KO8TdWDs+t0EPxu5c5FEw0rf94icAxAPMsP2iNwTGfJrrr3vDOvK0LB7/Q==
X-Received: by 10.107.47.41 with SMTP id j41mr2134834ioo.168.1466022164864;
 Wed, 15 Jun 2016 13:22:44 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 15 Jun 2016 13:22:44 -0700 (PDT)
In-Reply-To: <CAFZEwPNtWkG54dpcLz+E=QjED8ftJqemyNKFwFKdty6HiPtNDw@mail.gmail.com>
X-Google-Sender-Auth: 2l0uFsZKnsviOymaRjsSahc05ek
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297398>

On Wed, Jun 15, 2016 at 2:47 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Jun 15, 2016 at 11:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Reimplement `bisect_clean_state` shell function in C and add a
>>> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
>>> git-bisect.sh .
>>> [...]
>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>> ---
>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>> +static int mark_for_removal(const char *refname, const struct object_id *oid,
>>> +                           int flag, void *cb_data)
>>> +{
>>> +       struct string_list *refs = cb_data;
>>> +       char *ref = xstrfmt("refs/bisect/%s", refname);
>>> +       string_list_append(refs, ref);
>>> +       return 0;
>>> +}
>>> +
>>> +static int bisect_clean_state(void)
>>> +{
>>> +       int result = 0;
>>> +
>>> +       /* There may be some refs packed during bisection */
>>> +       struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
>>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>>> +       string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
>>> +       result = delete_refs(&refs_for_removal);
>>> +       string_list_clear(&refs_for_removal, 0);
>>
>> This is leaking all the strings added to 'refs_for_removal', isn't it?
>> Either you need to loop over the items and free the strings manually,
>> or (if it's not too ugly), set 'strdup_strings' before invoking
>> string_list_clear().
>
> I didn't carefully see that in the function string_list_clear() it
> only free()'s the memory if strdup_strings is 1. I think changing
> strdup_strings to 1 would be an easy way out but it would make the
> code very ugly and non-trivial.

I disagree about it making the code "*very* ugly and non-trivial". It
is quite trivial. What I meant by "ugly" was that it may be too
intimate with the implementation of string_list. However, since the
solution is already used in the codebase, it may be acceptable. For
instance, in builtin/fetch.c:

    /* All names were strdup()ed or strndup()ed */
    list.strdup_strings = 1;
    string_list_clear(&list, 0);

which is exactly the approach I was suggesting. You'll find the same
pattern in builtin/shortlog.c.

> On the other hand, I can initialize
> the string as STRING_LIST_INIT_DUP which will automatically set
> strdup_strings as 1 and then also free the memory of ref at that point
> after the string ref was appended to the list. Personally, I will
> prefer the latter one.

Meh.
