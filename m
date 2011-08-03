From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v13 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Thu, 4 Aug 2011 01:13:13 +1000
Message-ID: <CAH3Anro1Hs5VBT9901PoDdhGjtzTEZHWd9hgHvjfB_ivSErHMw@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD3XzUjxiz6QQzyTOYzfiWrF4ckiv0h+gvi7YuZkma6yiw@mail.gmail.com>
	<CAH3AnrrkAeN3BgnnFBsbzh=37tC6f6aRACgk94wxW85qFQpfVw@mail.gmail.com>
	<201108030727.04246.chriscool@tuxfamily.org>
	<CAH3Anroaq+fH3T3_G1HsS3ecdNdpReaKLC5v=x37rDqSmtghww@mail.gmail.com>
	<CAH3AnrpQZJprVtkNH1oeGXADzy1HA20xSTD8Cwpo3=ymOjgYhA@mail.gmail.com>
	<CAP8UFD3QvXv_gnAtw3qMCOdDyAUAFMYcf33ieP+HebvTf3SGAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 17:13:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qod8L-0007YT-ER
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 17:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab1HCPNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 11:13:15 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52556 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab1HCPNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 11:13:14 -0400
Received: by vxh35 with SMTP id 35so688910vxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lGrjS+xhrhMPwAmyWSJbPlRx1MZc7CyVvjlQCMOm5mI=;
        b=YMpDx1T3K+Zn2SDIDerqutiT7GPDQCDWJKPYe17eQZ7VAa+C598XiIH4DnDVSsJpRu
         S3NqTyD/NIsdo4oLJHbIWKFVDS1SjjNXv08F1o/zT/KnUqp7j9DqNwsMpwnX7LHkjL9f
         RRyAu8L7uKT6oBzc+nt/96RhweBjog7siM65I=
Received: by 10.52.98.197 with SMTP id ek5mr6776454vdb.298.1312384393403; Wed,
 03 Aug 2011 08:13:13 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Wed, 3 Aug 2011 08:13:13 -0700 (PDT)
In-Reply-To: <CAP8UFD3QvXv_gnAtw3qMCOdDyAUAFMYcf33ieP+HebvTf3SGAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178589>

On Thu, Aug 4, 2011 at 12:09 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Aug 3, 2011 at 3:24 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>> On Wed, Aug 3, 2011 at 10:46 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>>> On Wed, Aug 3, 2011 at 3:27 PM, Christian Couder
>>> <chriscool@tuxfamily.org> wrote:
>>>> On Tuesday 02 August 2011 16:41:13 Jon Seymour wrote:
>>>>> On Tue, Aug 2, 2011 at 10:04 PM, Christian Couder
>>>>>
>>>>> If I was to do this, I'd prefer to change uses of $BISECT_MODE with a
>>>>> call to a function bisect_mode() that does the same thing.
>>>>
>>>> Yeah, I think it would be a good idea to have a bisect_mode() function.
>>>> I don't like very much to blindly call some code when we might not need it.
>>>>
>>>
>> Mmmm.
>>
>> Actually, there is a neater way to do this.
>>
>> I'll such use the existence of BISECT_HEAD to inform the
>> implementation of bisect_mode().
>>
>> This avoids the need for a separate .git/BISECT_MODE file.
>
> Yeah, but then you have to be careful of the fact that BISECT_HEAD
> might have not been properly deleted or might have been created by the
> user for other purposes.
>

I have removed $GIT_DIR/BISECT_MODE in v15.

If BISECT_HEAD was being used for other purposes, it is going to get
deleted anyway, irrespective of whether we have a separate BISECT_MODE
file, so I am not sure we need to consider that when deciding when we
need a separate BISECT_MODE file.

FWIW: bisect_mode() was only going to get called from one place so I
just inlined the implementation in that place. (on the call to
bisect--helper).

jon.
