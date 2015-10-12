From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 21:37:16 +0200
Message-ID: <CAHGBnuOqVPHAhfN6qtt=VDODW9h+A1xMEnzaZfD61DCNyj_YOg@mail.gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<561B69AE.8050403@gmail.com>
	<BF182294-B896-4C2D-B371-74036BC522A2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	tboegi@web.de, pw@padd.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:37:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZliuS-0004Lh-9d
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbbJLThS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:37:18 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38739 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbJLThR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 15:37:17 -0400
Received: by igkz10 with SMTP id z10so54078675igk.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mJ1FnyghnjBaR+0xqcHMx6SMYxfV+n+PI4e9n2I+n2A=;
        b=s8870WQTxC750GA3TwBcNr9YVXVRJ/qtmAMQQfDpJvu/AtYGZwH4i2b6Xa6rDg3I9R
         FTWxsB0KhZbuuJiqGf33pmC69z9Vp0ZFyNa94ZSHVTciu6g8JgeckpGQRCKSyFeIlAJB
         wlilKhgS1QK+SNlbEhfsyCdZDLT/j08+y4E7esFmHZefbLTneG4+JFyfTPKj6VwO89fx
         ZK3ZXhsIHwrKPRL1NOYR4jcsigTS/KPLWxbQJvmx56r5STVC9ZKHht0o2Rtl1HE2Qsju
         LgGkT4YmY8ATtQ/EsSRPsnRyxaktqantB+0eCnJojK6xuk5Adc2FXUum3ByesSoCTp72
         vxZg==
X-Received: by 10.50.80.14 with SMTP id n14mr13361283igx.30.1444678637031;
 Mon, 12 Oct 2015 12:37:17 -0700 (PDT)
Received: by 10.107.138.213 with HTTP; Mon, 12 Oct 2015 12:37:16 -0700 (PDT)
In-Reply-To: <BF182294-B896-4C2D-B371-74036BC522A2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279407>

On Mon, Oct 12, 2015 at 7:12 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:

>>> +install: make configure && ./configure
>>> +
>>> +before_script: make
>>> +
>>> +script: make --quiet test
>>
>> Semantically, it does not seem correct to me that configuarion goes to the install step. As "make test" will build git anyway, I'd instead propose to get rid of "install" and just say:
>>
>> before_script: make configure && ./configure
>>
>> script: make --quiet test
>
> I understand your point. I did this to make the "make" logs easily accessible (no option "--quite"). By default Travis CI automatically collapses the logs from all stages prior to the "script" stage. You can uncollapse these logs by clicking on the little triangle on the left border of the log. Therefore the "make" logs are available without noise.

To make this more clear, I guess what you're referring to is the
visual difference between [1] and [2], correct?

> Do you see value in "make" logs?
>
> If yes then we could also do:
> before_script: make configure && ./configure && make

Reading through Travis' docs [3] again, "before_script" is documented
to "return a non-zero exit code, the build is errored and stops
immediately", while "script" is documented as "returns a non-zero exit
code, the build is failed, but continues to run before being marked as
failed". As it does not make much sense to continue the build or even
start testing if the build failed, maybe it's indeed best to do:

before_script: make configure && ./configure && make

script: make --quiet test

[1] https://travis-ci.org/larsxschneider/git/jobs/84805733
[2] https://travis-ci.org/larsxschneider/git/jobs/84955658
[3] http://docs.travis-ci.com/user/customizing-the-build/

-- 
Sebastian Schuberth
