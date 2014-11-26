From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git file listing is inconsistent
Date: Wed, 26 Nov 2014 13:55:20 -0800
Message-ID: <20141126215520.GS6527@google.com>
References: <CAGOJM6+DTSn2qa-KTWceqyraaugX_YVZhirkdc+t+cDfFB4OyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Woody Gilk <woody.gilk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:55:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtkYc-00063V-RH
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 22:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbaKZVz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 16:55:27 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39002 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbaKZVz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 16:55:26 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so3369404iec.24
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 13:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0n2vu7RqNU+IDJQc+/5YJin439q0dv3s5RFdpcyddRE=;
        b=Ng0ZsgPBoaH1IRktzb40AuRcNBzepx9hLVGXm0fNnzVFRPXEeh0QnxwHb2qzFV7GUT
         8HBedxa/tkj9myj4dmrFfw+BEmCBBbps8bmxAuik8mo1KyJEXzp+yfw0jnbpaxGv9/4R
         J+YrMCRpbs1k8Lukf5reLa0x33BHY0K3tajDPdwxXpzuiv0ugNXuBGsXHMmDJ3dPfJTa
         Ws4Cqk9GZbk8y/Cx4/Auw9knlYJfCbVCytoMRonBIadRJiKAvTqjxmE9AQ4X77+OgNp4
         PHZ4S6UMPQ/Z61e3ZNq0DneIdHDEvj7Cm9kf1I+4f2Hsm0xO1yFM938q8I3hh558CDre
         T2Vg==
X-Received: by 10.42.179.132 with SMTP id bq4mr28364067icb.61.1417038922785;
        Wed, 26 Nov 2014 13:55:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31d4:43f9:cf9a:f63a])
        by mx.google.com with ESMTPSA id zy11sm3164962igc.4.2014.11.26.13.55.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 13:55:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGOJM6+DTSn2qa-KTWceqyraaugX_YVZhirkdc+t+cDfFB4OyQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260312>

Hi Woody,

Woody Gilk wrote:

> git diff --name-only
> git grep --files-with-matches
>
> I think --files-with-matches should be deprecated and replaced with
> --name-only for consistency.

See the (non-git) diff(1) and grep(1) manpages.

It might make sense for 'git grep' to learn --name-only too as a
synonym to help muscle memory, though.

*looks*

Actually, 'git grep -h' tells me that git grep --name-only is already
accepted as a synonym for --files-with-matches, ever since

 $ git log -Sname-only -- builtin-grep.c
[...]
 commit 2cd5dfd240ecb63c77bcb2532664984e3b69ae47
 Author: Shawn O. Pearce <spearce@spearce.org>
 Date:   Wed Feb 20 23:28:07 2008 -0500

     Teach git-grep --name-only as synonym for -l

     I expected git grep --name-only to give me only the file names,
     much as git diff --name-only only generates filenames.  Alas the
     option is -l, which matches common external greps but doesn't match
     other parts of the git UI.

     Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>

(v1.5.5-rc0~171).  Have you tried it?

Would something like the following patch help?

-- >8 --
Subject: grep doc: add reminder about --name-only option

Since v1.5.5-rc0~171 (2008-02-20), "git grep" accepts --name-only
as a synonym for the GNU-style --files-with-matches, but because the
synonym is not mentioned in the manpage synopsis it is hard to find.

Reported-by: Woody Gilk <woody.gilk@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-grep.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 31811f1..8060efe 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
 	   [-F | --fixed-strings] [-n | --line-number]
-	   [-l | --files-with-matches] [-L | --files-without-match]
+	   [-l | --files-with-matches | --name-only] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
-- 
2.2.0.rc0.207.ga3a616c
