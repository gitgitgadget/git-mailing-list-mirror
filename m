From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 01:35:34 +0530
Message-ID: <CALkWK0nAMVKuDg4wmwujkpNxAF9zxQEdsZXyUzr+w4zVpWDCzA@mail.gmail.com>
References: <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org> <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org> <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com> <20130410195256.GA24177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:06:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1Hh-0001Qz-TR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936319Ab3DJUGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:06:17 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:52005 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936034Ab3DJUGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:06:15 -0400
Received: by mail-ie0-f171.google.com with SMTP id e14so1108282iej.30
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=M8KfLm76BRYm7rxHd2yHq8OCc5aLogFZh+Ab2N5fzGI=;
        b=XihRRrgdrVkXM4mrw3CQNKyMqeaNIdIaKCG1ECEC3EccVNDxuJqM/0gAabHYzyhCl8
         MQrRBYr1roTxxngBapHn2I6ihjoDlHdVrSHvqcXyfH+QRTJ7P5xfh0EMmhA26eWhYDhD
         DLjoT9bLxK5mugp/KgylWywr2Ded3fkFA6Jjuglylv4V0voV33Nv2mzlLAOuywV9oF09
         16CUOxKHSfvvm77s3HX4rnnhghAjCYC/dZSPFfExHxC3xxxvCbu6q3VEhNycNzPDsXwc
         Gd5uVgECsFnIVW9aFQnTGdAwK1qc09+MfFvzPmFScowb05VVGnJ3pfObQU8CS5/y9NjM
         cDpQ==
X-Received: by 10.50.17.166 with SMTP id p6mr14228448igd.12.1365624374643;
 Wed, 10 Apr 2013 13:06:14 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 13:05:34 -0700 (PDT)
In-Reply-To: <20130410195256.GA24177@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220746>

Jeff King wrote:
> Maybe. But no more so than the current:
>
>   git push
>
> which may also push master and next to the same remote.

I would argue that this was not really a problem in practice, until I
introduced branch.<name>.pushremote.

Let us imagine that I was working on artagnon/git.git (remote: ram), a
fork of git/git.git (remote: origin) earlier.  My fork contains the
link and implicit-push branches in addition to the master, next and pu
branches, which are present on both.  When I push from my
implicit-push branch with push.default = matching, I'm updating all
the matching refs on the remote ram (since branch.implicit-push.remote
is set to ram), which is fine.  Now, I git push while on branch
master.  My push is simply rejected, as I don't have write access to
the remote origin.

This is designed exactly for the read-only upstream, read-write fork
scenario.  If I had write access to upstream (where we're essentially
regression to a centralized model), we'd have some major confusion.

> As I said in an
> earlier message, I would be OK with allowing both or neither, but
> allowing one but not the other is even more confusing.

What is the point of allowing something internally consistent, but
nonsensical?  You should complain.
