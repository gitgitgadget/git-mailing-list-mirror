From: Edward Thomson <ethomson@microsoft.com>
Subject: RE: Rename conflicts in the index
Date: Tue, 26 Mar 2013 20:40:37 +0000
Message-ID: <A54CE3E330039942B33B670D971F857403A0AC1E@TK5EX14MBXC253.redmond.corp.microsoft.com>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
 <7va9q72n1u.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vboa6t14w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:41:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKagg-0000JT-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab3CZUlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:41:14 -0400
Received: from mail-bl2lp0212.outbound.protection.outlook.com ([207.46.163.212]:14709
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754143Ab3CZUlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Mar 2013 16:41:14 -0400
Received: from BL2FFO11FD018.protection.gbl (10.1.15.202) by
 BY2FFO11HUB002.protection.gbl (10.1.14.144) with Microsoft SMTP Server (TLS)
 id 15.0.651.3; Tue, 26 Mar 2013 20:40:53 +0000
Received: from TK5EX14MLTC104.redmond.corp.microsoft.com (131.107.125.37) by
 BL2FFO11FD018.mail.protection.outlook.com (10.173.161.36) with Microsoft SMTP
 Server (TLS) id 15.0.651.3 via Frontend Transport; Tue, 26 Mar 2013 20:40:52
 +0000
Received: from TK5EX14MBXC253.redmond.corp.microsoft.com ([169.254.3.151]) by
 TK5EX14MLTC104.redmond.corp.microsoft.com ([157.54.79.159]) with mapi id
 14.02.0318.003; Tue, 26 Mar 2013 20:40:37 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQAI1oifAoxQUOAABEG55gACjazQ
In-Reply-To: <7vboa6t14w.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.35]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(189002)(199002)(24454001)(52314002)(52034002)(51704002)(54356001)(50986001)(53806001)(56776001)(56816002)(20776003)(5343635001)(47976001)(55846006)(63696002)(47776003)(54316002)(69226001)(46102001)(33656001)(59766001)(76482001)(80022001)(4396001)(44976002)(79102001)(66066001)(77982001)(65816001)(47736001)(74502001)(49866001)(31966008)(16406001)(47446002)(23726001)(46406002)(74662001)(51856001)(50466001);DIR:OUT;SFP:;SCL:1;SRVR:BY2FFO11HUB002;H:TK5EX14MLTC104.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 079756C6B9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219204>


Junio C Hamano [mailto:gitster@pobox.com] wrote:
> Edward Thomson <ethomson@microsoft.com> writes:
> > I would propose a new extension, 'CONF', to handle conflict data,
> > differing from the stage >0 entries in the index in that this
> > extension tracks the conflicting file across names if the underlying
> > merge engine has support for renames.
> >
> > I made an attempt to keep the entry data similar to other entries in
> > the index.  I would propose that entries in the conflict are as follows:
> >
> > Flags
> >   Four octets that describe the conflict.  Data includes:
> >
> >   0x01  HAS_ANCESTOR
> >     There is a file in the common ancestor branch that contributes
> >     to this conflict.  Its data will follow.
> >   0x02  HAS_OURS
> >     There is a file in "our" branch that contributes to this conflict.
> >     Its data will follow.
> >   0x04  HAS_THEIRS
> >     There is a file in "their" branch that contributes to this conflict.
> >     Its data will follow.
> >
> >   0x08  NAME_CONFLICT_OURS
> >     This item has a path in "our" branch that overlaps a different
> >     item in "their" branch.  (Eg, this conflict represents the "our"
> >     side of a rename/add conflict.)
> >   0x10  NAME_CONFLICT_THEIRS
> >     This item has a path in "their" branch that overlaps a different
> >     item in "our" branch.  (Eg, this conflict represents the "theirs"
> >     side of a rename/add conflict.)
> >
> >   0x20  DF_CONFLICT_FILE
> >     This is the file involved in a directory/file conflict.
> >   0x40  DF_CONFLICT_CHILD
> >     This is a child of a directory involved in a directory/file conflict.
> >
> >   Other bits are reserved.
> >
> > Conflict Sides
> >   The data about one side of a conflict will contain:
> >   mode (ASCII string representation of octal, null-terminated)
> >   path (null terminated)
> >   sha1 (raw bytes)
> >
> > The conflict sides will be written in this order:
> >   Ancestor (if HAS_ANCESTOR is set)
> >   Ours (if HAS_OURS is set)
> >   Theirs (if HAS_THEIRS is set)
> 
> Puzzled.  Most of the above, except NAME_CONFLICT_{OURS,THEIRS} bits, look
> totally pointless duplication.

Obviously HAS_ANCESTOR / HAS_OURS / HAS_THEIRS is to indicate to a reader
whether there is data to be read or not.  Similar to how a mode of 0
in the REUC indicates that the rest of the record should not be read.)

> When you are working with Git, you have to be prepared to read from the
> datafile like the index that other people (and your previous
> version) created, and you also have to make sure you do not make what you
> write out unusable by other people without a good reason.

I'm acutely aware that you need to be able to read an index that other
people created - that's the problem at hand.  git does not produce an
index that allows anyone (including itself) to reason about rename
conflicts.  It doesn't even bother to write high-stage conflict entries
in many instances, so you can have an instance where git tells you that
a conflict occurred but one of those files is staged anyway, the other
is just dirty in the workdir and you can commit immediately thereafter.

While obviously it's possible to handle this situation (is file A
in conflict?  Look in the rename conflict extension.  Not there?  Okay,
look in the index.)  That's not exactly elegant.  My goal here was
to have a single source for conflicts.

> (by the way "CONF" sounds as if it is some sort of configuration data).

There's only four letters, and not everything's as easy as "TREE".  REUC,
for example, sounds like a donkey, though I suppose it depends on the
language in question.

-ed
