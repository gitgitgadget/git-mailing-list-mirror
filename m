From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] test-svn-fe: split off "test-svn-fe -d" into a
 separate function
Date: Tue, 31 May 2011 11:32:59 -0500
Message-ID: <20110531163259.GC390@elie>
References: <BANLkTi=O9AeOZTHVLbq+rKv5k-CqNGb+LQ@mail.gmail.com>
 <BANLkTinpta+a4MAr0e2YtMa1Kr1QcJmYWg@mail.gmail.com>
 <20110525235520.GA6971@elie>
 <BANLkTinBGnCKsUOXY_RD-7yNyM7XqNTsRw@mail.gmail.com>
 <20110527110828.GA7972@elie>
 <20110527110914.GB7972@elie>
 <1306858704.13283.2.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue May 31 18:33:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRRsY-0000uj-65
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 18:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757437Ab1EaQdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 12:33:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50295 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757389Ab1EaQdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 12:33:06 -0400
Received: by ywe9 with SMTP id 9so1866952ywe.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OfC04upfBVFFVsh7yy8+SMhmIqQijyWxdyD8OPwdwPE=;
        b=vpXjyCnKdHHM4QA+tb9JrlPqPe4OjwtjfnAgtCmAjz9rA7fRjekh71DQ3zpdDmFcUa
         jI1y7UsbozbeNaSA8O7pAYaJTUJjd4d5tHJ1Ysqx4LQ+Y7IZ+hrBugx6KLKA5oCt3YMv
         lv1aTPN+jZij8Qu1m8es9ITKcLfgtdwG8vIG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pGNxm0/VLqXk1wRqlmois6vypJOIoA3cR+4YhGIWmxPdbSrlwAJBOhY+u67oW/1Ei7
         4lmCaL5Vq+cgXBav3eMC99nmXt/eBg5P4fV2B0OJKzTVpp+R0ELoRNhFf+AC98759hlJ
         qde/kAz88FfNUEqEjHW166q5VDFpQNrqNOWgM=
Received: by 10.236.79.70 with SMTP id h46mr7725794yhe.278.1306859585712;
        Tue, 31 May 2011 09:33:05 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id i62sm180534yhm.80.2011.05.31.09.33.03
        (version=SSLv3 cipher=OTHER);
        Tue, 31 May 2011 09:33:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1306858704.13283.2.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174812>

Drew Northup wrote:
> On Fri, 2011-05-27 at 06:09 -0500, Jonathan Nieder wrote:

>> +static const char test_svnfe_usage[] =
>> +	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
[...]
> How is this germane to the original intent? Is there a gain by making it
> global (to that file) that I'm missing?

It allows this variable with information about the program in general
to be shared by the two functions.  Many examples of that style show
up with

	git grep -l -F -e 'main(' | xargs git grep -F -e 'usage[]' --
	git grep -F -e 'usage[]' -- builtin

I should have mentioned so in the commit message, though; maybe
something like this:

	The helper for testing the svndiff library is getting
	dangerously close to the right margin.  Split it off into a
	separate function so it is easier to contemplate on its own.

	In other words, this just unindents the code a little.  In the
	process, make the test_svnfe_usage[] string static so it can
	be shared by the two functions (and other future functions in
	this test program) without fuss.  No noticeable change
	intended.

Thanks for noticing,
Jonathan
