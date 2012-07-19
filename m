From: bronek <kenorb@gmail.com>
Subject: Re: Bug: Git-Svn creates wrong tag when svn tag contains spaces
Date: Thu, 19 Jul 2012 19:42:57 +0200
Message-ID: <CANmdXCFFNUk1NntEkJUBjm4XyQPzRUdxDLOksEK63a0B0bTkrQ@mail.gmail.com>
References: <3760846560270293323@unknownmsgid> <871uk76dxw.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:43:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srul3-0004Uv-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab2GSRnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:43:20 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52568 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab2GSRnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:43:19 -0400
Received: by qcro28 with SMTP id o28so1861636qcr.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=kS85THN4vgoMsOm/QJjMNNXwE+lV/snwukKHyfkV1Gs=;
        b=QhsU/qus7QmiB0n4zpQ+xcwG1LsnFhCcpmLzxziwkEVDsBRLD9PySR6gA9J3ushArj
         1nb0br8YE9iM1VFpKKC2zKWeyXK+jweUE3ZjVJY8ZuZkKk2xUZ7zb3WtTTSdRINc7d7C
         fdn5sm/xDcICwFohfigRJWzHp6o18SRmU2kLAYe9uB10zbJSurR6E/ifN1GQ/KrSIqgM
         qWq2ET5Orr+WWgMtMBlUTr9iNXvV2cLjP7eyapA3bX2xrDwOHgKpT/+WSxQ1yzczYFfZ
         l+iC8zDfU8jrBgrpVBCWMZJHnORuZ0mFYShh9BnpnFBaveiv15qJZtx3fGatul6dFifa
         RagA==
Received: by 10.224.184.204 with SMTP id cl12mr5157880qab.55.1342719798443;
 Thu, 19 Jul 2012 10:43:18 -0700 (PDT)
Received: by 10.229.248.139 with HTTP; Thu, 19 Jul 2012 10:42:57 -0700 (PDT)
In-Reply-To: <871uk76dxw.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201749>

The problem is as follow:
1. git svn fetch
2.
Found possible branch point: https://xxx/svn/xxx/branches/11-07 D t-m
=> https://xxx/svn/xxx/branches/11-09 S t-m, 4332
fatal: Not a valid object name refs/remotes/1-11 M R 2.6
cat-file commit refs/remotes/1-11 M R 2.6: command returned error: 128

I'm using git version 1.7.9.5 on Ubuntu 12.04

I've tried to create the tag manually, but it's not allowed.
$ git tag "11-07 D t-m" remotes/11-07%20D
fatal: '11-07 D t-m' is not a valid tag name.

As workaround I've tried:
- to create or rename tag manually as suggested here:
http://stackoverflow.com/questions/11365317/git-svn-clone-fails-fatal-not-a-valid-object-name/11559472#11559472
- http://qa.celogeek.com/programming/versionning/git/svn/rebase_with_bad_object_after_rm
But without success.

There is also bug report on lunchpad:
https://bugs.launchpad.net/ubuntu/+source/git/+bug/786942
strace log:
[pid 30618] access(".git/config", R_OK) = 0
[pid 30618] open(".git/config", O_RDONLY) = 3
[pid 30618] fstat(3, {st_mode=S_IFREG|0664, st_size=551, ...}) = 0
[pid 30618] mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f2ed01e9000
[pid 30618] read(3, "[core]\n\trepositoryformatversion "..., 4096) = 551
[pid 30618] read(3, "", 4096)           = 0
[pid 30618] close(3)                    = 0
[pid 30618] munmap(0x7f2ed01e9000, 4096) = 0
[pid 30618] write(2, "fatal: Not a valid object name r"..., 76fatal:
Not a valid object name refs/remotes/1-11 M R 2.6
) = 76
[pid 30618] exit_group(128)             = ?

---
Kind regards,
Rafal



On 19 July 2012 16:08, Thomas Rast <trast@student.ethz.ch> wrote:
>
> "Rafal W." <kenorb@gmail.com> writes:
>
> > I've the problem described here:
> > http://code.google.com/p/git-core/issues/detail?id=16
>
> Git does not have a bug tracker.  Please post the issue, description,
> etc. to this list.
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
