Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9154C1F51C
	for <e@80x24.org>; Wed, 30 May 2018 07:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967924AbeE3HH6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 03:07:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:63883 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935905AbeE3HH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 03:07:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2018 00:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,459,1520924400"; 
   d="scan'208";a="43252374"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by fmsmga007.fm.intel.com with ESMTP; 30 May 2018 00:07:55 -0700
Date:   Wed, 30 May 2018 15:04:48 +0800
From:   Ye Xiaolong <xiaolong.ye@intel.com>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch: no 'prerequisite-patch-id' info when specifying
 commit range
Message-ID: <20180530070448.GC27396@yexl-desktop>
Mail-Followup-To: Eduardo Habkost <ehabkost@redhat.com>,
        Fengguang Wu <fengguang.wu@intel.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180529184651.GB14525@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529184651.GB14525@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Eduardo

On 05/29, Eduardo Habkost wrote:
>Hi,
>
>I'm trying to use git-format-patch --base to generate the list of
>prerequisite patches for a series, but the behavior of git
>doesn't seem to match the documentation:
>
>When using a commit count (e.g.: "-2"), git-format-patch generates the
>prerequisite-patch-id lines as expected.  But when using a commit range like
>"Z..C", the prerequisite-patch-id lines are missing.
>
>Is this intentional, or it is a bug?

Thanks for reporting, it seems an unexpected behavior, I'll look into it.

Thanks,
Xiaolong

>
>Example using git.git commits:
>
>  $ git format-patch --stdout --cover-letter --stdout --base b7b1fca17~5 -2 b7b1fca17 | egrep 'base-commit|prereq'
>  base-commit: 2738744426c161a98c2ec494d41241a4c5eef9ef
>  prerequisite-patch-id: 080ac2faf21a6a7f9b23cb68286866d026a92930
>  prerequisite-patch-id: e3ee77500c9aa70248e7ee814662d01f79d0dcdb
>  prerequisite-patch-id: 6d831e23e33075681e6b74553151a32b73092013
>  (ehabkost@localhost:~/rh/proj/git (ok) 1j)
>  $ git format-patch --stdout --cover-letter --stdout --base b7b1fca17~5 b7b1fca17~2..b7b1fca17 | egrep 'base-commit|prereq'
>  base-commit: 2738744426c161a98c2ec494d41241a4c5eef9ef
>  $ git --version
>  git version 2.17.1
>  $ git log --graph --pretty=oneline -6 b7b1fca17
>  * b7b1fca175f1ed7933f361028c631b9ac86d868d fsck: complain when .gitmodules is a symlink
>  * 73c3f0f704a91b6792e0199a3f3ab6e3a1971675 index-pack: check .gitmodules files with --strict
>  * 6e328d6caef218db320978e3e251009135d87d0e unpack-objects: call fsck_finish() after fscking objects
>  * 1995b5e03e1cc97116be58cdc0502d4a23547856 fsck: call fsck_finish() after fscking objects
>  * ed8b10f631c9a71df3351d46187bf7f3fa4f9b7e fsck: check .gitmodules content
>  * 2738744426c161a98c2ec494d41241a4c5eef9ef fsck: handle promisor objects in .gitmodules check
>  $ 
>
>If I understand the documentation correctly, both "-3 C" or "Z..C" were
>supposed to be equivalent:
>
>> With `git format-patch --base=P -3 C` (or variants thereof, e.g. with
>> `--cover-letter` or using `Z..C` instead of `-3 C` to specify the
>> range), the base tree information block is shown at the end of the
>> first message the command outputs (either the first patch, or the
>> cover letter), like this:
>> 
>> ------------
>> base-commit: P
>> prerequisite-patch-id: X
>> prerequisite-patch-id: Y
>> prerequisite-patch-id: Z
>> ------------
>
>-- 
>Eduardo
