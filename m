From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v7 0/9] submodule: improve robustness of path handling
Date: Tue, 29 May 2012 08:01:19 +1000
Message-ID: <CAH3AnroT1vs-s==ykNyogq6gbVncY0pt5U1=fMp+b6B0jwG19Q@mail.gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
	<4FC3DAEF.1070508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, phil.hord@gmail.com,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue May 29 00:01:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ80D-0005cC-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 00:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033Ab2E1WBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 18:01:21 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40400 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2E1WBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 18:01:20 -0400
Received: by wgbdr13 with SMTP id dr13so3263469wgb.1
        for <git@vger.kernel.org>; Mon, 28 May 2012 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bYE6crEkxw7IALb0g4Xe24XRdLZ7brki1ZYo3uRMNn8=;
        b=dovacpW21aUKkFTa/0RNii7GnFE4UhIqVVL4+NMxC2YBu4wJlQI3wI8SRkygi0xxYJ
         p6ARm3kopZ5iTFM1aVUwoFOS4AkVuMe5AzFbFPywqQmFGREmiWKIlEFEw/XsvFw5C8hx
         Coj7IQbVck8659olpfdmO9urffRr8avGfMBDLUMuuYox1FZ3qXCr1tap46SJg8kNgMK9
         mrBt34xcn5Z15Sd1M7IEEBRTBobrlOtKewIT5l2IBHYBebsr4J2XkGucfqC1W1s7OpRJ
         DvqRgLC+Yh1n6lEunnxwCzUPvsZky7WxcNW+820d7KjBFgNBZPOJGDhw4SYW83gO6kEm
         CSfg==
Received: by 10.216.228.135 with SMTP id f7mr6148851weq.129.1338242479667;
 Mon, 28 May 2012 15:01:19 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Mon, 28 May 2012 15:01:19 -0700 (PDT)
In-Reply-To: <4FC3DAEF.1070508@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198727>

On Tue, May 29, 2012 at 6:07 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 27.05.2012 17:34, schrieb Jon Seymour:
>> This series improves the robustness of path handling by 'git submodule' by:
>>
>> * detecting submodule URLs that will result in non-sensical submodule origin URLs
>>
>> * improving handling of various kinds of relative superproject origin URLs
>>
>> * improving handling of various kinds of denormalized superproject origin URLs
>
> Hmm, this has become a quite invasive patch series. While I bought the
> use case of having a superproject with a relative url and was inclined
> to accept that it might even not start "./" or "../" (even though that
> is a pretty unusual use and can be easily fixed by prepending a "./"),
> I'm not sure the in depth check of URLs is worth the code churn. And
> especially the high probability of breaking other peoples use cases in
> rather subtle ways worry me (this did happen quite often when the
> submodule script was changed in the past; as an example take the
> windows path issues Johannes already pointed out in his email). And I
> can't remember bug reports that people complained about URL problems
> due to the issues you intend to fix here, which makes me think they
> might be well intended but possibly unnecessary (but my memory might
> server me wrong here).
>
> So I'd vote for just fixing the relative submodule path issues and to
> not care about the possible issues with URLs. Opinions?

I'll write a minimal patch to solve my relative path problem without
fixing the invalid/"greedy" submodule url or url normalization issues.

The reason I went with a more extensive series is that the change in
6/9 considerably simplified the change I wanted to make in 7/9 while
at the same time making the path handling of resolve_relative_url more
precise, in the sense documented by the tests in 2/9.

The refactoring in 5/9 and the changes in 8/9 and 9/9 are related to
renormalization which I realised was a weakness (if not a problem
people were complaining about) in the original code as documented by
the tests in 4/9.

Do you have any comments about whether the failures documented in 2/9
and 4/9 are worth noting, at least, as weaknesses?

>
> (And patches 6-8 contain changes to test cases other than just changing
> test_expect_failure to test_expect_success which makes reviewing this
> series unnecessarily hard)

Agree absolutely about patch 8 - I will re-roll with separate tests to
document the test setup issue I fixed in 8.

The only other changes to tests in 6 and 7 were the removal of
comments about the actual bad behaviour. Would your preference be that
I removed these #actual comments completely or that I moved
documentation of the actual behaviour to the header of the test?

jon.
