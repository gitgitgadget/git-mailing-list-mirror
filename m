From: linux@horizon.com
Subject: Re: Bisects that are neither good nor bad
Date: 29 May 2006 18:56:32 -0400
Message-ID: <20060529225632.7073.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 00:56:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkqf8-0004i0-02
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWE2W4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWE2W4e
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:56:34 -0400
Received: from science.horizon.com ([192.35.100.1]:33334 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932077AbWE2W4e
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 18:56:34 -0400
Received: (qmail 7074 invoked by uid 1000); 29 May 2006 18:56:32 -0400
To: paul@permanentmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20993>

(Cc: to the git list, since the people there undoubtedly know much better.)

> Is there a method of bisecting that means neither "good" nor "bad"?  I
> have run into kernel problems that are not related to the problem I'm
> attempting to track.  Some are not avoidable by changing the .config (see
> the third bisect in comments 10 and 11 in the bugzilla report).

Yes.  While you're bisecting, HEAD is a special "bisect" head used just
for that purpose.  If you encounter a compile error or are otherwise
unable to test a version, you can "git reset --hard <commit>" to jump
to some other commit and test that instead.  Because that command
unconditionally changes both the current head and the checked-out code,
it's normally somewhat dangerous, but while bisecting, there's no problem.
You can choose anything you like to test instead of git-bisect's suggested
version, but staying near the middle of the uncertain range is usually
a good idea.  "HEAD^" (the parent of the current commit) is often a
simple choice.  "git bisect visualize" might give you some ideas.

Note that if the problem actually is in the area of the untestable commit,
git bisect might drag you back there, but this lets you try to avoid it.

It's also worth repeating some advice from the manual:

>> You can further cut down the number of trials if you know what part of
>> the tree is involved in the problem you are tracking down, by giving
>> paths parameters when you say bisect start, like this:
>>
>> $ git bisect start arch/i386 include/asm-i386
