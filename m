Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01C71F404
	for <e@80x24.org>; Thu,  5 Apr 2018 19:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeDETvO (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 15:51:14 -0400
Received: from connotech.com ([76.10.176.241]:55444 "EHLO mail.connotech.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752701AbeDETvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 15:51:13 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Apr 2018 15:51:13 EDT
Received: from [192.168.1.11] (unknown [192.168.1.11])
        by mail.connotech.com (Postfix) with ESMTPA id C2A1E196E4F
        for <git@vger.kernel.org>; Thu,  5 Apr 2018 19:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=connotech.com; s=key3;
        t=1522957440; bh=gJ6Hd2O7fEX6Dqkhziu4Fitlzi/dKy8664YCMIFteiI=;
        h=Date:From:To:Subject;
        b=AmjOeW9A80bbeaHwV5eFbwNPpZ56orkPoqjTHWPzduS1iTBTZ0H5UQy75s9RdgRII
         +m3s/hsRmQEAEUuf52j8nCPGs8eUj2PN6jwVa1XrD/wB0svhafu6LDOpgr/RQ/euj0
         dPSxXAhMtuCyOkpzi2i5pIzuTiq+Mvl7jCygmP2U=
Message-ID: <5AC67C43.9080500@connotech.com>
Date:   Thu, 05 Apr 2018 19:42:59 +0000
From:   Thierry Moreau <thierry.moreau@connotech.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     git@vger.kernel.org
Subject: Self-inflicted "abort" in a newbie attempt at read-only exploration
 of a cloned repository?
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear GIT enthusiasts!

This ends up with a "git checkout" command aborting. A bit frustrating 
at the early stage of GIT learning curve.

My first goal is to clone repositories locally in order to explore the 
various linux kernel versions, with the rich GIT metadata.

Thus, I clone:

$  git clone --branch linux-4.16.y 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git 
linux-stable
$  git -C linux-stable/ branch
* linux-4.16.y

So far so good. Then, I want to extract an earlier kernel version into a 
tmp dir:

$  mkdir tmp
$  git -C linux-stable/ --work-tree $PWD/tmp/ checkout linux-4.15.y
$  git -C linux-stable/ branch
* linux-4.15.y
   linux-4.16.y

I got my extracted 4.15 version but the source repository (index? ...?) 
has somehow changed. Let me try something silly:

$  git -C linux-stable/ --work-tree $PWD/tmp/ checkout linux-4.14.y
$  git -C linux-stable/ branch
* linux-4.14.y
   linux-4.15.y
   linux-4.16.y

I indeed switched my extracted version from 4.15 to 4.14, but I am 
puzzled that the local source repository (linux-stable) is modified. 
Then I try to bring it back closer to its original state, just to keep 
things tidy:

$  git -C linux-stable/ checkout linux-4.16.y

And this command aborts, both with Git versions 2.01 and 2.17. Here is 
the truncated command output:

error: Your local changes to the following files would be overwritten by 
checkout:
	.gitignore
	.mailmap
	Documentation/00-INDEX
	Documentation/ABI/obsolete/sysfs-gpio
	Documentation/ABI/stable/sysfs-bus-vmbus
	Documentation/ABI/stable/sysfs-devices
	[... ...]
	Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
	Documentation/devicetree/bindings/arm/omap/crossbar.txt
	Documentation/devicetree/bindings/arm/omap/ctrl.txt
	Documentation/devicetree/bindings/arm/realtek.txt
	Documentation/devicetree/bindings/arm/rock
error: The following untracked working tree files would be overwritten 
by checkout:
	Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
	Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
	Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-invocation.svg
	Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
	Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
	[... ...]
	arch/riscv/include/asm/smp.h
	arch/riscv/include/asm/spinlock.h
	arch/riscv/include/asm/spinlock_types.h
	arch/riscv/include/asm/string.h
	arch/riscv/include/
Aborting

Questions:
=========

Is there a GIT tutorial that begins with my stated goal of an 
extract-only usage of cloned GIT repositories? (Maybe the root cause is 
my reluctance to learn the more involved GIT usages.)

Does the above reproducible abort deserve attention?

Any suggestion for my stated goal?

Thanks in advance,

- Thierry Moreau
