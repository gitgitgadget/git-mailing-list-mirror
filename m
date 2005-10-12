From: Morten Welinder <mwelinder@gmail.com>
Subject: Usage of isspace and friends
Date: Tue, 11 Oct 2005 21:40:26 -0400
Message-ID: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 13 05:30:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPtna-0007Nm-JH
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 05:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVJMD35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 23:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVJMD35
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 23:29:57 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:30673 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750825AbVJMD34 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 23:29:56 -0400
Received: by qproxy.gmail.com with SMTP id e12so23074qbe
        for <git@vger.kernel.org>; Wed, 12 Oct 2005 20:29:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AjbhNuflMwUgigds+lslc5WK4bgLWCNAgr0Imv9bEFE1mUGZTwQtOs0GKegYTZZahXmL/59XZRb9WjJVx3hFem0Oic8KNxbRDUQtfdWLhubhNHoPoF/9ciJ49qDXEZU+dgy21k5J3NzkuetwfIO1AgDyvyZSJ41TX7xI6qnS46I=
Received: by 10.65.194.4 with SMTP id w4mr34091qbp;
        Tue, 11 Oct 2005 18:40:26 -0700 (PDT)
Received: by 10.65.107.8 with HTTP; Tue, 11 Oct 2005 18:40:26 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10060>

Someone needs to audit the usage of isspace, tolower, and friends.  There are
things like this in the code:

static int is_dev_null(const char *str)
{
	return !memcmp("/dev/null", str, 9) && isspace(str[9]);
}

Since str[9] is of type char it should not be used as a argument to
isspace directly,
but rather be cast to unsigned char:

    ... isspace((unsigned char)str[9]);

Admittedly that is ugly.  Blame K&R.  (Glibc has a partial workaround for this
kind of coding bug.  On the up side you won't get a crash, but on the down
side you can get the wrong result.)

Morten
