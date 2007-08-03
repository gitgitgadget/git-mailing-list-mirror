From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 16:27:49 -0400
Message-ID: <9e4733910708031327u7df2205ap56a7ad5430380fb@mail.gmail.com>
References: <46B2E8F3.30301@alum.mit.edu>
	 <0BB549C6E74E24409FB20B3B1D1B6644029461C0@ATL1EX11.corp.etradegrp.com>
	 <9e4733910708030841r31175efg4ea4ea41e852ab2@mail.gmail.com>
	 <46B37ADB.8020103@alum.mit.edu>
	 <9e4733910708031316x1b7d2a40n5d0298cedd6cf97c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Patwardhan, Rajesh" <rajesh.patwardhan@etrade.com>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org, users@cvs2svn.tigris.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:28:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH3km-0002Jr-3H
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 22:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152AbXHCU1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 16:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbXHCU1v
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 16:27:51 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:53988 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbXHCU1u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 16:27:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so758747rvb
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 13:27:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kn4F32O31xImYYBANfK587WkhAWw4EQ+wH9q3Fb9M2ZT25WAkqpjqRT2YS3H5Wo8EuYqhqgF15c80uZsK0+753/k1IC9bJHZlmgUHMDDNEJzgbsXGDoVQnVyrRC82tTLR87j6Ra+NKoZjLvqZpVngSicwJBhkw393n4un3ZyPPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lnvAAOb7f3JGUCOTwGm585ZAlBDRK6W0juG60RxX38Op374szvamSLjZ9+7FrwP0OM/oLknzpMY2NVx+IZUOg0AXqSCHmvLRKcvSBVNkHPP6aXlYwa8Cv3VHUEjkGaUexgP7Q9UZmQ0dpecp2wewrA9Ha+FqI2Qn2s0orola8sc=
Received: by 10.114.181.1 with SMTP id d1mr3336822waf.1186172869879;
        Fri, 03 Aug 2007 13:27:49 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Fri, 3 Aug 2007 13:27:49 -0700 (PDT)
In-Reply-To: <9e4733910708031316x1b7d2a40n5d0298cedd6cf97c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54752>

On 8/3/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Make a bulk importer for SVN like git-fastimport. I measured some SVN
> imports and the bulk of the time was spent forking off SVN. Before
> git-fast import it would have taken git two weeks to import Mozilla
> CVS.

And add a CVS parser to cvs2svn. Use the one I posted or write it again.
Fork is not a very fast operation, millions of forks take a week to run.

In the cvs2git code I did there was one process running cvs2svn and it
parsed the CVS files internally. A second process ran git-fastimport.
Nothing else was forked.

When I first started we were forking both git and cvs. When I ran
oprofile on it 95% of the CPU time was being spent in the kernel.
Linus helped me figure out what was going on. It was the overhead of
page table copies associated with millions of forks that was taking so
long. The solution is to eliminate the forks.

My first try with forks for both cvs and git took about a week to
import Mozilla CVS. After all the forks were eliminated I could import
Mozilla CVS in four hours.

>
> >
> > Michael
> >
> >
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
