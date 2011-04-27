From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 18:42:24 -0500
Message-ID: <20110427234224.GA26854@elie>
References: <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se>
 <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net>
 <7vwrif5q93.fsf@alter.siamese.dyndns.org>
 <20110427220748.GA19578@elie>
 <7vsjt35l84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:42:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFENf-0006wY-55
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 01:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760162Ab1D0Xml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 19:42:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47020 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202Ab1D0Xmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 19:42:31 -0400
Received: by gyd10 with SMTP id 10so789053gyd.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0c6yB4fCLUFTI01EH4snfK8AgnbKItvkBVlK6gJK0/U=;
        b=wgUSDgWJACzCsju8F+nBqNUAW2iMNpZJRJyh7YfWXDelGe5kg5kKSol++aYOc+TmOg
         Fx6MqZBVYEudrhMTg+oT/8YerlNTdVJcqahS2WVfNFT3Tq0EiwuFw5TDTpot6zSS+25M
         0YwP/t/7FX17LCRkLq8hSOkcnhdKZcshOl8tM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aHrioyt7PIFTngAZUjKM0/PAusTgjhwdqJACLhV6TGaZjBdl6LWaCo0odpviQcrzgn
         IwG4fznxnn5bqitsmsbF0IG/vfAsHULtTFR0DQgy5ubgSD0bSlyBv1auWSNwtC96GeaF
         H4pGf3/TzmU8YlPyVozoIFq0lxbuSFtZvlF+w=
Received: by 10.236.25.164 with SMTP id z24mr3662888yhz.314.1303947750290;
        Wed, 27 Apr 2011 16:42:30 -0700 (PDT)
Received: from elie (adsl-69-209-61-200.dsl.chcgil.ameritech.net [69.209.61.200])
        by mx.google.com with ESMTPS id l74sm629193yhn.96.2011.04.27.16.42.28
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 16:42:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjt35l84.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172292>

Junio C Hamano wrote:

> I was thinking it, and the location git-work binary gets installed, should
> depend on where "git" and its subcommand binaries are installed.  The word
> plug-in mentioned in the thread implied that whatever plugs in is not by
> itself full fledged thing that is useful standalone, so it seemed a very
> natural thing to do.

With the goal of making some commands available to git without putting
them on the $PATH in mind, this all makes more sense.  Sorry I missed
that before.

>> Or is the idea to blindly install (a symlink to) git-work to $(git
>> --exec-path)/ rather than a place on the $PATH?
>
> You can call it _blindly_ if you like, but that is what I meant.  "git"
> tells where the binary and help material for a "plugin" to be installed,
> so that it can find them where it expects to.

Right, my worry was based on the usual way programs find their way
onto my $PATH.  That is:

 - if they are installed via a package from the distro, they are in
   /usr/bin.

 - if they are installed with "make install" by the local sysadmin for
   all users, they are in /usr/local/bin.

 - if I am trying them out for myself, they are in $HOME/opt/foo/bin
   and when it is time to remove it, "rm -fr $HOME/opt/foo".

 - if I have adopted them, symlinks go in $HOME/bin.

With a local gcc-4.6 in $HOME/bin, if the sysadmin upgrades gcc so
gcc-4.6 is to appear in /usr/bin or /usr/local/bin, my setup still
works without trouble.  So, barring bugs, each installation method
does not interfere with the other ones.

Call it overengineering, but I would want a way for installing new git
commands to have the same attributes (installable by normal users in
multiuser systems and name conflicts not being a terrible
administrative burden).  A simple way would be to introduce
GIT_MAN_PATH as you described and to teach "git help" to accept a
GIT_EXEC_PATH consisting of a colon-delimited (semicolon-delimited on
Windows) list of directories.
