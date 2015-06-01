From: Phil Susi <psusi@ubuntu.com>
Subject: git-repack keeps running out of memory
Date: Mon, 01 Jun 2015 14:39:04 -0400
Message-ID: <556CA6C8.6000804@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 20:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUdZ-0006vt-VL
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbbFASkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:40:33 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36038 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbbFASkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:40:31 -0400
Received: by qgf2 with SMTP id 2so50805293qgf.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=woPBco1PHj8dWaYN7dscfKvKithtHHKWQKU3m82M1j4=;
        b=NAnQLCEVHNpsj//JCBMrHSfuaTA4N5+ALi3kQBdVvwHpThyFNV8ud9x1QkvftnVHFx
         u0SiatuaNMfUExL3WzV2lxUe45W/0gNclvZy2zoDUvza7y+P3oR94FZZh6lD2jUAx9OQ
         ebrMCDvRWBE5o6Ecw+D4KeOTZD1s0LXcBvBak12PVUXaM77YY5TSL1St6GpVuAJicQm9
         Aw5R4iQzTTkw9CkA6DoQPdsVl7NQYA9IY5LwRyhbRLXfXMUIzLXNdnMr/AEps1mfKNDk
         UNvQFhARp1K/dp+AAeX/L3M+AvugfaLotSuwmeF8M7wFIxl52zeHcQfBSRoU9ZkyE3+F
         NccQ==
X-Received: by 10.55.26.86 with SMTP id a83mr40927333qka.83.1433184030280;
        Mon, 01 Jun 2015 11:40:30 -0700 (PDT)
Received: from [10.1.1.233] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id 92sm3321525qgi.13.2015.06.01.11.40.29
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 11:40:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270456>

I keep having git-repack run out of virtual memory ( 32 bit system ) 
when trying to repack my linux kernel repo.  It keeps making it right up 
to 99% then barfing saying mmap failed: Cannot allocate memory.

I thought I could help this by limiting the pack size, and using 
--window-memory to limit the memory usage, but it still happens with 
this full command line:

git repack -a -d --max-pack-size=500m -f -F --depth=20 --window=250 
--window-memory=500m

The key factor seems to be the --window... with 50 it works fine, but 
with 100 or more, even with the very low --window-memory limit, it crashes.
