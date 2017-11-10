Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72091F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 16:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdKJQJ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 11:09:28 -0500
Received: from bran.ispras.ru ([83.149.199.196]:31620 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751142AbdKJQJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 11:09:28 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Nov 2017 11:09:27 EST
Received: from [10.10.14.117] (real.intra.ispras.ru [10.10.14.117])
        by smtp.ispras.ru (Postfix) with ESMTP id A5D31203C7
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 19:00:25 +0300 (MSK)
To:     git@vger.kernel.org
From:   =?UTF-8?B?0JXRhNC40LzQvtCyINCS0LDRgdC40LvQuNC5?= <real@ispras.ru>
Subject: Bug: cherry-pick & submodule
Message-ID: <c48bf9f3-10b2-dfac-a207-74a57e66b848@ispras.ru>
Date:   Fri, 10 Nov 2017 19:00:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------BB1C1433F49F6F28DBA2EE31"
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------BB1C1433F49F6F28DBA2EE31
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I faced an unexpected behaviour during cherry-picking
a commit to a branch with a submodule.

Git graph:

A -- B [master]
  \
   `- C -- D [test]

Both branches have a file with name `a_file`.
It has been added by commit A.
Commits B and C add a folder with name `a_submodule` to the respective 
branches.
Commit C does it regularly by adding a file with name `a_submodule/content`.
Commit B adds a submodule with name `a_submodule`.
Commit D only modifies `a_file`.
Note that `a_file` and `a_submodule` are not related.

[repo]
   |- a_file
   `- a_submodule

When I trying to cherry pick commit D on commit B, I got
a conflict with `a_submodule`. Changes of `a_file` are
successfully cherry-picked.

I expected, that there would be no conflicts.

A bash script reproducing the bug is attached.

Vasily.

--------------BB1C1433F49F6F28DBA2EE31
Content-Type: application/x-shellscript;
 name="bug.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bug.sh"

IyEvYmluL2Jhc2gKCnJtIC1yZiBhX3N1Ym1vZHVsZSBhX3JlcG8KCm1rZGlyIGFfc3VibW9k
dWxlCmNkIGFfc3VibW9kdWxlCmdpdCBpbml0CnRvdWNoIGFfZmlsZV9pbl9hX3N1Ym1vZHVs
ZQpnaXQgYWRkIGFfZmlsZV9pbl9hX3N1Ym1vZHVsZQpnaXQgY29tbWl0IC1tICJhZGQgYSBm
aWxlIGluIGEgc3VibW9kdWxlIgpjZCAuLgoKbWtkaXIgYV9yZXBvCmNkIGFfcmVwbwpnaXQg
aW5pdAoKdG91Y2ggYV9maWxlCmdpdCBhZGQgYV9maWxlCmdpdCBjb21taXQgLW0gImFkZCBh
IGZpbGUiCgpnaXQgYnJhbmNoIHRlc3QKZ2l0IGNoZWNrb3V0IHRlc3QKCm1rZGlyIGFfc3Vi
bW9kdWxlCnRvdWNoIGFfc3VibW9kdWxlL2NvbnRlbnQKZ2l0IGFkZCBhX3N1Ym1vZHVsZS9j
b250ZW50CmdpdCBjb21taXQgLW0gImFkZCBhIHJlZ3VsYXIgZm9sZGVyIHdpdGggbmFtZSBh
X3N1Ym1vZHVsZSIKCmVjaG8gIjEyMyIgPiBhX2ZpbGUKZ2l0IGFkZCBhX2ZpbGUKZ2l0IGNv
bW1pdCAtbSAibW9kaWZ5IGEgZmlsZSIKCmdpdCBjaGVja291dCBtYXN0ZXIKCmdpdCBzdWJt
b2R1bGUgYWRkIC4uL2Ffc3VibW9kdWxlIGFfc3VibW9kdWxlCmdpdCBzdWJtb2R1bGUgdXBk
YXRlIGFfc3VibW9kdWxlCmdpdCBjb21taXQgLW0gImFkZCBhIHN1Ym1vZHVsZSBpbmZvIGZv
bGRlciB3aXRoIG5hbWUgYV9zdWJtb2R1bGUiCgojIFRyeWluZyB0byBjaGVycnktcGljayBt
b2RpZmljYXRpb24gb2YgYSBmaWxlIGZyb20gdGVzdCBicmFuY2guCmdpdCBjaGVycnktcGlj
ayB0ZXN0CgojIHNvbWUgZGVidWcKZ2l0IHN0YXR1cwoKZ2l0ayAtLWFsbAo=
--------------BB1C1433F49F6F28DBA2EE31--
