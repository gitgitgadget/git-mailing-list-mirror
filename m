From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Tue, 23 Jun 2015 16:22:35 +0530
Message-ID: <CAOLa=ZR_54yxEnhr_dyB0pwNbfTUhoh48bn7h3QjA5H5BzWPuA@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-4-git-send-email-karthik.188@gmail.com>
 <CAPig+cRzZDa4LyEpzVcODYCdwxoHPRJ3hqjEvSWdBsKi3Ti7nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 12:53:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7LpH-0001HY-51
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 12:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbbFWKxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 06:53:07 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36827 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbbFWKxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 06:53:05 -0400
Received: by oigb199 with SMTP id b199so3994044oig.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MvbBMSrTw/2dp27E0JIzSNHXW/n+tncUChhr2nFG16o=;
        b=R+73aQ6Pc8Eh/JE34ciVYsj0KCk93qn281IApvd0Bxdr37MZcC8cnRin9Ix8CaQuHp
         0WthF5yM3roHbwe+2RjVDaQVPC8HHBEpOi+TC5H1EHRQ6j7MImLEKYNR9VlOBDKjcYrE
         QrzJiDEfsSSFfkgXSGVBBh/5xOehuEUkVfv3sKpTEMcQ7NDe8oH+IjKDbe1z4oMU2gvK
         mWtocg5KcHs1YuxBz6E9zZsQ7W9d50h+tvXAh/C0y2Qt3vE6/v0wuhkk7IhxfhsbMXiJ
         MG3/0v2RDMxQnEWhMUQP3tR4JR3fzy/Lv9s+XxoeXhKhGf9iH5SISQ19LiuIvDfyi9aB
         JpGg==
X-Received: by 10.202.190.134 with SMTP id o128mr27657262oif.111.1435056784891;
 Tue, 23 Jun 2015 03:53:04 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 23 Jun 2015 03:52:35 -0700 (PDT)
In-Reply-To: <CAPig+cRzZDa4LyEpzVcODYCdwxoHPRJ3hqjEvSWdBsKi3Ti7nA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272448>

On Tue, Jun 23, 2015 at 4:08 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jun 21, 2015 at 4:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add the '--points-at' option provided by 'ref-filter'. The
>> option lets the user to pick only refs which point to a particular
>> commit.
>>
>> Add documentation and tests for the same.
>>
>> Based-on-patch-by: Jeff King <peff@peff.net>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
>> index b1fa8d4..67de3a7 100755
>> --- a/t/t6301-for-each-ref-filter.sh
>> +++ b/t/t6301-for-each-ref-filter.sh
>> @@ -16,4 +16,24 @@ test_expect_success 'setup some history and refs' '
>>         git update-ref refs/odd/spot master
>>  '
>>
>> +test_expect_success 'filtering with --points-at' '
>> +       cat >expect <<-\EOF &&
>> +       refs/heads/master
>> +       refs/odd/spot
>> +       refs/tags/three
>> +       EOF
>> +       git for-each-ref --format="%(refname)" --points-at=master >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'check signed tags with --points-at' '
>> +       cat >expect <<-\EOF &&
>> +       refs/heads/side
>> +       refs/tags/four
>> +       refs/tags/signed-tag four
>> +       EOF
>> +       git for-each-ref  --format="%(refname) %(*subject)" --points-at=side >actual &&
>
> s/for-each-ref\s+/for-each-ref /
>

Will change! thanks :)


-- 
Regards,
Karthik Nayak
