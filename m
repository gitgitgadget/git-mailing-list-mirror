From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Mon, 18 Feb 2008 10:18:40 +0100
Message-ID: <87pruuy64v.fsf@rho.meyering.net>
References: <871w7bz1ly.fsf@rho.meyering.net>
	<ee77f5c20802171409k2dee2c87v8d84eba111c3d506@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:19:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR29g-0000hz-Ro
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 10:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbYBRJSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 04:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbYBRJSr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 04:18:47 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:37733 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbYBRJSm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 04:18:42 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3E9FA17B59D
	for <git@vger.kernel.org>; Mon, 18 Feb 2008 10:18:41 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3169117B575
	for <git@vger.kernel.org>; Mon, 18 Feb 2008 10:18:41 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id E9A6F2609C;
	Mon, 18 Feb 2008 10:18:40 +0100 (CET)
In-Reply-To: <ee77f5c20802171409k2dee2c87v8d84eba111c3d506@mail.gmail.com>
	(David Symonds's message of "Sun, 17 Feb 2008 14:09:48 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74252>

"David Symonds" <dsymonds@gmail.com> wrote:
> On Feb 17, 2008 1:58 PM, Jim Meyering <jim@meyering.net> wrote:
>> This change removes all useless if-before-free tests.
>> E.g., it replace code like this
>>
>>         if (some_expression)
>>                 free (some_expression);
>>
>> with the now-equivalent
>>
>>         free (some_expression);
>>
>> It is equivalent not just because POSIX has required free(NULL)
>> to work for a long time, but simply because it has worked for
>> so long that no reasonable porting target fails the test.
>> Here's some evidence from nearly 1.5 years ago:
>>
>>     http://www.winehq.org/pipermail/wine-patches/2006-October/031544.html
>
> That's not great evidence. It only tests 9 systems, and misses several

If you mean mingw, cygwin, and M$-based ones, they're all ok.
As far as I know, you have to go back to SunOS4 to find a system on which
free(NULL) fails.  That OS stopped being a reasonable porting target
a couple years ago.

> targets that Git already runs on. It seems like a fairly minor cleanup
> for a definite loss of portability.

It's a definite loss of portability if you can find a reasonable porting
target for which free(NULL) fails.  But even if you do, the fix is
not to reject the clean-up, but to amend it with a wrapper function.
That encapsulates the work-around in one place rather than polluting
all of those files.
