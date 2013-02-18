From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 05/10] pkt-line: rename s/packet_read_line/packet_read/
Date: Mon, 18 Feb 2013 03:05:56 -0800
Message-ID: <20130218110556.GA9294@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092252.GE5096@sigill.intra.peff.net>
 <20130218101915.GE7049@elie.Belkin>
 <20130218102931.GP5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 12:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7OYK-0008Rp-BR
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 12:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab3BRLGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 06:06:07 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:64281 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3BRLGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 06:06:06 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2439320dak.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 03:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sqmQdIfKIuIjCN/LX7YY0AWiM2J/IfqDuTIr4Qi5nbs=;
        b=0PY0IRQyVCPV5lSLK3F6SclyIIO0g1EGC63r6XM5qW5xXiIzAcyj11iV7sMqekUrR+
         IUzACviH/17l1qbhSeO8Y+bzpkH6a1litXoBcKXCDC57DtTnrsAOysjGliVZGqCO0t3D
         QN8JTPfXgCEA5tj4hB0GYJKS3aHg+vkH7qtR1LsmjvMLoKYQaKxYjcLcmMxDoLhs9ZEu
         DnOvI0/1EapUz9Bq7hrsfw3sj9xMU88ZblEmSusTkW4VZ5XFJ8saDuugmQjx6f3W4ygn
         YJ3AjvBhlAe+9m8EJDLD8I7hU2AMvolrj/fKYR74OSSgOSE7otX64t/6l5sjuO7jQDLv
         2zxA==
X-Received: by 10.68.227.202 with SMTP id sc10mr29049923pbc.109.1361185564937;
        Mon, 18 Feb 2013 03:06:04 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qb10sm14155347pbb.43.2013.02.18.03.06.02
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 03:06:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218102931.GP5096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216477>

Jeff King wrote:
> On Mon, Feb 18, 2013 at 02:19:15AM -0800, Jonathan Nieder wrote:

>> In combination with patch 3, this changes the meaning of packet_read()
>> without changing its signature, which could make other patches
>> cherry-picked on top change behavior in unpredictable ways. :(
>>
>> So I'd be all for this if the signature changes (for example to put
>> the fd at the end or something), but not so if not.
>
> True. Though packet_read has only existed since last June, only had one
> callsite (which would now conflict, since I'm touching it in this
> series), and has no new calls in origin..origin/pu. So it's relatively
> low risk for such a problem. I don't know how careful we want to be.

I was unclear.  What I am worried about is that someone using a
version of git without this patch will try some yet-to-be-written
patch using packet_read from the mailing list and not notice that they
are using the wrong function.  For example, if someone is using
1.7.12.y or 1.8.1.y and wants to try a patch from after the above,
they would get subtly different and wrong results.

The rule "change the name or signature when breaking the ABI of a
global function" is easy to remember and follow.  I think we want not
to have to be careful at all, and such rules can help with that. :)

Thanks,
Jonathan
