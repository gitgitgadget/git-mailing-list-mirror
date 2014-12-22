From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Misbehaving git bisect bad HEAD
Date: Mon, 22 Dec 2014 15:04:09 +0100
Message-ID: <87y4pzbx2e.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 15:04:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y33ax-0007bw-47
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 15:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbaLVOEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 09:04:13 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:57229 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbaLVOEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 09:04:12 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3k5j8p38Dkz3hj2N
	for <git@vger.kernel.org>; Mon, 22 Dec 2014 15:04:10 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3k5j8p2rZyzvh3m
	for <git@vger.kernel.org>; Mon, 22 Dec 2014 15:04:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id LHmFYEZQVcob for <git@vger.kernel.org>;
	Mon, 22 Dec 2014 15:04:09 +0100 (CET)
X-Auth-Info: SLb1TpJeeqf7UJj4oIkpgYlyR7DpKJtcg4QoKHD+ikqur22g4YpfezgiAiiYT8BI
Received: from igel.home (host-188-174-216-244.customer.m-online.net [188.174.216.244])
	by mail.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Mon, 22 Dec 2014 15:04:09 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 3D8202C37F1; Mon, 22 Dec 2014 15:04:09 +0100 (CET)
X-Yow: I'm DESPONDENT...  I hope there's something DEEP-FRIED under this
 miniature DOMED STADIUM...
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261644>

Running "git bisect bad" should be the same as "git bisect bad HEAD",
shouldn't it?

When replaying this bisect log on the Linux kernel tree:

git bisect start
# bad: [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1
git bisect bad 97bf6af1f928216fd6c5a66e8a57bfa95a659672
# good: [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18
git bisect good b2776bf7149bddd1f4161f14f79520f17fc1d71d
# good: [70e71ca0af244f48a5dcf56dc435243792e3a495] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 70e71ca0af244f48a5dcf56dc435243792e3a495
# good: [988adfdffdd43cfd841df734664727993076d7cb] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
git bisect good 988adfdffdd43cfd841df734664727993076d7cb
# good: [b024793188002b9eed452b5f6a04d45003ed5772] staging: rtl8723au: phy_SsPwrSwitch92CU() was never called with bRegSSPwrLvl != 1
git bisect good b024793188002b9eed452b5f6a04d45003ed5772
# good: [66dcff86ba40eebb5133cccf450878f2bba102ef] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 66dcff86ba40eebb5133cccf450878f2bba102ef
# bad: [88a57667f2990f00b019d46c8426441c9e516d51] Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 88a57667f2990f00b019d46c8426441c9e516d51
# good: [0ec28c37c21a2b4393692e832e11a7573ac545e2] Merge tag 'media/v3.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 0ec28c37c21a2b4393692e832e11a7573ac545e2
# good: [c0f486fde3f353232c1cc2fd4d62783ac782a467] Merge tag 'pm+acpi-3.19-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good c0f486fde3f353232c1cc2fd4d62783ac782a467
# bad: [34b85e3574424beb30e4cd163e6da2e2282d2683] Merge tag 'powerpc-3.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux
git bisect bad 34b85e3574424beb30e4cd163e6da2e2282d2683
# good: [64ec45bff6b3dade2643ed4c0f688a15ecf46ea2] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect good 64ec45bff6b3dade2643ed4c0f688a15ecf46ea2

Running "git bisect bad" gives this:

$ git bisect bad 
Bisecting: 6 revisions left to test after this (roughly 3 steps)
[ec2aef5a8d3c14272f7a2d29b34f1f8e71f2be5b] power/perf/hv-24x7: Use kmem_cache_free() instead of kfree

Running "git bisect bad HEAD" instead gives this:

$ git bisect bad HEAD
Bisecting: a merge base must be tested
[56548fc0e86cb9156af7a7e1f15ba78f251dafaf] powerpc/powernv: Return to cpu offline loop when finished in KVM guest

This is git 2.2.1.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
