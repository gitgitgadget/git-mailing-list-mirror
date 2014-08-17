From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter
 instead of mmap
Date: Sun, 17 Aug 2014 18:33:54 +0700
Message-ID: <CACsJy8BUBfQeny4iu6nZ+pCy84_=8EEfEHY3pWLpx_1PLCwC5w@mail.gmail.com>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de>
 <1407303134-16635-3-git-send-email-prohaska@zib.de> <20140816102703.GD7857@serenity.lan>
 <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de> <20140817072746.GD23808@peff.net>
 <C1695CEB-B278-422A-90D6-C3EAD8B6638C@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 13:34:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIyjL-0004jS-9F
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 13:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbaHQLe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 07:34:26 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:49457 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaHQLeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 07:34:25 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so5436330igd.8
        for <git@vger.kernel.org>; Sun, 17 Aug 2014 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y7Wls8litxkyaUh4weoFjUchgpd5bT0Ev186RQ8qTbQ=;
        b=Dq3teLZCnkHdxz8Cj7MM+ff40tWZqp4YjBDFFX3alJr+UN3vM1favQsusRfMekhSyt
         KPOOoLE2egLQfpdVdIlzG2IJLqra1JASuJFk9334baQcv0Dl79vWA7s8DnPyzE3y9nRn
         ixsRcBYrpeBT+rc7N6NrnGVs3laQjn2523kknISLu/+F1rM7mMP9VOmtzXNPvawb+LYL
         DTDn7uehlVtdoWQMGGapTatGPrWfGvsP/zo++Cfg0oNuXKEymv2rlJRC3DEVm/lOvAes
         7lZ7RA6PPzPE/sxXgqJd6tmfxXjCkaI1Gyo19ic1RY1AHD4nYen2HwE1OOGArsoVOW4Q
         OEDA==
X-Received: by 10.50.87.10 with SMTP id t10mr76720662igz.41.1408275264522;
 Sun, 17 Aug 2014 04:34:24 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Sun, 17 Aug 2014 04:33:54 -0700 (PDT)
In-Reply-To: <C1695CEB-B278-422A-90D6-C3EAD8B6638C@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255365>

On Sun, Aug 17, 2014 at 5:25 PM, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Aug 17, 2014, at 9:27 AM, Jeff King <peff@peff.net> wrote:
>
>> On Sat, Aug 16, 2014 at 06:26:08PM +0200, Steffen Prohaska wrote:
>>
>>>> Is the 15MB limit supposed to be imposed somewhere or is it just a guide
>>>> of how much memory we expect Git to use in this scenario?
>>>
>>> The test should confirm that the the file that is added is not mmapped
>>> to memory.  The process size should be relatively small independently
>>> of the size of the file that is added.  I wanted to keep the file size
>>> small.  The chosen sizes worked for me on Mac and Linux.
>>
>> Measuring memory usage seems inherently a bit flaky for the test suite.
>> It's also a little out of place, as the test suite is generally about
>> correctness and outcomes, and this is a performance issue.
>
> For files >2GB on a 32-bit system (e.g. msysgit), filtering with the previous code always failed.  Now it works.  I created the patch to change git from 'fundamentally doesn't handle this' to 'works as expected'.

I deal with similar problem and added $GIT_ALLOC_LIMIT to test large
blob code. Maybe we could add $GIT_MMAP_LIMIT? I don't suppose we call
xmmap/xmalloc so often that the extra test would slow git down.
-- 
Duy
