From: Domenico Andreoli <cavokz@gmail.com>
Subject: dangling blob which is not dangling at all
Date: Wed, 1 Aug 2007 03:34:50 +0200
Message-ID: <20070801013450.GA16498@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 03:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG37W-0001Bc-TV
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 03:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbXHABe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 21:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761185AbXHABex
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 21:34:53 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:54894 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761402AbXHABev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 21:34:51 -0400
Received: by fk-out-0910.google.com with SMTP id z23so48902fkz
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 18:34:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=bwH2YoebKmaP3Zg2tzHrxhWVKu8tARSa23GKzmn7iTpplww8PoG9O3olDShjKrKG66zQJK/LGyoxVq8fqHdSkKq0GKUCiIBxDQqKcJ7zV1wUmcNXsM6g6gJFoPLhPn2CTjKSUX5JYkZ3FV7qS2MStrkUQ5FPBquTPG6bhCRqLok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Z1Ksek5UxCfNppLZhCvF6dPH0a0yACsDEyzL3HqjxEiunb/BO3MgCXPqgn0sAaLmhruySufQq9gilEvreZxvbrPjWggBmcVoHkk2bIamIu28TMpzzL32qlbaDiOygMSIN7tnfzivMHsBsVtg/KyYQbrlujTo8skmDGjj15dGMG8=
Received: by 10.86.93.17 with SMTP id q17mr169241fgb.1185932089979;
        Tue, 31 Jul 2007 18:34:49 -0700 (PDT)
Received: from raptus.dandreoli.com ( [159.149.71.27])
        by mx.google.com with ESMTPS id b17sm341044fka.2007.07.31.18.34.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 18:34:49 -0700 (PDT)
Received: by raptus.dandreoli.com (Postfix, from userid 1000)
	id E02193E48C0; Wed,  1 Aug 2007 03:34:50 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54395>

Hi,

  first of all, I want to thank Linus and you all for git, it is
revolutionizing my every-day work flow. Exceptional.

Playing with my central bare git repository (yes, I am a former
CVS/SVN user) and trying to lose data I discovered something I am not
understanding well.

Running git fsck --no-reflogs I found some dangling objects (I have
to say I enjoyed a lot in navigating commits, trees and blobs with
plumbing... really!), two were commits and one was a blob.

One of the commits was there because I pushed (forcing) from a working
repository after a git reset HEAD^. I checked it and removed it and
all the other dependant objects until the blob which contained the new
version of that file. It seems I even understood what I was doing! ;)
Until here, everything had been smooth.

Second commit was something pushed from another repository but at the
right head was strangely recorded with a different hash. Removing it,
its tree and another sub-tree, no blob was pending. So the final blob
containing the change was still used elsewhere, indeed by the "right
head" of above. While I would expect this in a working repository where
merging is happening all the day, it is not clear how it happened to
my central repository, where nobody does any work. Any idea?

And now, what I think is a bug, the dangling blob. It is signaled as
dangling but it is not. Hunting for a commit/tree/blob to compare it to
in order to understand which modification it was hiding, I found a tree
object which referred to it, which by definition of "dangling object"
should not exist. So fsck looks f*cked... and I am well available to
understand what is going wrong here, but please help me.

$ git fsck --no-reflogs
dangling blob e5d444e61b834c34710ce8fb5cb176e20e5894e1
$ git-ls-tree 70b58535361eb633d44d4f1275af3421ca6a5ed7
...
100644 blob e5d444e61b834c34710ce8fb5cb176e20e5894e1    link_stream.c
...

If you read me until here, good night! ;)

Cheers,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
