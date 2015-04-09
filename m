From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 4/4] t1006: add tests for git cat-file --literally
Date: Thu, 09 Apr 2015 08:54:09 +0530
Message-ID: <346F89A0-8224-453C-AE22-A717D318F43F@gmail.com>
References: <551F7984.5070902@gmail.com> <1428126289-19239-1-git-send-email-karthik.188@gmail.com> <CAPig+cQ8SqtjRHRp=po0uXHWp3TFDXBsu5W6EUTs=ZWtR-br1A@mail.gmail.com> <5525689F.5040306@gmail.com> <CAPig+cTYm-x7oLd+ts6wTXT3Xe_d1Fbw00=0NmrBPCd-+U4_eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 05:24:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg34j-0000Pw-R7
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 05:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbbDIDYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 23:24:13 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36825 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbbDIDYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 23:24:12 -0400
Received: by pabsx10 with SMTP id sx10so135276149pab.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 20:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=GAaIE0AFCLwfqCiihqnEGWAk1JC2EfZbwhSIyMcvjLg=;
        b=ovQwmTPa2mDBHlJ3q4b/iMLeXqPXkSjICm7v+ZFsL5Pwt9+HpIANJlfuqJK/NzIP7K
         G77qK5j0e/zAi6k4ufN5Ipeta54BIKFxJCuW7lm9lLrdkCktmng35PqxHJisqy21XLs2
         MBRNI2G7eJ5JIArr1QupCNYRlz+C8KcEmm6/ZiMOkeI26HapEO9DQUt3GTiKkkN3iaIe
         iDiQVSPACIAGTrSNqOtp6pNteLRH6yqDc4CSQbX1FA+9OV01gwvrLFXTWGzSM3quEuOV
         vmSzqtT+V5cEQgLsGdh608Zfqq2o7OeIMU2Nq5c3h/apkFRsJDyyDmniTNHyphXAbix1
         6syA==
X-Received: by 10.66.102.65 with SMTP id fm1mr52019547pab.115.1428549851955;
        Wed, 08 Apr 2015 20:24:11 -0700 (PDT)
Received: from [100.97.43.143] ([106.66.179.97])
        by mx.google.com with ESMTPSA id fn1sm12493308pbb.95.2015.04.08.20.24.07
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Apr 2015 20:24:10 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPig+cTYm-x7oLd+ts6wTXT3Xe_d1Fbw00=0NmrBPCd-+U4_eQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266980>



On April 9, 2015 2:04:08 AM GMT+05:30, Eric Sunshine <sunshine@sunshineco.com> wrote:
>On Wed, Apr 8, 2015 at 1:42 PM, karthik nayak <karthik.188@gmail.com>
>wrote:
>> On 04/08/2015 02:19 AM, Eric Sunshine wrote:
>>> On Sat, Apr 4, 2015 at 1:44 AM, Karthik Nayak
><karthik.188@gmail.com>
>>> wrote:
>>> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>> > ---
>>> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>>> > index ab36b1e..5b74044 100755
>>> > --- a/t/t1006-cat-file.sh
>>> > +++ b/t/t1006-cat-file.sh
>>> > @@ -296,4 +308,19 @@ test_expect_success '%(deltabase) reports
>packed
>>> > delta bases' '
>>> >          }
>>> >   '
>>> >
>>> > +bogus_type="bogus"
>>> > +bogus_sha1=$(git hash-object -t $bogus_type --literally -w
>--stdin
>>> > </dev/null)
>>> > +
>>> > +test_expect_success "Type of broken object is correct" '
>>> > +       echo $bogus_type >expect &&
>>> > +       git cat-file -t --literally $bogus_sha1 >actual &&
>>> > +       test_cmp expect actual
>>> > +'
>>> > +
>>> > +test_expect_success "Size of broken object is correct" '
>>> > +       echo "0" >expect &&
>>>
>>> Zero is such a common fallback value when things go wrong that it
>may
>>> not be the best choice for this test. Consequently, it might be
>better
>>> to create the bogus object with non-zero length. Take a look at how
>>> 'hello_length' and 'hello_sha1' are computed elsewhere in this
>script
>>> for inspiration.
>>
>> The first part of this patch contains tests which make use of
>'hello_length'
>> adn 'hello_sha1', but I get what you're saying, will look into it.
>Thanks.
>
>Just to be sure we're on the same page, I wasn't suggesting re-using
>'hello_size' and 'hello_sha1', but merely to use that as an example of
>how to avoid hard-coding the length of your non-zero-length bogus
>object. So, something like this, perhaps:
>
>    bogus_content='bogus'
>    bogus_size=$(strlen "$bogus_content")
>    bogus_sha1=$(echo_without_newline "$bogus_content" |
>        git hash-object -t $bogus_type --literally -w --stdin)
>    ...
>    test_expect_success "Size of broken object is correct" '
>        echo $bogus_size >expect &&
>        ...
Yes, I had done exactly what you suggested here. Thanks 
