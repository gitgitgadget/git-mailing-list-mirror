From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 15/18] reset: Make reset remove the sequencer state
Date: Wed, 27 Jul 2011 07:16:12 +0200
Message-ID: <20110727051612.GJ18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-16-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 07:16:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlwTu-0006Nw-CF
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 07:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab1G0FQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 01:16:25 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:59207 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab1G0FQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 01:16:24 -0400
Received: by eye22 with SMTP id 22so1593353eye.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=F/Zo+qFQyiuwDLF4Cz1F8hjzK6FdBLCKkRxqumk7B8c=;
        b=AgltaJvaNKC7Lp7x0Z93fZrk7DjwItpRLgjItkDasMu+7l+oIWbu8l9PVHdYQ+44WV
         09NXfW/9DerB97BBHbe8oiSW9Wm4aBbmSkIw+wX+ZOcVLzc4DdU30HW7kLI2R3LEtVOP
         hZc1y4Mz5Cxg+BGMvnUeU6BWPraUbcgmBl0TM=
Received: by 10.213.34.201 with SMTP id m9mr1288760ebd.100.1311743783368;
        Tue, 26 Jul 2011 22:16:23 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id q16sm831105eef.41.2011.07.26.22.16.21
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 22:16:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-16-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177932>

Ramkumar Ramachandra wrote:

> [Subject: reset: Make reset remove the sequencer state]

The chosen strategy here also affects some other commands, most notably
"git checkout".

[...]
> Guard against accidental removal of the sequencer state by providing
> one level of "undo".  In the first "reset" invocation,
> ".git/sequencer" is moved to ".git/sequencer-old"; it is completely
> removed only in the second invocation.

That doesn't help much if the user doesn't know about it, I fear.
Any ideas about how to address that?

Especially, if I run

	git checkout HEAD^

and get the response

	note: removing pending cherry-pick state
	hint: use "git cherry-pick --revive" to return to the cherry-pick

then I probably would not be too annoyed.  And on the other hand,
if I run

	git reset --hard

to clear away an ugly conflict in the course of a long
cherry-pick-many and suddenly "git cherry-pick --continue" stops
working without explanation and the only way I know to finish the job
I was working on is to start over, that would be an unpleasant
experience.
