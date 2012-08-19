From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest namespace change
Date: Sun, 19 Aug 2012 13:28:01 +0200
Message-ID: <A15D5621-7EF5-4409-967A-0DA20B007899@gmail.com>
References: <20120719213311.GA20385@sigill.intra.peff.net> <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu> <7vboi8rl2q.fsf@alter.siamese.dyndns.org> <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com> <7vehn3rbom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 13:28:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T33gU-0002Xf-1C
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 13:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab2HSL2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 07:28:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55930 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2HSL2H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2012 07:28:07 -0400
Received: by eaac11 with SMTP id c11so1744512eaa.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 04:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=e6bsMqKCMKLCwdBYYRyhPgAOv5P2+xX9hTKUsBAsYGI=;
        b=Gt+s7KQhuDtXBy2eTUSBK/I0CMUqK6wYjmCj0BYVvX3rkMzO4axttRUMRGsHKENfa7
         d+NxWZwppLq/AA1Bva+Gq7z/W/sVMeibNtDB9LPzHv2Tys1edxV5IuKPSuahF/iF52cJ
         TAaBbn6f3BkT13sgWj/bJ/5KMuqAuunnfbJaumLJBBkXip/1glK5oMohB6mGgRszC9zu
         Hdh/pejVnRd2eXUqjgfnPNtQvvAmC9P243EqeznFqdoKtOYlB0DMi0mVqErt4wepDwnl
         GxaUlXDnwajLcR8BtOvYXa0KpJ6AuA3iMUzh/r8/PIwISW0PDqziHPl49ItDnRcOEhra
         IAGg==
Received: by 10.14.224.4 with SMTP id w4mr4311429eep.21.1345375684917;
        Sun, 19 Aug 2012 04:28:04 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id 45sm33500008eed.17.2012.08.19.04.28.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 04:28:04 -0700 (PDT)
In-Reply-To: <7vehn3rbom.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203717>

On 19 Aug 2012, at 02:02, Junio C Hamano wrote:

> Alexey Muranov <alexey.muranov@gmail.com> writes:
> 
>> Excuse me if i miss something again, but i might be willing to
>> discuss the "ultimate destination".  Could you possibly state in
>> simple terms what the problem with determining the "ultimate
>> destination" is?
> 
> Decide if it makes sense to break backward compatibility of loose
> ref representation merely to support having a branch "next" and
> another branch "next/foo" in the same repository, and if it does,
> what the new loose ref representation looks like.

I looked again through this thread and tried to understand better the issues.

1. I vote for moving dead reflogs to "logs/graveyard" (or to "logs/deadlogs").

2. I think that allowing both "next" and "next/foo" complicates the mapping from branch names to file paths, and it does not seem necessary if dead reflogs are moved away to "graveyard" anyway.

3. There remains the question what to do with dead reflogs for different branches having the same name.  Maybe, keep the death date and time under the graveyard directory and not allow the user to delete 2 times in less than 1 second?

/logs/graveyard/yyyy-mm-dd-hhmmss/refs/heads/next/foo

In a sense this is similar to the git storage model: an "atomic" destructive operation creates a timestamped "commit" in logs/graveyard directory.