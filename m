From: Jeff King <peff@peff.net>
Subject: Re: [FYI] How I compile on SunOS 5.7 with the SUNWspro compiler and
	ksh
Date: Mon, 18 Aug 2008 22:01:32 -0400
Message-ID: <20080819020131.GA18364@coredump.intra.peff.net>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <20080819002047.GA15770@coredump.intra.peff.net> <L3gfLYBAXG5GUGcbdLqOnZab_UfskZC4FTgP9d47MJuoAiJRa2V5ZQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 19 04:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVGYU-0003RQ-46
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 04:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYHSCBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 22:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYHSCBf
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 22:01:35 -0400
Received: from peff.net ([208.65.91.99]:4150 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbYHSCBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 22:01:34 -0400
Received: (qmail 19470 invoked by uid 111); 19 Aug 2008 02:01:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 18 Aug 2008 22:01:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Aug 2008 22:01:32 -0400
Content-Disposition: inline
In-Reply-To: <L3gfLYBAXG5GUGcbdLqOnZab_UfskZC4FTgP9d47MJuoAiJRa2V5ZQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92806>

On Mon, Aug 18, 2008 at 07:47:39PM -0500, Brandon Casey wrote:

> > Hmm. I thought I had t5000 working on Solaris 5.7 a few months ago.
> > Unfortunately, the Solaris box I test on is down at the moment, so I
> > can't take a closer look. What is the problem?
> 
> Probably:
> $ gtar --version
> tar (GNU tar) 1.12

Ah, I found out the difference: my box is actually Solaris 5.8. The gtar
version there is 1.13 (which is also the version that ships with Solaris
5.9).

> $ gtar xf - < ../b.tar
> /apps/bin/gtar: Unknown file type 'g' for pax_global_header, extracted as normal file
> /apps/bin/gtar: : Could not create directory: No such file or directory
> /apps/bin/gtar: Error exit delayed from previous errors

I get the pax header warning, but nothing else. Judging from your find
results:

> ./a/long_path_to_a_file
> ./a/long_path_to_a_file/long_path_to_a_file
> ./a/long_path_to_a_file/long_path_to_a_file/long_path_to_a_file
> ./a/long_path_to_a_file/long_path_to_a_file/long_path_to_a_file/long_path_to_a_file

There should be another directory that is one level deeper, with
"file_with_long_path" in it...

> ./file_with_long_path

which seems to have been extracted in the root instead!

So perhaps you are hitting some length limitation in gtar.

-Peff
