Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE3220401
	for <e@80x24.org>; Sat, 24 Jun 2017 18:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755245AbdFXSvZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 14:51:25 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35189 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdFXSvX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 14:51:23 -0400
Received: by mail-it0-f46.google.com with SMTP id v202so7055417itb.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Mzpt7RumZEyYRGNjxPv5vboPttQMwT89xRHf0J9m1AU=;
        b=JTrCZD/2WCQ+uF5e4NNDOpQSPU69W2rLfsehY/ubpM2Zw1PjeSIwbHY6j8u3uZDsKi
         5db5u1dBOcrwc0Rdln3JazGi2BqEmA+BSUaaMCAdwMBlxufAEwRP4+szClhW5zNZjSHx
         iBgxnNP3tUukmVv2sOPnI2tlJ60wzvWq6rNYXMQELViukAP6AuPdIpKOAoudGl7/21D/
         q+4OYlXOgsSLzjNeyBQxzuYCIT4jxyBMOpXKsENAYybfNuJwk5ALgSDeKnwGJGAeeY59
         mr3vNlzUByLwSCEXVn+0ey/0UhYcHFjabcniSx+15s4wqDBhR16UQEPjAn78OyaC84gS
         QV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Mzpt7RumZEyYRGNjxPv5vboPttQMwT89xRHf0J9m1AU=;
        b=hcKZkZdCHB3YsJinaZsSQKEmSP4COMSvQXGl8rqADjsMliwMp6GrN1WaPWUiPKo81S
         qFdideEielGOANvfAIboYIPGRqFBEGEABNAcWncNzColcmhAksJhgAo8hPm7xDTG6h12
         ynQ5rrSp1RtPbzkb9N2lNoG2XlbFLgmFHdRyAsZ12NNl3XIrfqPrgiT1mDQr/sEUZLIb
         x+jxLfWuxcz30fXnDu2FZPBU+WEOMsQ4WtjfP4xwAvCPKo9neusAc8LtYHWTQX1l0FnE
         Y7WttzbhfijI5ruLa3WwQDhieSaQaUhXgzSmRdMrUIlxNtxDMy2DJbnbZcQC3fRNuLTF
         pV5g==
X-Gm-Message-State: AKS2vOyydXw1bypKb0H3Jaf7yYFW5rwthUjPOHtPOcuF+ACigwG07jbF
        /tRKjja4Eji7nd0RxY9DLcBCZbGD8P9T
X-Received: by 10.36.216.7 with SMTP id b7mr14206138itg.30.1498330272381; Sat,
 24 Jun 2017 11:51:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Sat, 24 Jun 2017 11:51:11 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Jun 2017 20:51:11 +0200
Message-ID: <CAP8UFD0bOfzY-_hBDKddOcJdPUpP2KEVaX_SrCgvAMYAHtseiQ@mail.gmail.com>
Subject: Crash in t3507-cherry-pick-conflict.sh with GIT_TEST_SPLIT_INDEX set
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git from the master branch currently segfaults when running
t3507-cherry-pick-conflict.sh with GIT_TEST_SPLIT_INDEX set:

expecting success:
        pristine_detach initial &&
        test_must_fail git cherry-pick -s picked-signed &&
        git commit -a -s &&
        test $(git show -s |grep -c "Signed-off-by") = 1

HEAD is now at df2a63d... initial
Auto-merging foo
CONFLICT (content): Merge conflict in foo
error: could not apply e4ca149... picked-signed
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'
Segmentation fault
not ok 29 - commit after failed cherry-pick does not add duplicated -s
#
#               pristine_detach initial &&
#               test_must_fail git cherry-pick -s picked-signed &&
#               git commit -a -s &&
#               test $(git show -s |grep -c "Signed-off-by") = 1
#

The crash happens during the `git commit -a -s` with a backtrace like this:

Program received signal SIGSEGV, Segmentation fault.
0x000000000050bcf1 in entry_equals (map=0x8cef80 <the_index+64>,
e1=0xa2d2d2d2d2d2d00, e2=0x7fffffffce10,
    keydata=0x0) at hashmap.c:98
98              return (e1 == e2) || (e1->hash == e2->hash &&
!map->cmpfn(e1, e2, keydata));
(gdb) bt
#0  0x000000000050bcf1 in entry_equals (map=0x8cef80 <the_index+64>,
e1=0xa2d2d2d2d2d2d00, e2=0x7fffffffce10,
    keydata=0x0) at hashmap.c:98
#1  0x000000000050bec6 in find_entry_ptr (map=0x8cef80 <the_index+64>,
key=0x7fffffffce10, keydata=0x0)
    at hashmap.c:138
#2  0x000000000050c044 in hashmap_get (map=0x8cef80 <the_index+64>,
key=0x7fffffffce10, keydata=0x0)
    at hashmap.c:182
#3  0x0000000000525a1d in hashmap_get_from_hash (map=0x8cef80
<the_index+64>, hash=1625022057, keydata=0x0)
    at hashmap.h:78
#4  0x0000000000526edd in index_file_exists (istate=0x8cef40
<the_index>, name=0x8f19d0 "unrelated",
    namelen=9, icase=0) at name-hash.c:701
#5  0x00000000004f55ba in treat_one_path (dir=0x7fffffffd0b0,
untracked=0x0, istate=0x8cef40 <the_index>,
    path=0x7fffffffcf80, baselen=0, pathspec=0x88c2b8 <s+24>, dtype=8,
de=0x8f8a00) at dir.c:1550
#6  0x00000000004f5914 in treat_path (dir=0x7fffffffd0b0,
untracked=0x0, cdir=0x7fffffffcfa0,
    istate=0x8cef40 <the_index>, path=0x7fffffffcf80, baselen=0,
pathspec=0x88c2b8 <s+24>) at dir.c:1660
#7  0x00000000004f6006 in read_directory_recursive
(dir=0x7fffffffd0b0, istate=0x8cef40 <the_index>,
    base=0x61561b "", baselen=0, untracked=0x0, check_only=0,
pathspec=0x88c2b8 <s+24>) at dir.c:1809

It bisects to f9d7abec2a (split-index: add and use
unshare_split_index(), 2017-05-05) that is fixing memory leaks when
discarding the index.
It looks like we are freeing some cache entries that we shouldn't free.
