Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C571F404
	for <e@80x24.org>; Thu,  8 Mar 2018 21:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeCHVCR (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 16:02:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750909AbeCHVCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 16:02:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F15424000787;
        Thu,  8 Mar 2018 21:02:16 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-50.rdu2.redhat.com [10.10.120.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 793B950330;
        Thu,  8 Mar 2018 21:02:16 +0000 (UTC)
To:     public git mailing list <git@vger.kernel.org>
Cc:     "Carsey, Jaben" <jaben.carsey@intel.com>
From:   Laszlo Ersek <lersek@redhat.com>
Subject: recent glob expansion breakage on Windows?
Message-ID: <e0ba9fb9-056e-4979-415b-f8eca47e2490@redhat.com>
Date:   Thu, 8 Mar 2018 22:02:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 08 Mar 2018 21:02:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 08 Mar 2018 21:02:17 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lersek@redhat.com' RCPT:''
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jaben reports that git-send-email is suddenly failing to expand the
"*.patch" glob for him, at the Windows CMD prompt:

---------
E:\...>git send-email --suppress-cc=author --suppress-cc=self
--suppress-cc=cc --suppress-cc=sob --dry-run *.patch

No patch files specified!
---------

Whereas, moving the same patch files to another subdir, and then passing
the subdir to git-send-email, works fine.

I seem to have found some $^O based perl code in the git tree that
expands the glob manually (in place of the shell) on Windows -- however,
that code looks ancient ^W very stable, and doesn't seem to explain the
sudden breakage.

Is it possible that a separate perl update on Jaben's Windows box is
causing this? Or does the breakage look consistent with a recent git change?

Has anyone else reported something similar recently?

Thanks (and sorry about the noise; this list might not be the best place
to ask)!
Laszlo
