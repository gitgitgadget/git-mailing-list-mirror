From: Yichao Yu <yyc1992@gmail.com>
Subject: Remote hung up during `git fetch`
Date: Wed, 21 Nov 2012 23:18:34 -0500
Message-ID: <CAMvDr+R__wWRwm2xNC3-v0T1RVu_rKdjKUJhb8cHwEXvuX9OMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 00:00:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbfl3-0005wu-Ka
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 00:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214Ab2KVXAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 18:00:07 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60502 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab2KVXAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 18:00:05 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2625936iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 15:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=BlxFH5X571txGGMK1IZ9yJYIvZof1WtLslLMw5mYWhE=;
        b=jG9G37ABWtemHl5FMk7Cqj2hSqEO5MEod1RNI7SiSW+gakzOy8cab8I4n0cXD1xfal
         zokvsGnqXTeLeJXYINNSQYgfF+KylqBU8795P6cHZoF398VFDnfiToCiSKHdWi34DqOD
         Fhk/PwR9exQHFQYhG4blvbxLenYoISEDRNWiAevfUOonrJ4j9zBngllliMcCaS057f9B
         UaroSZSUd71ZSHryQUR4Y9QP13vh9PfJJeLDZgMupZK9BtlAyXXS86vDZAQY7cbUAGgs
         /U3MdBSEBW1Ml/reeXx+yjvuJczRYX2timadDwZDvXMn7BsEr6ETfwFdKLEf7KZIEXuD
         bRHg==
Received: by 10.50.12.165 with SMTP id z5mr1895031igb.17.1353557934382; Wed,
 21 Nov 2012 20:18:54 -0800 (PST)
Received: by 10.64.15.165 with HTTP; Wed, 21 Nov 2012 20:18:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210221>

Hi everyone,

I want to build packages for snap shoot of different branches from
different remote git repositories in the same local directory (so that
I don't need to recompile everything everytime.) and I am using a
combination of `git clone/checkout/reset/fetch` to do that. However,
during git-fetch, the remote sometimes stop responding or simply reset
the connection. This happens occasionally at least for both ssh and
git protocol (not sure about http/https) on github, bitbucket and also
kernel.org so I think it is probably not due to a weird behavior of a
certain host. Does anyone know the reason or is there anything I have
done wrong? And is there a better way to set the local tree to a
certain branch at a certain url? THX

My git version is ArchLinux package 1.8.0-1. (timezone
America/New_York in case the time stamp somehow matters)

Here is a script that always triggers the issue (at least now) and
it's output. (No I am not trying to merge git and the kernel... These
are just random public repos on kernel.org that can trigger the issue.
Although I am pulling from two repos from different project here, the
same thing can also happen on other hosts when the two repos are
actually the same project)

Yichao Yu

------------------------------------------------------------------

#!/bin/bash

repo_name=git
# remote1='git://github.com/torvalds/linux.git'
remote1='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'
branch1='master'
# remote2='git://github.com/git/git.git'
remote2='git://git.kernel.org/pub/scm/git/git.git'
branch2='next'

git clone --depth 1 --single-branch --branch "$branch1" "$remote1" "$repo_name"
cd "$repo_name"
git fetch -vvv "$remote2" # "$branch2:$branch2"

-----------------------------------------------

Cloning into 'git'...
remote: Counting objects: 43215, done.
remote: Compressing objects: 100% (41422/41422), done.
remote: Total 43215 (delta 3079), reused 22032 (delta 1247)
Receiving objects: 100% (43215/43215), 119.06 MiB | 1.60 MiB/s, done.
Resolving deltas: 100% (3079/3079), done.
Checking out files: 100% (40905/40905), done.
fatal: destination path 'git' already exists and is not an empty directory.
Server supports multi_ack_detailed
Server supports side-band-64k
Server supports ofs-delta
want 2d242fb3fc19fc9ba046accdd9210be8b9913f64 (HEAD)
have ef6c5be658f6a70c1256fbd18e18ee0dc24c3386
have db9d8c60266a5010e905829e10cd722519e14777
done
fatal: The remote end hung up unexpectedly
