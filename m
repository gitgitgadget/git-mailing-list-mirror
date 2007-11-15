From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: New repo quickly corrupted
Date: Thu, 15 Nov 2007 16:50:15 -0500
Message-ID: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ismbe-0003Mk-98
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763644AbXKOVuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765414AbXKOVuU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:50:20 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:14513 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765316AbXKOVuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 16:50:19 -0500
Received: by nz-out-0506.google.com with SMTP id s18so652266nze
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 13:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=QO8lF5tKKzC96ywh1fv1xbQ8Q/GaloeI3+cjboEJPxU=;
        b=ICRTXqH5wE1aWc5AVcT8iUvVg6YBcKooBQMt7hiKmWxRiSMkxTyCO7KQlwMkqGinUpcuzYWjNyJGAr/PiJF10YT2kcF6xF25mUJx0bFfQ6tgjoN0XwjZgK/VZoBbqsHr/vbC+nQmw7uR55Ddl7Gwjtgup35jBzqdbCkhHMzJkRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s3pFguM3THFM1VAI3Rxb5ZsdthmHwicAaHWc/o7nixKcXLUzhThfgf9dJzL8k0AfDX8sMLb+Nr3tIQHEEhIDk+sJWCTyRdKJP/XHcF7QttuZ7uWlnBYs3ZICLIhmovsoU4qomHyuodtrFZGVJpqVIExAe0v1dozK+BL6F07qUfs=
Received: by 10.114.195.19 with SMTP id s19mr249622waf.1195163415344;
        Thu, 15 Nov 2007 13:50:15 -0800 (PST)
Received: by 10.115.76.19 with HTTP; Thu, 15 Nov 2007 13:50:15 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65163>

I was working on a new repo created from a tar snapshot of an old
project, and after about a half-hour and about 5 commits for hacking,
I had fixed the problem I set out to take care of.

However, I tried to run git gc to clean it up and put it away and I
was met with the following:

[sewall@hobo SWIFT++_1.2 (master)]$ git gc
Counting objects: 227, done.
error: corrupt loose object '680aba836639d14a36b81f9e29da52bd9af69770'
fatal: object 680aba836639d14a36b81f9e29da52bd9af69770 cannot be read
error: failed to run repack

I've followed discussions on the list about corrupted repos and did
[sewall@hobo SWIFT++_1.2 (master)]$ git fsck
error: corrupt loose object '24bbb41919ef906db6f40c3c80f246b7e0cdf9f4'
error: 24bbb41919ef906db6f40c3c80f246b7e0cdf9f4: object corrupt or missing
error: corrupt loose object '680aba836639d14a36b81f9e29da52bd9af69770'
error: 680aba836639d14a36b81f9e29da52bd9af69770: object corrupt or missing
error: 8de8382bdc3cc5f936670df414b33ee63927f3a4: object corrupt or missing
error: corrupt loose object 'd186d23e87ddf344acc56f48e3cf2f61c7a47e16'
error: d186d23e87ddf344acc56f48e3cf2f61c7a47e16: object corrupt or missing
missing blob 680aba836639d14a36b81f9e29da52bd9af69770
missing blob 8de8382bdc3cc5f936670df414b33ee63927f3a4
missing blob d186d23e87ddf344acc56f48e3cf2f61c7a47e16
missing blob 24bbb41919ef906db6f40c3c80f246b7e0cdf9f4

And since these were all blobs, I looked for em with git-log:
[sewall@hobo SWIFT++_1.2 (master)]$ git log --raw --all | grep 24bbb*
[sewall@hobo SWIFT++_1.2 (master)]$ git log --raw --all | grep d186*
[sewall@hobo SWIFT++_1.2 (master)]$ git log --raw --all | grep 8de83*
[sewall@hobo SWIFT++_1.2 (master)]$ git log --raw --all | grep 680ab*

So it would assume that these are dangling objects. Given the simple
history of the repo, the only think I can think of that could have
caused it would be that my first commit was of the original files, and
I immediately remembered that I wanted to run dos2unix on the files so
I did and did a commit -a --amend.

I untarred the original snapshot again and ran git-hash-object over
all the files, and sure enough each of those missing hashes
corresponds to a blob in the original (non-dos2unix'd) file.

I copied the corrupted repo, manually deleted those objects, then
hash-object -w the appropriate originals back in. git-fsck was
mollified.

Finally, I tried repeating the process and the same error occurs.
In summary:
unzip original.zip
git init
git add .
git commit -m "Initial commit"
find . -type f -exec dos2unix {} +
git commit -a --amend
[accept same message]
git fsck
[same error message as above]

I just built my git today, unmodified:
git version 1.5.3.5.721.g039b

What's going on?

Jason

P.S. These files aren't particularly secret, so I'm happy to post them
if need be. Its actually someone else's code (a fellow student who
graduated some time before I arrived in grad school); I was asked to
modernize it enough to compile on on the latest gcc.
