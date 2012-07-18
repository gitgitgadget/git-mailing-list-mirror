From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Wed, 18 Jul 2012 11:27:22 +0000
Message-ID: <20120718112722.GA22042@dcvr.yhbt.net>
References: <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
 <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
 <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka>
 <7v8vesk12v.fsf@alter.siamese.dyndns.org>
 <20120711012617.GA18369@dcvr.yhbt.net>
 <20120711214019.GF30213@beczulka>
 <7vmx35dhzo.fsf@alter.siamese.dyndns.org>
 <20120718074908.GA23460@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Wed Jul 18 13:27:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrSPj-0005bP-CN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 13:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab2GRL1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 07:27:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60876 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab2GRL1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 07:27:23 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD3F1F42A;
	Wed, 18 Jul 2012 11:27:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120718074908.GA23460@beczulka>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201675>

Marcin Owsiany <marcin@owsiany.pl> wrote:
> On Wed, Jul 11, 2012 at 03:56:43PM -0700, Junio C Hamano wrote:
> > If the caller does not handle errors, it could be even clearer to
> > write it like
> > 
> > 	command_noisy(qw(update-ref HEAD), $gs->refname) ||
> > 		die "Cannot update HEAD!!!";
> 
> Turns out that command_noisy()
>  - has a meaningless return value
>  - throws an exception on command failure
> so the "||" bit does not work.
> Also, for some reason command_noisy does not check for the command being
> killed by a signal, so I'd prefer to leave the verify_ref there.

Ugh, I always forget the Git.pm API, too.  Perhaps command_noisy should
be made to respect signals in exit codes (the rest of git-svn is
compromised by this behavior in command_noisy, too, it turns out... :x)

I'm not sure what else would break if command_noisy were changed,
git-svn appears to be the only user in git.git.
