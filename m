Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59DA1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 19:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932697AbeFLTuz (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 15:50:55 -0400
Received: from troubleshooters.com ([69.5.27.237]:43266 "HELO
        troubleshooters.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1754102AbeFLTuy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 15:50:54 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jun 2018 15:50:54 EDT
Received: (qmail 23386 invoked from network); 12 Jun 2018 19:44:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        h=X-Originating-IP:Date:From:To:Subject:Message-ID:Organization:X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
        s=default; d=troubleshooters.com;
        b=UfckBAwDXMHgX0D1XHs0FlCKNRrFl0Okqe3xyqKrVgUT5c5PrhiNQ+uKZN5YRe5JNm119r3kkC9GPTJSF3ncIzfLn1buD9f+Lg+UhFJcyWnq/2FFgk/+BkufP4s3/hLS8SaE4k0SnwMP3fGC1ZQ0V2KzuxIJ9R3PgeZF2a2pZCA=;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/simple; d=troubleshooters.com;
        s=default; t=1528832653; bh=V4r9DWSdxd0KcYjGNGeYxOAOHs4=; l=1709;
        h=X-Originating-IP:Date:From:To:Subject:Message-ID:Organization:
         X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=M7iGwSAeyPf42UOlZZMn4pSaqCNSDR4F2oP589hQCOFqAaJt6IadmB1dZjLI2ed6j
         V0dFIICWi2NV50ewWymh7jBNAmfwrQcbUDID2IPc4TFEHJRaCcGj5/yI3JM0gPoSdD
         nAXVXWByD76b0D+2dOk5VVafBOVzR1NMytUZM5hU=
X-Originating-IP: [72.188.224.222]
Date:   Tue, 12 Jun 2018 15:44:13 -0400
From:   Steve Litt <slitt@troubleshooters.com>
To:     git@vger.kernel.org
Subject: How to delete files and directories from git commit history?
Message-ID: <20180612154413.3df64441@mydesk.domain.cxm>
Organization: Troubleshooters.Com
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have git 2.17.1 running on Void Linux 64 bit running the Linux
4.16.9_1 kernel, not available to the public in any way (yet). I have a
repository in my project's working directory, and push to a bare
repository on the hard disk.

My project (call it myproject) had a directory (call it docs/propdir)
that was unnecessary for the project, and I've decided I don't want to
offer the files in that directory as free software. So I need to delete
docs/propdir from all commits in the repository. I did the following,
while in my working repository's myproject directory:

git filter-branch --tree-filter 'rm -rf docs/propdir' HEAD

After that command, I could git clone the working repo and then git
checkout to a commit stage that used to have the directory and files,
and they're not there. So far, so good.

But then I view all filenames from that directory that have ever been
in the project, as follows:

git cat-file --buffer --batch-all-objects \
 --batch-check='%(objecttype) %(objectname)' \
 | grep ^c | cut -d " "  -f 2 \
 | xargs -n 1 git ls-tree -r | sort | uniq \
 | grep propdir

The preceding command lists directory docs/propdir and all the files
it's ever contained. This makes me uneasy because if the filenames are
still there, I wonder if there's a route to get the files with a git
command. Second, I'd prefer that when my repo is exposed to the public,
people not know this directory and these files ever existed.

What command do I do to remove all mention of doc/propdir and its
files from my git history?

Thanks,

SteveT

Steve Litt 
June 2018 featured book: Twenty Eight Tales of Troubleshooting
http://www.troubleshooters.com/28


