Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5AC211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 07:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfAMHHI (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 02:07:08 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:37102
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbfAMHHI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Jan 2019 02:07:08 -0500
X-IronPort-AV: E=Sophos;i="5.56,472,1539640800"; 
   d="scan'208";a="291720030"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2019 08:07:04 +0100
Date:   Sun, 13 Jan 2019 08:07:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     git@vger.kernel.org
Subject: git blame --reverse reports on lines that were not asked for
Message-ID: <alpine.DEB.2.21.1901130758180.4448@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version: git version 2.17.1, git version 2.20.1

Git tree:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable
7566ec393f4161572ba6f11ad5171fd5d59b0fbd

The command git blame --reverse 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8..HEAD -L1176,1176 -L1173,1173 arch/mips/kvm/emulate.c

Produces:

693dfd5a3f19e (Erez Shitrit 2017-04-27 17:01:34 +0300 1173)                                     preempt_disable();
693dfd5a3f19e (Erez Shitrit 2017-04-27 17:01:34 +0300 1174)                                     /* Blow away the shadow host TLBs */

Line 1174 was not asked for, and there is no information about line 1176.

git blame --reverse 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8..HEAD -L1173,1173 -L1175,1175 arch/mips/kvm/emulate.c works fine:

693dfd5a3f19e (Erez Shitrit 2017-04-27 17:01:34 +0300 1173)                                     preempt_disable();
f3124cc551c85 (James Hogan  2016-09-16 00:00:08 +0100 1175)                                     kvm_mips_flush_host_tlb(1);

git blame --reverse 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8..HEAD -L1173,1176 arch/mips/kvm/emulate.c also works fine:

693dfd5a3f19e (Erez Shitrit 2017-04-27 17:01:34 +0300 1173)                                     preempt_disable();
f3124cc551c85 (James Hogan  2016-09-16 00:00:08 +0100 1174)                                     /* Blow away the shadow host TLBs */
f3124cc551c85 (James Hogan  2016-09-16 00:00:08 +0100 1175)                                     kvm_mips_flush_host_tlb(1);
693dfd5a3f19e (Erez Shitrit 2017-04-27 17:01:34 +0300 1176)                                     cpu = smp_processor_id();

My impression is that git --reverse blame is not all that reliable, and we can even see that 1174 gets assigned to two different commits depending on how the command is formulated.  But I would expect it to at least report on only and exactly the lines that were asked for.

thanks,
julia
