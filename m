From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Kernel bug caused by 'git apply' misapplying a patch with ambiguous
 chunk
Date: Thu, 02 Apr 2015 18:25:12 +0300
Message-ID: <551D5F58.4010201@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 17:25:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydgzg-0001Jr-7J
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 17:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbDBPZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 11:25:15 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:46355 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbbDBPZO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 11:25:14 -0400
Received: from [2001:708:30:12d0:beee:7bff:fe5b:f272]
	by mail.kapsi.fi with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <mikko.perttunen@kapsi.fi>)
	id 1YdgzY-00021R-Pf; Thu, 02 Apr 2015 18:25:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-SA-Exim-Connect-IP: 2001:708:30:12d0:beee:7bff:fe5b:f272
X-SA-Exim-Mail-From: mikko.perttunen@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266642>

Hello everyone,

we recently ran into a kernel bug caused by git misapplying this patch: 
https://lkml.org/lkml/2014/7/3/896 .

The chunk '@@ -653,6 +655,7 @@' in tegra124.dtsi (the second file in the 
patch) has ambiguous context (there are several almost identical PHY 
nodes in the file). Git applied the chunk to the second PHY node when it 
should have been applied to the first node.

You can reproduce this by checking out, for example, version 3.16 of the 
Linux kernel and applying the patch from the above link and then looking at

   arch/arm/boot/dts/tegra124.dtsi

and verifying that git has added the 'nvidia,has-utmi-pad-registers'
property to the second, instead of the first 'phy' node.

Of course this is probably rather hard to fix on the applying end; but 
perhaps format-patch could check for ambiguous chunks and either warn 
the user or increase the context size automatically, or apply could warn 
about the chunk being ambiguous?

Thanks,
Mikko Perttunen
