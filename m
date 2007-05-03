From: Bryan Larsen <bryan@larsen.st>
Subject: Re: [PATCH] Try 2: Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 03 May 2007 19:35:51 -0400
Message-ID: <463A71D7.5060506@larsen.st>
References: <463A6930.8090603@larsen.st> <7vfy6dzf25.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 01:34:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjkoB-0005lV-HK
	for gcvg-git@gmane.org; Fri, 04 May 2007 01:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbXECXd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 19:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbXECXd4
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 19:33:56 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:50751 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbXECXdz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 19:33:55 -0400
Received: by nz-out-0506.google.com with SMTP id o1so697518nzf
        for <git@vger.kernel.org>; Thu, 03 May 2007 16:33:54 -0700 (PDT)
Received: by 10.65.133.8 with SMTP id k8mr4526817qbn.1178235232529;
        Thu, 03 May 2007 16:33:52 -0700 (PDT)
Received: from ?192.168.1.91? ( [206.248.190.98])
        by mx.google.com with ESMTP id q18sm809280qbq.2007.05.03.16.33.50;
        Thu, 03 May 2007 16:33:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <7vfy6dzf25.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46121>

Junio C Hamano wrote:
> Bryan Larsen <bryan@larsen.st> writes:
> 
>> The perl scripts start with "#!/usr/bin/perl".  There is a mechanism
>> PERL_PATH in the Makefile to change this, but it currently doesn't work
>> with PERL_PATH="/usr/bin/env perl".
> 
> I do not get this whole business.  Why would you even want to
> support that to begin with?
> 
> The purpose of PERL_PATH is for you to tell git the path you
> have your Perl at.  It is not about supplying a small shell
> script that lets "env" to figure it out.
> 

Maybe PERL_PATH should be renamed PERL_SHEBANG or something.  Because if 
you pass in something that doesn't work on a shebang line (longer than 
32 characters, say), it just won't work.

I was under the impression that "#!/usr/bin/env perl" was the "right" 
way to invoke perl.  But I'm not doing this because I want to do the 
"right" thing.  I'm doing this because it makes this scenario work:

$ sudo port install git-core
installing openssl...
installing openssh...
installing curl...
installing expat...

$ ...
$ git-send-email ...
$ ...

$ sudo port install git-svn
installing apr...
installing subversion...
installing perl...
installing p5-svn-simple...

git-core works fine with stock perl, and we don't want to install extra 
megabytes of unneeded stuff if it really isn't needed.

Certainly there are other ways of making this work.  But they're all 
uglier than doing the "right" thing of "/usr/bin/env perl".

cheers,
Bryan

P.S.
On Linux, "#!/usr/bin/env perl -w" doesn't work.  On OS X it works fine.
