From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 4/4] t1006: add tests for git cat-file --literally
Date: Wed, 08 Apr 2015 23:12:55 +0530
Message-ID: <5525689F.5040306@gmail.com>
References: <551F7984.5070902@gmail.com> <1428126289-19239-1-git-send-email-karthik.188@gmail.com> <CAPig+cQ8SqtjRHRp=po0uXHWp3TFDXBsu5W6EUTs=ZWtR-br1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 19:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfu0p-0000Ur-81
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 19:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbbDHRnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 13:43:35 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33711 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbbDHRne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 13:43:34 -0400
Received: by pdbnk13 with SMTP id nk13so122765982pdb.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/Lsp4n/yO2vyEv7QE56H7wEhaZcpFCQDAVKty7K7z8I=;
        b=t5ANpd9et4x1yOC9LCb2CRrmWtVmDERUd8Js2ZpkiHq24YNt5IRZ4+Esss2TgRo4z3
         LxJxdLnUnRFA4JeNPhaL5BK7YdRZnS2PIibNFSv4bgy0A40uBNorRlsp1Wg0zdfzlfSy
         Prth6NBJ6fVU7khRHn6NlG2loB4IwxQKut7084/QuyTqCGeJXcFXa2Wo+os5jeCUIakl
         4ujC/NUvg6/v7+J2q9ujMV3P+Wju72LT8kuA9BVPaUQLdV2fkjnfKNhqPMzZPsFQ6NSw
         5QV+TOyybdFxSM0/mDh1HYJex3Brg96//SBsHhFvV5Ub6ZSDx25K8/B/EAMmscqfuTW6
         Ud+g==
X-Received: by 10.70.92.34 with SMTP id cj2mr24861936pdb.116.1428515013946;
        Wed, 08 Apr 2015 10:43:33 -0700 (PDT)
Received: from [192.168.42.172] ([49.15.136.60])
        by mx.google.com with ESMTPSA id gy3sm11689279pbb.42.2015.04.08.10.43.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2015 10:43:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cQ8SqtjRHRp=po0uXHWp3TFDXBsu5W6EUTs=ZWtR-br1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266967>


On 04/08/2015 02:19 AM, Eric Sunshine wrote:
> On Sat, Apr 4, 2015 at 1:44 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > ---
> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> > index ab36b1e..5b74044 100755
> > --- a/t/t1006-cat-file.sh
> > +++ b/t/t1006-cat-file.sh
> > @@ -47,6 +47,18 @@ $content"
> >          test_cmp expect actual
> >       '
> >
> > +    test_expect_success "Type of $type is correct using --literally" '
> > +       echo $type >expect &&
> > +       git cat-file -t --literally $sha1 >actual &&
> > +       test_cmp expect actual
> > +    '
> > +
> > +    test_expect_success "Size of $type is correct using --literally" '
> > +       echo $size >expect &&
> > +       git cat-file -s --literally $sha1 >actual &&
> > +       test_cmp expect actual
> > +    '
> > +
> >       test -z "$content" ||
> >       test_expect_success "Content of $type is correct" '
> >          maybe_remove_timestamp "$content" $no_ts >expect &&
> > @@ -296,4 +308,19 @@ test_expect_success '%(deltabase) reports packed delta bases' '
> >          }
> >   '
> >
> > +bogus_type="bogus"
> > +bogus_sha1=$(git hash-object -t $bogus_type --literally -w --stdin </dev/null)
> > +
> > +test_expect_success "Type of broken object is correct" '
> > +       echo $bogus_type >expect &&
> > +       git cat-file -t --literally $bogus_sha1 >actual &&
> > +       test_cmp expect actual
> > +'
> > +
> > +test_expect_success "Size of broken object is correct" '
> > +       echo "0" >expect &&
>
> Zero is such a common fallback value when things go wrong that it may
> not be the best choice for this test. Consequently, it might be better
> to create the bogus object with non-zero length. Take a look at how
> 'hello_length' and 'hello_sha1' are computed elsewhere in this script
> for inspiration.
The first part of this patch contains tests which make use of 'hello_length'
adn 'hello_sha1', but I get what you're saying, will look into it. Thanks.
>
> > +       git cat-file -s --literally $bogus_sha1 >actual &&
> > +       test_cmp expect actual
> > +'
> > +
> >   test_done
> > --
> > 2.4.0.rc1.249.g9f2ee54
