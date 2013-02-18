From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] remote-curl: verify smart-http metadata lines
Date: Sun, 17 Feb 2013 16:54:43 -0800
Message-ID: <20130218005443.GB3221@elie.Belkin>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064707.GB22626@sigill.intra.peff.net>
 <20130217104939.GE6759@elie.Belkin>
 <20130217191422.GA25096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:55:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7F0j-0003gM-2n
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119Ab3BRAyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:54:49 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:63619 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995Ab3BRAyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:54:49 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2220186dak.30
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 16:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uOfxEaBffPSFs/l3D8lo0oGjC/AYENEZne9Q3OGU8/A=;
        b=u7QFEw/e28k93JK5lRQbY/ugnGzvaGzyElzTq8EGJu93FF9+zgKEp0wNQa931LueQ7
         5PXlFDyeD7Yj0lQMQlBOQNu8WeQYooWBH7aRsqVSKbWLtgkS0bf6K66CuLNC2kebw3+d
         BDydsdOtK+D1HwkreXjF95DGNh3w9C3PPUbfcKQDqE9ChmeNJwHISm8Sy+4SccARjtwM
         6lq5DdAQJHucyeu4tGXDmFsVlWpaixee+JrM4GSsHLVGFZzbzkkOeMMvZ0VmTlagEosh
         vhHljm7QOUUYcSv1idP5NufJARGkZaFB/8T2bXa433pnOM7ZUllMURliutiNZl7yYd4W
         DcfA==
X-Received: by 10.68.143.99 with SMTP id sd3mr25203065pbb.53.1361148888684;
        Sun, 17 Feb 2013 16:54:48 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id o5sm101760232pay.5.2013.02.17.16.54.46
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 16:54:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130217191422.GA25096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216425>

Jeff King wrote:
> On Sun, Feb 17, 2013 at 02:49:39AM -0800, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> --- a/remote-curl.c
[...]
>>> +		if (read_packets_until_flush(&last->buf, &last->len) < 0)
>> 
>> Style nit: this made me wonder "What would it mean if
>> read_packets_until_flush() > 0?"
[...]
> My intent was that it followed the error convention of "negative is
> error, 0 is success, and positive is not used, but reserved for
> future use".

>From a maintainability perspective, that kind of contract would be
dangerous, since some *other* caller could arrive and use the function
without a "< 0" without knowing it is doing anything wrong.  When new
return values appear, the function should be renamed to help the patch
author and reviewers remember to check all callers.

That is, from the point of view of maintainability, there is no
distinction between "if (read_packets_until_... < 0)" and
"if (read_packets_until_...)" and either form is fine.

My comment was just to say the "< 0" forced me to pause a moment and
check out the implementation.  This is basically a stylistic thing and
if you prefer to keep the "< 0", that's fine with me.

>                                                                      If
> an implementation is producing bogus packet lines and expecting us not
> to complain, it really needs to be fixed.

Agreed completely.  Thanks again for the patch.

Jonathan
