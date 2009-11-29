From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] t7011: Mark fixed test as such
Date: Sun, 29 Nov 2009 14:57:20 +0100
Message-ID: <4B127DC0.4020108@drmicha.warpmail.net>
References: <0327ed3d7c4621f205d2d111254d716bd1b06c28.1259432535.git.git@drmicha.warpmail.net> <fcaeb9bf0911290047t43ea3040x730e04baa81d8a98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 14:57:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEkHN-000200-Lq
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 14:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbZK2N5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 08:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbZK2N5V
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 08:57:21 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:55241 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497AbZK2N5U (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 08:57:20 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D6F68C4EB6;
	Sun, 29 Nov 2009 08:57:26 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 29 Nov 2009 08:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=p7GUVRWc/DYRiBl2ERRtDHkf85k=; b=faIZ89YRLLa0q/hGA+FORKH0q3/k8V9Vi3mxVwFSFoFMSzfMgbGoDOHbuaqdm/jtEdppKBtLJaT7652poGMsM7JfdoaNgr+QFHhLmUbdYhk+ESDyOa1dqWxh5RlcjG5TJ/3YJbZ471+c0fR6n8hQF12mte19Gsxk66ydOVFZaLE=
X-Sasl-enc: DuGpV4P37dR0fmXBTYaJzs9kh1tdVf+iPB7ygQQbe21f 1259503046
Received: from localhost.localdomain (p5DCC0DA4.dip0.t-ipconnect.de [93.204.13.164])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07C22198D3;
	Sun, 29 Nov 2009 08:57:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <fcaeb9bf0911290047t43ea3040x730e04baa81d8a98@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134018>

Nguyen Thai Ngoc Duy venit, vidit, dixit 29.11.2009 09:47:
> On 11/29/09, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> Test 16/17 had been fixed since its introduction in b4d1690 (Teach Git
>>  to respect skip-worktree bit (reading part), 2009-08-20). So, mark it as
>>  expect_success rather than expect_failure.
>>
>>  Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
> No ACK. See below.
> 
>>  ---
>>  I'm actually wondering about 17/17 as well.
>>  If commit is called with a file name then shouldn't it simply commit the
>>  current state of the file in the worktree, no matter what the index or
>>  skip-worktree say? I therefore think 17/17 should be expect_success
>>  and have no test_must_fail.
> 
> Both 16/17 and 17/17 ensure that Git won't look at files on worktree
> if they are marked as skip-worktree (by definition of skip-worktree,
> you can safely ignore worktree, otherwise you would not mark them as
> such). 16/17 happens to pass, not because it does not touch worktree,
> but because the base index does not have "1", which happens to is the
> same situation in 16/17 (test commit when "1" is gone). The result is
> OK but it is actually not (17/17 shows this clearer as it commits the
> worktree version).

On 16/17, I really cannot agree. You explain that you expect the test to
succeed (we agree here), but that it succeeds for the wrong reasons. So
it should be either "expect_success", or the test itself should be
changed so that it really tests what it intends to, otherwise it raises
a wrong "FIXED". I suggested and submitted the former.

On 17/17, it's not clear what should happen. "skip-worktree" says ignore
the worktree and look in the index instead of accessing worktree files.
But "git commit file" says ignore the index and stage and commit the
file from the worktree directly. And that is exactly what happens:

You say "git commit file".
That means "ignore the index".
That also means that git ignores the skip-worktree bit which is set in
the index.
Therefore, file is committed with the content is has in the worktree.

I'm going by the documentation for git-update-index and git-commit. It
could be that they are wrong, too, but they agree with the code, so
what's the reference for saying both code and documentation are wrong?

Michael
