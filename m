From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 16:28:41 -0600
Organization: CAF
Message-ID: <201308141628.42163.mfick@codeaurora.org>
References: <520BAF9F.70105@googlemail.com> <201308141125.59991.mfick@codeaurora.org> <520C01C3.2060804@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, iveqy@iveqy.com,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 00:28:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9jYf-0000yz-Fe
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 00:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183Ab3HNW2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 18:28:45 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:51572 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760033Ab3HNW2o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 18:28:44 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id BAADE13EF11;
	Wed, 14 Aug 2013 22:28:43 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id ACE5613EF89; Wed, 14 Aug 2013 22:28:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 56C5913EF11;
	Wed, 14 Aug 2013 22:28:43 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <520C01C3.2060804@googlemail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232316>

On Wednesday, August 14, 2013 04:16:35 pm Stefan Beller 
wrote:
> On 08/14/2013 07:25 PM, Martin Fick wrote:
> > I have been holding off a bit on expressing this
> > opinion too because I don't want to squash someone's
> > energy to improve things, and because I am not yet a
> > git dev, but since it was brought up anyway...
> 
> It's ok, if you knew a better topic to work on, I'd
> gladly switch over. (Given it would be a good beginners
> topic.)

See below...

> > I can say that as a user, having git-repack as a shell
> > script has been very valuable.  For example:  we have
> > modified it for our internal use to no longer ever
> > overwrite new packfiles with the same name as the
> > current packfile. This modification was relatively
> > easy to do and see in shell script.  If this were C
> > code I can't imagine having personally: 1) identified
> > that there was an issue with the original git-repack
> > (it temporarily makes objects unavailable) 2) made a
> > simple custom fix to that policy.
> 
> Looking at the `git log -- git-repack.sh` the last commit
> is from April 2012 and the commit before is 2011, so I
> assumed it stable enough for porting over to C, as there
> is not much modification going on. I'd be glad to
> include these changes you're using into the rewrite or
> the shell script as of now.

One suggestion would be to change the repack code to create 
pack filenames based on the sha1 of the contents of the pack 
file instead of on the sha1 of the objects in the packfile.  

Since the same objects can be stored in a packfile in many 
ways (different deltification/compression options), it is 
currently possible to have 2 different pack files with the 
same names.  The contents are different, but the contained 
objects are the same.  This causes the object availability 
bug that I describe above in git repack when a new packfile 
is generated with the same name as a current one.

I am not 100% sure if the change in naming convention I 
propose wouldn't cause any problems?  But if others agree it 
is a good idea, perhaps it is something a beginner could do?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
