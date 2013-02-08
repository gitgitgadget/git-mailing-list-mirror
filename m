From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Thu, 7 Feb 2013 23:48:13 -0800
Message-ID: <20130208074813.GA7337@elie.Belkin>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com>
 <7v38x766b2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ihU-00007G-HG
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 08:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759676Ab3BHHsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 02:48:25 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:48333 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab3BHHsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 02:48:24 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so1922680pab.32
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 23:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=choWi9jPUh9EO4W2dQYPf+vnRXeNBS2b5G22bLD+pZw=;
        b=A3k9CqIwp3l7rsMVZqMJ+yl4BKIp+iHKl8Y5Kk76sEmOFdZ09DrJLgAgmgM89MVTU9
         fs2CZch7XmGJZnjgzqDhl+MyrOJyHL0aoNcAT/q7GDqkM6H/XZ2EpVv6Cd06/Jl6/LIg
         g11IrtvenLftyR14XLCmO1RdHu9ORH1fgxaehTALJGBHACmdiWMq6w7jYmJYlE0HDImZ
         8RUJDv6Nhj7dMJZVLqAEibuBiEcSjfWPT9pFc7mOk44UTH0OEqUdDjITt/tHwxLdADG2
         u54x/RPwkKv3aI993/5O/ptzwzvjV/3/gqf0pfgqukyX9G4tjO4kpceLPZ77CkE80sMI
         dHIA==
X-Received: by 10.66.79.202 with SMTP id l10mr14517908pax.36.1360309704329;
        Thu, 07 Feb 2013 23:48:24 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id i6sm52326277paw.19.2013.02.07.23.48.20
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 23:48:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v38x766b2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215765>

Junio C Hamano wrote:

> I'd actually see this as Gerrit being weird.
>
> If it wants to quarantine a commit destined to the "master" branch,
> couldn't it just let people push to "master" and then internally
> update "for/master" instead?

It is because pushing doesn't update refs/heads/master.  Instead, it
starts a code review.

Suppose Gerrit allows starting a new code review by pushing to
refs/heads/master.  It sounds okay if I squint --- it's just a very
slow asynchronous ref update, right?  Let's see:

	$ git clone <gerrit server> test
	Cloning into 'test'...
	$ echo hi >greeting
	$ git add greeting
	$ git commit -q -m 'hello'
	$ git push origin master
[...]
	remote: New Changes:
	remote:   <gerrit server>/r/1234
	remote: 
	To <url>
	   ea4cb77b..9117390e  master -> master
	$ : walk away, forget what I was doing
	$ git fetch origin
	From <url>
	 + 9117390...ea4cb77 master     -> origin/master  (forced update)

"Wait, why did the remote rewind?"

Regards,
Jonathan
