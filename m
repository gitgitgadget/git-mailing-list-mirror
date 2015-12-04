From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Push --follow tags does not agree with its documentation
Date: Fri, 04 Dec 2015 22:41:46 +0100
Message-ID: <1449265306.29869.6.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 22:41:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4y70-00077h-04
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbbLDVlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:41:50 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37510 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbbLDVlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:41:49 -0500
Received: by wmww144 with SMTP id w144so81514072wmw.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 13:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:content-type:mime-version
         :content-transfer-encoding;
        bh=+QXWywz6Guc9DEjrVEmp4dJiK+B4/6Q2GmyA8xoA5HU=;
        b=titvODhVypCZfEW8cK+9AdYF+3FeQx4WYJCY+9REU6vPjlDyKlCfTLTq4efPT8l0sx
         hsy3n3r78zDi7GSqrO/UliT3sI65xY8y0TxYSZPxFPbDRrY2bQaZmoCG0iadUF6Axhyp
         qI5xS1Qby9wABLE4d2DkQO+uNJFj1rk65mieyd/qYzTBufHfhEYvmMU0ZpgNiRJUQUUP
         gfD+Fu07e2FID5XibJ1kNrUPPihof8PNdXDDHwTURD3nzaS51vXDTwgViN32e3v4zLW8
         jKGid0Per7xPu5p1uICL8rXxBvHUmB3M0Je9vYAqljtPKoH5y+z5Y8CZfb6MIqQ+tYl0
         8uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:content-type
         :mime-version:content-transfer-encoding;
        bh=+QXWywz6Guc9DEjrVEmp4dJiK+B4/6Q2GmyA8xoA5HU=;
        b=fwqqwpA1xQDq7en2Wac5QuJw4dkt7ReIpwlY4lOu45Ki2AqYQR1ki76b3NYh4ivwsO
         pzgs2n6xx6MOn6p/swkyBbeAuhSqiuO4KJlR9aK3Ir8/xeFYK2M8heRVv4ypQhfmPpex
         7ujYeiekv/kuIMGWd+VWIMg+L6QT2ZbtZKqsXzBSewpa7SBwENyzP8ZrkkWw+XiRfWqm
         2RdDy6E9K8ooYi6uRJLc4521Q2XlQxPukAxtyHKAP/Ljfib6s8gCJq01TVa/GWPpv1Vz
         JBdRWQ/LchOCrLfRrwOdQyUeiJ1SM5MNNeqQ3xSfZ0n1r7jgTCMxbyLuwI6p2Ckht+03
         hr5w==
X-Gm-Message-State: ALoCoQk13cj0i1l5/O5s6VCNkQB9DYEfY0mGkDFJloFKQLZg+qFYRQSC9N3zm72PAZ/hFZKB8SOB
X-Received: by 10.28.189.5 with SMTP id n5mr7715878wmf.76.1449265308237;
        Fri, 04 Dec 2015 13:41:48 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id f11sm5211740wmd.7.2015.12.04.13.41.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2015 13:41:47 -0800 (PST)
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282008>

When deleting an annotated tag with git push -d while having
push.follwTags set to true, causes push to push other annotated tags. I
was surprised by this as this does not agree with the documentation

	Push all the refs that would be pushed without this option, and
	also push annotated tags in refs/tags that are missing from the
	remote but are pointing at commit-ish that are reachable from
	the refs being pushed. This can also be specified with
	configuration variable push.followTags. For more information,
	see push.followTags in git-config(1).

Note also that the tag pushed in error is not even reachable from the
tag that's being deleted.

$ git config push.followTags
true

$ git push origin --delete v2.5.1
To /tmp/whelk.git/
 - [deleted]         v2.5.1

$ git push origin --delete 2.5

Counting objects: 1, done.
Writing objects: 100% (1/1), 166 bytes | 0 bytes/s, done.
Total 1 (delta 0), reused 1 (delta 0)
To /tmp/whelk.git/
 - [deleted]         2.5
 * [new tag]         v2.5.1 -> v2.5.1

Which one is correct in this case, the behaviour or the documentation?
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
