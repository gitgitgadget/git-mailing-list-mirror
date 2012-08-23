From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Support generate poison .mo files for testing
Date: Thu, 23 Aug 2012 17:53:52 +0700
Message-ID: <CACsJy8Bc=GZH+d_VLMqHFKz93zBed5oHjOjUgWa4piY-tpdUNA@mail.gmail.com>
References: <7va9xofbgo.fsf@alter.siamese.dyndns.org> <1345613246-4053-1-git-send-email-pclouds@gmail.com>
 <7vboi3b2n8.fsf@alter.siamese.dyndns.org> <CACsJy8Dp5FZd9Ko6o18r5TeS5dfbjv61wOmP1452zyvHfX5LMQ@mail.gmail.com>
 <7v393ec2w9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 12:54:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4V3X-0008Io-I2
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 12:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341Ab2HWKy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 06:54:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42559 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030305Ab2HWKyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 06:54:24 -0400
Received: by ialo24 with SMTP id o24so1104077ial.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=igJ94WpcUKMudsNoYSljErykF9sFaGSAldnaJvUMMtE=;
        b=xRSjSZhdGxBh3afLpJf1ZMCQVYD1OCZK5VHg9iPL5aM7CbZLAmKkB0LNRMVyVTIv0e
         MPXloRsQ4oyOmL4TFTNVG8edmWpuW2iHLGcJA/XtJF/OfV56S9kglBBmDfz8XN5xVEaM
         3Sg+mAd0Rdc9xN0n9I9VKXVn1tO3w3JeYnBkiLU0Tc1njj+qqaR8IzgmY3+KpQP2Rnx9
         Ex8xGaYcpxMZgERdkqW62bkcPob7RyJRBhhlHq/mZOTDPTlSuh2JPZ0Xfo7Ddq9iErKj
         cq8sFIDrg33N3+CHEHhbMV3zu/yalhucQRwPm6xdfNRJ+vWhEyh2LZ0GZa/VV44bPZQD
         GgsA==
Received: by 10.50.184.135 with SMTP id eu7mr5454047igc.15.1345719263150; Thu,
 23 Aug 2012 03:54:23 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Thu, 23 Aug 2012 03:53:52 -0700 (PDT)
In-Reply-To: <7v393ec2w9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204145>

On Wed, Aug 22, 2012 at 11:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> But a better way could be
>> replacing "tracked" with "t r a c k e d". We know the rule so we can
>> recreate the that string from "tracked" in test_i18n*. Or reverse the
>> upper/lower case, whichever is easier for the recreation by test_i18n*
>
> That does not make much sense to me, so either one of us must be
> slightly confused.  I thought the only purpose of testing with the
> "poison" was to find messages that must not be localized but were
> localized by mistake.  For that, we have to make sure that anything
> that uses test_i18n* is reading from Porcelain, in other words, we
> must use the byte-for-byte comparison without using test_i18n* when
> verifying the plumbing output.  And the primary requirement for this
> arrangement to work is that the expected output in C locale and the
> actual ouptut in the synthetic poison locale are reliably different.
> They do not have to be reversible (I was actually going to suggest
> rot13 of the original instead of cycling through the "* gettext
> poison *" in your patch --- prefixing with QQ would not work, as it
> is likely that the test with "grep" may not be anchored at the left
> end).

Yes, for verifying plumbing output that should be enough.

> Teaching test_i18n* to fuzzily match the expected output in C locale
> against the actual output in synthetic poison locale may or may not
> be doable, but spending any cycle working on that sounds like a
> total waste of time (even though it might be fun).  It does not test
> that we are translating Porcelain messages correctly.

Right. I was aiming at testing translated messages but obviously went
off track trying to test a fake locale instead. Thanks for stopping
me.
-- 
Duy
