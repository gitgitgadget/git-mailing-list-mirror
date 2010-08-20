From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: t7610-mergetool.sh -q isn't quiet
Date: Fri, 20 Aug 2010 02:50:10 -0400
Message-ID: <E395511F-ACF9-4390-A081-4AC4C072C7CC@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 08:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmLXM-00069f-Op
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 08:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab0HTG4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 02:56:55 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44928 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0HTG4x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 02:56:53 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2010 02:56:53 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 460221FFC135; Fri, 20 Aug 2010 06:50:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 176AB1FFC0D4
	for <git@vger.kernel.org>; Fri, 20 Aug 2010 06:50:00 +0000 (UTC)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153978>

I'm just posting this to the list because I should really already be in bed...

Running t7610-mergetool with -q isn't quiet.  This is also noticeable when running the full test suite in a TAP harness (e.g. prove).

$ ./t7610-mergetool.sh -q
Normal merge conflict for 'file1':
  {local}: modified
  {remote}: modified
Normal merge conflict for 'file2':
  {local}: created
  {remote}: created
Normal merge conflict for 'subdir/file3':
  {local}: modified
  {remote}: modified
# passed all 7 test(s)
1..7

All the output seems to be from the last test.

Also, some of the test style seems odd.  For example:

test_expect_success 'mergetool on file in parent dir' '
    cd subdir && (
    ( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
    ( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
    test "$(cat ../file1)" = "master updated" &&
    test "$(cat ../file2)" = "master new" &&
    git commit -m "branch1 resolved with mergetool - subdir") &&
    cd ..
'

Shouldn't that just be :

    (
     cd subdir &&
     yadda &&
     yadda
    )

If nobody else gets to it, hopefully I'll find time tomorrow.  If not, I should get a fresh supply of tuits over the weekend.

~~ Brian