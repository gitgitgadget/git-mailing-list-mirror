From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest namespace change
Date: Mon, 20 Aug 2012 13:32:22 +0200
Message-ID: <62FFD304-1902-4D69-9287-ECD1E32BABC9@gmail.com>
References: <20120719213311.GA20385@sigill.intra.peff.net> <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu> <7vboi8rl2q.fsf@alter.siamese.dyndns.org> <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com> <7vehn3rbom.fsf@alter.siamese.dyndns.org> <A15D5621-7EF5-4409-967A-0DA20B007899@gmail.com> <7v1uj2pysd.fsf@alter.siamese.dyndns.org> <9E4BBC27-5B26-4048-93D4-FE02C550F4E2@gmail.com> <7vobm6o1cu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 13:32:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3QDh-0001p0-JV
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 13:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2HTLc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 07:32:28 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48504 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab2HTLc0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 07:32:26 -0400
Received: by eaac11 with SMTP id c11so1971080eaa.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 04:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=vWvp6V4ba56oFZ3hPnTPuDA2DMMjtVHbQKe7A7269w8=;
        b=tW7cQvzZ1iyadvJ43dHzrtDaxExvYAp684LukOiy1QX+hjx8afWJeVq/ZAHOT6mIZ/
         hJjtUIWEy6fPg2pq7VWd08uxlpiLW8VHoZ/8wXA8P14+04LQFiQBxIxXUQD977OojmPY
         nhtgrjF76bRHjHfsNAsJJ5iRp9xiIUPRxHLXw9b0vdWKrg4BOkeH4ZWXT/NVUqBmaqIG
         VHgRQGl+JE9iHTSwmtkNSJHxqqilWgL42FYlJNx3ea63Xj7NShIv4AIYkn/Nu5XupK4n
         dIFpZypRJ5nk2VDT6MvGRWJ90MmYGe31idIuGHIF1c8SQe27PiEOXB1WA0kv1pgOEz7m
         kuxQ==
Received: by 10.14.203.70 with SMTP id e46mr8427307eeo.2.1345462345328;
        Mon, 20 Aug 2012 04:32:25 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id h42sm41126942eem.5.2012.08.20.04.32.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 04:32:24 -0700 (PDT)
In-Reply-To: <7vobm6o1cu.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203770>

Dear Junio,

On 20 Aug 2012, at 02:26, Junio C Hamano wrote:

> We are not particularly interested in "it is possible" when many
> implementations can all trivially allow it to be "possible"; the
> question is what a sensible solution is among them, and I didn't
> find "a directory with timestamp in its name" a particularly
> sensible way to go.
> 
> Either Jeff's "refname $name's log goes to logs/graveyard/$name~" or
> Michael's "append ~d to each directory component, append ~f to the
> leaf component" that are already proposed will keep "one file per
> name" property to allow us to open once and efficiently read the
> file through.  Why would we want to see an inferiour alternative
> added to the discussion?

I let the others decide if my idea with "timestamp" directories has a significant advantage over other proposed solutions or not.  It seemed different, so i wanted to add it to the discussion.  I cannot clearly formulate an advantage, but i will try to explain why i proposed it.

I would like also to propose another solution for allowing both "next" and "next/foo" branches, and to try to explain how it is different from the other proposed solutions (unless i missed something).

I would like that the solutions introduce as little new as possible to the existing solutions used in similar situation.

The problem of mapping branch names to file paths looks to me very similar to the problem of mapping URLs to file paths for static web sites, so i would propose to use the same solution: add a special extension to distinguish a file from a directory, for example ".branch" and ".tag" (like ".html" in the case of URL).  This would allow having both branches "next" and "next/foo" with refs stored in files "next.branch" and "next/foo.branch".  This will look very clear and familiar to people not specialist in Git, but familiar with static web sites.  The only limitation this would introduces is that branch names "foo.branch" would need to be forbidden.  If the extension is optional, this makes the new rule almost compatible with the current one, except if somebody is currently using branches n
 amed like "foo.branch" or "next.branch/foo".

For the reflogs of deleted branches, if both "next/foo" and "next" are allowed and it is decided to append to the reflogs when a new branch with the same name is deleted, then of course "timestamp" directories are useless.  However, i do not think that if a branch "tmp" was created and deleted multiple times, all its reflogs have to be concatenated into a single file.  So i viewed the problem of deleting identically named branches as the problem of deleting files under an operating system environment that uses a Trash Bin.  In this case, adding a timestamp usually solves the problem.

-Alexey.