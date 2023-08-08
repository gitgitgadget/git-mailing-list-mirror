Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CCBC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 22:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjHHWc2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Aug 2023 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHHWc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 18:32:27 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 15:32:21 PDT
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F0BDE
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 15:32:20 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 5ECA7432FC
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 00:24:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 0786D439C2
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 00:24:53 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B_88w2_ihJ4C for <git@vger.kernel.org>;
        Wed,  9 Aug 2023 00:24:53 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 3D8DC43A2B
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 00:24:52 +0200 (CEST)
Message-ID: <676330b6-720a-e262-d583-9012e549bba7@opperschaap.net>
Date:   Tue, 8 Aug 2023 18:24:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Wesley <wesleys@opperschaap.net>
Subject: git pre-push hook not getting the lines from STDIN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=p0WdMEafAAAA:8
        a=MR9Ty-H2_0z2zyL-q1UA:9 a=QEXdDO2ut3YA:10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello list,

I'm trying to figure out how I can check which branches are used in a 
git push action while using the pre-push hook. In the man page the 
following is mentioned:

----<

Information about what is to be pushed is provided on the hook’s 
standard input with lines of the form:

<local ref> SP <local object name> SP <remote ref> SP <remote object 
name> LF

For instance, if the command `git push origin master:foreign` were run 
the hook would receive a line like the following:

   refs/heads/master 67890 refs/heads/foreign 12345

----<

I cannot seem to reproduce this behavior with the push action. Only when 
pushing to delete a remote branch or pushing to a new branch gets 
created yields any success. I went as far back as git 2.9.0 (I can't 
build older versions of git), to no avail. The line in the man page 
seems to indicate git v1.8.2-rc0 was the first tag to have it (ec55559f).

Could someone verify that what I am seeing is correct behavior or that 
this is incorrect?

As stated, I experience issues on git v2.9.0, 2.40.1 (Debian) and also 
directly from source 2.42.0.rc0.26.g6ac35453d6.

Thanks,
Wesley


----< a new branch

$ git push origin test:fofofo
+.git/hooks/pre-push:5> remote=origin
+.git/hooks/pre-push:6> url=git@gitlab.com:gitlabmeme/somerepo.git
+.git/hooks/pre-push:8> success=128
+.git/hooks/pre-push:10> z40=0000000000000000000000000000000000000000
+.git/hooks/pre-push:11> IFS=' '
+.git/hooks/pre-push:13> read LOCAL_REF LOCAL_SHA REMOTE_REF REMOTE_SHA
+.git/hooks/pre-push:15> echo refs/heads/test
refs/heads/test
+.git/hooks/pre-push:16> echo 24a3b84a02937df6040fecce2e0620e16c823b36
24a3b84a02937df6040fecce2e0620e16c823b36
+.git/hooks/pre-push:17> echo refs/heads/fofofo
refs/heads/fofofo
+.git/hooks/pre-push:18> echo 0000000000000000000000000000000000000000
0000000000000000000000000000000000000000
+.git/hooks/pre-push:21> [ refs/heads/test '=' 
0000000000000000000000000000000000000000 ']'
+.git/hooks/pre-push:23> [ refs/heads/test '=' '(delete)' ']'
+.git/hooks/pre-push:30> exit 128

----< deletion of a branch on the remote

$ git push origin :development
+.git/hooks/pre-push:5> remote=origin
+.git/hooks/pre-push:6> url=git@gitlab.com:gitlabmeme/somerepo.git
+.git/hooks/pre-push:8> success=128
+.git/hooks/pre-push:10> z40=0000000000000000000000000000000000000000
+.git/hooks/pre-push:11> IFS=' '
+.git/hooks/pre-push:13> read LOCAL_REF LOCAL_SHA REMOTE_REF REMOTE_SHA
+.git/hooks/pre-push:15> echo '(delete)'
(delete)
+.git/hooks/pre-push:16> echo 0000000000000000000000000000000000000000
0000000000000000000000000000000000000000
+.git/hooks/pre-push:17> echo refs/heads/development
refs/heads/development
+.git/hooks/pre-push:18> echo 1762c08fd38c1137bbca27898df7c64ad846f877
1762c08fd38c1137bbca27898df7c64ad846f877
+.git/hooks/pre-push:21> [ '(delete)' '=' 
0000000000000000000000000000000000000000 ']'
+.git/hooks/pre-push:23> [ '(delete)' '=' '(delete)' ']'
+.git/hooks/pre-push:23> exit 128

----<

If I push to an existing repo on my remote I see this:
$ git push origin HEAD:development
+.git/hooks/pre-push:5> remote=origin
+.git/hooks/pre-push:6> url=git@gitlab.com:gitlabmeme/somerepo.git
+.git/hooks/pre-push:8> success=128
+.git/hooks/pre-push:10> z40=0000000000000000000000000000000000000000
+.git/hooks/pre-push:11> IFS=' '
+.git/hooks/pre-push:13> read LOCAL_REF LOCAL_SHA REMOTE_REF REMOTE_SHA
+.git/hooks/pre-push:15> echo

+.git/hooks/pre-push:16> echo

+.git/hooks/pre-push:17> echo

+.git/hooks/pre-push:18> echo

+.git/hooks/pre-push:21> [ '' '=' 
0000000000000000000000000000000000000000 ']'
+.git/hooks/pre-push:23> [ '' '=' '(delete)' ']'
+.git/hooks/pre-push:28> exit 128

----< The pre-push script

#!/usr/bin/env zsh
#
set -x

remote="$1"
url="$2"

success=128

z40=0000000000000000000000000000000000000000
IFS=' '

read LOCAL_REF LOCAL_SHA REMOTE_REF REMOTE_SHA

echo $LOCAL_REF
echo $LOCAL_SHA
echo $REMOTE_REF
echo $REMOTE_SHA

# deletion of remote branch
[ "$LOCAL_REF" = $z40 ] && exit $success
# git 2.40 at least does not have $z40 as a delete
[ "$LOCAL_REF" = '(delete)' ] && exit $success

exit $success




-- 
Wesley

Why not both?
