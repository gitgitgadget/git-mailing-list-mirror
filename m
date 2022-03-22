Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF525C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 16:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbiCVQtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiCVQtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 12:49:51 -0400
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 09:48:20 PDT
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF3B84C
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 09:48:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id D200A1600EA;
        Tue, 22 Mar 2022 09:38:43 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sqDsWrBScKUu; Tue, 22 Mar 2022 09:38:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id CCEA7160140;
        Tue, 22 Mar 2022 09:38:42 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JJYzQjAfTmTW; Tue, 22 Mar 2022 09:38:42 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id A5C081600EA;
        Tue, 22 Mar 2022 09:38:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------NxpDpf04jb9jAtmhzGzGljqL"
Message-ID: <bd751d5c-2f8b-4c52-72ec-f2b7268a30a8@cs.ucla.edu>
Date:   Tue, 22 Mar 2022 09:38:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Cc:     Carlo Arenas <carenas@gmail.com>
Subject: improve performance of PCRE2 bug 2642 bug workaround
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------NxpDpf04jb9jAtmhzGzGljqL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Today, Carlo Arenas pointed out[1] that GNU grep didn't work around 
PCRE2 bug 2642, which Git grep has a workaround for. While installing a 
GNU grep patch to fix this[2] I noticed that Git's workaround appears to 
be too pessimistic: on older PCRE2 libraries Git grep sets 
PCRE2_NO_START_OPTIMIZE even when PCRE2_CASELESS is not set.

Attached is a patch to Git that I just now cobbled up and have not even 
compiled, much less tested. Please feel free to ignore it, as it would 
merely improve performance on older, buggy PCRE2 libraries and that 
might not be worth your trouble. I'm sending this email as more of a 
thank-you for letting us know indirectly of the PCRE2 bug.

[1]: https://lists.gnu.org/r/grep-devel/2022-03/msg00004.html
[2]: https://lists.gnu.org/r/grep-devel/2022-03/msg00005.html
--------------NxpDpf04jb9jAtmhzGzGljqL
Content-Type: text/x-patch; charset=UTF-8; name="git-grep.diff"
Content-Disposition: attachment; filename="git-grep.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2dyZXAuYyBiL2dyZXAuYwppbmRleCA4MmViN2RhMTAyLi5iOTU1M2Vj
OWY1IDEwMDY0NAotLS0gYS9ncmVwLmMKKysrIGIvZ3JlcC5jCkBAIC0yOTcsNyArMjk3LDkg
QEAgc3RhdGljIHZvaWQgY29tcGlsZV9wY3JlMl9wYXR0ZXJuKHN0cnVjdCBncmVwX3BhdCAq
cCwgY29uc3Qgc3RydWN0IGdyZXBfb3B0ICpvcHQKIAogI2lmbmRlZiBHSVRfUENSRTJfVkVS
U0lPTl8xMF8zNl9PUl9ISUdIRVIKIAkvKiBXb3JrIGFyb3VuZCBodHRwczovL2J1Z3MuZXhp
bS5vcmcvc2hvd19idWcuY2dpP2lkPTI2NDIgZml4ZWQgaW4gMTAuMzYgKi8KLQlpZiAoUENS
RTJfTUFUQ0hfSU5WQUxJRF9VVEYgJiYgb3B0aW9ucyAmIChQQ1JFMl9VVEYgfCBQQ1JFMl9D
QVNFTEVTUykpCisJaWYgKFBDUkUyX01BVENIX0lOVkFMSURfVVRGICYmCisJICAgICgob3B0
aW9ucyAmIChQQ1JFMl9VVEYgfCBQQ1JFMl9DQVNFTEVTUykpID09CisJICAgICAoUENSRTJf
VVRGIHwgUENSRTJfQ0FTRUxFU1MpKSkKIAkJb3B0aW9ucyB8PSBQQ1JFMl9OT19TVEFSVF9P
UFRJTUlaRTsKICNlbmRpZgogCg==

--------------NxpDpf04jb9jAtmhzGzGljqL--
