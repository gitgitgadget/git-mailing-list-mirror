From: Andy Lowry <andy.work@nglowry.com>
Subject: BUG in git diff-index
Date: Thu, 31 Mar 2016 10:12:07 -0400
Message-ID: <CAJxkE8SVF_ikHqDCh6eHExq=seitHPVpxW2GmPo40jtqWvz1JQ@mail.gmail.com>
References: <loom.20160331T143733-916@post.gmane.org>
	<20160331140515.GA31116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:12:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldKd-0006Qj-RY
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbcCaOMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:12:09 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36473 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbcCaOMI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 10:12:08 -0400
Received: by mail-vk0-f51.google.com with SMTP id z68so104782748vkg.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nglowry-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=JDGKibDTXfIygWFL3YA8lIWKM883ykp98hCN/nFz9K8=;
        b=MhxNbdEG3jUMEkGThn6k+hePXi9bsl8NIlI3k93RhtDMwY5cZhktk6CK+/eCpqcaKW
         zQ2gKY/YOeQJEWdMb2FZ/rISpwjtlq5h3GCavyc2Sb9pIIijt3RrF5sCk5UXewlCty7f
         ZVu8s1EyXQM2zDRI+P2tvjw2ZI8G1OhmqYmsjYzEzJincgy5quGdjc9TPxlP4745+Wb6
         VVuRrDUTN61Ii8afbD/+uXD0BwRigyni3y7n9W2/miC6yajWxwNPJU/EPOOa4xDxqB4c
         Uf+gA9MNhOe2FNHMpAGzOVBLrgqsMT4JPtOhoIfwt/QN/YrB495cqQEs3fmOwgZLVJIy
         zrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=JDGKibDTXfIygWFL3YA8lIWKM883ykp98hCN/nFz9K8=;
        b=JWuQFuZzDt/X3GdI88etT8hnmmbsZo1OFfwktkrrfoyL7BfKHKLzG/fvrTDQHbwico
         UZNNSHw16m97UQSRBaIrJdnnSkGRF6SzueZCbiWLsRzhsv4oOHQOuIqY4MhW5182XFbe
         PS/WVL45obSNAbf2fBKFyxpwnG+uOM83LerEFnzAh4KDzJj5Sfc/ec+1BAuKWESLx9P2
         rBJG2LD3kM3gtvImOl9Klx1+ZueMV58jFERzzcYeUiyL1xM19GetcH1uONlMBHTAXNxA
         mg1hZE40BviksUS9VUyZYvHfWpEVwdguI/ZIhj4zcQItve38q3qB2gRgFmFIPKOqZc9A
         TvBg==
X-Gm-Message-State: AD7BkJJzBYbZmfbE9cvV3pvQkgKHNDHW9+l/P2DZvqihX9x/v43O7AHVPo8PiP5wNcc75xsAhPpI/nb5S9bcrA==
X-Received: by 10.176.0.175 with SMTP id 44mr3679361uaj.6.1459433527470; Thu,
 31 Mar 2016 07:12:07 -0700 (PDT)
Received: by 10.103.86.12 with HTTP; Thu, 31 Mar 2016 07:12:07 -0700 (PDT)
X-Originating-IP: [69.116.255.234]
In-Reply-To: <20160331140515.GA31116@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290385>

Thanks, very helpful.

What I'm actually after is a tree-to-filesystem comparison, regardless
of index. I've currently got a "diff" thrown in as a "work-around"
before "diff-index", but  now I understand it's not a workaround at
all. If there's a better way to achieve what I'm after, I'd appreciate
a tip. Otherwise I'll just change the comments explaining why there's
a "diff" in my script.

andy

> &gt; 5. git diff correctly reports no changes &gt; 6. git diff-index now also reports nothing This is working as designed (though I agree it is a little confusing). From "git help diff-index": These commands all compare two sets of things; what is compared differs: git-diff-index  compares the  and the files on the filesystem. git-diff-index --cached  compares the  and the index. git-diff-tree [-r]   [...] compares the trees named by the two arguments. git-diff-files [...] compares the index and the files on the filesystem. Your invocation triggers the first, though it is not a true comparison of what is on the filesystem, but rather a tree/index comparison, taking into account the filesystem values. The all-zeroes sha1 indicates that the index entry is not up to date with what is in the
  filesystem, but we don't actually read the file contents to refresh the entry. Back when diff-index was written, it was generally assumed that scripts would refresh the index as their first operation, and then proceed to do one or more operations like diff-index, which would rely on the refresh from the first step. Running the porcelain "git diff" does refresh the index, which is why your step 6 shows no diff. If you want a pure tree-to-index comparison, use --cached (this will also be slightly faster, as it does not have to stat the working tree at all). -Peff
