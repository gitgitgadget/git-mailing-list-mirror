From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/5] completion: fix completion of certain aliases
Date: Wed, 09 Apr 2014 15:36:38 -0500
Message-ID: <5345af56dec8c_537810af310b9@nysa.notmuch>
References: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
 <1397069404-7451-6-git-send-email-felipe.contreras@gmail.com>
 <xmqqa9bu1enk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 22:51:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXzSx-0004nL-1u
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 22:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934323AbaDIUvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 16:51:22 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:50188 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933590AbaDIUvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 16:51:21 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so3346234obc.35
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type;
        bh=4HgmPqU6cl897vgebnNAmYggb5+EKWjh24hqMIMdijs=;
        b=zQCJEhwviPhskfNQP6E9qLtRKRs/6JnQb1Cbag7/8IyIhMLqhSGQ9w83BEQUjvbpIa
         h9W2D9SgZ+T8+MckiRY2zVJpGqc2TEFyvs6PhpFxp38/SfL4TEM64kiP9TV9IEuvUGFH
         McP7kJfwO4EKEpQ7jMKY40lE/0IYo0Wb3+8Ea+vKWVXlq0eLM8RoaMhVu/SNceuqUIVU
         6M+HePMSCv/E+ZDLRQer0bu/64omIBs2Uowgbim2tPK60iBQEopXzYGcfA7NLBs4eabr
         o4WJHmJlngsQbG/sipdBgAmJO8ymG2/GB/0fFDWjH69SDPlP6ckpembTy0yfZckO08Gf
         jGsg==
X-Received: by 10.182.43.132 with SMTP id w4mr10478777obl.41.1397076681463;
        Wed, 09 Apr 2014 13:51:21 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm8479272oec.0.2014.04.09.13.51.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 13:51:20 -0700 (PDT)
In-Reply-To: <xmqqa9bu1enk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245997>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Some commands need the first word to determine the actual action that is
> > being executed, however, the command is wrong when we use an alias, for
> > example 'alias.p=push', if we try to complete 'git p origin ', the
> > result would be wrong because __git_complete_remote_or_refspec() doesn't
> > know where it come from.
> >
> > So let's override words[1], so the alias 'p' is override by the actual
> > command, 'push'.
> >
> > Reported-by: Aymeric Beaumet <aymeric.beaumet@gmail.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> 
> Does "some commands" above refer to anything that uses
> __git_complete_remote_or_refspec, or is the set of commands larger than that?

For this particular issue, yes, the former.

> But perhaps we muck with the contents of words[] in a similar way in many
> different places in the existing completion code often enough that such an
> attempt not to touch the words[] array does not buy us much safety anyway.  I
> didn't check (and that is why I am asking with "I am wondering...").

The 'words' array is already messed up and not used correctly, so I wouldn't
worry too much about this patch messing it more (I don't see how that can be).

For example:
  % git --git-dir=$PWD/.git fetch or<tab>

-- 
Felipe Contreras
