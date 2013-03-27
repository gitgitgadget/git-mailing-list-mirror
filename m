From: Edward Thomson <ethomson@microsoft.com>
Subject: RE: Rename conflicts in the index
Date: Wed, 27 Mar 2013 17:03:40 +0000
Message-ID: <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
 <7va9q72n1u.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vboa6t14w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:05:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtmi-00007g-HU
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab3C0REo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:04:44 -0400
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:18795
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752737Ab3C0REn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Mar 2013 13:04:43 -0400
Received: from BN1AFFO11FD001.protection.gbl (10.58.52.202) by
 BN1AFFO11HUB024.protection.gbl (10.58.52.134) with Microsoft SMTP Server
 (TLS) id 15.0.651.3; Wed, 27 Mar 2013 17:03:59 +0000
Received: from TK5EX14MLTC104.redmond.corp.microsoft.com (131.107.125.37) by
 BN1AFFO11FD001.mail.protection.outlook.com (10.58.52.61) with Microsoft SMTP
 Server (TLS) id 15.0.651.3 via Frontend Transport; Wed, 27 Mar 2013 17:03:59
 +0000
Received: from TK5EX14MBXC253.redmond.corp.microsoft.com ([169.254.3.151]) by
 TK5EX14MLTC104.redmond.corp.microsoft.com ([157.54.79.159]) with mapi id
 14.02.0318.003; Wed, 27 Mar 2013 17:03:41 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQAI1oifAoxQUOAABEG55gAtP7SQ
In-Reply-To: <7vboa6t14w.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.72]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(24454001)(189002)(199002)(51704002)(31966008)(47736001)(5343635001)(55846006)(56776001)(50986001)(54316002)(47776003)(65816001)(4396001)(54356001)(46102001)(47446002)(51856001)(47976001)(20776003)(46406002)(59766001)(76482001)(49866001)(80022001)(74662001)(79102001)(56816002)(77982001)(53806001)(69226001)(74502001)(23726001)(16406001)(66066001)(33656001)(81342001)(63696002)(50466001);DIR:OUT;SFP:;SCL:1;SRVR:BN1AFFO11HUB024;H:TK5EX14MLTC104.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 0798146F16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219278>

Junio C Hamano [mailto:gitster@pobox.com] wrote:
> Edward Thomson <ethomson@microsoft.com> writes:
> > I would propose that this not simply track rename conflicts, but all
> > conflicts.
> 
> That is a no starter.

So.  Can you explain to me why this would be a non starter?  Can you suggest
some alternate strategy here?

Maybe there's something I'm fundamentally misunderstanding.  It seems that
at present, git will:

1. Detect rename conflicts when performing a merge (at least,
   git-merge-recursive will, which is the default.)

2. If the rename itself caused a conflict (eg, renamed in one side, added in
   the other) then the merge cannot succeed.

3. The resultant index is written as if renames were not detected, which
   means - at best - records the files that went in to the name conflict
   and git status reports an "added in ours" conflict, which is a pretty
   disappointing conflict.  Often, though, many of the files will not
   exist at higher stage entries, since without rename detection, they
   would have not been conflicts.  At worst, one side is staged, there are
   no conflicts in the index and the user can commit (and thus lose the
   other side.)

Thus it's not like we could add some extension that merely records the names
that produced the rename conflicts and point them at the higher stage entries
in the index.  That would require that they actually be in the index.

Thanks-
-ed
