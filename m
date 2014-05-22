From: David Turner <dturner@twopensource.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 14:08:16 -0400
Organization: Twitter
Message-ID: <1400782096.18134.1.camel@stross>
References: <1400775763.1933.5.camel@stross>
	 <20140522164634.GB30419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 20:08:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXPj-0002Vu-SH
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 20:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbaEVSIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 14:08:20 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:37793 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaEVSIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 14:08:19 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so6427056qgd.29
        for <git@vger.kernel.org>; Thu, 22 May 2014 11:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=sjfzT2Ag6UarozfVM3QXLRAg4Uh6EAA/nYVzZV8R60M=;
        b=TRsCqthlzriCmMf1AmhNuHEjCOj0CGnPVQfmOG+7jHOIphWkQ3vO5C2bV2a3LHC0F8
         rsgC1CQup1plraNpoKP+kLe7i5cDUQbKGR7HGbMQBDxbjXCX0SddJUCCSItEks7zburf
         GnIMt+tZfxAcd6lgmUecabRpF7ijCoah/yoT8mfkQ1D1Hq0UmA+h32D1l+LIP8sQQbmE
         8Nid3QKHHU8vhG+idMA7FcWRZIwqAAQjqCotjtrXHD9mYR1kVS82aJJQmADRIXfXWo/n
         w5mhWKMqRQoypjnS5jDvz11Ko4PnYDp6QG2Uouav0xWnmnI8Mht4dG7kCO5VqtBbml0w
         PeqQ==
X-Gm-Message-State: ALoCoQnQ7wuMIkm4nFDLubKGDiLu9lN+asJg3d3iaI6PdXMpWxBbZp9lvKK/jhIgHYNfhS7gJu3X
X-Received: by 10.140.104.195 with SMTP id a61mr16016523qgf.102.1400782098595;
        Thu, 22 May 2014 11:08:18 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id 5sm320440qgi.45.2014.05.22.11.08.16
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 11:08:17 -0700 (PDT)
In-Reply-To: <20140522164634.GB30419@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249926>

On Thu, 2014-05-22 at 12:46 -0400, Jeff King wrote:
> On Thu, May 22, 2014 at 12:22:43PM -0400, David Turner wrote:
> 
> > If I have a git repository with a clean working tree, and I delete the
> > index, then I can use git reset (with no arguments) to recreate it.
> > However, when I do recreate it, it doesn't come back the same.  I have
> > not analyzed this in detail, but the effect is that commands like git
> > status take much longer because they must read objects out of a pack
> > file.  In other words, the index seems to not realize that the index (or
> > at least most of it) represents the same state as HEAD.  If I do git
> > reset --hard, the index is restored to the original state (it's
> > byte-for-byte identical), and the pack file is no longer read.
> 
> Are you sure it's reading a packfile?

Well, it's calling inflate(), and strace says it is reading
e.g. .git/objects/pack/pack-....{idx,pack}.

So, I would say so.
