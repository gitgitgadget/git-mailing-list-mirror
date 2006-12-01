X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 19:52:09 -0800
Message-ID: <f2b55d220611301952x68f30bccs1700588eee4a6a97@mail.gmail.com>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
	 <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0611301520370.3513@woody.osdl.org>
	 <873b80tqvv.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611301618490.3513@woody.osdl.org>
	 <871wnkh142.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611301720240.3513@woody.osdl.org>
	 <87y7psfjvk.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611301827540.3451@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 03:52:23 +0000 (UTC)
Cc: "Carl Worth" <cworth@cworth.org>,
	"Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Theodore Tso" <tytso@mit.edu>, "Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XeY1thISEJ9oo6paNijIqXfrqp9MumbWMNMpnUgRPY17RkzY0VCdu3oDvOliRz36xd+XxqsOjRpJowAyFkQ5dPyTIEUcH5sn/ugftlIYtNYUWOu7n9OxTIpLV/lLr2a2/UPZPJR0CEDIFyRVusKMyD++0k1s1dMpghfhcdURKtQ=
In-Reply-To: <Pine.LNX.4.64.0611301827540.3451@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32847>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpzRh-00059s-Cm for gcvg-git@gmane.org; Fri, 01 Dec
 2006 04:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758842AbWLADwM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 22:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758851AbWLADwM
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 22:52:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:55194 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1758842AbWLADwL
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 22:52:11 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2866677wxd for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 19:52:10 -0800 (PST)
Received: by 10.90.86.10 with SMTP id j10mr4702436agb.1164945129933; Thu, 30
 Nov 2006 19:52:09 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Thu, 30 Nov 2006 19:52:09 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

I think Linus is right that the semantics of "git commit" and "git
add" are not broken and do not need fixing.  But Carl and others are
right that they are not self-explanatory to most people, whether or
not they have been tainted by CVS and its ilk.  Maybe this is a job
for a little contextual documentation (aka hand-holding) to accompany
the tutorial and reference docs.

How about we add a set of "expert" flags in the config, gating access
to non-intuitive behavior and to idioms that should be discouraged in
casual use.  For instance, with an empty config, "git commit -m" fails
with a message to the effect of:
    "As a general rule, you shouldn't use the -m flag unless you're
scripting git for automation purposes.  If this is what you are doing,
or if you insist on committing without feedback about the state of
your tree, you need to set the 'expert-commit-message' flag".

Likewise, when your working copy does not match HEAD, "git commit"
with neither -a nor an explicit list of files fails, saying:
    "'git commit' on a dirty working copy does the Right Thing!  But
some people find the Right Thing counter-intuitive at first.  Either
stick to 'git commit -a' or read the docs and set the
'expert-commit-dirty' flag."

And "git add" still does the right thing, but warns:
    "Remember, git is not CVS.  'git add' has taken a snapshot of the
current _contents_ of the newly added files, not just their names.
From now on, you will need to 'git mark' edits to them if you want
them to be part of the next commit, just like edits to files that have
already been committed.  This warning can be suppressed by setting the
'expert-add-content' flag."

Note that 'expert-commit', etc. should NOT change the semantics of any
command that doesn't error out.  They should just enable idioms that a
novice user is likely to try and get unexpected results.  They should
be overridable from the environment, of course, either one by one
(export GIT_EXPERT_COMMIT_MESSAGE=y) or wholesale (export
GIT_I_GROK_IN_FULLNESS_UP_TO=1.4.4).

Cheers,
