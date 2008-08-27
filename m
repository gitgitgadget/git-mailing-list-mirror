From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Are these bugs?
Date: Wed, 27 Aug 2008 19:36:47 -0400
Message-ID: <76718490808271636i4de8f385pdaeb1672f06a00d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUaK-00019k-8m
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbYH0Xgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYH0Xgt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:36:49 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:48897 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYH0Xgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:36:48 -0400
Received: by yx-out-2324.google.com with SMTP id 8so59850yxm.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=+xodyqAoNo21ywoX70azebJJ1zw9EB7o6wSzr0a58Uc=;
        b=bvRbjkoL7p7z6KYpRzCBlbeT3xGhKukGP62zaRYpHJy/M31HTlqxUK9qdheTxv0qNU
         4C7bqW+88t/fbmFjwHu/qGZctyRTWIK66lkkRYW4z9eYbsnjxgJAkmxY8tkyHDhErr8Y
         hbTe7app/z1rL1LCITv1Kf6ITdN/fOQ6Jpm8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=FgU++j6D9j2Gubqq9D7xhmPkLYZLL3YbotAVbjLENy72wFIJhi92KX2vFqTLNCkzKf
         5xbvQvP+iWOM7S4PLJwsA+/kw47uA46t72TxtOf2nWSYZJHPEgEKD04ZKJLu6kUNU/c5
         Nv7m0abkT4PA5apnsjKGLUuPqVN2w7DKV2h/E=
Received: by 10.151.46.3 with SMTP id y3mr988494ybj.225.1219880207569;
        Wed, 27 Aug 2008 16:36:47 -0700 (PDT)
Received: by 10.150.50.2 with HTTP; Wed, 27 Aug 2008 16:36:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93986>

1. You can't use reset in a just initialized repo:

$ mkdir testrepo
$ cd testrepo
$ echo foo > foo
$ git init
$ git add .
$ git reset
fatal: Failed to resolve 'HEAD' as a valid ref.

In the real-world, I had initialized a new repository and realized I'd
staged extra files I didn't want. I was going to "git reset" then
re-add the specific files I wanted, but that obviously failed. I
worked around this by using "git rm --cached" to get rid of what I
didn't want.

I understand why "git reset" failed, but at best the error message is
confusing to a new user.

2. "git add --ignore-errors" doesn't work with ignored files:

$ mkdir testrepo
$ cd testrepo
$ git init
Initialized empty Git repository in /Users/jay/testrepo/.git/
$ echo foo >> .git/info/exclude
$ echo foo > foo
$ echo bar > bar
$ git add --ignore-errors foo bar
The following paths are ignored by one of your .gitignore files:
foo
Use -f if you really want to add them.
fatal: no files added

Now you may ask "why are you specifying foo if you don't want to add
it?" In the real-world I was generating the list to "git add" with
xargs and it was quite a long list. It was easiest to filter out what
I didn't want through .git/info/exclude. But I ended up having to "...
| grep -v <stuff I don't want> | xargs git add".

So I think preferable would be: "Use -f if you really want to add them
or --ignore errors to continue anyway."

$ git version
git version 1.6.0.176.g8698c

Thoughts?

j.
