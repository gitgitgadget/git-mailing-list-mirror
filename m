X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [RFC] requiring Perl SVN libraries for git-svn
Date: Fri, 15 Dec 2006 08:02:38 -0800
Message-ID: <m2vekddu5d.fsf@ziti.local>
References: <20061213202142.GE8179@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 16:02:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=d4ReZ/BYgzUyMBLHCpkyTOzHullOJkujTagu3M1pwkjl6P5sVFNP8iW8eOfMFEccwb6L32z1eXyuGTKfcJDOGIbQsRbXQ4LmS/dxLovbi+Vxf1SNX8WsLnyeWKE+7y0uH3k3yU7IA24s9r4lpbQD0C5ytx5WnEkfm2ctCSuqZ+Y=
In-Reply-To: <20061213202142.GE8179@localdomain> (Eric Wong's message of "Wed, 13 Dec 2006 12:21:42 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34526>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFWP-0006ko-MV for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752788AbWLOQCq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWLOQCp
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:02:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:63588 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752788AbWLOQCp (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 11:02:45 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1173997nfa for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 08:02:43 -0800 (PST)
Received: by 10.49.91.6 with SMTP id t6mr213000nfl.1166198562797; Fri, 15 Dec
 2006 08:02:42 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 p43sm15474593nfa.2006.12.15.08.02.41; Fri, 15 Dec 2006 08:02:42 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:
> Are there any git-svn users out there who would be seriously hurt if I
> dropped support for using the svn command-line client in git-svn?
>
> The API of the SVN:: libraries seem to be relatively stable these days
> and are *much* faster than the command-line client.  I plan on
> maintaining compatibility with version 1.1 of the SVN libraries for at
> least another year; or more if it's not a big problem.

I've been using the SVN:: libraries and agree that that they work well
(and faster).  One downside I see is that the svn command-line stuff
will Just Work for a lot of folks, whereas obtaining or building svn's
Perl bindings can be more of a chore [*1*].

OTOH, using git-svn via the svn CLI is slow and much less fun than
with SVN::.  So I can also see an additional argument to drop so that
people's first impression of git-svn won't be, "gaah, slow" -- because
with the SVN:: libs, my experience has been, "yaah, much faster!" :-)

My $0.02.

+ seth


[*1*] I asked our sysadmin to install the Perl libraries on one of our
new servers and although they seem to be installed, they are
non-functional.  git-svn stiffles the error messages, but a simple
script that just tries to require SVN::Core gives:

    Can't load
    '/usr/lib/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/auto/SVN/_Core/_Core.so'
    for module SVN::_Core:
    /usr/local/src/subversion-1.4.2/subversion/libsvn_ra_dav/.libs/libsvn_ra_dav-1.so.0:
    undefined symbol: PKCS12_SAFEBAG_free at
    /usr/lib/perl5/5.8.8/x86_64-linux-thread-multi/DynaLoader.pm line 230.

Anyone else seen this?  I guess that if you drop the svn command-line
support, that it would then make sense to error out with more complete
