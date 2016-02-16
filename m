From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Tue, 16 Feb 2016 16:26:38 -0700
Message-ID: <1501768.nZTW69Q7aq@thunderbird>
References: <72756249.nAoBccgOj7@thunderbird> <C8BDC3289C184F40BFBE3B150CFBB50B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ovidiu Gheorghioiu <ovidiug@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:26:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVp0W-0003cK-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933355AbcBPX0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:26:07 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:52127 "EHLO
	fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933275AbcBPX0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:26:06 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160216232605.IIWT331.fed1rmfepo101.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Tue, 16 Feb 2016 18:26:05 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id KBS41s00T2tqoqC01BS4Y5; Tue, 16 Feb 2016 18:26:05 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.56C3B00D.001D,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=jFJIQSaiL_oA:10 a=xtxXYLxNAAAA:8
 a=tmIK4eZ4PTl_79ilvuEA:9 a=CjuIK1q_8ugA:10 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id BF48013F83B;
	Tue, 16 Feb 2016 16:26:38 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.4.0-4-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286454>

On Tuesday, February 16, 2016 01:54:48 PM Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> >>    It appeared that the conditional for 'Reject an attempt to record a
> >>    non-merge empty commit without * explicit --allow-empty.' could be
> >>    simplified after adding this patch.
> >>
> >>    This change can't be propagated to the conditional because it allows
> >>    a commit that was previously disallowed.
> 
> This last sentence sounds somewhat worrysome.  Does that mean some
> commit that was previously disallowed (which ones?) is still
> forbidden by "commit" without "--dry-run" (which is correct--we are
> not interested in changing the behaviour of the main codepath), but
> "--dry-run", even with this update, will say "OK you will make a
> meaningful commit" by exiting with 0 for such disallowed commit?
I tried to think of a better set of wording.  Finally I decided to make it part of the note 
rather than the commit message so that it could be debated as part of the review 
but not be part of the commit record for the line being changed.

The patch doesn't change behaviour other than the dry-run return code 
which now matches the return code of commit.  The one line change is not changing the
main code path behaviour

The main code path for the case being fixed executes through the main code path 
successfully returning zero.  The ''--dry-run' was predicitng failure if a script was 
checking the return code, but successs if looking at the messages.

The final couple of paragraphs explain why I chose not to change the if() statement. 
The reason I didn't is so that expected behaviour is maintained.

The condition that can not be removed in the if is the 'whence != FROM_MERGE'.   Removing 
that caused t7502 to generate errors.   Therefore I left ' if (!commitable && whence != FROM_MERGE 
&& !allow_empty &&  !(amend && is_a_merge(current_head)))' in the commit.c file.
