From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] builtin/clone: support submodule groups
Date: Wed, 25 Nov 2015 16:33:16 -0800
Message-ID: <CAGZ79kZ3Pf6PTp_hoC5PrGq59EH35-dzC7jRQhNn-v3jTkFQrg@mail.gmail.com>
References: <5656366D.4010508@web.de>
	<1448497884-2624-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:33:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1kUw-0000jC-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 01:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbbKZAdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 19:33:18 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33883 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbKZAdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 19:33:17 -0500
Received: by ykfs79 with SMTP id s79so75029269ykf.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 16:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JrbVirXW5Hiuwq0bY0b4wmftlwOzIxuQHkC1F14idx4=;
        b=bnQcYNwkhX7TmutOXso1T89KmxS5ceb2sID5ShpLZwY7qZjL1O7q4amhqAq+5j51Vm
         x5g/WKAhvzrBQKiFSVi2n55c/EL+2pB7TwejVBxTLTnRoq3waXR1cCuTfc9JpIefJQc4
         4E3ulQKR8KNayZPXVg716YZ8+H0wc7XZYz7wxY0KVIUOtIb6+/pFZcBVCdMTPshOhYnh
         Oyg5CXDcX43w7XKZepXkXTExWECt+Fh+kevhJmBEdOzAu0VBQO+KQXdjEnwUF0DfgHDB
         k53FKdt9PkuviFRZgagC4lGcZM+ZIBv4DYdla9PzWmU+ubNRKunDAMxNGig84KRzsWgy
         zCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JrbVirXW5Hiuwq0bY0b4wmftlwOzIxuQHkC1F14idx4=;
        b=hH84M8GL8eCyB42Uw+BueizAmicGi34+ktPOw+yUJ9iYiQYLxPMlaOhuMnSsasKUHD
         AuIqPPzgzcbEQfea1S7tt2Wd/YbXHzmlh+QZ4i/4wBQL1yMkzaNxyg2nYl+UubAThu7b
         6PzxEBGSvZoh0wsXD97rUEf/rybp4uM7vQ70bzByZR//02oXKg70lGfD1ht1INrMtyde
         4AW5K8BuGXlghApU3BkATQ829dC/v9JlJoUEs7iLQz7XLKYVFnIINeJZ48JKTnHjQBrp
         WxfSkcazON2ssoKeUFCrR8VJ6yKn1yyoQzq5SHjn5eKQSF/LkYYH0YLes3TBU0yBbUcE
         enlA==
X-Gm-Message-State: ALoCoQkUUt/2BVSsdrSLaz06sdxeZz0+wTDWXAA+KPDXNEqv6Nudz5SnoeAWxN3x3QQ3zzbqRmBU
X-Received: by 10.13.235.135 with SMTP id u129mr38564561ywe.48.1448497996461;
 Wed, 25 Nov 2015 16:33:16 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 25 Nov 2015 16:33:16 -0800 (PST)
In-Reply-To: <1448497884-2624-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281752>

On Wed, Nov 25, 2015 at 4:31 PM, Stefan Beller <sbeller@google.com> wrote:
> This passes each group to the `submodule update` invocation and
> additionally configures the groups to be automatically updated.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This is a resend of the patch "[PATCH 5/5] builtin/clone: support submodule groups"
> as that's where Jens and I discussed.
>
> * reworded the documentation to match reality of the patch

Oh wait, I just wrote down wishful thinking (at least partially)
You cannot quite specify the comma separated list yet in one --group parameter.
