From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Proposed function path_in_directory()
Date: Mon, 08 Oct 2012 20:20:24 +0200
Message-ID: <50731968.7020602@kdbg.org>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu> <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu> <7vd314gcti.fsf@alter.siamese.dyndns.org> <50692150.8080504@alum.mit.edu> <506FE619.1020608@alum.mit.edu> <7vy5jhlz70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:21:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHwq-0005T3-1B
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 20:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab2JHSUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 14:20:32 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:38622 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752102Ab2JHSU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 14:20:28 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8D9952C4002;
	Mon,  8 Oct 2012 20:20:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E594A19F3EC;
	Mon,  8 Oct 2012 20:20:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <7vy5jhlz70.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207254>

Am 08.10.2012 18:13, schrieb Junio C Hamano:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 2. Does there need to be any special related to DOS paths?
> 
> The ceiling computation may need special case for dos.  What does
> the getcwd() give us?  Do we learn only the path within the "current
> drive" and need to prefix C: (or D: or X:) ourselves if we really
> want to tell C:\bin and D:\bin apart?

We don't have to do that. getcwd() returns the drive letter.

> Assuming that is the case, the ceiling computation would need a
> helper function that hides the gory details of prefixing getcwd()
> result with drive letter or whatever needed, and another that
> normalizes the elements of the environment variables (I presume that
> if an element in it without the drive prefix should be normalized to
> add the current drive letter to it so that the normalized getcwd()
> result can be compared with it).  E.g. if the ceiling list is
> "D:/a/b;/trash/" then getcwd() returning "/a" alone does not make it
> outside the ceiling due to "D:/a/b"---our current drive must be "D"
> for that pattern to kick in.  The unqualified /trash would apply to
> any drive.

A component in an path list like GIT_CEILING_DIRECTORIES or PATH that
does not contain the drive letter is a user error. Do not cater for it.

It is more important to take into account that those components can
contain backslash as directory separators, while our mingw_getcwd()
returns forward slashes.

-- Hannes
