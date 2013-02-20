From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 08/19] write_or_die: raise SIGPIPE when we get EPIPE
Date: Wed, 20 Feb 2013 14:06:37 -0800
Message-ID: <20130220220637.GC24236@google.com>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
 <20130220215043.GA24236@google.com>
 <20130220215845.GB817@sigill.intra.peff.net>
 <20130220220114.GB24236@google.com>
 <20130220220359.GA1417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:07:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Hog-0005qh-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 23:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab3BTWGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 17:06:42 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63902 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3BTWGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 17:06:41 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so4285504pad.14
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 14:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NN/s3LLVNk0Blkdnkk0hhFPULl2R7bFbY8/bz9rQNiM=;
        b=e347ab6sAh1ycoUrgrVOoaw2ygaYLASGa2ZPAK6nwuL3v5Pyv7IAFNL8u7X0M8YB0K
         OCXp/hLO7gkUe/hC18Ps5PYYoMc/AxUXkZJPcKNssKjhc75OH5sPvKVueLyVJ5WAjTOS
         eob2mRCVQjAOJWRKcULD/let2FntSb7Qonwkd9nyGAumLX4kahjsJM/PgqCFcPhWjH6K
         ot5vwizPsjxgDgwC+Gz+N7RuNqwgMCBvJsDxLRc0uV9wsmJUBlY3mHkhZBj4xzYKXaay
         72BdItNdKAv61yKqiQp/Hay8p8awvNym8BE5HwAeqbBwAAiMF//0tJZEhUV8QkryL8yn
         usPA==
X-Received: by 10.68.195.197 with SMTP id ig5mr4769743pbc.178.1361398001347;
        Wed, 20 Feb 2013 14:06:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id d1sm112455779pav.6.2013.02.20.14.06.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 14:06:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130220220359.GA1417@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216741>

Jeff King wrote:
> On Wed, Feb 20, 2013 at 02:01:14PM -0800, Jonathan Nieder wrote:

>>>> How about
>>>>
>>>> 		die("BUG: another thread changed SIGPIPE handling behind my back!");
>>>>
>>>> to make it easier to find and fix such problems?
>>>
>>> You mean for the "should never happen" bit, not the first part, right? I
>>> actually wonder if we should simply exit(141) in the first place. That
>>> is shell exit-code for SIGPIPE death already (so it's what our
>>> run_command would show us, and what anybody running us through shell
>>> would see).
>>
>> Yes, for the "should never happen" part.
[...]
> I don't mind adding a "BUG: " message like you described, but we should
> still try to exit(141) as the backup, since that is the shell-equivalent
> code to the SIGPIPE signal death.

If you want. :)

I think caring about graceful degradation of behavior in the case of
an assertion failure is overengineering, but it's mostly harmless.
