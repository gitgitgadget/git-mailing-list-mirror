From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 4/4] t1006: add tests for git cat-file --literally
Date: Wed, 8 Apr 2015 16:34:08 -0400
Message-ID: <CAPig+cTYm-x7oLd+ts6wTXT3Xe_d1Fbw00=0NmrBPCd-+U4_eQ@mail.gmail.com>
References: <551F7984.5070902@gmail.com>
	<1428126289-19239-1-git-send-email-karthik.188@gmail.com>
	<CAPig+cQ8SqtjRHRp=po0uXHWp3TFDXBsu5W6EUTs=ZWtR-br1A@mail.gmail.com>
	<5525689F.5040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 22:34:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfwfv-0002jT-Ea
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 22:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbbDHUeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 16:34:11 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35107 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbbDHUeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 16:34:09 -0400
Received: by lbbuc2 with SMTP id uc2so72714004lbb.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3Qqp3AQtllVEZu5TctQcJ+4N9xHTxb0o+oMybg/HiVQ=;
        b=xX0z+swPk/xqRvtbzSBEZEv1Cfm/8tGq80AL+cvfVOiNAil0aosYAPsI3VJ1Fo1MDI
         WfT39ux+HHrgBTJ6TbOeD4WbXwPNudbCn/7ON/FytbBXN4GiqFqbeRp5UympXKcW+zc9
         N3k3amkZM9DIxXniDRv1VVkxub2kpER88WdItlhodzUZKXl0uTXAKICOzlQX5xd8FhNc
         fcE86Ma7OwMxcNaxl8TBEnzSyoWmPc8oLiZOr+oZin3L/FrikB5W0BPKvhSf5MGQKKQf
         La1XpzuAc5pXnSiyOY0R4iz4jMK6Nhy/LCryV9PWWTAmrwITgFfTNwsaGmnF0Um0173D
         Rodw==
X-Received: by 10.112.57.197 with SMTP id k5mr8900504lbq.102.1428525248113;
 Wed, 08 Apr 2015 13:34:08 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Wed, 8 Apr 2015 13:34:08 -0700 (PDT)
In-Reply-To: <5525689F.5040306@gmail.com>
X-Google-Sender-Auth: KdqDe91in9WPzeru8t6cdag90JQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266972>

On Wed, Apr 8, 2015 at 1:42 PM, karthik nayak <karthik.188@gmail.com> wrote:
> On 04/08/2015 02:19 AM, Eric Sunshine wrote:
>> On Sat, Apr 4, 2015 at 1:44 AM, Karthik Nayak <karthik.188@gmail.com>
>> wrote:
>> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> > ---
>> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> > index ab36b1e..5b74044 100755
>> > --- a/t/t1006-cat-file.sh
>> > +++ b/t/t1006-cat-file.sh
>> > @@ -296,4 +308,19 @@ test_expect_success '%(deltabase) reports packed
>> > delta bases' '
>> >          }
>> >   '
>> >
>> > +bogus_type="bogus"
>> > +bogus_sha1=$(git hash-object -t $bogus_type --literally -w --stdin
>> > </dev/null)
>> > +
>> > +test_expect_success "Type of broken object is correct" '
>> > +       echo $bogus_type >expect &&
>> > +       git cat-file -t --literally $bogus_sha1 >actual &&
>> > +       test_cmp expect actual
>> > +'
>> > +
>> > +test_expect_success "Size of broken object is correct" '
>> > +       echo "0" >expect &&
>>
>> Zero is such a common fallback value when things go wrong that it may
>> not be the best choice for this test. Consequently, it might be better
>> to create the bogus object with non-zero length. Take a look at how
>> 'hello_length' and 'hello_sha1' are computed elsewhere in this script
>> for inspiration.
>
> The first part of this patch contains tests which make use of 'hello_length'
> adn 'hello_sha1', but I get what you're saying, will look into it. Thanks.

Just to be sure we're on the same page, I wasn't suggesting re-using
'hello_size' and 'hello_sha1', but merely to use that as an example of
how to avoid hard-coding the length of your non-zero-length bogus
object. So, something like this, perhaps:

    bogus_content='bogus'
    bogus_size=$(strlen "$bogus_content")
    bogus_sha1=$(echo_without_newline "$bogus_content" |
        git hash-object -t $bogus_type --literally -w --stdin)
    ...
    test_expect_success "Size of broken object is correct" '
        echo $bogus_size >expect &&
        ...
