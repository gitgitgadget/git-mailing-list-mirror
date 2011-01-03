From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4] teach vcs-svn/line_buffer to handle multiple input
 files
Date: Sun, 2 Jan 2011 18:49:00 -0600
Message-ID: <20110103004900.GA30506@burratino>
References: <20101224080505.GA29681@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 01:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZYbu-0002DH-NK
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 01:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab1ACAtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 19:49:13 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:44469 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab1ACAtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 19:49:12 -0500
Received: by yib18 with SMTP id 18so2930641yib.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 16:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bqShKxS6OPumliM353UJcWlUqSxEwQQQAxFPiWS2wJ8=;
        b=Xd/EA5PyjaIfe06ByiwNczGUxOKU/pSzGwQPoIQVzHU02uZx+OHdBKRsqEd30H9bkR
         fMecOEAnJgvnJ3ntcybkiwlyYHOzU1bOxvywld5TuDpp6TJ6/JCteZqUdFACFG311iED
         lvNl+Gq5GlagownQs3oEM4Pk6v4rWhWZkPH4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=da1RQjynsswhBvl56la8k+Ta4NOfkVjPoJrJmR9fxaaUO9IR1riWf/5zWCx4f5Ddfh
         UMM81vpnvze5b+44Y0om6faNJ3Pip9Ii36jJlS2FLeAuwEav/AMaHZ5Wpv9OwL1g2HRj
         ixLDAqokOcfsmXFrghUootbfN3vNRcDcN+8CU=
Received: by 10.90.13.31 with SMTP id 31mr11788660agm.82.1294015751851;
        Sun, 02 Jan 2011 16:49:11 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id 72sm11852878yhl.38.2011.01.02.16.49.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 16:49:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101224080505.GA29681@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164430>

Jonathan Nieder wrote:

> [*]
> I am not sure whether this is the right approach for reading from the
> report-fd.  To avoid deadlock, we cannot issue a blocking read(2)
> after the trailing newline has been read from an expected line or the
> nth byte has been read in fixed-length input.

I think this isn't a problem (even though I haven't found any
comforting text in the standards themselves).

To convince myself so, I wrote a couple of new tests.  The change
descriptions explain the reasoning.

These four patches apply on top of

  [PATCH 4/4] vcs-svn: teach line_buffer to handle multiple input files

and are numbered accordingly.  Thoughts welcome, as always.

Jonathan Nieder (4):
  vcs-svn: make test-line-buffer input format more flexible
  tests: give vcs-svn/line_buffer its own test script
  vcs-svn: tweak test-line-buffer to not assume line-oriented input
  t0081 (line-buffer): add buffering test

 t/t0080-vcs-svn.sh     |   54 ---------------
 t/t0081-line-buffer.sh |  174 ++++++++++++++++++++++++++++++++++++++++++++++++
 test-line-buffer.c     |   76 +++++++++++++++------
 3 files changed, 230 insertions(+), 74 deletions(-)
 create mode 100755 t/t0081-line-buffer.sh
