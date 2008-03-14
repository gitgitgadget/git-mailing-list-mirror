From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 18:28:48 +0100
Message-ID: <20080314172848.GA5080@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site> <20080313224741.GA5000@localhost> <7vhcf9r4qp.fsf@gitster.siamese.dyndns.org> <20080314121752.GB3315@localhost> <7vd4pxqoql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:29:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDir-0002nT-Ae
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbYCNR26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbYCNR26
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:28:58 -0400
Received: from qb-out-0506.google.com ([72.14.204.238]:24371 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbYCNR25 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:28:57 -0400
Received: by qb-out-0506.google.com with SMTP id e11so4010041qbe.15
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=jV3AB4lkg/SH0cCHczAy/sM68m6ThqSiA0lIYbfKVic=;
        b=jO1c3hI5f2zUf9dZoz2vhXiS8BFExAIBk7Ocl9l9rxKwGnsbhiOOUY4BEkJRwt4ofcSh9nrbW9qpr2tSado2/xoTZWbD2Hz518LKQZYlSstkJAjI4wUal5t1v1gDf3DiEiDItYHvtghRmjExO2d/oK4EmCUihQxnvreemXS3weE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=qw8wiYLgV56PJb7U0UbfYci3NdKperIoH5Sn3cGgWbBUuyZdpPKbHy7GcOg6We/ZuOgzS83rjkHmunL2x8P0GCw1L9KjoZsoOJOGPcF/4bojqH80wHommuCcl6cIckEBZBNC4huMgJcNGaWvdcAVNHXBEjQ6CiEtTI5oYmzHX4E=
Received: by 10.35.90.1 with SMTP id s1mr18757889pyl.36.1205515734154;
        Fri, 14 Mar 2008 10:28:54 -0700 (PDT)
Received: from darc.dyndns.org ( [84.154.73.161])
        by mx.google.com with ESMTPS id e8sm436278muf.8.2008.03.14.10.28.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 10:28:52 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1JaDi4-0001Pi-BA; Fri, 14 Mar 2008 18:28:48 +0100
Content-Disposition: inline
In-Reply-To: <7vd4pxqoql.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77256>

On Fri, Mar 14, 2008 at 09:01:06AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> >> Reading the rest of the function, I notice that it consistently favor "a"
> >> over "b", when a conflict cannot be reconciled.
> >
> > Indeed. I think "b" should be favored over "a", however.
> 
> Why?

>From the commit message to the latest version of my patch:
http://marc.info/?l=git&m=120548648727308&w=2

On Fri, Mar 14, 2008 at 10:21:05AM +0100, Clemens Buchacher wrote:
> If the file mode or link changed in only one branch, keep the changed
> version. If the file mode or link changed differently in both branches,
> report a conflict. If this happens, the user is more likely to be aware of
> the change in the head branch. Choose the remote version by default, in
> order to make the user think about the change.

In principle, both decisions are equally right or wrong. However, suggesting
the remote version (i.e., "b") by default gives more incentive to think about
it because the file now changed with respect to the head version (i.e., "a"),
which the user started out with.

Clemens
