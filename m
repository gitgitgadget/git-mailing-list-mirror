From: Felix Ruess <felix.ruess@gmail.com>
Subject: git 2.8.1 not working with socks5h https proxy anymore
Date: Fri, 8 Apr 2016 20:46:08 +0200
Message-ID: <CAEc+GFeG-ZdeTXGsjmwV0QP6QwYvjA4nzCGitka0aXjqEkatfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 20:46:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aobQS-0000Cj-Di
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 20:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796AbcDHSqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 14:46:16 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34828 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbcDHSqP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 14:46:15 -0400
Received: by mail-lf0-f51.google.com with SMTP id c126so87742844lfb.2
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=WP8eQQSaD31eY36Bg/ZCk2QhMJFpYbriNIcjkppLHN8=;
        b=jSdk7dhnzhw67IApaFMyPfJsVHVjhb9bDKXSWxm+ip7nXhPDL3u+vOVc2H11NHtgU/
         TRht4BVMnRwTzbz1SdRtXrdFjYzZfjbzCwb8OAn2OmNMl/7C8NHKJvZ3i+qs+hJ5Eo2w
         xrrcPcB7Dowf4mmYiJ84JshSWuKsWDNKEBcFODKmxZ71ln+tSdaOMHWm5XTE3JQI+VqC
         6T9ZXBZmhMtK1yc1lq4vbO4JeZsghFP4+sTv+w/SJ3uzE+rjma61mGBSGPsRx0NVoIB9
         XS0DHqoWJlJvWl35RnlhvuPoMZiTuaDLmSSYgYkssoYTgwxVh8ReM/9yaWJFv1QxJ5ND
         EARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WP8eQQSaD31eY36Bg/ZCk2QhMJFpYbriNIcjkppLHN8=;
        b=VCGxkt6U2GdGUvWq8bZG4AYeE6kB0rUY71Rb7NeLqfxTctRSb6nPtX/rL3+mA/yU+b
         V3cZyhDL0vh9qarl5ZVO/7xErcKyUptLjfwCQK2Mxv3gzLwTr7xPtLv6WaSeorHNfdNZ
         YzGUw8NTSHaj/Z4SKRFx9iiDvJFyizlvzB5wYViOJPWGS9M7PVlErhA4PWIeKQoK5FMk
         tVGmRYHGBXCX1zKe8ExW9u57Pjw+BW4OJsMVhhEtkKALFQZkLavNTiQGcp35WHQ02hNC
         Fq2uq+dl/u2FZt+w6h1k6E6M0qBhV9y1iKZMAkpHMbgPrvej7vpossfS5KK6sV7goJCP
         OZvA==
X-Gm-Message-State: AD7BkJL00a5l7SGwO+XKVQS12mWQp6GS+bGc89YgHR6jovX+cEBpSfH1iUAkLeXLJRcQKSeGzGETMicXFQ8SXA==
X-Received: by 10.112.129.169 with SMTP id nx9mr4185393lbb.96.1460141168781;
 Fri, 08 Apr 2016 11:46:08 -0700 (PDT)
Received: by 10.114.68.70 with HTTP; Fri, 8 Apr 2016 11:46:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291053>

Hi all,

I just encountered a problem with the latest git version (2.8.1) that
looks like a regression to me:
When trying to clone a repo via a https socks5 proxy the connection times out:

$ git config --global 'http.proxy=socks5h://127.0.0.1:1080'
$ export GIT_CURL_VERBOSE=1
$ git clone https://foo.de/bar.git
Cloning into 'bar'...
* Couldn't find host foo.de in the .netrc file; using defaults
* Hostname was NOT found in DNS cache
*   Trying 127.0.0.1...
* Hostname was NOT found in DNS cache
* 80
* 147
* 201
* 194
channel 2: open failed: connect failed: Connection timed out
channel 4: open failed: connect failed: Connection timed out
* Failed to receive SOCKS5 connect request ack.
* Closing connection 0
fatal: unable to access 'https://foo.de/bar.git/': Failed to receive
SOCKS5 connect request ack.

I'm on Ubuntu 14.04 64bit and it works perfectly fine with git 1.9.1
(and was also working with older git 2.x versions, although not sure
any more what the last working version was).

Cheers, Felix
