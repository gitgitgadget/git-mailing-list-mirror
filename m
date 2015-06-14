From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 09/11] parse-options.h: add macros for '--contains' option
Date: Sun, 14 Jun 2015 12:28:52 +0530
Message-ID: <CAOLa=ZRu14cJ22_0pbEi5hhZU3XaSeb+_BYEFTfi8fH3PgbxZw@mail.gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
 <1434226706-3764-1-git-send-email-karthik.188@gmail.com> <1434226706-3764-9-git-send-email-karthik.188@gmail.com>
 <CAP8UFD02qxKJYJ=hg7ZWsvUZfJe85CY-v2V-64swdxnibF=mmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 08:59:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z41t1-0005Zp-0s
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 08:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbbFNG7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 02:59:15 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36501 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbbFNG7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 02:59:13 -0400
Received: by obpc2 with SMTP id c2so17357827obp.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ypvbwVZKPkktRaPi66erJrtVCEkCmQ3RUvyhOKohzr4=;
        b=yluTcbC3AIBDvpbvAPobujXlBLZQK3YNeyHaAHzQVDNkKtSDPFj8pYYMVzLjD626/m
         OT2JBx902q6X5mo5eJFgwzWWD5LW4pXsPpr30L4nglig9/kVUoIvjmhgNqteCt+m4tFp
         2aIwqiu+i4GUhS27YQ/T8xBAqKV8UQfIg/UNSXV/SA7QYjdXAsxuZeClKChfICZ53SUc
         s8zsd323zMc0g36sNnOuYckRtIkGE0o+bjUhJAzk4CfJjtGHNA7VW057tRPWEHuvDL18
         iqSbM7iy3j5oNgIGeczpfOno0MmwnR7eVQ1tIvXSfw0ur0+AZgkH0riig2us+w34IaD7
         1UjQ==
X-Received: by 10.60.62.105 with SMTP id x9mr18788082oer.1.1434265153244; Sat,
 13 Jun 2015 23:59:13 -0700 (PDT)
Received: by 10.182.28.5 with HTTP; Sat, 13 Jun 2015 23:58:52 -0700 (PDT)
In-Reply-To: <CAP8UFD02qxKJYJ=hg7ZWsvUZfJe85CY-v2V-64swdxnibF=mmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271607>

On Sun, Jun 14, 2015 at 11:43 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Jun 13, 2015 at 10:18 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a macro for using the '--contains' option in parse-options.h
>> also include an optional '--with' option macro which performs the
>> same action as '--contains'.
>>
>> Make tag.c use this new macro
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  builtin/tag.c   | 14 ++------------
>>  parse-options.h |  7 +++++++
>>  2 files changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 2d6610a..767162e 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -595,23 +595,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>
>>                 OPT_GROUP(N_("Tag listing options")),
>>                 OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
>> +               OPT_CONTAINS(&with_commit, N_("print only tags that contain the commit")),
>> +               OPT_WITH(&with_commit, N_("print only tags that contain the commit")),
>>                 {
>>                         OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
>>                         PARSE_OPT_NONEG, parse_opt_sort
>>                 },
>>                 {
>> -                       OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
>> -                       N_("print only tags that contain the commit"),
>> -                       PARSE_OPT_LASTARG_DEFAULT,
>> -                       parse_opt_commit_object_name, (intptr_t)"HEAD",
>> -               },
>> -               {
>> -                       OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
>> -                       N_("print only tags that contain the commit"),
>> -                       PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
>
> The PARSE_OPT_HIDDEN flag is removed below. This means that "--with"
> will appear in the "git tag -h" output, which means that "--with"
> should appear in the documentation...
> The commit message may also want to tell that with is not hidden any more.
>

Yes! I will add that.

>> -                       parse_opt_commit_object_name, (intptr_t)"HEAD",
>> -               },
>> -               {
>>                         OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
>>                         N_("print only tags of the object"), 0, parse_opt_object_name
>>                 },
>> diff --git a/parse-options.h b/parse-options.h
>> index 8542d9c..d76e907 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -243,5 +243,12 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
>>         OPT_COLOR_FLAG(0, "color", (var), (h))
>>  #define OPT_COLUMN(s, l, v, h) \
>>         { OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
>> +#define _OPT_CONTAINS_OR_WITH(name, variable, help) \
>> +       { OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
>> +         PARSE_OPT_LASTARG_DEFAULT, \
>> +         parse_opt_commit_object_name, (intptr_t) "HEAD" \
>> +       }
>> +#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h)
>> +#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h)
>
> Shouldn't it be "with" instead of "contains"?

Actually it wouldn't matter, but since I've removed the PARSE_OPT_HIDDEN flag
it would show 'contains' twice. Will change it to 'with'.

Thanks for the review.

-- 
Regards,
Karthik Nayak
