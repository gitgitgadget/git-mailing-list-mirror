From: Greg KH <gregkh@linuxfoundation.org>
Subject: Funny 'git describe --contains' output
Date: Tue, 28 Aug 2012 21:48:40 -0700
Message-ID: <20120829044840.GA25869@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 06:48:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6aCy-00086Y-8M
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 06:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177Ab2H2Esp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 00:48:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35290 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2H2Esp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 00:48:45 -0400
Received: by pbbrr13 with SMTP id rr13so461235pbb.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 21:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:x-gm-message-state;
        bh=NK+GHZFarai5/YBGI2MSWl7qxaYdNdxTSuXZzdmynDQ=;
        b=XK7d++QADk2LCGQANQRz3vynJnkOb0g+w2LYm8nermPGCj+IGrX1c5uQmCKoiu+Re9
         qs7G0CpE80reKM90jCtYpORIVysBG4CMNAvLq480+QFeO9blpnfGmFkJblbRmZP6KAne
         wAAT4VHwUwYEcxvqKoEX+2xf4wLiGI/BluzH2D736D/naqce1V+tW2gRiImQvP70k2lW
         /i2kDw3VmwPIJupTbnpTjlAX+L/pvRmSN0iUYpndtaJod4l1N08Dc5VK/XJe5Yz5gkVF
         8BT5tj0dNK3Oi2rprKHvtmx36DKOmE9v/t2ubEXc+V8o5SOoNbbLVAdzYzE9qNAnkJix
         uNZQ==
Received: by 10.68.195.34 with SMTP id ib2mr1567584pbc.164.1346215724687;
        Tue, 28 Aug 2012 21:48:44 -0700 (PDT)
Received: from localhost (0127ahost2.starwoodbroadband.com. [12.105.246.2])
        by mx.google.com with ESMTPS id kt8sm18521079pbc.1.2012.08.28.21.48.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 21:48:43 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnmpJ+I116rWRticGZma4eaYSrlrY+16lX9KGLoMezkf9ZOJX1hxIO7f+SH9zjUheQ5xGXF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204461>

Hi,

In the Linux kernel tree, commit 0136db586c028f71e7cc21cc183064ff0d5919
is a bit "odd".

If I go to look to see what release it was in, I normally do:
	$ git describe --contains 0136db586c028f71e7cc21cc183064ff0d5919
	v3.6-rc1~59^2~56^2~76

However, it really showed up first in the 3.5-rc1 kernel release, as can
be seen by doing the following:
	$ git tag --contains 0136db586c028f71e7cc21cc183064ff0d5919
	v3.5
	v3.5-rc1
	v3.5-rc2
	v3.5-rc3
	v3.5-rc4
	v3.5-rc5
	v3.5-rc6
	v3.5-rc7
	v3.6-rc1
	v3.6-rc2
	v3.6-rc3

This commit ended up coming into Linus's tree in two different places,
both in 3.5-rc1 and in 3.6-rc1, through different merge requests, so it
seems to be tricky to figure out when it "first" went in.

Asking Linus about this, he tried the following:

	$ git name-rev --tags 0136db586c028f71e7cc21cc183064ff0d5919
	0136db586c028f71e7cc21cc183064ff0d5919 tags/v3.6-rc1~59^2~56^2~76
	$ git rev-list 0136db586c028f71e7cc21cc183064ff0d5919..v3.5-rc1 | wc
	  11415   11415  468015
	$ git rev-list 0136db586c028f71e7cc21cc183064ff0d5919..v3.4-rc1 | wc
	  0       0       0
	$ git rev-list 0136db586c028f71e7cc21cc183064ff0d5919..v3.6-rc1 | wc
	  22279   22279  913439

which shows that there are "less" commits to get from this commit to
v3.5-rc1 instead of v3.6-rc1, so something odd is going on here.

Any ideas?

I can reproduce this right now with git version 1.7.12.116.g31e0100

thanks,

greg k-h
