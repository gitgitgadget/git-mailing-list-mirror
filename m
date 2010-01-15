From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Test t5560: Fix test when run with dash
Date: Fri, 15 Jan 2010 20:16:59 +0100
Message-ID: <201001152017.00121.j6t@kdbg.org>
References: <7vfx69hyd5.fsf@alter.siamese.dyndns.org> <4B5027B8.2090507@viscovery.net> <7vljfzz0yd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:18:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVrgM-0006sh-Hf
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 20:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036Ab0AOTSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 14:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737Ab0AOTSA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 14:18:00 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:40790 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751297Ab0AOTSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 14:18:00 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0F965A7EB3;
	Fri, 15 Jan 2010 20:17:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5F8DC19F60C;
	Fri, 15 Jan 2010 20:17:00 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7vljfzz0yd.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137100>

On Freitag, 15. Januar 2010, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> > Tarmigan Casebolt schrieb:
> >>         REQUEST_METHOD="GET" some_shell_function
> >>
> >> I can't tell from my reading of the POSIX spec whether my usage was
> >> wrong or if dash is wrong,
> >
> > According to POSIX, variables set as shown above for shell functions are
> > not exported and retain their value after the function returns.
>
> I actually looked for this yesterday, but didn't find a relevant
> definition.  But "2.9.5 Function Definition Command" [*1*] seems to
> address the issue: "When a function is executed, it shall have the
> syntax-error and variable-assignment properties described for special
> built-in utilities...".
>
> And "2.14 Special Built-in Utilities" section [*2*] says "2. Variable
> assignments specified with special built-in utilities remain in effect
> after the built-in completes...".  Taking both together, it seems that
> the assignment should be in effect after the function returns.
>
> Does my reading match yours,

These are exactly the definitions that I meant. The statement that variables 
are not exported is in "2.9.1 Simple Commands" 
http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01

"[If there is a command name], the variable assignments shall be exported for 
the execution environment of the command and shall not affect the current 
execution environment (except for special built-ins)."

> Yesterday, I saw rebase--interactive has a few codepaths where "output"
> shell function was used with the single-shot export; perhaps they need to
> also be fixed.

I knew these spots, and they were discussed when that code was introduced. 
Before I sent out the mail you were responding to, I tried various ways to 
show the failure in rebase--interactive, but it didn't fail...

-- Hannes
