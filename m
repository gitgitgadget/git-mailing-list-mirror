From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Fri, 9 Aug 2013 12:42:14 -0700
Message-ID: <20130809194214.GV14690@google.com>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Thorsten Glaser <tg@mirbsd.de>
X-From: git-owner@vger.kernel.org Fri Aug 09 21:42:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7sa9-0006sS-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 21:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030842Ab3HITmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 15:42:19 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:52664 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030816Ab3HITmS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 15:42:18 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so951685pde.37
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XAUeoABIKXSUySIbVb2HMFnrz5y7NyoKln1WQfmutAg=;
        b=EsXp2gCD8oKhSRs2JLKFBhpwT1+Zu4v7oLmJcRFjz67pj2j3agGiSoUlMX8D0xzBwp
         5fvSq2T9ngV00wkE9ZiI0k3Feh9GVLMms5hVhNzueaHKa+nfYa6Rc6gTMLf0K8ryDunk
         j5X/YKLF+nsCpgLbSU+WFX2Xy3NgQg8f35jlF8s/tnA0BDp7yPhf9G9SnY4rQrsGSpkP
         /NdTifTc9ijLOoQgIuqlnDSI+lZ/7ktWNPuaPZY0FGAihwI+hLnkxIxrjA9u5x1ozHeV
         MbBcrkV26ux6g2iiywyDbFEUo8rF8ah5sFQ9SzyZd8Z80rGjiIzxNy0VZ56h/uAi7Uob
         FLAA==
X-Received: by 10.68.212.229 with SMTP id nn5mr13141115pbc.44.1376077337859;
        Fri, 09 Aug 2013 12:42:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sx7sm21651021pbc.41.2013.08.09.12.42.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 12:42:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232015>

Hi Thorsten,

Thorsten Glaser wrote[1]:

> git config user.email SHOULD NOT default to $(id -un)@$(hostname -f)
> because just too many cow-orkers seem to be unable to follow basic
> instructions

Heh.

Can you say a little more about your setup?  In a university
environment with sysadmin-managed email and /etc/mailname set up
correctly it is handy that people can start working without doing
anything special to configure git's "[user] email" setting.  On the
other hand it is obnoxious to receive patches with wrong authorship
information.  So I'm wondering if there's some detail that
distinguishes between these cases.

Incidentally, it's been a long time since I looked at the "Please
configure your email address; I've made something up, but you'll want
to check it" message:

	Your name and email address were configured automatically based
	on your username and hostname. Please check that they are accurate.
	You can suppress this message by setting them explicitly:

	    git config --global user.name "Your Name"
	    git config --global user.email you@example.com

	After doing this, you may fix the identity used for this commit with:

	    git commit --amend --reset-author

I wonder if it's too gentle and long to get the point across.  Would
something the following (including the guesses in the message for
easier copy-pasting) help?

	No name and email address configured, so I had to guess.  You
	can suppress this message by setting your identity explicitly:

		git config --global user.name "Thorsten Glaser"
		git config --global user.email tg@mirbsd.de

	After doing so, you may fix the identity used for this commit
	with "git commit --amend --reset-author".

It may also make sense to distinguish between cases where a mailname
is set and not set.  Git already notices the cases where the guessed
email address ends with ".(none)" and errors out, and it could make
sense to be more aggressive.

Hope that helps,
Jonathan

[1] http://bugs.debian.org/719226
