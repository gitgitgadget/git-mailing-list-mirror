From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-diff-tree -R A B == git-diff-tree B A"?
Date: Fri, 20 May 2005 08:29:22 -0700
Message-ID: <7v64xdvru5.fsf@assigned-by-dhcp.cox.net>
References: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 17:31:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ9R8-0002N1-Js
	for gcvg-git@gmane.org; Fri, 20 May 2005 17:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVETP3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 11:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVETP3g
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 11:29:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38805 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261411AbVETP30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 11:29:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520152923.RPBR7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 11:29:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 20 May 2005 08:20:21 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Fri, 20 May 2005, Junio C Hamano wrote:
>> 
>> I was preparing a set of tests for diff family because I wanted
>> to have something that catches screwups I am going to inflict
>> upon them during the coming couple of days.  One of the tests
>> accidentally found out that the above is not true in the current
>> implementation.  Just an excerpt of relevant lines [*1*]:
>> 
>> $ git-diff-tree -r $tree_B $tree_A
>> 
>> +100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
>> +100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
>> -100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
>> -100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
>> 
>> $ git-diff-tree -R $tree_A $tree_B
>> 
>> +100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
>> -100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
>> +100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
>> -100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM


LT> Ahh.. "diff-tree" uses the wrong algorithm for selecting name ordering.

LT> It thinks that "DF" and "DF/" sort equally because it just looks at the
LT> name, not the type. So then, becuse the names sort the same, it will sort
LT> them according to where they come from, and you get the behaviour you see.

LT> It doesn't really matter, but you're right, I should fix it to be
LT> consistent.

Don't bother.  I already have a fix with the test case.

