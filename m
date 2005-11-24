From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb on kernel.org and UTF-8
Date: Wed, 23 Nov 2005 22:19:40 -0800
Message-ID: <7vsltmy3cz.fsf@assigned-by-dhcp.cox.net>
References: <7vzmnw9qo0.fsf@assigned-by-dhcp.cox.net>
	<4383BEE4.1060800@zytor.com> <20051123033526.GA24098@vrfy.org>
	<7vfypm20eh.fsf@assigned-by-dhcp.cox.net>
	<20051124050104.GC16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 07:23:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfASQ-0006c7-Lg
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 07:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbVKXGTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 01:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbVKXGTn
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 01:19:43 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:65250 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161014AbVKXGTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 01:19:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124061820.JGHX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 01:18:20 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20051124050104.GC16995@mythryan2.michonline.com> (Ryan
	Anderson's message of "Thu, 24 Nov 2005 00:01:04 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12677>

Ryan Anderson <ryan@michonline.com> writes:

> On Wed, Nov 23, 2005 at 07:24:38PM -0800, Junio C Hamano wrote:
>> 
>> How about doing something like this?
>> 
>> 	[i18n]
>>         	commitEncoding = utf8
>> 		blobEncoding = utf8
>> 
>> to mean:
>> 
>> 	If you _have_ to make an assumption on an encoding
>> 	commit and blob objects are in, utf8 is your best bet
>> 	(but mistakes can happen, and some blobs can be binary).
>
> The rest of the options help clarify this, but can you make these
> options 'assumeCommitEncoding' and 'assumeBlobEncoding' to make it clear
> that these are *assumptions* and not actually controlling what gets
> written?

As I outlined in the "editorEncoding" part, if everything works
as planned, your latin-1 editing editor would leave latin-1
message for git-commit to pick up (or command line "-m $msg"
option would be encoded in latin-1), and iconv would munge that
to utf8 to feed commit-tree (because of "commitEncoding" being
utf8). In that sense, commitEncoding is not assumption for the
writers.  If everybody, including outside sources we merge from,
makes best effort not to screw up, these settings would
faithfully describe what encoding logs are in.

But writers can screw up, and funnily encoded commit messages
merge from outside source brings in cannot be fixed after the
fact, so "assume" part must be implied anyway for readers.
