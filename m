From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] teach git-config to output large integers
Date: Tue, 20 Aug 2013 23:34:58 -0700
Message-ID: <20130821063458.GB2802@elie.Belkin>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <20130820224710.GB24766@sigill.intra.peff.net>
 <20130820225745.GL4110@google.com>
 <20130821030036.GD25296@sigill.intra.peff.net>
 <20130821043841.GA2802@elie.Belkin>
 <20130821050053.GA875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 08:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC20g-0006bU-52
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 08:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab3HUGfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 02:35:07 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43105 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab3HUGfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 02:35:03 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so27820pdj.11
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZwlPBJa4TcUeJ2qXJCAIE18WFLVdK3zUH07BkbmxaV8=;
        b=zXQmtEKjl8xh80g5sVYTbBVJ9fuugnqTdxjgvUgH9FyQMVcyRWJTGkFfL+JEpoPYYx
         5xK58DBue4NfGzrwhtgUGBB5spdxuud0MXujRj85FhXXxycyjf7Z4BxTngNs5RAP1hdV
         WeIVDPwHtUc8JOaT+umqtlYoDoiamOHpt8c2gpzACxqTUWnxkkp0CQ8Hq3W273/PhIhS
         vjsexEq7oheKiXJsTQ6QWvjMfq+DzZyVxGuz8hgG97uZ1Gp6J8hy8dtwlz+0bdcvDCW4
         rJmbKBnkOqr0JOToIkgS1arooRZgnDnK4etfdXmiGZmuTDL8F8eP+3ijOUMlgT4n4Dea
         vKMg==
X-Received: by 10.67.23.164 with SMTP id ib4mr8021803pad.42.1377066902721;
        Tue, 20 Aug 2013 23:35:02 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id yk10sm8058862pac.16.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 23:35:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130821050053.GA875@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232688>

Jeff King wrote:
> On Tue, Aug 20, 2013 at 09:38:41PM -0700, Jonathan Nieder wrote:

>> That is what I was trying to get at in discussing the test.  It is not
>> "We would like --int to reject values higher than this, but some
>> platforms do not allow us to", but "Either rejecting this value, or
>> even better, computing the right size and printing it, is an
>> acceptable behavior, and this test checks for those."
>
> You are conflating the two patches, I think. The test we were discussing
> is for the _first_ patch, which fixes a bug in the range check. It is
> not meant to test git-config in particular, but to test that values
> higher than INT_MAX and lower than LONG_MAX are properly range-checked.
>
> Forget the second patch for a moment. I believe the first one is a bug
> fix that we would want even if we do not take the second patch at all.

Sure.  I'm not conflating the patches.  What I mean is that tests are
supposed to test desirable behavior, whatever that is --- they are not
about preventing all behavior changes but only about preventing
regressions.

So talking about tests is a (perhaps overly roundabout) way to figure
out the desirable behavior.

In particular, at first glance I would think computing 3 * 2^20
instead of erroring out would be a *good* behavior, not a regression.
If that's right, it doesn't make sense to me to go to careful lengths
either to test that git continues to error out on most platforms, or
to introduce new options to ensure "git config --int" continues to
error out.

That is what I am trying to understand.  Everything about the first
patch except for the test makes sense to me, but the test doesn't.  As
you noted, we know the test won't pass on some platforms.  Why is it
something we should *want* to pass?

Jonathan
