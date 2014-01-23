From: shawn wilson <ag4ve.us@gmail.com>
Subject: submodules
Date: Thu, 23 Jan 2014 03:38:49 -0500
Message-ID: <CAH_OBicG4bLWu_C=uF6bTzzdJP5SSZ=odQF-qsP4n+VvAN4nrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 23 09:39:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Fog-0005wY-W2
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 09:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbaAWIjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jan 2014 03:39:11 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:41843 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbaAWIjK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 03:39:10 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so1495117pde.41
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 00:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=E3CIC4ZhDQeyndhswuaxsHiBiofifywRD17JNaEesC8=;
        b=uCPpgxNxSbiJLdBxmZgz7N/rHtmVhzvDcCnjJxvQJaRof1d9Y8LA7vJxYXpIQ99U3S
         v9W/xoxwVYCgB6lqALIhIe6sikzJkAeT8ZKNwejJsJqTpKw7FV0w8ttk8Wj0m6Dtb9qB
         f0SsPwaLa+upZY/6uRtz9MR4+PZyYLu2XrNeAbKAzLlpq0Ywr3Sh6Hen+8uM6SLMIv6W
         1IeYSmC6X6qOcaAvOrM6SgNmsV4dYzE3D8CUojyM1I8arSxj+OtXnWcEMXFno0EkI4SF
         HxZ9P+bprZj6++YSplhhUzN+AE/ilr9/U0Cw+4SCRk1fufnJJBlwc52khjXZWu3d63eR
         3xSQ==
X-Received: by 10.68.195.4 with SMTP id ia4mr6812693pbc.142.1390466349667;
 Thu, 23 Jan 2014 00:39:09 -0800 (PST)
Received: by 10.70.61.135 with HTTP; Thu, 23 Jan 2014 00:38:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240906>

I've got a git repo that just contains a bunch of small projects
(scripts, configs, etc). The idea was (is) to make it so that each
project is tracked seperately (different branches, not needing to
filter out logs for unrelated commits). And it works great for that.
The problem is that I guess I don't know how to manage it and keep
stumbling and tripping over myself here.

My issue is in trying to update the submodules, I'm getting:
 % git submodule update --init
                                                gits/kt (master =E2=9A=A1=
)
swlap1
fatal: reference is not a tree: 98f1e9f99fca32ab3de901219eb2f600d38ab3a=
5
Unable to checkout '98f1e9f99fca32ab3de901219eb2f600d38ab3a5' in
submodule path 'repo_a'

Ok, so a bit of googling and I found this:
http://stackoverflow.com/questions/13425298/git-submodule-update-fatal-=
error-reference-is-not-a-tree
Ok, so update the repo that contains the submodules every time you
push from a sub repo? How / where do I create a hook to do this?

And then:
http://stackoverflow.com/questions/2155887/git-submodule-head-reference=
-is-not-a-tree-error
So, the first example didn't really work:
 % cd repo_a
                                            gits/kt (master =E2=9A=A1) =
swlap1
 % git checkout 98f1e9
                                              kt/repo_a (master)
swlap1
error: pathspec '98f1e9' did not match any file(s) known to git.

So, at this point I realized I have pushed from two repos (maybe
others have as well) and not updated the repo of submodules. So, as
long as the issue is just with this one repo, I'm ok with loosing a
little data (not much has changed in a while and maybe I'll go and
find the blobs and merge them back in later). So I try the other
method:
 % git log --oneline -p -- repo_a
                                            gits/kt (master =E2=9A=A1) =
swlap1
7911a1e Bump.
diff --git a/repo_a b/repo_a
index 206635e..98f1e9f 160000
--- a/repo_a
+++ b/repo_a
@@ -1 +1 @@
-Subproject commit 206635eed8b94e4133a7689b34a570e2fb0b6069
=2E......
 % git checkout d92f592- -- repo_a
                                            gits/kt (master =E2=9A=A1) =
swlap1
fatal: invalid reference: d92f592-



So, (after this is solved) is there a post hook (not even sure where
such a thing would go) after pushing from a submodule repo (maybe a
concatination of commit messages or something) so that this stays in
sync and I never have to think about this again (though I think I'll
remember after winning this fight).
