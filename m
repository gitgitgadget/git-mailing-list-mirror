From: Nathan Neulinger <nneul@neulinger.org>
Subject: Feature request - allow requesting a lock timeout
Date: Fri, 4 Dec 2015 08:28:27 -0600
Organization: Neulinger Consulting
Message-ID: <5661A30B.6030803@neulinger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 15:28:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4rLi-0003vN-8f
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 15:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbbLDO2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 09:28:33 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33377 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbbLDO2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 09:28:30 -0500
Received: by ykdv3 with SMTP id v3so125385199ykd.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 06:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neulinger-org.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:organization:message-id:date:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=troQbzjCKs7i88ZX4dqS3Bz4NuC6gHe2B3pVsXmxpbM=;
        b=OZxpAN5nLJvH7PZxT/N7xl5jOwdlmyzn9vPkoRtUdqKtKu3mqXYsyHml5syheoaXfm
         L7TkG9cOuBa6ArxBEMasrMqZKpYfgSM85lWaPmqnkklKWeFBXlVlR7iNIzN/8UNq2wDa
         x8ZMO6CclxN0wGqwSO/hDVdMkFcQqUpkYvxBwPPpllWu7kAi77Zburj0Kk3AlnHuyFyP
         fOIu8RqMEFnLeulcONc2LiXMuC8qWm8wicZ/XQYNlpFw22lYNNNpErCcLJU8z0UacOyV
         M+yHM4XiAoc5SBvVea2neEMq+WVCBhP5pB3fM69kewfH+vg05qOR/B+eE5ycDxzyEvL+
         utfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:organization:message-id:date
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=troQbzjCKs7i88ZX4dqS3Bz4NuC6gHe2B3pVsXmxpbM=;
        b=kZoaqbqt0mXc/TPKWa01QFcKwDG4hfTIXSrq9CskZ2FUy0fTYKcZp3PfvTzb1NO1o7
         pW+dQbC8TIymS5F8NFOENZiLgddw/CqYDmU6/hwrczh6RfnAlZvKrdulSssAfVfclVSh
         T/9+ML9pkflbjX/pWCQoyuD2CZN6bccfV3NBcWvh4vE3X/4Li4KOM/T9YL/ojRQWy9KE
         K1xRapsSPg8bDxn2nvfXw7Ba2cgsGWmxmnaXsxzlJOggIH42sGWr6EUEdjZbynVlNENk
         QYijEPffKsKIgYPeWQ9b1O7YegFfkyYwQ8HA39cEdPEl7T/rpWHBwWxTOoG1VB2u67Jv
         dk5Q==
X-Gm-Message-State: ALoCoQlOvNSsvkq73o5u1exaZL6KH3S7iGh7ZXqf2tF0MvaqLWTk0NwlYT3khEWP39453/ZZ7ChU
X-Received: by 10.13.205.3 with SMTP id p3mr12713760ywd.22.1449239309782;
        Fri, 04 Dec 2015 06:28:29 -0800 (PST)
Received: from infinity.srv.mst.edu (infinity.srv.mst.edu. [131.151.49.1])
        by smtp.gmail.com with ESMTPSA id c67sm9073326ywe.31.2015.12.04.06.28.28
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Dec 2015 06:28:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281980>

It appears that almost all of the locking calls in the current code use hold_lock_file_for_update() which translates 
into a request with zero timeout.

This effectively means that for certain classes of usage, you can't use git concurrently without either external locking 
or retry logic. It would be nice to see a global option "--lock-timeout" that would request a specific non-zero default 
timeout for many of those operations.

Even having the option to have a couple-second timeout would eliminate most typical concurrency issues, simplifying some 
automated use cases.

Horrible/contrived example, but demonstrates the issue:

	for f in `seq 1 150`; do touch $f; (git add $f &); done

You'll get a whole bunch of:

	fatal: Unable to create '/tmp/dummy/.git/index.lock': File exists.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412
