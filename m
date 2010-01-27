From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv12 00/23] git notes
Date: Thu, 28 Jan 2010 00:05:03 +0100
Message-ID: <201001280005.03190.johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
 <7vzl3zpbbz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 00:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaGwt-00017A-Jv
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 00:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab0A0XFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 18:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177Ab0A0XFM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 18:05:12 -0500
Received: from smtp.getmail.no ([84.208.15.66]:50863 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753133Ab0A0XFL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 18:05:11 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWX001SUHGLTZ00@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Jan 2010 00:05:09 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWX000WFHGFQS10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Jan 2010 00:05:09 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.225424
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vzl3zpbbz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138206>

On Wednesday 27 January 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > - Patch #23 is a new patch adding the "git notes add" command for
> > appending contents to notes (instead of editing/replacing).
> 
> I find this even more confusing.  Originally I was puzzled by the lack of
> "git notes add"; it took me for quite until I managed to figure out that
> "git notes edit" was the command to use, even if I wanted to add notes to
> a commit that I know that does not have any.

Not sure what you're getting at here. For the case where a commit has no 
notes, "git notes add" and "git notes edit" are already _identical_. I was 
only trying to emphasize that when there is an existing note, "git notes 
add" will append to it, whereas "git notes edit" will replace it with your 
edited version. I'm sorry if this was unclear.

> I would expect "git notes edit" to be "edit starting from the existing
>  one (if exists)", and "git notes add" to be "add notes to a commit that
>  lacks one,

Up to here, the current patch does exactly what you expect.

>  complain if it already has notes, and allow --force to replace".

I disagree. I wrote the current semantics with the following use case in 
mind:

"I have just reviewed a commit, and want to add a 'Reviewed-by' tag to the 
commit notes. I don't really care if the commit already has notes, but I 
certainly _don't_ want to delete them when adding my 'Reviewed-by'. 
Furthermore, I want to do this with a simple command, without being thrown 
into an editor."

Now, 'git notes edit -m "Reviewed-by: ..."' will do the job nicely for 
commits that have no notes, but it will discard any existing notes, so it is 
not a good solution in this case.

Instead, the current semantics of "git notes add" _does_ solve this use case 
('git notes add -m "Reviewed-by: ..."' will append to the existing notes, or 
create a new notes object if none exist).

I'm not opposed to changing the semantics if people find them unintuitive, 
but I would want the new semantics to provide for this use case as well.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
