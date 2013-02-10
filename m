From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3 11/11] Unify appending signoff in format-patch, commit
 and sequencer
Date: Sun, 10 Feb 2013 15:55:47 -0800
Message-ID: <CA+sFfMduqEJPtDQyTe2n7QiLmDpTN7MzLGrUNf1hWf-h0rGzvA@mail.gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
	<1359335515-13818-12-git-send-email-drafnel@gmail.com>
	<20130128033921.GP8206@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4gkn-0007S0-OE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 00:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab3BJXzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 18:55:50 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47062 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab3BJXzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 18:55:49 -0500
Received: by mail-wi0-f170.google.com with SMTP id hm11so2708888wib.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 15:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=FH68cAVuxHDOO40mZe6Qx3Rz4woPYbfwSLHHJ2q7SfE=;
        b=YXoKufVYBW64ROjvpomtY/Mp9O4wKTkl2NBBhshKpgkephX4d5EFT0ZW7Lcw3wlXf9
         GnBg1UFpm1Ri/ahSmnTv0OQpKXdhRxFP4P8XwZAl42B0/IMyJj2GJkYVjCURIpuAsHWf
         FzE8t/sWZ+wrEBA4bniDKfvcISeQVmL3nwjTWzlAXJg5g4zMy1Boa0VGQEl+AZBl9Qi/
         b6aJV7VMIqoGN9OcfFeSmyKrjHklzliZm0JpJvGWOraiou0oDccISW+nZiSQCTikrgVx
         w2kkuK1pq7efmCguSCMJTvxH0nxgDgOuL1nNWR2WoCAe+qPmg2TFMhspRujFDeXorONY
         QQrw==
X-Received: by 10.194.76.37 with SMTP id h5mr13419614wjw.21.1360540547929;
 Sun, 10 Feb 2013 15:55:47 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Sun, 10 Feb 2013 15:55:47 -0800 (PST)
In-Reply-To: <20130128033921.GP8206@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215973>

On Sun, Jan 27, 2013 at 7:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Casey wrote:
>
>> --- a/log-tree.c
>> +++ b/log-tree.c
> [...]
>> @@ -208,94 +207,6 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
>>       putchar(')');
>>  }
>>
>> -/*
>> - * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
>> - * Signed-off-by: and Acked-by: lines.
>> - */
>
> That's stricter than the test from sequencer.c.  Maybe it's worth
> stealing to avoid false positives?

No, we don't want this stricter test because it assumes that the
right-hand side of "[-A-Za-z]+:" will be an email address, so it
requires an '@' to exist.  We want to be able to support lines that do
not have email addresses on the right-hand side like:

   Bug: XXX
   Change-Id: XXX

and perhaps eventually

   Cherry-picked-from: XXX

The current series has retained the same basic test for an
rfc2822-like line that existed in sequencer.c and would interpret a
line that contains only a colon as conforming.  A follow-on patch
could require that at least one character precede the colon, but that
would be a change in behavior that is not the goal of this series.

-Brandon
