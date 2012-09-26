From: Jonathan Johnson <me@jondavidjohn.com>
Subject: Bug in Submodule add
Date: Tue, 25 Sep 2012 22:18:05 -0600
Message-ID: <BC634E06939C44239106E7A8DD229130@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 06:18:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGj4z-00019e-NO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 06:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab2IZESM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 00:18:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57407 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab2IZESL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 00:18:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1226085pbb.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 21:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:message-id:subject:x-mailer:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-gm-message-state;
        bh=+XU3KWelurwjk7189dtQL1ToEtr8O5GW4GeUTLI7bp4=;
        b=VTrY/3s8aq01ORKxqh3388rY7L5Hri5/3Y3/hVMRar9rDAAgbxstFCQU+APobeMpci
         eD6aokq1HkuLixs7m9GnMRviGWVCHh1Wwtkwr6PL/ozLUUFSL6MtVou8NSAqzkLHnLO+
         L9I4dQ8jfOczielYXFKiXCn4T4yKV3e047Sq9t0wCqKXRItBpg4Rn6WDlM/kzoZ86dNc
         DYdHtD7yFFqGeiIBrk0pu5MWARru8I/vAhL7puc03eAD90+JfXokqQS5FdK2OV6I04Px
         /IOQF8ui0ffQTYB75OHqFoZIkyt/LDw7gKR3eB4kQTsTf7Y52PF9Vcx6/+lR6vnLp4+1
         OJrQ==
Received: by 10.68.242.231 with SMTP id wt7mr51081370pbc.99.1348633090936;
        Tue, 25 Sep 2012 21:18:10 -0700 (PDT)
Received: from [192.168.168.102] (c-71-237-124-199.hsd1.co.comcast.net. [71.237.124.199])
        by mx.google.com with ESMTPS id j9sm1228136pav.15.2012.09.25.21.18.07
        (version=SSLv3 cipher=OTHER);
        Tue, 25 Sep 2012 21:18:09 -0700 (PDT)
X-Mailer: sparrow 1.6.3 (build 1172)
Content-Disposition: inline
X-Gm-Message-State: ALoCoQnC94EzlqLOEMUNW7D1ynM3BBS5sUUbAaD6odgxi/QES3nX2QeHo5IquqbxVhrcToc8N/Y4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206393>

I believe I have found an issue with the way `submodule add` detects a submodule that already exists in the repository. 

To reproduce

1) add a git submodule in a specific location (we'll say it's at `./submodule/location`)
2) go through the normal steps of removing a submodule, as listed here - https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial
3) Now the submodule is completely removed and there is no reference to it in .gitmodules or .git/config
4) Re-add a different repository at the same location (`./submodule/location`)

Expected - The new submodule repository will be set up at ./submodule/location and have the new repository as its origin

What Actually Happens - The new submodule uses the existing `$gitdir` (old repository) as the actual backing repository to the submodule, but the new repository is reflected in .gitmodules and .git/config.

So to recap, the result is that `git remote show origin`  in the submodule shows a different origin than is in .gitmodules and .git/config

One simple step to remedy this would be to add the deletion of the backing repository from the .git/modules directory, but again, I think an actual command to take care of all of these steps is in order anyways.  Not sure you want to encourage people poking around in the .git directory.

If this is already resolved in the newest versions, please disregard

Thanks!

Jonathan Johnson

http://jondavidjohn.com | me@jondavidjohn.com
