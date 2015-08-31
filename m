From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 07/13] ref-filter: add support for %(contents:lines=X)
Date: Sun, 30 Aug 2015 21:43:44 -0700
Message-ID: <CAOLa=ZTb0-eymVhvO5aqh94MptsAAbe=XSCR2TGG-Yea2cYu8g@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-8-git-send-email-Karthik.188@gmail.com> <CAPig+cTYQmrFnf7p6zxNh9w6AKXth99nRu40chQtUYAkWVss=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 06:44:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWGxL-0000Kz-OK
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 06:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbbHaEoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 00:44:14 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34262 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbbHaEoO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 00:44:14 -0400
Received: by obbfr1 with SMTP id fr1so84648043obb.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AegwS88PFKAQlPjPsmZMRDZN8FyFS+hZz0+O253iwfU=;
        b=XbpWv7uxh0xciKdUQr/TwiDc3AajBu/zZ+O60sjoliMnpFU7GCPafJRFjwgEfGDz7S
         VTUbsYF3HlLdu502FMvXr4uWQ1nTTP5TMAVzu1YF7NVfYBKijcnN0G6cj7sLpTQb2uHt
         BWPZ3Gi7ZSTFRqSVJeHHko2EgT2etk4dMfsGK95sZAndjPu8DOWXn0RjBNuIs7I+Od80
         VMXvLYmVxLIwjo3r9Rs4eHcm7e05y67Vkn6MLJG8KJjhSJ6XUH208OXWnLLCdndnm0up
         /d7D21TdfuVHIBKYJK4ASBVlAyQqe5sFGlTBGbW5j3ZBybZJ2uBRlJWbMR/M/1DAP9nv
         yprw==
X-Received: by 10.182.153.161 with SMTP id vh1mr12194892obb.34.1440996253484;
 Sun, 30 Aug 2015 21:44:13 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 30 Aug 2015 21:43:44 -0700 (PDT)
In-Reply-To: <CAPig+cTYQmrFnf7p6zxNh9w6AKXth99nRu40chQtUYAkWVss=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276845>

On Sun, Aug 30, 2015 at 3:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> In 'tag.c' we can print N lines from the annotation of the tag using
>> the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
>> modify it to support appending of N lines from the annotation of tags
>> to the given strbuf.
>>
>> Implement %(contents:lines=X) where X lines of the given object are
>> obtained.
>>
>> Add documentation and test for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> @@ -608,6 +672,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>>                         v->s = xmemdupz(sigpos, siglen);
>>                 else if (!strcmp(name, "contents"))
>>                         v->s = xstrdup(subpos);
>> +               else if (skip_prefix(name, "contents:lines=", &valp)) {
>> +                       struct contents *contents = xmalloc(sizeof(struct contents));
>> +
>> +                       if (strtoul_ui(valp, 10, &contents->lines))
>> +                               die(_("positive width expected align:%s"), valp);
>
> I forgot to mention this when I reviewed the patch earlier[1], but you
> copied this error message a bit too literally from the %(align:) atom.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/276807
>

I fixed that with your other suggestions, should have mentioned it. Thanks

-- 
Regards,
Karthik Nayak
