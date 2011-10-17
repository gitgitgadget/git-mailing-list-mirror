From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead of
 'submit'.
Date: Mon, 17 Oct 2011 09:18:39 -0700 (PDT)
Message-ID: <83923897.7841.1318868319131.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <4E99E8D2.6020107@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Pete Wyckoff <pw@padd.com>,
	Andrei Warkentin <andreiw@vmware.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Oct 17 18:18:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFptk-0008UD-R8
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 18:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab1JQQSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 12:18:40 -0400
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:19350 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752614Ab1JQQSk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 12:18:40 -0400
Received: from mailhost4.vmware.com (mailhost4.vmware.com [10.16.67.124])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id 889984B002;
	Mon, 17 Oct 2011 09:18:39 -0700 (PDT)
Received: from zimbra-prod-mta-2.vmware.com (zimbra-prod-mta-2.vmware.com [10.113.160.174])
	by mailhost4.vmware.com (Postfix) with ESMTP id 806B5CA00E;
	Mon, 17 Oct 2011 09:18:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-prod-mta-2.vmware.com (Postfix) with ESMTP id 69FD531C6B;
	Mon, 17 Oct 2011 09:18:39 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from zimbra-prod-mta-2.vmware.com ([127.0.0.1])
	by localhost (zimbra-prod-mta-2.vmware.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ee1AgBgCpBtO; Mon, 17 Oct 2011 09:18:39 -0700 (PDT)
Received: from zimbra-prod-mbox-2.vmware.com (zimbra-prod-mbox-2.vmware.com [10.113.160.202])
	by zimbra-prod-mta-2.vmware.com (Postfix) with ESMTP id 39A1731725;
	Mon, 17 Oct 2011 09:18:39 -0700 (PDT)
In-Reply-To: <4E99E8D2.6020107@diamand.org>
X-Originating-IP: [10.113.61.163]
X-Mailer: Zimbra 7.1.1_GA_3225 (ZimbraWebClient - FF3.0 (Linux)/7.1.1_GA_3225)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183797>

Hi,

----- Original Message -----
> From: "Luke Diamand" <luke@diamand.org>
> To: "Andrei Warkentin" <andreiw@vmware.com>
> Cc: git@vger.kernel.org, gitster@pobox.com, "Pete Wyckoff" <pw@padd.com>
> Sent: Saturday, October 15, 2011 4:10:58 PM
> Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead of 'submit'.
> 
> On 14/10/11 22:51, Andrei Warkentin wrote:
> > Many users of p4/sd use changelists for review, regression
> > tests and batch builds, thus changes are almost never directly
> > submitted.
> >
> > This new config option lets a 'p4 change -i' run instead of
> > the 'p4 submit -i'.
> >
> > Signed-off-by: Andrei Warkentin<andreiw@vmware.com>
> > ---
> >   contrib/fast-import/git-p4     |   16 ++++++++++++----
> >   contrib/fast-import/git-p4.txt |   10 ++++++++++
> >   2 files changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/contrib/fast-import/git-p4
> > b/contrib/fast-import/git-p4
> > index 2f7b270..19c295b 100755
> > --- a/contrib/fast-import/git-p4
> > +++ b/contrib/fast-import/git-p4
> > @@ -959,7 +959,10 @@ class P4Submit(Command, P4UserMap):
> >                   submitTemplate =
> >                   message[:message.index(separatorLine)]
> >                   if self.isWindows:
> >                       submitTemplate =
> >                       submitTemplate.replace("\r\n", "\n")
> > -                p4_write_pipe("submit -i", submitTemplate)
> > +                if gitConfig("git-p4.changeOnSubmit"):
> > +                    p4_write_pipe("change -i", submitTemplate)
> > +                else:
> > +                    p4_write_pipe("subadasdmit -i",
> > submitTemplate)
> 
> 
> What does "p4 subadasmit" do? That's a new command to me!
> 

Ack, that's emabarrasing. How did that get there :-)?

Anyway, the other suggestion I had was to create a new command
instead of overriding behaviour of an existing one. Of course,
copy-pasting P4Submit into P4Change is silly, so...

How about something like this?

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

Thanks for the review,
A
