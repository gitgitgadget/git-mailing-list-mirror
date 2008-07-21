From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: problem using jgit
Date: Mon, 21 Jul 2008 13:36:18 -0400
Message-ID: <p0624080dc4aa78c93ffe@[192.168.1.106]>
References: <p06240809c4a9d887fda4@[192.168.1.106]>
 <488467E3.7000107@gmail.com> <488482A2.4000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 19:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzKD-0005tw-UD
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 19:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbYGURgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 13:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbYGURgb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 13:36:31 -0400
Received: from deanbrook.org ([66.160.189.173]:57561 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751232AbYGURga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 13:36:30 -0400
Received: from 63.138.152.192 ([63.138.152.192]) by deanbrook.org for <git@vger.kernel.org>; Mon, 21 Jul 2008 10:36:27 -0700
In-Reply-To: <488482A2.4000601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89371>

At 2:35 PM +0200 7/21/08, Marek Zawirski wrote:
>Marek Zawirski wrote:
>>Stephen Bannasch wrote:
>>>I've setup a simple test class that integrates jgit to clone a git repository. However I'm getting a NullPointerError when RevWalk.parseAny ends up producing a null object id.
>>>
>>>The code and the stack trace for the error are here:
>>>
>>>  http://pastie.org/237711
>>>
>>>This problem occurs using the jgit from the master branch from this repo:
>>>
>>>  git://repo.or.cz/egit.git
>>Hello Stephen,
>>
>>I think you've experienced error caused by the same bug as me, during my latest fetch/push GUI works few days ago.
>>Your code looks fine, probably  it's actually bug in jgit. I think it's some regression. Thanks for reporting.
>It's caused by 14a630c3: Cached modification times for symbolic refs too
>Changes introduced by this patch made Repository#getAllRefs() including Ref objects with null ObjectId in case of unresolvable (invalid?) HEAD symbolic ref, and null Ref for HEAD  when it doesn't exist. Previous behavior was just not including such refs in result.
>
>Fix for null Ref is just a matter of simple filtering out null Ref object for HEAD, if it doesn't exist (just is it considered to be legal state of repository when HEAD doesn't exist?).
>
>To fix null ObjectId issue, we have to either change all clients of this method or revert method to previous behavior. Now it's just unspecified in javadoc.
>Robin, Shawn, what do you think? If we want to have unresolvable refs included, IMO it may be sensible to provide argument includeUnresolbable for Repository#getAllRefs() to let clients avoid burden of filtering them out when they don't need them (most cases, perhaps).
>I can prepare fix for it (rather easy one) as you are unavailable now, let me now what's your opinion.

Thanks for looking at this problem Marek. 

If you get a change working for jgit that might not be available in a branch on git://repo.or.cz/egit.gi will you send a patch.

I am looking forward to continuing my tests using jgit from Java and JRuby.
