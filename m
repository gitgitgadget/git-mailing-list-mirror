From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 05/10] ref-filter: add support to sort by version
Date: Thu, 30 Jul 2015 15:53:25 +0530
Message-ID: <CAOLa=ZRs0-sAC8dfHeMDVAr7Rp6XK+nMN9vGV=HGJH0nBj2fUA@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438065211-3777-1-git-send-email-Karthik.188@gmail.com> <1438065211-3777-5-git-send-email-Karthik.188@gmail.com>
 <CAPig+cSZzA+3BaP78VhQ3JjYbW_Y+KRhQ6c4-SPuxysKmL8bZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"Matthieu.Moy@grenoble-inp.fr" <Matthieu.Moy@grenoble-inp.fr>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 12:24:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKl0K-0008KH-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 12:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbbG3KX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 06:23:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33928 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbbG3KXz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 06:23:55 -0400
Received: by obre1 with SMTP id e1so27534404obr.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8czH+tPelGUIy6kzCriuWMEWp3L98mTsGNcLErWbvso=;
        b=kVmZ5OuhtJ1kw1dXa4eDob3H5qFbmoado1c+7bYy+pTU0SwvVHE0B4PxtNsmp6JXA0
         LN8ZpQsViseX/sTsYwjO5FIsV2i4YBJBGgof95gc9e1e090Pf6nQViPYOPuvMisupbQl
         4Q0Uey97ym3lk3tHha9kD5vYfMnyz7nwfACl07z1rG1xR7TJf5/Gznj20JtZqjmgqjXV
         26GkpqrqGks7ik0IKFuhLz1rFGTivUSS2Yx9/kbTFqBgd636Gp5bYlQXXtfDi2ofLfXU
         jdq5gk/hB9TqKjz0H9jjFNziKU990h1zVXRUzp2Z9TBOB2dD/4GMZ8JXdessdVCGvKHR
         XxzQ==
X-Received: by 10.60.177.195 with SMTP id cs3mr44831094oec.37.1438251835190;
 Thu, 30 Jul 2015 03:23:55 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 30 Jul 2015 03:23:25 -0700 (PDT)
In-Reply-To: <CAPig+cSZzA+3BaP78VhQ3JjYbW_Y+KRhQ6c4-SPuxysKmL8bZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274981>

On Thu, Jul 30, 2015 at 1:04 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tuesday, July 28, 2015, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add support to sort by version using the "v:refname" and
>> "version:refname" option. This is achieved by using the 'versioncmp()'
>> function as the comparing function for qsort.
>>
>> This option is included to support sorting by versions in `git tag -l`
>> which will eventaully be ported to use ref-filter APIs.
>>
>> Add documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 45dd7f8..2b60aee 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -151,6 +151,9 @@ For sorting purposes, fields with numeric values sort in numeric
>>  order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
>>  All other fields are used to sort in their byte-value order.
>>
>> +There is also an option to sort by versions, this can be done by using
>> +the fieldname `version:refname` or in short `v:refname`.
>
> Nit: "or in short" reads a bit oddly. Perhaps:
>
>     ...`version:refname` or its alias `v:refname`.
>
> or
>
>     ...`version:refname` or the short-form `v:refname`.
>
> (I rather prefer the "alias" alternative.)
>

Thanks! will change.

>>  In any case, a field name that refers to a field inapplicable to
>>  the object referred by the ref does not cause an error.  It
>>  returns an empty string instead.
>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> index 19ac480..68688a9 100755
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -97,4 +97,40 @@ test_expect_success 'padding to the right using `padright`' '
>> +test_expect_success 'version sort' '
>> +       git for-each-ref --sort=version:refname --format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
>> +       cat >expect <<-\EOF &&
>> +       foo1.3
>> +       foo1.6
>> +       foo1.10
>> +       EOF
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'version sort (shortened)' '
>> +       git for-each-ref --sort=v:refname --format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
>> +       cat >expect <<-\EOF &&
>> +       foo1.3
>> +       foo1.6
>> +       foo1.10
>> +       EOF
>> +       test_cmp expect actual
>
> Nit: In the earlier review when I suggested using "v:refname" for one
> of the tests in order to exercise it (in addition to
> "version:refname"), I didn't mean that you had to add another
> (identical) test but rather that you could have one of the existing
> tests use "v:refname". (Not a big deal. You can leave this as is if
> you like. I just wanted to clarify.)
>

Ah! Thats ok, this seems to explain the commit entirely showing that
"v:refname" and "version:refname" are the same thing.

-- 
Regards,
Karthik Nayak
