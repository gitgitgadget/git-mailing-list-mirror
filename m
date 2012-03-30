From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git push performance problems with ~100K refs
Date: Fri, 30 Mar 2012 08:22:15 -0600
Message-ID: <53c2a263-69f5-4de0-b2e2-17639d311405@email.android.com>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org> <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com> <20120330093207.GA12298@sigill.intra.peff.net> <20120330094052.GB12298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 16:25:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDcla-0002NK-WE
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 16:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760417Ab2C3OZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 10:25:23 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:35141 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759560Ab2C3OZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 10:25:22 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6664"; a="177338326"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 30 Mar 2012 07:25:21 -0700
Received: from [192.168.1.160] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 1C79D10004AB;
	Fri, 30 Mar 2012 07:25:21 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20120330094052.GB12298@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194363>



Jeff King <peff@peff.net> wrote:
>
>Actually, I did have time for a simple test. Doing:
>
>  git rev-list HEAD |
>  while read sha1; do
>    echo $sha1 refs/heads/$sha1
>  done >>packed-refs
>  git pack-refs
>
>in git.git slows down the test above considerably, and perf reports 90%
>of the time spent in commit_list_insert_by_date. So I think that is
>indeed the problem.
>
>At one point, I looked at replacing the commit_list implementation with
>a heap-based priority queue, but unfortunately many parts of the code
>depend on the list-like nature and would need to be rewritten. We might
>be able to hack around it by at least adding all of the initial items
>to
>an unordered list, then sorting it into its final form.

Thanks Peff for the explanation.  Jgit actually has the exact same problem, it slows down the pushing side.  Fortunately, in jgit it is well isolated and can easily be remedied by both the solutions you mention, and both work to speed it (jgit) up drastically!  I wonder if libgit2 suffers from the same problem?

This might be one of the last pieces to git ref scalability left?  Does this affect many other use cases, fetches?

-Martin


Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
