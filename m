From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/8] t5520: test no merge candidates cases
Date: Mon, 18 May 2015 10:46:50 -0700
Message-ID: <xmqqoalhdbhx.fsf@gitster.dls.corp.google.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
	<1431955978-17890-3-git-send-email-pyokagan@gmail.com>
	<e89b333476cbb1e546371a07b357cd42@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 18 19:47:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuP7y-0001F1-3f
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 19:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbERRqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 13:46:53 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33707 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbERRqw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 13:46:52 -0400
Received: by igbpi8 with SMTP id pi8so87671131igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2OPbz9lmSdH02mAmUWBPejwoCi7NhBkP0fDwq3MQT74=;
        b=gk1MU1MK8q95ICoaOMnBo8clSW+d7tS7at6CLCajrxYF0YRAF1MRN/Uob2wWmNQAZY
         HCO7Z2aPmaOkrn3IJLMB7BI3ysXf95SJZHikhdkOaRlZjwXKt3yh+Y5pabEvdgeD+SIo
         QPaPhhAv/XQT8PKdgg/3QBHWT8JKBAGKgA17GP6P6aXtMX6dHiifzvU5PGy5Fea3GoXr
         M0KmWzmxhVBqed+kIw//pxIup1PABfJDTBHKmO0AkfyUdDk0z5p20gHsIxZHnyB7JJBc
         z72QWSI9Jidb2wh3MAKpq1D513aPxUYK/ZJexyEIjXTsoOY2GA1KlhcIcK1AmyVpeXqO
         yl7Q==
X-Received: by 10.107.160.141 with SMTP id j135mr31073431ioe.43.1431971212307;
        Mon, 18 May 2015 10:46:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id 16sm8129789ion.20.2015.05.18.10.46.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 10:46:51 -0700 (PDT)
In-Reply-To: <e89b333476cbb1e546371a07b357cd42@www.dscho.org> (Johannes
	Schindelin's message of "Mon, 18 May 2015 17:08:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269283>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> +test_expect_success 'fail if wildcard spec does not match any refs' '
>> +	git checkout -b test copy^ &&
>> +	test_when_finished "git checkout -f copy && git branch -D test" &&
>
> When I read this line, I immediately asked myself whether the
> branch would be deleted even if the test case failed. I then
> tested this theory by editing the first test case ("setup") like
> this:
> ...
> and indeed, the file "file" was gone, even if the test case
> failed. I therefore believe that this "test_when_finished" cleanup
> might make debugging substantially harder. Maybe we can drop these
> lines from this patch?

The test framework is aware of the fact that it needs to help the
people who are debugging the scripts.  The support is limited to the
case in which you run it under the -i option, i.e.

	$ cd t
        $ sh ./t5520-pull.sh -i -v

will refrain from running test_when_finished scripts when the test
piece fails.  Even though this is only limited to -i, I found it
often sufficient for debugging.
