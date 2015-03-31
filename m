From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Allowing weak references to blobs and strong references to
 commits
Date: Tue, 31 Mar 2015 16:14:49 -0700
Message-ID: <20150331231449.GF22844@google.com>
References: <20150331100756.GA13377@glandium.org>
 <xmqq8uecrk5g.fsf@gitster.dls.corp.google.com>
 <20150331223919.GA24362@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:15:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd5N3-0005Nm-M8
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 01:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbbCaXOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 19:14:53 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34493 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbbCaXOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 19:14:52 -0400
Received: by iedfl3 with SMTP id fl3so33128837ied.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vXmX8fGg4mjeGeiHdpksol57y8CF1IZTUTjJPnKLQBc=;
        b=rMsVqNYlDobJ6t6mpBqk2eSVJYjBeEomMf+sC6dB4zIvAF3AZ19anGqG+WjJ/+3IKy
         EmeSc7beORwcTHA1VYHf6A9tg3dZaAA9Do0aZAFdc+4SSBjo0PFtB026woW/FdcmK4wG
         CzeBqf4IGaDNIr1oUOBnj8FO9tQQmsmv1C9mQNE23NCH/viUmf8oWfZ3+oeBp959vR5G
         k/ZfTyeIFZIBGXDKeMq6Kh9V1X6cFpjQISSKr0Rv2dM1lwjp/oi4vUWjSG53j2KbdkJZ
         AoLmHPTX0v3TkCqvV+7Z66EDlwjZXHscSRPX3dd3Ur9ek0nxxvYXvv5Yk/dmHxLP2XTe
         JjqQ==
X-Received: by 10.107.30.135 with SMTP id e129mr60694244ioe.26.1427843691972;
        Tue, 31 Mar 2015 16:14:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:dcc8:cc5b:3d3e:d0a6])
        by mx.google.com with ESMTPSA id o8sm11036587igp.11.2015.03.31.16.14.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 31 Mar 2015 16:14:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150331223919.GA24362@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266578>

Mike Hommey wrote:

> Octopus merges are limited to 16 parents.

The note about this in fast-import is out of date (e.g., see
t/t7602-merge-octopus-many.sh and v1.6.0-rc0~194, 2008-06-27).  How
about this patch?

-- >8--
Subject: fast-import doc: remove suggested 16-parent limit

Merges with an absurd number of parents are still a bad idea because
they do not render well in tools like gitk, but if they are present
in the repository being imported into git then there's no need to
avoid reproducing them faithfully.

In olden times, before v1.6.0-rc0~194 (2008-06-27), git commit-tree
and higher-level tools built on top of it were limited to writing 16
parents for a commit.  Nowadays normal git operations are happy to
write more parents when asked, so the motivation for this note in the
fast-import documentation is gone and we can remove it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks,
Jonathan

 Documentation/git-fast-import.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f71fb01..773584e 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -506,11 +506,8 @@ If the `from` command is
 omitted when creating a new branch, the first `merge` commit will be
 the first ancestor of the current commit, and the branch will start
 out with no files.  An unlimited number of `merge` commands per
-commit are permitted by fast-import, thereby establishing an n-way merge.
-However Git's other tools never create commits with more than 15
-additional ancestors (forming a 16-way merge).  For this reason
-it is suggested that frontends do not use more than 15 `merge`
-commands per commit; 16, if starting a new, empty branch.
+commit are permitted by fast-import and other git commands, thereby
+establishing an n-way merge.
 
 Here `<commit-ish>` is any of the commit specification expressions
 also accepted by `from` (see above).
-- 
2.2.0.rc0.207.ga3a616c
