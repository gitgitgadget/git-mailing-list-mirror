From: David Kilzer <ddkilzer@kilzer.net>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Sun, 17 Jun 2012 06:46:03 -0700
Message-ID: <1917D067-6FB3-4393-B178-BBE36B4B5D4E@kilzer.net>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net> <7vwr38bmj5.fsf@alter.siamese.dyndns.org> <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net> <7vd34z96lv.fsf@alter.siamese.dyndns.org> <76A6615B-5758-4D67-A556-2EE131FF7B20@kilzer.net> <7vmx427aj0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 15:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgFo4-0005Ro-A3
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 15:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309Ab2FQNqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 09:46:06 -0400
Received: from nm13.bullet.mail.sp2.yahoo.com ([98.139.91.83]:20664 "HELO
	nm13.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757204Ab2FQNqF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 09:46:05 -0400
Received: from [98.139.91.63] by nm13.bullet.mail.sp2.yahoo.com with NNFMP; 17 Jun 2012 13:46:04 -0000
Received: from [208.71.42.208] by tm3.bullet.mail.sp2.yahoo.com with NNFMP; 17 Jun 2012 13:46:04 -0000
Received: from [127.0.0.1] by smtp219.mail.gq1.yahoo.com with NNFMP; 17 Jun 2012 13:46:04 -0000
X-Yahoo-Newman-Id: 416575.66144.bm@smtp219.mail.gq1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: laFz9P0VM1lkBxTk.5mzqGBB0ZZ_Wd6d_UT5wKgfFEhRPqq
 zqDAHgxhIg6y.frFt9GPtdVvwTHShlTPfFfXus3m6AaO0nWfi4VMSqyA_v6d
 IdlzYAcWe_PgRkedPjf6jB3FcbCNEMmD400D.0svGWAKfFZqIZ2JriXDZuJI
 kUaukI4QeHWlrp5GLiXPwULu2abUESw6U_WE6fEaG0eB98ZLLdRQLWLjkg3i
 S1GbgupQvxiP5G5xjGoPG9GTlUF.QDXjX9iYQOe1gWNLaOYmI4xRauOiR3wE
 MCtRVj51BLd4xdesk9rdKx4uQcxWanY57ceLUxVHb69iWgzQ8voipZnJB7qD
 6XdDd0itUuGxcUoUS1x0yPCLEtPTSHM86.SuO8om51uuNwe9HllevS.RFkT5
 gQEFkbRER_vPUJZMU.KvHXpSJeWLbx1go.sIsJMu30NIbOvMBhgzBRXdDy5m
 ZBLVUQy1JSry54Goq2BTg.CupX6nzor9Zh3F4v2QVs4ujUk_5m3gi28beL2x
 fG0jyP68FUR8-
X-Yahoo-SMTP: 1KOiJh.swBAFCIHbgY4jfyoPcdmG
Received: from kilze0-204.kilzer.net (ddkilzer@98.207.50.178 with plain)
        by smtp219.mail.gq1.yahoo.com with SMTP; 17 Jun 2012 06:46:04 -0700 PDT
In-Reply-To: <7vmx427aj0.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200122>

+ Johannes Schindelin  [sorry, should have added you at the beginning of the thread]

On Jun 16, 2012, at 10:49 PM, Junio C Hamano wrote:

> David Kilzer <ddkilzer@kilzer.net> writes:
> 
>> On Jun 15, 2012, at 10:19 PM, Junio C Hamano wrote:
>> 
>>> I do not use the configuration variable myself, and I didn't check
>>> the code, but if you had rerere.autoupdate set, doesn't "git merge"
>>> in the codepath you are touching (or anywhere for that matter)
>>> already blindly take the replayed resolution and commit the result?
>> 
>> No, it does not.  That is what I originally expected to happen
>> when I used "git rebase -i -p" through a merge with conflicts, but
>> it currently does not behave this way.
> 
> After looking at what is done in t/t4200-rerere.sh, I think "git
> merge" (or anything that use --rerere-autoupdate, that is) is meant
> to exit with an error code after allowing rerere to add the result
> of replayed resolution to the index, so that the user can deal with
> any remaining paths that may be still in conflict.
> 
> Are you sure that the autoresolved paths are not "git add"ed when
> you have rerere.autoupdate set by "git merge" in "git rebase -i/-p"?

You are correct, autoresolved paths are "git add"ed when rerere.autoupdate is true.

Argh...in my original patch, I wasn't setting rerere.autoupdate.  After fixing that in the test, it's clear that the patch is no longer needed.

> Or are you only talking about the error exit from "git merge" that
> would cause "git rebase -i" to stop and give control back to the end
> user?
> 
> I suspect that the latter behaviour to stop "rebase" in the middle
> is in line with the spirit of --rerere-autoupdate, and it is not
> likely that we would want to change it.

If it could be guaranteed that all changes in a merge commit would be preserved when running "git rebase -i -p" with rerere.autoupdate enabled, I think that would be an argument for not returning control to the user during the rebase operation.  However, changes to non-conflicted files in a merge commit are currently lost in this case, so it would be too dangerous to enable this behavior now.

Dave
