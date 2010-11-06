From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Fri, 5 Nov 2010 22:03:12 -0400
Message-ID: <AANLkTinSb09oZHN8br5goeoG2b+Cgra88E1qeLqi-Y=z@mail.gmail.com>
References: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
	trast@student.ethz.ch, Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 03:07:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEYC8-0003Ke-KG
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 03:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab0KFCDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 22:03:14 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49810 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab0KFCDN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 22:03:13 -0400
Received: by qyk10 with SMTP id 10so3264960qyk.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Y4hfXRdgVU/0Uh5tPzI+diE4zcX2uM7Y2NzR1uPSPJE=;
        b=Z+4eKe4B/SRfmTpQ0qtN7yDZeK/FU3EgnOHeC4qotclQIhKipRwS/FuvoIy8Q7T46M
         LYNt7at727li7lGtJdkCMoiMnLOmgIEYOU1ImGm7q0jItgZ4fdVlMHgF8+buL1Q0ZJyE
         phJQuP720D6pXXd/y7HeB9J0kuoYBDYe94RSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Tnc9Grl49PYeR57EpQOJaEn/HSNP/k/xq1Emdcrx4TRsURDXw9D+Y9VP3uIyBCrxUj
         PDlNm0w3pl4DSXZ2neIKiC7wWeQm1LjQoNS/HKfS7dMho79Q4dxQSaZl6vxDDePTh6H3
         vQ3zLMwUAYZdemixexgJuOMiglJouhYXY+ZTk=
Received: by 10.224.175.65 with SMTP id w1mr1670796qaz.140.1289008992581; Fri,
 05 Nov 2010 19:03:12 -0700 (PDT)
Received: by 10.224.20.82 with HTTP; Fri, 5 Nov 2010 19:03:12 -0700 (PDT)
In-Reply-To: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160832>

I have now removed all the command line processing from
git-rebase--interactive.sh. I think the next step will be to align the
order of the validation steps between the two script files. When that is
done, I will remove one step at a time from git-rebase--interactive.sh
while simultaneously moving down the call to it from git-rebase.sh.

To avoid going off in the wrong direction, I would appreciate your input
on the order of the validation steps. I was thinking about having them
in this order:
1. Check command line
2. a. If --continue, --skip or --abort requested, rebase-apply/ or
      rebase-merge/ must exist. (What if -i is also passed and
	  rebase-apply/ exists?)
   b. Otherwise, rebase-apply/ or rebase-merge/ must not exist
3. Check that references, such as upstream and onto, are valid
4. Check that working tree is clean
5. Run pre-rebase hook

What do you think?

rebase -i currently checks that GIT_COMMITTER_IDENT is set. Should that
be checked and if so, should it only be checked if the rebase is
interactive?

/Martin
