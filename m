From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: Unable to clone an ssh repository (with ugly installation-specific workaround)
Date: Wed, 13 Feb 2008 09:17:20 -0500
Message-ID: <9b3e2dc20802130617m1c260c5fhb923e7a47e770f98@mail.gmail.com>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com>
	 <m31w7iegk6.fsf@localhost.localdomain>
	 <47B15ADC.8080309@viscovery.net>
	 <alpine.LSU.1.00.0802121028290.3870@racer.site>
	 <51419b2c0802130457g25892543n9db02e681d9605c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 15:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPIRJ-0007iQ-NI
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 15:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437AbYBMORW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 09:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbYBMORW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 09:17:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:52961 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbYBMORV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 09:17:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so15684rvb.1
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dWMACWQQf648xrGUSJdf70w/aYOaRNeUig0+LOIdRMY=;
        b=AOkzZXEg+HqtsoDS8r1zXSaXlmwKNXD2naPhE3z2+IeJlhmbo8WPOreSlSrQV9s3Thrj2ioXeQ6vpn1tk66nFOQwIbaAoSDK2VHdADaJA0WpaxnKAtphUCqxz+A0p8VQXS0FWtnUrK8JIDFgoeJi16dAcr58u0Q4yXmJ68FTi0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=osI15Vhhm31ogcpShGhrUWJMqvwIWRt+oWPwSKZsWiFDH2BZoFE6NtGVPm+2sotPaxvd/f0o+16ftZ8KmP9Y5VrBwfWvLdg9KYkJzORFFqbWjX8tJLV3H8DaYOtHRFWZNtx3F77gaoNojWUYcTdEs8dxIXIxzc9oWfZv+8nbt7s=
Received: by 10.140.180.11 with SMTP id c11mr1865406rvf.166.1202912240240;
        Wed, 13 Feb 2008 06:17:20 -0800 (PST)
Received: by 10.140.173.7 with HTTP; Wed, 13 Feb 2008 06:17:20 -0800 (PST)
In-Reply-To: <51419b2c0802130457g25892543n9db02e681d9605c5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73797>

On Feb 13, 2008 7:57 AM, Elijah Newren <newren@gmail.com> wrote:
> On Feb 12, 2008 3:30 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > A quick work-around for Elijah is to add
> > >
> > >    GIT_EXEC_PATH=/home/enewren/software/install/linux/git/bin
> > >
> > > to .profile on the remote host.
> >
> > I guess you meant .bashrc, as .profile is not sourced when using ssh
> > transport (it does not spawn a shell) AFAIR.
>
> As far as I can tell, setting paths in .bashrc doesn't really work (or
> else I'm just doing it wrong).  If it did, I would have never hit this
> bug.  Observe the difference between (feel free to replace PATH with
> GIT_EXEC_PATH; same general result occurs):
>
>   $ ssh localhost
>   # Wait for connection to be made, then run
>   $ echo $PATH
>
> AND
>
>   $ ssh localhost 'echo $PATH'
>
> AND
>
>   $ ssh localhost 'source .bashrc
>   echo $PATH'
>
> The first and the third give the same result, but the second gives
> something different.  It is the second form that git uses, meaning
> that my paths never get set up.

I had this problem as well, and the only solution I found was setting
up my .ssh/environment file.
I guess when you specify a command for ssh, it executes this command
by itself, not within a shell environment.  Usually it is bash that
sources .bashrc and .profile, so you don't get your paths set up.
Unfortunately .ssh/environment is not a scripting environment, so you
have to just specify your full path there, based on what you get when
you echo $PATH from the shell.
Also, this requires putting the following in sshd_config:

PermitUserEnvironment yes

Which, and this is the biter, is not usually a default on most
systems, as far as I can see.. so it could mean bugging the sysadmin
if it's not your machine, which is not always convenient.  Can't see
any alternative though.

Steve
