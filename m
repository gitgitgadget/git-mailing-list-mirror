From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 09:37:54 +0100
Message-ID: <81b0412b0703140137i6d0df44aua9205e81249570ea@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0703140237270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 14 09:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HROzr-0004sC-Pd
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 09:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933900AbXCNIh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 04:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933901AbXCNIh5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 04:37:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:15429 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933900AbXCNIhz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 04:37:55 -0400
Received: by nf-out-0910.google.com with SMTP id o25so123612nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 01:37:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H3lK0Gv3RFb89zzy1Egpka27o1xRBMAmnPzVQuRqKaNDg3NVS4ltCsATUaV+zdzTGWkF9BoD1ejU8V8i+ibs4QaHKC7BrdgQ0kIjn9T8cJvtDjEaRwN/JOkwa1So2aGRFgVUKY/50kmKfT7kiXf2ZW9eMoTFA+e72GrpHTniuMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tzF34qPSzz9dJBsD0IHfNFD7qwSMTFsWIcW1W7KmdEmtZiKym0UJsTCdxdGY7+6oJPdJzjGjyCnxymiy24DOc3e3XeLupMa0DVU9XwaAD3++S/jAq0f5gQKZwk3aPdgdNf6jACuiQ9laIQrGT/6aZ4S9FLpHHYivfIjo9ir265k=
Received: by 10.78.164.9 with SMTP id m9mr1002193hue.1173861474462;
        Wed, 14 Mar 2007 01:37:54 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 01:37:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703140237270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42185>

On 3/14/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > So, big master to hom everybody bows, how to return the correct value
> > > when executing a pager? Because this _has_ to be done if we go that
> > > way.
> >
> > Why? If you execute the pager, nobody cares about the error value
> > anyway.
> >
> > I don't see why you would mix in a pager here. If you do
> >
> >       diff -u file1 file2 | less -S
> >
> > the return value of the pipe will not only generally be totally
> > uninteresting and never used, but it will be the return value of "less"
> > anyway. Which is what we'd get quite naturally.
>
> The thing is, most people do not realize that
>
>         git diff file1 file2
>
> _will_ execute a pager. As foreground process. And the return value is
> that of the pager.

In this example this is obviously (sometimes it is obscurely) interactive.
The return code is seldom expected.

More sneaky case could be this:

  git diff file1 file2 > tmp && do_something
  rm -f tmp

But we have isatty in setup_pager, so this works properly.
