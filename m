Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C828208BD
	for <e@80x24.org>; Thu, 10 Aug 2017 18:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbdHJSAJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:00:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57426 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752827AbdHJSAI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:00:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB9298EA4F;
        Thu, 10 Aug 2017 14:00:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=V
        26jA3LzNR7JYA7d7Ox+vSK6dsQ=; b=wy6ZQmk9EljXl8cFYBkITSyj+ybkge2vZ
        +117yDUGR8q57Zz70WrUREWZTcYZVCsZEiC3K02MKC/3lL8noXrhL+rUDdGo6ckX
        5J1Qrj1ttNMNNod0wjMbDIDyjb2KTA6nBhPMZvshyNWBpyKJruu4XLqS2HbX231r
        q7DVVtYn4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=jQ7JCic72dV5kUPNjnblZYt+N59G/u8HNbPAbXTTgHUIK9p3lWuy/9GC
        OIs6M6B+gTlRRvyFQXSOPsMN6poEwS9axuaK1CnjN39aTEqsdnJmZVSIIxh9Cr12
        Te02kZG1mMwzuiRRDGeeHNJzeWbu+eeJHDQJIbNxdQkZzlEgSFQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E33FB8EA4E;
        Thu, 10 Aug 2017 14:00:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03ED68EA3E;
        Thu, 10 Aug 2017 14:00:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.14.1, v2.13.5, and others
Date:   Thu, 10 Aug 2017 11:00:04 -0700
Message-ID: <xmqqh8xf482j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDA7BA10-7DF5-11E7-B61F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.14.1 is now available at the
usual places, together with releases for older maintenance track for
the same issue: v2.7.6, v2.8.6, v2.9.5, v2.10.4, v2.11.3, v2.12.4,
and v2.13.5.

These contain a security fix for CVE-2017-1000117, and are released
in coordination with Subversion and Mercurial that share a similar
issue.  CVE-2017-9800 and CVE-2017-1000116 are assigned to these
systems, respectively, for issues similar to it that are now
addressed in their part of this coordinated release.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of these tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

A malicious third-party can give a crafted "ssh://..." URL to an
unsuspecting victim, and an attempt to visit the URL can result in
any program that exists on the victim's machine being executed.
Such a URL could be placed in the .gitmodules file of a malicious
project, and an unsuspecting victim could be tricked into running
"git clone --recurse-submodules" to trigger the vulnerability.

Credits to find and fix the issue go to Brian Neel at GitLab, Joern
Schneeweisz of Recurity Labs and Jeff King at GitHub.

 * A "ssh://..." URL can result in a "ssh" command line with a
   hostname that begins with a dash "-", which would cause the "ssh"
   command to instead (mis)treat it as an option.  This is now
   prevented by forbidding such a hostname (which should not impact
   any real-world usage).

 * Similarly, when GIT_PROXY_COMMAND is configured, the command is
   run with host and port that are parsed out from "ssh://..." URL;
   a poorly written GIT_PROXY_COMMAND could be tricked into treating
   a string that begins with a dash "-" as an option.  This is now
   prevented by forbidding such a hostname and port number (again,
   which should not impact any real-world usage).

 * In the same spirit, a repository name that begins with a dash "-"
   is also forbidden now.
