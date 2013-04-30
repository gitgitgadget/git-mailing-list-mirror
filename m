From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 17:38:02 -0500
Message-ID: <CAMP44s3=frHWUh8rQ5kTooUJqwAtkEG37MaeY3Ho6G7-kwZQ_w@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
	<CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
	<7vsj27ac2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJBa-00057V-TC
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933838Ab3D3WiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:38:06 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:62686 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933732Ab3D3WiE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:38:04 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so1023686lbi.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Etw7TWW6+G/3p8DSZSc+2RLW60Een9bnQYXD2Q1oa8k=;
        b=jhHn6FM9o2S+wkF3UN8wHByXyQzYfonkRzK6kiTMOggofCA0+f+gdFC2zRM+YfbaQR
         z5tLqGFdjC03m3+SrD89lc/NdUD8g0X0D9opxUrX/zN/kaU9hYDlV1ExIEnPWqFD6fck
         tk1YV3nsPVBm89lbEM+0TTJR5/5nhB3eKdnpxdre15pTOHlZeq3VeGF8Ckxfx4TdteWz
         EtHiQI9tv55q/YR97Z5hbd4CZqpVABx5pvEv1MiJNO2Eapk+syQuQ0rhSvqZ8FidZoc8
         HuS7ltIVaH3FIr2DhmTap6BxH9wWRJOcr1EDv8bCsxLXbNhtwZ52n38+fSDeuEGTUo0K
         VhNA==
X-Received: by 10.112.154.98 with SMTP id vn2mr369048lbb.8.1367361482746; Tue,
 30 Apr 2013 15:38:02 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 15:38:02 -0700 (PDT)
In-Reply-To: <7vsj27ac2a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223033>

On Tue, Apr 30, 2013 at 5:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> That means "git checout @" should work the same way as "git checkout
>>> HEAD", "git log @~4" would work the same way as "git log HEAD~4",
>>> "git update-ref @ $(git rev-parse master)" should update the HEAD
>>> without creating $GIT_DIR/@, etc.
>>>
>>> You can't go any simpler than that rule, and there is no room for
>>> confusion if that rule is properly implemented.
>>
>> I disagree. I can do 'git log @{-1}-4', but I cannot do 'git
>> update-ref @{-1}'. Why? Because the '@' notation is for revision
>> parsing, and 'git update-ref' doesn't do revision parsing.
>>
>> I'd say, everywhere where you could do @{-1}, you should be able to do @.
>
> Yes, @{-1} is about a ref, the branch that you were on previously.
> That is why you can do
>
>         git checkout fc/at-head
>         git checkout master...
>         git am -s <./+fc-updated-at-head-series.mbox
>         git co -B @{-1}
>
> We wouldn't be able to do the last step, if @{-1} evaluated it down
> to the object name, losing the refname.
>
> If "update-ref @{-1}" does not grok @{-1}, probably there needs a
> call to interpret_nth_prior_checkout() in the codepath.

Maybe, but the closest thing would be dwim_ref(), which would also use
rev parsing rules, so there might ambiguous refs.

Since 'update-ref master' updates the 'master' ref, and not
'refs/heads/master' (IOW; no parsing at all), I think it makes sense
that @{-1} is not parsed, and neither is @.

If the user really really wants rev parsing, she can use 'git rev-parse'.

Cheers.

-- 
Felipe Contreras
