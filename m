From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest namespace change
Date: Sun, 19 Aug 2012 09:07:35 +0200
Message-ID: <AA92444F-B359-4C46-A1E2-13049C44C6D9@gmail.com>
References: <20120719213311.GA20385@sigill.intra.peff.net> <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu> <7vboi8rl2q.fsf@alter.siamese.dyndns.org> <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com> <7vehn3rbom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 09:07:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2zbv-0004i5-OX
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 09:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab2HSHHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 03:07:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50340 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab2HSHHl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2012 03:07:41 -0400
Received: by eaac11 with SMTP id c11so1715760eaa.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 00:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=UdFYRXVsIYlju9ZGDPcLJq1KH+vM74gxqg7gh6CuzXA=;
        b=iEpGc/gxBeiT749Zo4LwECk1kYRNUoJN5H2+MW7a8kmxD1N4qsYUkCFE+0vbvY05T7
         NCkXXrMOIQLpu6xiBdAmCTbJK4pI0PEonmeICWpFEJX92YKJytOnbEbxF/m6IqLe8svJ
         SVMV+78/yPLjHN0wMSmDVXpespPMCkF5FcfPNsDfrF/x0kBCNxaIQBtr4mdbZoRJ6YRr
         Be9NB1+2gg8VukrSDJ331ddxd9LDHt+W6exQQmqhhC7dPt3jUpBLZ76WD+UAqTjJ+BMJ
         P0aSBTZm7kcEETF8+cXB7z2KIGmH1ODWLiBkRArJrUpeOYdq1+I9BDEabWvPVuy9tVcl
         rnfw==
Received: by 10.14.225.200 with SMTP id z48mr3741025eep.39.1345360059852;
        Sun, 19 Aug 2012 00:07:39 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id z3sm29976320eel.15.2012.08.19.00.07.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 00:07:39 -0700 (PDT)
In-Reply-To: <7vehn3rbom.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203712>

On 19 Aug 2012, at 02:02, Junio C Hamano wrote:

> Alexey Muranov <alexey.muranov@gmail.com> writes:
> 
>> I hope my opinion might be useful because i do not know anything
>> about the actual implementation of Git,...
> 
> That sounds like contradiction.

I think that the implementation (the code), the model, and the interface are independent.
On the top level, for example, one does not need to know how commit storage is optimized, it is enough to understand that each commit is a snapshot of a subtree in a file directory.

>> To just give a quick idea of my ideas, i thought that 'fetching'
>> in Git was an inevitable evil that stands apart from other
>> operations and is necessary only because the computer
>> communication on Earth is not sufficiently developed to keep all
>> Git repositories constantly in sync,...
> 
> It is a feature, not a symptom of an insufficiently developed
> technology, that I do not have to know what random tweaks and
> experiments are done in repositories of 47 thousands people who
> clone from me, and I can sync with any one of them only when I know
> there is something worth looking at when I say "git fetch".

Currently, one of the main functions of 'fetch', apart from changing the remote tracking branches, is downloading the remote objects.  This is necessary because of an insufficiently developed technology.

The other main function is changing the local copies of remote branches (changing the remote tracking branches), this is what i described as "taking a snapshot".

I did not understand what you meant by

  "I do not have to know what random tweaks and experiments are done in repositories of 47 thousands people who clone from me, and I can sync with any one of them only when I know there is something worth looking at when I say "git fetch"."

How is it possible to know and not to know what is going on in the remote repository in the same time?

-Alexey.