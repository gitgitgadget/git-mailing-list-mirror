X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Wed, 1 Nov 2006 01:40:56 +0100
Message-ID: <200611010140.56834.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200610311753.20711.jnareb@gmail.com> <7vejsoovxu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 00:41:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jEko4AOTTmrdQs66ayLeG+lkMretVKloaseX7sAnuaYXNQvWDG0l8y+vqhXQnIiQkZsrbvuZUbzCVkd7zFK+VCBnrn0Yq6lp9Yb7NvmzrlW/NjXeP12YZeyXyEHjY3rT+HK5QlcmX6eSeLYC4+w0C5RyihrK+IcUZFNIEgKrd7E=
User-Agent: KMail/1.9.3
In-Reply-To: <7vejsoovxu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30613>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf4A1-0003yK-Tx for gcvg-git@gmane.org; Wed, 01 Nov
 2006 01:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946248AbWKAAkv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 19:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946259AbWKAAkv
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 19:40:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:47173 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946248AbWKAAku
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 19:40:50 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1609160ugm for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 16:40:48 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr7167722ugj; Tue, 31 Oct 2006
 16:40:48 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id e1sm5863943ugf.2006.10.31.16.40.47; Tue, 31 Oct
 2006 16:40:48 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> 
> To be honest, I dislike these */n series where the the end is
> unknown.  It just confuses me what's still surviving, what's
> already shot down, and what's being rerolled.

Well, it looks like this patch series is closing to final patch.
The "New improved patchset view" is done.
 
> Let's step back a bit and see if we share the same view as to
> the status of each one:
> 
> [PATCH/RFC 1/n] gitweb: Better git-unquoting and gitweb-quoting of p...
> 
> Marked preliminary, perhaps need some discussion and rerolling
> but I haven't looked at it.

I'm not sure if without this patch (well, the unquote part) gitweb
can work with filenames which git quotes using escape sequences,
like ", \, LF, TAB. Former version didn't unquote fully, and it
passed partially unquoted filename to git.

> [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
> 
> Discussed; we agreed that showing byte values in different
> colors is preferable.  Waiting for re-roll.

The problem with using text color or background color is that
the filenames tends to be shown with different color and background
color: "tree" view, parts of difftree, parts of diff header, etc.
Perhaps text-decoration: overline;? Just kidding...

> [PATCH 3/n] gitweb: Use 's' regexp modifier to secure against filena...
> 
> I looked at it although haven't said anything yet.  Probably a
> safe and good change but I wonder how LF at the end of the line
> matches /...(.+)$/s pattern; iow, if we do not use -z does it
> still do the right thing?  Otherwise I suspect you would perhaps
> need to chomp?

We always pass chomped lines. First chunk is unnecessary (we care only
for type), without second "tree" view look strange for files with
embedded newline in filename.

> [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same...
> 
> Good fix and even improves readability; will apply after
> dropping -- from ls-tree args.

As I said, noticed while testing gitweb with strange filenames
in 'gitweb/test' branch.

> [PATCH 5/n] [take 3] gitweb: New improved patchset view
> [PATCH 6/n] gitweb: Remove redundant "blob" links from git_difftree_...
> [PATCH 7/n] gitweb: Output also empty patches in "commitdiff" view
> [PATCH 8/n] gitweb: Fix two issues with quoted filenames in git_patc...
> 
> Haven't looked at them and I do not think people have had enough
> time to comment on them yet.

Well, patch 5 and 8 could be collapsed.

-- 
Jakub Narebski
