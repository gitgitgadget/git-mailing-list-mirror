From: Thomas Taranowski <tom@baringforge.com>
Subject: git subtree oddity
Date: Wed, 27 Mar 2013 20:12:56 -0700
Message-ID: <CAH0ocawbOX8C7_EaNFc2PiFT8cnpSJyPD+-8RLDL1S0SX-jQvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 04:14:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL3Hx-000322-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 04:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab3C1DNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 23:13:38 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:55854 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021Ab3C1DNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 23:13:37 -0400
Received: by mail-wg0-f51.google.com with SMTP id b12so1108398wgh.18
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 20:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:from:date:x-google-sender-auth
         :message-id:subject:to:content-type;
        bh=0aOyO+adB3Z0/WvWQroWOSFRjXZQBZMcSR/TQA50cfM=;
        b=sN02hVSILS7tdnYQZpuTco4J+uKjxknxMlrrxRd44jRyjJHFd1Gjb4BdoFUI829SKl
         4q2VlSgzcgECgw8H7nsSfkGvarjC4QF6lv8+efx3MMyW1nBJe3EmcglBMT5yefb7x8yV
         9EUbt6mjiPXHsgdVUUWrPSVEPnbMN+uRDBqBlLrbdq+x9LQoUat0pirzF80wpv7fwcJd
         bXBUH2f12yW7fTPQKA0dArV7DO42wVlKthNViZ8wMogZLm1yJqsD6R0Y+78X3kz7vV/W
         p9AZa4An4qlF+coemvrd4nEwIxfjktesO26cvowhpYp6QU4oPzfbdOJfgNY3//Zm2GWS
         PhHg==
X-Received: by 10.180.94.133 with SMTP id dc5mr1048557wib.1.1364440416277;
 Wed, 27 Mar 2013 20:13:36 -0700 (PDT)
Received: by 10.180.19.161 with HTTP; Wed, 27 Mar 2013 20:12:56 -0700 (PDT)
X-Google-Sender-Auth: PeFWzh84qSvbh8I0l0NY1wA4yRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219363>

I'd like to have the following configuration:

/myproject.git
|__/upstream_dependency -- Points to a remote library git repo
|__/project_source -- local project source


I issue the following commands to pull in the upstream dependency as a
subtree of the myproject.git repo:

git remote add upstream git://gnuradio.org/gnuradio
git fetch upstream
git checkout master
git subtree add -P upstream upstream/master

Now, my expectation is that I would have the following:

/myproject.git
|__/upstream_dependency -- Points to a remote library git repo
|____< all the upstream files are present here, as expected >
|__/project_source < this is still intact, as expected >
|__< all the upstream files are present here. wtf?>

My question is, why does "subtree add" pull in all the subtree files
into the root of the repo, and not just into the specified subtree
prefix?

#
# Here's an excerpt of what I see:
#
$:~/scratch/myproject.git$ ls
AUTHORS         gr-comedi               gr-utils
cmake           gr-digital              gr-video-sdl
CMakeLists.txt  gr-fcd                  gr-vocoder
config.h.in     gr-fft                  gr-wavelet
COPYING         gr-filter               gr-wxgui
docs            gr-howto-write-a-block  README
dtools          gr-noaa                 README.building-boost
gnuradio-core   gr-pager                README.hacking
gr-analog       gr-qtgui                README-win32-mingw-short.txt
gr-atsc         gr-shd                  upstream <---- the subtree directory
gr-audio        gr-trellis              volk
gr-blocks       gruel
grc             gr-uh

#
# Also, those same files are in the upstream subtree directory as well
(as expected)
#
$:~/scratch/myproject.git$ ls upstream
AUTHORS         grc                     gruel
cmake           gr-comedi               gr-uhd
CMakeLists.txt  gr-digital              gr-utils
config.h.in     gr-fcd                  gr-video-sdl
COPYING         gr-fft                  gr-vocoder
docs            gr-filter               gr-wavelet
dtools          gr-howto-write-a-block  gr-wxgui
gnuradio-core   gr-noaa                 README
gr-analog       gr-pager                README.building-boost
gr-atsc         gr-qtgui                README.hacking
gr-audio        gr-shd                  README-win32-mingw-short.txt
gr-blocks       gr-trellis              volk
