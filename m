From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 01:53:14 +0200
Message-ID: <20131015235314.GZ4589@mars-attacks.org>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
 <20131015231427.GF9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 01:53:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWEQU-0000wl-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 01:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933769Ab3JOXxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 19:53:17 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:42935 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933656Ab3JOXxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 19:53:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 3B26848CF;
	Wed, 16 Oct 2013 01:53:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7d6N5OzOSO54; Wed, 16 Oct 2013 01:53:28 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id B0181422A;
	Wed, 16 Oct 2013 01:53:28 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 4175C43928; Wed, 16 Oct 2013 01:53:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131015231427.GF9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236222>

On Tue, 15 Oct 2013, Jonathan Nieder wrote:

> Nicolas Vigier wrote:
> 
> >   $ cat /tmp/opt.sh
> >   #!/bin/sh
> >   OPTIONS_SPEC="\
> >   git [options]
> >   --
> >   q,quiet         be quiet
> >   S,gpg-sign?     GPG-sign commit"
> >   echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- "$@"
> >
> > Then the following two commands give us the same result :
> >
> >   $ /tmp/opt.sh -S -q
> >   set -- -S -q --
> >   $ /tmp/opt.sh -S-q
> >   set -- -S '-q' --
> >
> > We cannot know if '-q' is an argument to '-S' or a new option.
> 
> Hmph.
> 
> As Junio mentioned, inserting '' would be a backward-incompatible
> change.  I don't think it's worth breaking existing scripts.  Probably
> what is needed is a new parseopt special character with the new
> semantics (e.g.,
> 
> 	Use ?? to mean the option has an optional argument.  If the
> 	option is supplied without its argument, the argument is taken
> 	to be ''.
> 
> or something like
> 
> 	Use ?<default> to mean the option has an optional argument.  If
> 	the option is supplied without its argument and <default> is
> 	nonempty, the argument is taken to be <default>.
> 
> ).
> 
> Sensible?

Yes, I think it's sensible. I will look at this and propose an other
patch. Thanks.
