From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: Re: [PATCH] rebase: add --verify-signatures
Date: Wed, 23 Dec 2015 00:12:37 +0100
Message-ID: <20151222231237.GA10408@blarch>
References: <20151210130228.GA22641@netblarch.tu-darmstadt.de>
 <xmqq37vai0ev.fsf@gitster.mtv.corp.google.com>
 <xmqqy4d2gjw6.fsf@gitster.mtv.corp.google.com>
 <20151216133915.GA3586@blarch>
 <xmqqfuz2e003.fsf@gitster.mtv.corp.google.com>
 <20151217010422.GA19500@blarch>
 <xmqq60zxc4v7.fsf@gitster.mtv.corp.google.com>
 <20151221140414.GA3422@netblarch.tu-darmstadt.de>
 <xmqqvb7re55d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 22:56:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBUuV-00060p-W2
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 22:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933913AbbLVVzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 16:55:55 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32886 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680AbbLVVzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 16:55:54 -0500
Received: by mail-wm0-f41.google.com with SMTP id p187so124144366wmp.0
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yfgp72H9lHIAeADBV9gfqMkJweNR92rlt0BgUD2WpkA=;
        b=J4X5WoZZbgrMxwPAH+7M30gai/pWtTAG3TA52EFfXLQ2T9viuHNiTtSSnYSFSR+Mk8
         PifpJjS44JIqGtZtTt2SzFqHeTuqbhhTk6tybF85H5S3HvdC30fApzHjLbve3tkTYmyA
         tmE1Dys3Zv/ISvnsw5tx9+R1/7xnyfzknzfsyrwxoBEkxa5Q9qgwfJHn0iCCyPpdyMEe
         Y7ReoGiK3VI2p4ILJlAEdUetwW/AqMxe9E1WihV5q7weum7V0H5ag8NC7kdCnmjUvsKS
         l1fiqVolmkHnZVm3kwv3xGSfZj53EZiMxQkY3wu1+kMOdSjQPRZA1chg5b83d373SSvE
         M7AA==
X-Received: by 10.194.133.233 with SMTP id pf9mr29987727wjb.71.1450821353288;
        Tue, 22 Dec 2015 13:55:53 -0800 (PST)
Received: from blarch (dslb-088-068-225-120.088.068.pools.vodafone-ip.de. [88.68.225.120])
        by smtp.gmail.com with ESMTPSA id dl8sm34823298wjb.29.2015.12.22.13.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 13:55:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqvb7re55d.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282912>

Sorry, I didn't do a group-reply in my last mail.

On Mon, Dec 21, 2015 at 03:46:54PM -0800, Junio C Hamano wrote:
> Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:
> 
> > On Thu, Dec 17, 2015 at 10:22:20AM -0800, Junio C Hamano wrote:
> >> I suspect that you are missing the bigger workflow issues, if you
> >> think this and merge are the same.
> >> 
> >> git-merge will check the other history on the side branch that you
> >> are merging _into_ the trunk, to give you an opportunity to reject
> >> what does not pass and keep the trunk sane without doing anything
> >> else.  How you (or others who asked you to pull) clean up the side
> >> branch is outside the scope of its verification.
> >> 
> >> Your change to "git pull --rebase" checks the other way---the
> >> history, which is already the trunk, onto which your work will be
> >> rebased.  There is nothing you can do without messing with the trunk
> >> if the validation did not pass, be it with a rewind-and-rebuild or a
> >> sealing empty commit which is pointless.
> >
> > It would still make sense for long-lived development branches that
> > contain experimental or controversial features, or for forks/private
> > copies that add a couple of commits onto a branch. Merging is certainly
> > an option, but I don't see why rebasing would be a wrong alternative.
> 
> Nobody says rebase is a wrong alternative.
> 
> It is just the time you decide to rebase is a wrong time to check,
> iow, too late, for the validation of the tip.

In that case I would like to submit a patch that warns or even errors in
case both --rebase and --verify-signatures is passed to git-pull.
I think an error would be appropriate, but in theory this could break
scripts that have done that, albeit it probably didn't do what the user
expected, and I don't know git's policy about breaking something like
this.
