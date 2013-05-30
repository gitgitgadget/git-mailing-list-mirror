From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/7] add tests for rebasing with patch-equivalence present
Date: Thu, 30 May 2013 00:41:17 -0500
Message-ID: <CAMP44s0x8e2xpycOEswnYDBM5WKn=fCp7hcUEniARGVZUw1XkQ@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-3-git-send-email-martinvonz@gmail.com>
	<51A5A992.306@viscovery.net>
	<CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 07:41:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhvc6-00015E-GE
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 07:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967490Ab3E3FlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 01:41:21 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:39756 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967478Ab3E3FlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 01:41:18 -0400
Received: by mail-wg0-f53.google.com with SMTP id m15so7368182wgh.32
        for <git@vger.kernel.org>; Wed, 29 May 2013 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BGoeQb6u2lo6bEPdpZv8Cgwndx3FadEv79m+oBML+vk=;
        b=uJtrL6AVCLsmCutCVKCr3kxo38RMFP5SD94thc0HmY/C9KrNpp7EgZlrloR2rAYUM1
         VEktu5DNMio2b3VQesxoGKdlkOcCPTbrAU7Qk4Q6BxfKF1cb2OQ4vq0w1fIF/FE4sbKX
         8exYKL/IywF5ELw/aq0OfTsYFOOjyxHlOLFM2AVDCG/9CJjoDEc8ioP5ixRHfxBaWfU8
         reis6PT0Zbd3QsGMpLKkaUyzTFfjgrG61GJzaCFYr7za2TxA1q7c3Gr9IO7yipBXTWQL
         XiUpdOCUSz5K9eohaWfAk8QU5qo5NrXafV8QGs82MuhajrkOIVLi0XFIV6cTA0IXLCB0
         YHaw==
X-Received: by 10.194.77.66 with SMTP id q2mr2955391wjw.34.1369892477348; Wed,
 29 May 2013 22:41:17 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 22:41:17 -0700 (PDT)
In-Reply-To: <CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225926>

On Thu, May 30, 2013 at 12:30 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> On Wed, May 29, 2013 at 12:09 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
>>> +#       f
>>> +#      /
>>> +# a---b---c---g---h
>>> +#      \
>>> +#       d---G---i
>> ...
>>> +test_run_rebase () {
>>> +     result=$1
>>> +     shift
>>> +     test_expect_$result "rebase $* --onto drops patches in onto" "
>>> +             reset_rebase &&
>>> +             git rebase $* --onto h f i &&
>>> +             test_cmp_rev h HEAD~2 &&
>>> +             test_linear_range 'd i' h..
>>
>> Isn't this expectation wrong? The upstream of the rebased branch is f, and
>> it does not contain G. Hence, G should be replayed. Since h is the
>> reversal of g, the state at h is the same as at c, and applying G should
>> succeed (it is the same change as g). Therefore, I think the correct
>> expectation is:
>>
>>                 test_linear_range 'd G i' h..
>
> Good question! It is really not obvious what the right answer is. Some
> arguments in favor of dropping 'G':

I think the answer is obvious; G should not be dropped. Maybe it made
sense to drop g in upstream, but d fixes an issue, and it makes sense
to apply G on upstream.

Git should not make any assumptions, if the user wants G to be
dropped, he can easily do that by himself.

I don't think it's easy to implement that code-wise, but I think the
ideal behavior is clear.

-- 
Felipe Contreras
