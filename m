From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: fix shell expansion of items
Date: Thu, 20 Sep 2012 21:38:52 +0200
Message-ID: <CAMP44s1daQ_Cs8gGwpTJx0+9eKdRGF28PJkiAKJ8wf-2=WUMng@mail.gmail.com>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
	<20120920014608.GA27782@sigill.intra.peff.net>
	<20120920181152.GA4689@goldbirke>
	<20120920182104.GB19204@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:39:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmaU-0002x5-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093Ab2ITTiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 15:38:54 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44322 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2ITTix convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Sep 2012 15:38:53 -0400
Received: by oago6 with SMTP id o6so2579324oag.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CjBrqrMZdVY8VO4FQrAR+wJL3losNV8fZ0mQQXYNrCM=;
        b=Ei+88hjSQQPzeDApSeDYhZv0ONTRSpdy5qpSP4fibm7Hcs43TXsxmPpPesota54Fu4
         L6tsoZqlc5664685l2SjAz7utUCRzZTITwf3FTaFfldkoYmFROweb6kfBUziyeUPMqjK
         EjIQquGuQjn45rVERz49gLB4xvZZ9Cf5MPxWEj87imzyBmL6vsa9s3/X9ndyjo3+1N2G
         zCFFKmXM0zsDS0KqaqfaUNEsgptxIrauvBa7rXqPYBU3u83A1uH1H0NDWzMYxsrzQz8k
         PE+lmxdU+sNFaKqumm2TrgGhm5nwstAfJVSjsDAgr8p1Oulm884Jn3nGb8ipIYzqaPfN
         To9A==
Received: by 10.60.27.6 with SMTP id p6mr2118639oeg.37.1348169932776; Thu, 20
 Sep 2012 12:38:52 -0700 (PDT)
Received: by 10.60.164.7 with HTTP; Thu, 20 Sep 2012 12:38:52 -0700 (PDT)
In-Reply-To: <20120920182104.GB19204@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206071>

On Thu, Sep 20, 2012 at 8:21 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 20, 2012 at 08:11:52PM +0200, SZEDER G=C3=A1bor wrote:
>
>> > > In order to achieve that I took bash-completion's quote() functi=
on,
>> > > which is rather simple, and renamed it to __git_quote() as per J=
eff
>> > > King's suggestion.
>> > >
>> > > Solves the original problem for me.
>> >
>> > Me too. Thanks.
>>
>> While it solves the original problem, it seems to break refs
>> completion, as demonstrated by the following POC test:
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 92d7eb47..fab63b95 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -228,4 +228,11 @@ test_expect_success 'general options plus comma=
nd' '
>>       test_completion "git --no-replace-objects check" "checkout "
>>  '
>>
>> +test_expect_success 'basic refs completion' '
>> +     touch file &&
>> +     git add file &&
>> +     git commit -m initial &&
>> +     test_completion "git branch m" "master "
>> +'
>
> Hmm.  I notice that Felipe's patch wraps the _whole_ input to
> __gitcomp_nl in single quotes.

Wasn't there a patch series that added tests for __gitcomp_nl to catch
these issues?

--=20
=46elipe Contreras
