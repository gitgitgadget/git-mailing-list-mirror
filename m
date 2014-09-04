From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Thu, 4 Sep 2014 21:19:29 +0700
Message-ID: <CACsJy8B4BFMh692KJ5eVS6FsP_mCCMNCZcBdxyOMxfxEFBsQXw@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley>
 <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
 <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com>
 <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley> <CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com>
 <5405D983.3050707@xiplink.com> <xmqqfvga2ai9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 16:20:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPXtT-0002Px-NQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 16:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbaIDOUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 10:20:03 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:54965 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbaIDOUB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 10:20:01 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so1153493igb.2
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6du+qi/JR0p6P3XJ4aIX2kC9FZaanczwGE3AnwS6tWU=;
        b=Yv2zSgPZ4llyvyHAoxKaekb8MJ3+C3KLVjg5bptf1xBXx9f3LyV9w1266Tpp+E+hsB
         D3A3W5dXgxPjJx6n+OvDwsi+gIgrU+bYj54FY7OjNj3myxFwbu8qPEaOtb6/wNM5hQpM
         RSFy/wQHtF/qndlFxH6wr6I2V+wyygUtraQpi6/1Yxq6FlRDRdmhpv1Ud88qV8U316Bn
         KN9fee6G4f/eaI2uU9Wy5paBULJWBw4CAztPVHeaEfGdOt0un4E7A7LlELUPMxEHEUK2
         x1XMGU2sD+/V9AyfuROWgrFkZjnuRXq33yAfAI3bN7pzbS0UrH4YinMjLZSaJqHs4+OJ
         yd6g==
X-Received: by 10.50.61.145 with SMTP id p17mr7227452igr.41.1409840399349;
 Thu, 04 Sep 2014 07:19:59 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Thu, 4 Sep 2014 07:19:29 -0700 (PDT)
In-Reply-To: <xmqqfvga2ai9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256446>

On Wed, Sep 3, 2014 at 12:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> On 14-09-02 08:27 AM, Duy Nguyen wrote:
>>> After reading this "multiple checkout mode" in git-checkout.txt, I'm
>>> tempted to rewrite it like this. I think the example makes it clearer
>>> what I mean. If nobody has any comments, I'm going to send v2 with
>>> this (and other comments collected so far)
>>
>> Overall I think focusing on the word "checkout" for this feature makes the
>> documentation confusing.  It's also not a "mode" but just another git
>> feature.  Since this is all about multiple working directories (the phrase is
>> actually "working tree" in the existing docs) we should just stick to that
>> rather than introduce new terminology.
>>
>> Finally, a bit of bikeshedding, but I think "$GIT_DIR/repos" is also an
>> unfortunate choice and that "$GIT_DIR/worktrees" would be better.
>
> I tried to stay away from bikeshedding, but a good phrasing is
> important.  I think $GIT_DIR/worktrees captures what they are trying
> to represent better in that they are not storing repository
> information, but they are about storing per-worktree state.

Good thing this topic is in pu. Will s/repos/worktrees/ then.

>> So I suggest the following for the new section:

Will replace my text with yours. Thanks.
-- 
Duy
