From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead of
 'submit'.
Date: Mon, 17 Oct 2011 15:37:31 -0700 (PDT)
Message-ID: <1987300386.27372.1318891051633.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <20111017223202.GA1834@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Warkentin <andreiw@vmware.com>,
	Tor Arvid Lund <torarvid@gmail.com>,
	Luke Diamand <luke@diamand.org>, gitster@pobox.com
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvoP-00031H-JG
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330Ab1JQWhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:37:32 -0400
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:26580 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753917Ab1JQWhc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 18:37:32 -0400
Received: from mailhost4.vmware.com (mailhost4.vmware.com [10.16.67.124])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id F16B41A003;
	Mon, 17 Oct 2011 15:37:31 -0700 (PDT)
Received: from zimbra-prod-mta-3.vmware.com (zimbra-prod-mta-3.vmware.com [10.113.160.227])
	by mailhost4.vmware.com (Postfix) with ESMTP id E6816CA0D1;
	Mon, 17 Oct 2011 15:37:31 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-prod-mta-3.vmware.com (Postfix) with ESMTP id D50F1F9E08;
	Mon, 17 Oct 2011 15:37:31 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from zimbra-prod-mta-3.vmware.com ([127.0.0.1])
	by localhost (zimbra-prod-mta-3.vmware.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N8DTspKmJNp2; Mon, 17 Oct 2011 15:37:31 -0700 (PDT)
Received: from zimbra-prod-mbox-2.vmware.com (zimbra-prod-mbox-2.vmware.com [10.113.160.202])
	by zimbra-prod-mta-3.vmware.com (Postfix) with ESMTP id B7A96F9E06;
	Mon, 17 Oct 2011 15:37:31 -0700 (PDT)
In-Reply-To: <20111017223202.GA1834@arf.padd.com>
X-Originating-IP: [10.113.61.163]
X-Mailer: Zimbra 7.1.1_GA_3225 (ZimbraWebClient - FF3.0 (Linux)/7.1.1_GA_3225)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183838>

Hi,

----- Original Message -----
> From: "Pete Wyckoff" <pw@padd.com>
> To: "Andrei Warkentin" <awarkentin@vmware.com>
> Cc: git@vger.kernel.org, "Andrei Warkentin" <andreiw@vmware.com>, "Tor Arvid Lund" <torarvid@gmail.com>, "Luke
> Diamand" <luke@diamand.org>, gitster@pobox.com
> Sent: Monday, October 17, 2011 6:32:02 PM
> Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead of 'submit'.
> 
> Git can have multiple commits outstanding that touch the same
> file, but p4 cannot really have multiple pending changes in the
> same workspace that touch the same file.
> 
> If you call "git-p4 change", it would build a p4 change for each
> of those commits.  If the commits happen to touch the same file,
> the changes get rearranged as far as p4 is concerned so that all
> changes to a given file are lumped in the first change that sees
> the file.  This is highly counterintuitive from a git mindset.
> 
> The most restrictive implementation would have to:
> 
>     1.  ensure no pending changes in the P4 clientPath
>     2.  ensure number of commits ("git rev-list") is 1
> 
> You could be more permissive, allowing multiple pending changes
> if the file sets do not conflict.  In that case, the first test
> would look at the files in pending changes and allow the
> operation if they did not intersect with files in origin..master.
> The second would make sure that each file appears in no more than
> 1 commit in origin..master.

Hmmm...I see. I'll think some more about it, then!

> 
> Also make sure this works with preserveUser.  Not sure if an
> unsubmitted change can be handled the same way.
> 
> Because it feels like a delicate operation that could have big
> negative consequences, this needs a few unit tests.
> 
> For the code structure, I'd like to see a proper subclass instead
> of the dictionary idea.  Something like, e.g.:
> 
> class P4Submit(...):
>     def __init__(self, change_only=0)
> 	...
> 	self.change_only = change_only
> 
> class P4Change(P4Submit):
>     def __init__(self):
> 	P4Submit.__init__(self, change_only=1)
> 
> Sorry this is looking so difficult now.

No problem!

A
