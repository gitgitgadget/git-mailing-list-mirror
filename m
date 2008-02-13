From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Unable to clone an ssh repository (with ugly installation-specific workaround)
Date: Wed, 13 Feb 2008 05:57:39 -0700
Message-ID: <51419b2c0802130457g25892543n9db02e681d9605c5@mail.gmail.com>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com>
	 <m31w7iegk6.fsf@localhost.localdomain>
	 <47B15ADC.8080309@viscovery.net>
	 <alpine.LSU.1.00.0802121028290.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 13:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHBq-0004Yr-N5
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 13:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbYBMM5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 07:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYBMM5o
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 07:57:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:15179 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYBMM5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 07:57:43 -0500
Received: by wr-out-0506.google.com with SMTP id c48so4514wra.23
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 04:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wn0cTLN/3GjT3uB6KIghVGvRg2CWMsnqmlEUPYf/CMQ=;
        b=oifoCJBQtWPMhJ0PfbyTu14U1jX8uFfkc/zZWwrdUafmjgmjwTAazjhvcc1LsyHIJA2y75xl+y6QP6RkLAA/T7bPljJA4D2Q7HmEYFdCizvdBQUuMIa1e9PjxOE1Ox3BDvkyuvNrrKrhYjH728xWa2igN2xqJuD6piPSvUIOkls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M4+Y9tp3VkwtTrngXQCmaU4e17nM72PvJDqX8/ztEWOQrmX+eJAXX9C5gbZSzjSMJ8QjIVH+I6zgftGZX/S9fgRKPy6ZmlW2anyKNI1CEPCfOU7gJvKoa+mJcPaQu9ogK08RgtBGzYO5F8poBSCtlDaYI45nI88mg0ASdpklfwo=
Received: by 10.114.94.1 with SMTP id r1mr2901134wab.32.1202907459403;
        Wed, 13 Feb 2008 04:57:39 -0800 (PST)
Received: by 10.114.205.19 with HTTP; Wed, 13 Feb 2008 04:57:39 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802121028290.3870@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73783>

On Feb 12, 2008 3:30 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > A quick work-around for Elijah is to add
> >
> >    GIT_EXEC_PATH=/home/enewren/software/install/linux/git/bin
> >
> > to .profile on the remote host.
>
> I guess you meant .bashrc, as .profile is not sourced when using ssh
> transport (it does not spawn a shell) AFAIR.

As far as I can tell, setting paths in .bashrc doesn't really work (or
else I'm just doing it wrong).  If it did, I would have never hit this
bug.  Observe the difference between (feel free to replace PATH with
GIT_EXEC_PATH; same general result occurs):

  $ ssh localhost
  # Wait for connection to be made, then run
  $ echo $PATH

AND

  $ ssh localhost 'echo $PATH'

AND

  $ ssh localhost 'source .bashrc
  echo $PATH'

The first and the third give the same result, but the second gives
something different.  It is the second form that git uses, meaning
that my paths never get set up.

In my little git wrapper script, I put in some code to work around
this little issue and find git-upload-pack for the user if it can (by
ssh'ing to the machine and sourcing their .bashrc in the ssh command
if necessary; might be a hack, but it makes things nicer for me than
always specifying the -u flag).

Cheers,
Elijah
