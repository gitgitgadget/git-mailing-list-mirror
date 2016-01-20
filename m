From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 17:22:53 -0800
Message-ID: <20160120012253.GD16090@google.com>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
 <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
 <20160119213705.GA28656@sigill.intra.peff.net>
 <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
 <20160119215100.GB28656@sigill.intra.peff.net>
 <20160119215928.GA6556@sigill.intra.peff.net>
 <20160119222802.GC6556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:23:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLhUQ-00034k-LN
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 02:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934539AbcATBXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 20:23:04 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35019 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934403AbcATBW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 20:22:56 -0500
Received: by mail-pa0-f65.google.com with SMTP id gi1so42003859pac.2
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 17:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eGalYEx/Rz/p+nDfZ9keei2cJnTmOaIGEJE5Fz6p2U0=;
        b=MannZZS5mg0MBrBBVRqTVMKlA/u/pglekRvq3B8jgHwu0TkGej77pfA+kzBUVgpepc
         LPCFqs7Zi19A0rPI62m82e9cJODC2flQFdxAibhAdbdF5NZTTKPXilY3cQ7VkOGgA2S3
         5BvQm5i0871UTRv+jQWyBekGht0jm5OvMfu9PnXVX+aMgiPmxwULEpoDzpLjZTXUzA10
         qWbbPCqcWwebwf4EInofV6GBLA4dE48MfKUgOVwGUHm2+B+5EwAvWDS4S/khtLeZzVr1
         IwjaZ3SMPx/3Fu22jXWtb7wj2QfBdv8bzX28cnUxpTFrJ51Xi61lJNNGrBwsdSZ1BAQp
         qtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eGalYEx/Rz/p+nDfZ9keei2cJnTmOaIGEJE5Fz6p2U0=;
        b=jggVezBU74Aj5Vk9cFFoOLeRWOGG9+Ze9e3YtUyaZsYL+eSti4OiMe4sRLBRLFcRiU
         3LegFbY3tgh3rB79SfDLmliCTC9XJmZ4CXF1Ff8AAedhBfia5HPEp2FwFq/0OA83bbJy
         5rCLdkka1saR4GBRIuxU2+ZtMdc9FvpzhfeXVly0mlHmSU40A+ZO/U8SLCO0O9hDsSul
         5o+SUwAxDNqKG/8NTGLzj+WKuOjdCShjBHX/M5R1Eq6g6wLaNm7JUGIjabOQCrn3vxdr
         K2uKn4L1kGhgS3hhuhN3vTfGqDMiN7M6CnSGw+w1aHO8YglPKnMoG1v/gQ4OpA+lc9MK
         s34Q==
X-Gm-Message-State: ALoCoQnzWBG6KkbHFxMlLgqz2Ku8RjcGeVsN73FB2X/yKQVBiuEOzKc6xhbcE2jdCHDL/Zcm7XPi0GHdnqIrz/Kl/aVUILkdBA==
X-Received: by 10.66.148.99 with SMTP id tr3mr48850311pab.19.1453252976075;
        Tue, 19 Jan 2016 17:22:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b491:2661:5545:c04e])
        by smtp.gmail.com with ESMTPSA id p87sm44172163pfi.94.2016.01.19.17.22.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jan 2016 17:22:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160119222802.GC6556@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284405>

Jeff King wrote:
> On Tue, Jan 19, 2016 at 04:59:28PM -0500, Jeff King wrote:

>> We could get away "git diff --exit-code $1 $2" to do a single process
>> invocation (rather than two rev-parses), but I don't know if it is worth
>> the complexity.
>
> And here's that patch.
>
> I'm actually a little iffy on it because it switches to "diff-tree" from
> a raw-sha1 comparison. For a well-formed repo, that shouldn't matter.
> But what if you had a commit that was replacing a malformed tree object,
> but not otherwise changing the diff?  We might drop it as "empty", even
> though you'd prefer to keep it.

Mph.  We could get the best of both worlds by introducing a "git
rev-parse --compare <a> <b>" that compares object ids.  Actually...

How about something like this?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-filter-branch.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 86b2ff1..06f4e0f 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -44,7 +44,15 @@ skip_commit()
 # it will skip commits that leave the tree untouched, commit the other.
 git_commit_non_empty_tree()
 {
-	if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
+	if
+		test $# = 3 &&
+		git rev-parse "$1" "$3^{tree}" |
+		{
+			read a
+			read b
+			test "$a" = "$b"
+		}
+	then
 		map "$3"
 	else
 		git commit-tree "$@"
@@ -404,7 +412,7 @@ while read commit parents; do
 	then
 		tree=$(git write-tree)
 	else
-		tree=$(git rev-parse "$commit^{tree}")
+		tree="$commit^{tree}"
 	fi
 	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
 		"$tree" $parentstr < ../message > ../map/$commit ||
-- 
2.7.0
