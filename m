From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 09:45:01 -0700
Message-ID: <CAGZ79kZSZQwnatExNFKCiWz8zgJfnS+8VWLkZcMaiHS1ESqBaQ@mail.gmail.com>
References: <20160517031353.23707-1-sbeller@google.com> <20160517031353.23707-5-sbeller@google.com>
 <xmqqa8jpz51m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 18:45:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2i7K-00086r-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 18:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbcEQQpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 12:45:05 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38683 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcEQQpD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 12:45:03 -0400
Received: by mail-ig0-f178.google.com with SMTP id m9so13036393ige.1
        for <git@vger.kernel.org>; Tue, 17 May 2016 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UyDuNHnkVu33m4Cq1X4JPRFpZs33l5Up2/i+FW8sC9o=;
        b=nwuWl7ggg6oRP6+Lfnnnv49kDzRvYazLNEcf6t4dfjEZfSm9sKSkrs8feUwpaHG9Vc
         6YfJrglO4QJQt/JX6vhscXXik1Ip+LC/1geX/wIiaD4tktY9e7ZDc29mGlgMLu4EsaCX
         MW3GktWRsld6w46VsBlAnhGtanHjXSpXmSEz5z5CUtLy7P5diNmEH/Ql2Y2aTgNNY3ZL
         JUU5/X5YFSzrZKOMuHIxJ5G7nPqE4RmxAcJayUY7hbXM676vMsfXiqNaNXkawVoZM7Uj
         sxqJvEVqp9Kg7jXBUyoA7NdQ1zl0re6isvV0Vb3Qf5GfIEjaAhA55caav85kouLPm0ju
         GdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UyDuNHnkVu33m4Cq1X4JPRFpZs33l5Up2/i+FW8sC9o=;
        b=knplHbdOK1L8DPjfB4+usBEoc8UiyPWNVoV+IU2UeVC3ZM7grqSQr3BtdnY+pJAMTB
         pdyOpcXLLazz16YGmwFN+PFDdDwmWV8jyEEBFkctoJtmVUkjZa5ojQqJK66pgBaKO0Wp
         J6ms2eLuXD9lVCfhNuUglt2DCY1o5h8OQbmA8m9Nj4EJgSugaTdeXcpl1pFUhwcHpj0G
         kYWX1iu07D+bzCtqoVBlFH9SRdcJ5Jb7NW9TkAkJpnKXyYm/aGVFDvUzKkWkLGqBYPVv
         /NOG4InegeFYDd3wHeonCI/jP7D3t+QtpkaWv7D0FTsLqqHawXbBHqNpt2NqNk6ewROm
         o/Aw==
X-Gm-Message-State: AOPr4FUg0vkBJFMJRvGbdc6OfQMB2Bb3HObz17HwUWeloe1k7T41Y6MvzE2DwrWwWfUSJkhjZNVjsb7i+9GAA+qb
X-Received: by 10.50.30.228 with SMTP id v4mr1893348igh.85.1463503502529; Tue,
 17 May 2016 09:45:02 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 17 May 2016 09:45:01 -0700 (PDT)
In-Reply-To: <xmqqa8jpz51m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294874>

On Mon, May 16, 2016 at 9:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> + * attr:+val to find value set to true
>> + * attr:-val to find a value set to false
>> + * attr:!val to find a value that is not set
>> + *     (i.e. it is neither set as "val", "val=<empty>", nor unset as "-val")
>> + * attr:val=value: to find value that have at least a and b set.
>
> I would have expected that there won't be "attr:+val", but it is
> spelled as "attr:val" instead.

"val" matches if the attr is not unspecified, i.e. one of {true, false, value}
"+val" matches {true} only.

Maybe we want to redo that to

"val" matches {true} only.
"?val" matches {true, false, value}. (I can leave this case out in the
first series, too)

>
>> +static void parse_attr_item(struct attr_item *attr, const char *value)
>
> Please do not call something that is not part of the attribute
> infrastructure as "attr_item"; I wasted time looking for the
> structure definition for "attr_item" in <attr.h>.

So "parse_pathspec_attr_match" instead?

>
>> +static int match_attrs(const char *name, int namelen,
>> +                    const struct pathspec_item *item)
>> +{
>> +     char *path;
>> +     int i;
>> +
>> +     if (!check) {
>> +             check = git_attr_check_alloc();
>> +             for (i = 0; i < item->attr_nr; i++)
>> +                     git_attr_check_append(check, item->attrs[i].attr);
>> +     }
>> +
>> +     path = xmemdupz(name, namelen);
>> +     git_all_attrs(path, check);
>
> PLEASE DON'T.  git_all_attrs() asks for all the attribute under the
> sun and has no hope to perform sensibly, especially at the very leaf
> level of the pathspec logic where one call to this function is made
> for each and every path in the tree.

This is executed only once, as check is static? From a users perception
it doesn't matter if it is executed once just after parsing all pathspec
items or at the first path to check for a match, no?

The mistake is using the API wrong. So inside the '!check', after the
preparation loop of git_attr_check_append, we'd need to
hand over the "check" to git_check_attr instead?

>
> Instead, have a pointer to "struct git_attr_check" in pathspec_item
> and make a call to git_check_attr(path, item->check) here.

I see, then we have multiple `check` structs. Makes sense.

>
> Which means that you would need to prepare git_attr_check around ...
>
>> +             if (skip_prefix(copyfrom, "attr:", &body)) {
>> +                     ALLOC_GROW(item->attrs, item->attr_nr + 1, item->attr_alloc);
>> +                     parse_attr_item(&item->attrs[item->attr_nr++], body);
>
> ... HERE.
>
