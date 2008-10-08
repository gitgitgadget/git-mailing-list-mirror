From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [RFC] git rev-contains [Was: merge -s ffonly]
Date: Wed, 8 Oct 2008 10:30:50 -0400
Message-ID: <20081008143050.GG3052@riemann.deskinm.fdns.net>
References: <20081006235611.GA17662@spearce.org> <20081007185815.GA10744@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: =?us-ascii?Q?=3D=3FISO-8859-1=3FQ=3FUwe=5FKleine-K=3DF6nig=5F?= 
	<ukleinek@strlen.de>
X-From: git-owner@vger.kernel.org Wed Oct 08 16:43:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kna7x-0002mz-0g
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 16:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbYJHOdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbYJHOdP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 10:33:15 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48509 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYJHOdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 10:33:14 -0400
Received: by gxk9 with SMTP id 9so8139071gxk.13
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=Q6mMy6Y6SZuuAQ6s01uc0DfiLtkMFJY3AV/uogRfcPA=;
        b=qJmjE5MI3BEgvp8XAJqOzvzWGrnKjK+EqU2c0chntS2suYkfHAnuilofJtNCAotKHx
         2AgzG1kqfNblfiNNYPZcwW0wfhKDsrOWD4hRfiFzy0bBo49VuRr9YrNF3kEtlKc3iY79
         8kpNJa+KyVviktGQD2MmsMJ3UEKm3HNBS4yLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=MOGRIIYMy+I12CvqJEcfJmpsyRTGn+nJA5A+wgk+fxp3UY2x9xKLLKyhM5xdSwYdTL
         pgJJgbtPn1VZH3xHf0Y20lhqIvJHC/cQxX+VJHZoPMauyIzdmoYL3uXG0sZpNzr5I1MT
         SjVQmkJXdrIlywO+veeUqi+h9CViZ51z9BQlc=
Received: by 10.101.1.19 with SMTP id d19mr1676442ani.60.1223476393035;
        Wed, 08 Oct 2008 07:33:13 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id o61sm9312771hsc.10.2008.10.08.07.33.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 07:33:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081007185815.GA10744@strlen.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97801>

On Tue, Oct 07, 2008 at 08:58:15PM +0200, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig_ wrote:
> > +	if test -n "$(git rev-list $1..HEAD)"
> I already wrote similar tests and I wonder if this couldn't be done in a
> new builtin command more effectively.  Something like
> 
> 	git rev-contains HEAD "$1"
> 
> .  I expect it to be faster and maybe it prevents a command line
> overflow?! [...]
 
I'm not sure this warrants a builtin; seems like test is perfectly capable of
doing what you want:

if test '(' -n "$(git rev-list --max-count=1 $1..HEAD)" ')' -a \
	'(' -z "$(git rev-list --max-count=1 HEAD..$1)" ')'

The second check is needed to ensure that the commits actually have an
ancestor-descendant relationship.  And --max-count means your command line
won't overflow.

Or what about this:

if test "$(git merge-base $1 HEAD)" = "$(git rev-parse $1)"

My $0.02,
Deskin Miller
