From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead of
 'submit'.
Date: Fri, 14 Oct 2011 15:55:57 -0700 (PDT)
Message-ID: <811639890.180572.1318632957147.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <CA+DMoH-HqA0DCyUSttO-iYO0rUHq1nLqM9W0imAOjHC5H1r_9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Andrei Warkentin <andreiw@vmware.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 00:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REqfa-0001NK-4j
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 00:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab1JNWz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 18:55:58 -0400
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:53355 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752572Ab1JNWz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 18:55:57 -0400
Received: from mailhost3.vmware.com (mailhost3.vmware.com [10.16.27.45])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id 6F67D1F00B;
	Fri, 14 Oct 2011 15:55:57 -0700 (PDT)
Received: from zimbra-prod-mta-3.vmware.com (zimbra-prod-mta-3.vmware.com [10.113.160.227])
	by mailhost3.vmware.com (Postfix) with ESMTP id 67D14CD9B3;
	Fri, 14 Oct 2011 15:55:57 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-prod-mta-3.vmware.com (Postfix) with ESMTP id 5B9FBF3409;
	Fri, 14 Oct 2011 15:55:57 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from zimbra-prod-mta-3.vmware.com ([127.0.0.1])
	by localhost (zimbra-prod-mta-3.vmware.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hwKvAoUMI47G; Fri, 14 Oct 2011 15:55:57 -0700 (PDT)
Received: from zimbra-prod-mbox-2.vmware.com (zimbra-prod-mbox-2.vmware.com [10.113.160.202])
	by zimbra-prod-mta-3.vmware.com (Postfix) with ESMTP id 400BEF3408;
	Fri, 14 Oct 2011 15:55:57 -0700 (PDT)
In-Reply-To: <CA+DMoH-HqA0DCyUSttO-iYO0rUHq1nLqM9W0imAOjHC5H1r_9w@mail.gmail.com>
X-Originating-IP: [10.113.61.163]
X-Mailer: Zimbra 7.1.1_GA_3225 (ZimbraWebClient - FF3.0 (Linux)/7.1.1_GA_3225)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183628>

Hi Tor,

Thanks for the review!

----- Original Message -----
> Just out of curiosity... what is 'sd'?
> 

SourceDepot, a p4 fork that is used elsewhere, not by me though ;).

> > This new config option lets a 'p4 change -i' run instead of
> > the 'p4 submit -i'.
> 
> Well... I have to say that I'm not crazy about this patch... I don't
> think it is very elegant to have a config flag that says that "when
> the user says 'git p4 submit', then don't submit, but do something
> else instead".
> 
> I would much rather have made a patch to introduce some new command
> like 'git p4 change'.
> 

Agreed, how about something like this?

The commands dict maps command name to class and optional dict passed to cmd.run(). That way 'change'
can really mean P4Submit with an extra parameter not to submit but to do a changelist instead. The
reason why I initially made the config flag was because I didn't want to copy-paste P4Submit into P4Change.

commands = {
    "debug" : [ P4Debug, {} ]
    "submit" : [ P4Submit, { "doChange" : 0 } ]
    "commit" : [ P4Submit, { "doChange" : 0 } ]
    "change" : [ P4Submit, { "doChange" : 1 } ]
    "sync" : [ P4Sync, {} ],
    "rebase" : [ P4Rebase, {} ],
    "clone" : [ P4Clone, {} ],
    "rollback" : [ P4RollBack, {} ],
    "branches" : [ P4Branches, {} ]
}

A
