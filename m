From: Filip Gospodinov <filip.gospodinov@monetas.net>
Subject: git submodule ignores --git-dir
Date: Thu, 10 Sep 2015 22:06:03 +0200
Message-ID: <55F1E2AB.3020507@monetas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 22:08:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za88V-0007N5-TR
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 22:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbbIJUH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 16:07:56 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33070 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbIJUHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 16:07:55 -0400
Received: by wiclk2 with SMTP id lk2so41304903wic.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 13:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=EobfO7IxceY7Usl9BXyg8S7wHMf7wDfufEyqu+rZWDg=;
        b=Cp7a17cddEHpPji1+SSzGZ7+0ZceCej5KIv4SOJUg7cCXcwLVFjH2zbiBskJAEQldo
         NggSE/4dD0U6xeLbNZwuUeay4opMiCQtQCJRzQ6nB4hE5Pwr0m95caiy83dF/LQMUhsp
         jbpDryQXW9TU0MlzHbp/VUaEenMm1Nponh9HGwHDU0yA6tNHfJ6RkT+7FnBQABgGjL92
         H074wdE+6JjphFKqHODfrKZFIuhZlNRBrvK74H0ueH2ZBZF55RoHDn5SHUJUWze8+hEk
         c+YOC5FgVyP9YhXY7I5cNFjG4trnkuAvvdHt6p2Ndj2HQshdvARXm5lRH36lZBC5n0Vb
         dqNg==
X-Gm-Message-State: ALoCoQmbFCTb9e9Zx6qH6VPJndBloG0Mh1Z7M3mhFMTVIwP4vLnNnWs8DcXTBuGTBmE4BxGCzv61
X-Received: by 10.180.206.211 with SMTP id lq19mr10063473wic.81.1441915673667;
        Thu, 10 Sep 2015 13:07:53 -0700 (PDT)
Received: from [192.168.0.101] (80-218-115-88.dclient.hispeed.ch. [80.218.115.88])
        by smtp.googlemail.com with ESMTPSA id x10sm10993391wiy.6.2015.09.10.13.07.52
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2015 13:07:52 -0700 (PDT)
X-Google-Original-From: Filip Gospodinov <filip@monetas.net>
X-Enigmail-Draft-Status: N0010
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277630>

Hi!

I use the `--git-dir` flag in some scripts such that I don't need to `cd` back
and forth. Recently, I've discovered that `--git-dir` does not seem to work
correctly for `git submodule`. Here is a short snippet to reproduce that behavior:

mkdir repo1 subm
(cd subm; git init; git commit -m 1 --allow-empty)
(cd repo1; git init; git submodule add ../subm subm; git commit -m "add subm")
git clone repo1 repo2
git --git-dir=$PWD/repo2/.git submodule update --init


which errors with the following output:

No submodule mapping found in .gitmodules for path 'subm'

But this works:
cd repo2; git --git-dir=$PWD/.git submodule update --init


I know that for this particular use case I can just use `git clone --recursive`
and that other use cases can be worked around by using `cd`. Still, I wonder if
the behavior I discovered is a bug or if it's expected.

git --version
git version 2.5.1

Thanks you!
Filip
