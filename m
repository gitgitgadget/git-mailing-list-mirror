From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] git svn: Set default --prefix='origin/' if --prefix
 is not given
Date: Tue, 1 Oct 2013 08:12:53 +0200
Message-ID: <CALKQrgf0tBN9ymZ0Yq6iW95dwayhJC1a_9LZBagW6B_hBo5owA@mail.gmail.com>
References: <CALKQrgeXAtWeTedqkVtcTAUgbsBA9U6rbqUntu_ArmPgL9R3pg@mail.gmail.com>
	<1380581194-5269-1-git-send-email-johan@herland.net>
	<20131001040752.GA882@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 01 08:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQtCw-0008Ev-P7
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 08:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab3JAGM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 02:12:59 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:58660 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab3JAGM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 02:12:58 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VQtCa-00081y-SX
	for git@vger.kernel.org; Tue, 01 Oct 2013 08:12:56 +0200
Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VQtCa-000If1-Jb
	for git@vger.kernel.org; Tue, 01 Oct 2013 08:12:56 +0200
Received: by mail-wi0-f177.google.com with SMTP id cb5so5022665wib.16
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 23:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+dlbu8wLu+hbBtS/2eDo30ZY557DQcU6XHUbAWHu3mM=;
        b=Aki2XKje+tzEoKScbeJpHeor3GDWP28lPPLGesRvqDIRLIJ59PleevHkO0G3okq/Ql
         mY1t+/5Yzgxj93LEw+qx7Klr3d2D8Hq9xZKLz6hgcr8w/KAPornR8UFzRB//y0R9EuSy
         qFGi/s2x4uIKsiI/d12qrZYGvwimOcH8cVHvuGdkn9OZvoij7QDdOiZWpzQMoeMlYnKX
         bWneBZI9rMBPfVz5dLse+ZSoUPzD/skw/uGIYqxGbKk13x7PIvGXfw2Zm44qwP/gANG5
         LmBVvFEDYZmwYTCRjl6TWC/zRqn9AvV2Ndv2KzebdZn5u5Z32yywRSpIVPfxPz2HPduf
         6gkg==
X-Received: by 10.194.21.131 with SMTP id v3mr384135wje.44.1380607974088; Mon,
 30 Sep 2013 23:12:54 -0700 (PDT)
Received: by 10.194.56.102 with HTTP; Mon, 30 Sep 2013 23:12:53 -0700 (PDT)
In-Reply-To: <20131001040752.GA882@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235643>

On Tue, Oct 1, 2013 at 6:07 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Johan Herland <johan@herland.net> wrote:
>> git-svn by default puts its Subversion-tracking refs directly in
>> refs/remotes/*. This runs counter to Git's convention of using
>> refs/remotes/$remote/* for storing remote-tracking branches.
>
>> Furthermore, combining git-svn with regular git remotes run the risk of
>> clobbering refs under refs/remotes (e.g. if you have a git remote
>> called "tags" with a "v1" branch, it will overlap with the git-svn's
>> tracking branch for the "v1" tag from Subversion.
>>
>> Even though the git-svn refs stored in refs/remotes/* are not "proper"
>> remote-tracking branches (since they are not covered by a proper git
>> remote's refspec), they clearly represent a similar concept, and would
>> benefit from following the same convention.
>
> I regretted my original naming shortly after introducing it (IIRC,
> git-svn was the first refs/remotes/* user).  However, this risks
> breaking existing code and 3rd-party docs/tutorials.

True. Although the patch does not affect existing git-svn
configurations, it does affect all future (where the user does not
pass --prefix), and all documentation and scripts that will come to
work on those must be adjusted accordingly.

> How about we put a big warning of impending change in there for now and
> wait until git 1.9/2.0 to make the actual change?

Sounds sensible. What should the warning look like, and where should
it be placed? I'm thinking that if you run git svn init/clone without
--prefix, there should be a verbose warning explaining (a) the trouble
you're likely to encounter when using no prefix, and (b) the upcoming
change in default prefix. Obviuosly, there should be a corresponding
note in the git-svn manual page. Any other places in git.git that
warrants changing? Hopefully this should be sufficient to trigger
corresponding adjustments in third-party tools + docs ahead of the
actual change in 1.9/2.0.

> Thanks for bringing this up again!

Thanks for your comments!


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
