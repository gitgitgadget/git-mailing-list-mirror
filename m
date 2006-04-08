From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] xdiff/xdiffi.c: fix warnings about possibly uninitialized
 variables
Date: Sat, 8 Apr 2006 10:18:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604081013480.11852@alien.or.mcafeemobile.com>
References: <20060408152720.GA11125@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 19:19:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSH5u-0007Qm-4y
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 19:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWDHRSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 13:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWDHRSt
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 13:18:49 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:59570 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S965033AbWDHRSs
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 13:18:48 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C918E> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 8 Apr 2006 10:18:43 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20060408152720.GA11125@fiberbit.xs4all.nl>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18519>

On Sat, 8 Apr 2006, Marco Roeland wrote:

> Compiling this module gave the following warnings (some double dutch!):
>
> xdiff/xdiffi.c: In functie 'xdl_recs_cmp':
> xdiff/xdiffi.c:298: let op: 'spl.i1' may be used uninitialized in this function
> xdiff/xdiffi.c:298: let op: 'spl.i2' may be used uninitialized in this function
> xdiff/xdiffi.c:219: let op: 'fbest1' may be used uninitialized in this function
> xdiff/xdiffi.c:219: let op: 'bbest1' may be used uninitialized in this function
>
> A superficial tracking of their usage, without deeper knowledge about the
> algorithm, indeed confirms that there are code paths on which these
> variables will be used uninitialized. In practice these code paths might never
> be reached, but then these fixes will not change the algorithm. If these
> code paths are ever reached we now at least have a predictable outcome. And
> should the very small performance impact of these initializations be
> noticeable, then they should at least be replaced by comments why certain
> code paths will never be reached.

These paths are never reached because of the way data is prepared before 
and passed to the function. Unfortunately the compiler cannot know this.
Using them as -1 or XDL_LINE_MAX won't help either, since those are out of 
domain values. You can leave it there and the algo won't suffer, or you 
can relax a little the warning level when building the file.



- Davide
