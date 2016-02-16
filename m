From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Tue, 16 Feb 2016 16:40:05 -0700
Message-ID: <3639645.80CNmLM0I7@thunderbird>
References: <72756249.nAoBccgOj7@thunderbird> <C8BDC3289C184F40BFBE3B150CFBB50B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ovidiu Gheorghioiu <ovidiug@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:39:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVpDW-0005wf-7V
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385AbcBPXjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:39:33 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:47964 "EHLO
	fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933243AbcBPXjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:39:33 -0500
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160216233932.WWAQ17588.fed1rmfepo103.cox.net@fed1rmimpo209>
          for <git@vger.kernel.org>; Tue, 16 Feb 2016 18:39:32 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo209 with cox
	id KBfX1s00H2tqoqC01BfXD3; Tue, 16 Feb 2016 18:39:31 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020201.56C3B333.0193,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=RNFt6fe+ c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=jFJIQSaiL_oA:10 a=xtxXYLxNAAAA:8
 a=VwQbUJbxAAAA:8 a=OaCMxlJdtD-BkQcX3FAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id A632D13F83B;
	Tue, 16 Feb 2016 16:40:05 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.4.0-4-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286458>

On Tuesday, February 16, 2016 04:26:38 PM Stephen & Linda Smith wrote:
> On Tuesday, February 16, 2016 01:54:48 PM Junio C Hamano wrote:
> > "Philip Oakley" <philipoakley@iee.org> writes:
> > 
> > >>    It appeared that the conditional for 'Reject an attempt to record a
> > >>    non-merge empty commit without * explicit --allow-empty.' could be
> > >>    simplified after adding this patch.
> > >>
> > >>    This change can't be propagated to the conditional because it allows
> > >>    a commit that was previously disallowed.
> > 
> > This last sentence sounds somewhat worrysome.  Does that mean some
> > commit that was previously disallowed (which ones?) is still
> > forbidden by "commit" without "--dry-run" (which is correct--we are
> > not interested in changing the behaviour of the main codepath), but
> > "--dry-run", even with this update, will say "OK you will make a
> > meaningful commit" by exiting with 0 for such disallowed commit?
> I tried to think of a better set of wording.  Finally I decided to make it part of the note 
> rather than the commit message so that it could be debated as part of the review 
> but not be part of the commit record for the line being changed.
> 
> The patch doesn't change behaviour other than the dry-run return code 
> which now matches the return code of commit.  The one line change is not changing the
> main code path behaviour
> 
I am not adverse to moving the change to dry_run_commit() proper, 
but that would mean a slightly larger patch.

> The main code path for the case being fixed executes through the main code path 
> successfully returning zero.  The ''--dry-run' was predicitng failure if a script was 
> checking the return code, but successs if looking at the messages.
> 
> The final couple of paragraphs explain why I chose not to change the if() statement. 
> The reason I didn't is so that expected behaviour is maintained.
> 
> The condition that can not be removed in the if is the 'whence != FROM_MERGE'.   Removing 
> that caused t7502 to generate errors.   Therefore I left ' if (!commitable && whence != FROM_MERGE 
> && !allow_empty &&  !(amend && is_a_merge(current_head)))' in the commit.c file.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
