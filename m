From: Edward Thomson <ethomson@microsoft.com>
Subject: RE: Rename conflicts in the index
Date: Wed, 27 Mar 2013 18:53:07 +0000
Message-ID: <A54CE3E330039942B33B670D971F857403A0BB93@TK5EX14MBXC253.redmond.corp.microsoft.com>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
 <7va9q72n1u.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vboa6t14w.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vk3osn3vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:54:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvTq-0004A1-KT
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab3C0SxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:53:22 -0400
Received: from mail-by2lp0236.outbound.protection.outlook.com ([207.46.163.236]:37346
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752863Ab3C0SxW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Mar 2013 14:53:22 -0400
Received: from BY2FFO11FD003.protection.gbl (10.173.161.203) by
 BL2FFO11HUB011.protection.gbl (10.173.161.117) with Microsoft SMTP Server
 (TLS) id 15.0.651.3; Wed, 27 Mar 2013 18:53:19 +0000
Received: from TK5EX14MLTC102.redmond.corp.microsoft.com (131.107.125.37) by
 BY2FFO11FD003.mail.protection.outlook.com (10.1.14.125) with Microsoft SMTP
 Server (TLS) id 15.0.651.3 via Frontend Transport; Wed, 27 Mar 2013 18:53:19
 +0000
Received: from TK5EX14MBXC253.redmond.corp.microsoft.com ([169.254.3.151]) by
 TK5EX14MLTC102.redmond.corp.microsoft.com ([157.54.79.180]) with mapi id
 14.02.0318.003; Wed, 27 Mar 2013 18:53:08 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQAI1oifAoxQUOAABEG55gAtP7SQAAEvx18AAmt9kA==
In-Reply-To: <7vk3osn3vs.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.72]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(189002)(24454001)(199002)(53806001)(74662001)(46406002)(79102001)(65816001)(55846006)(44976002)(74502001)(31966008)(80022001)(46102001)(81342001)(51856001)(23726001)(16406001)(47446002)(66066001)(54356001)(49866001)(76482001)(69226001)(47736001)(56816002)(47776003)(50466001)(63696002)(56776001)(59766001)(33656001)(54316002)(20776003)(77982001)(50986001)(4396001)(47976001);DIR:OUT;SFP:;SCL:1;SRVR:BL2FFO11HUB011;H:TK5EX14MLTC102.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 0798146F16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219304>

Junio C Hamano [mailto:gitster@pobox.com] wrote:
> We do not gratuitously break existing implementations.  If no conflict is stored
> as higher-stage index entries in an index that has your index extension, no
> existing implementation can read a conflicted index written by your
> implementation and have users resolve conflicts.

I'm not suggesting that anybody stop writing >0 stage entries.

> When a path originally at A is moved to B on only one branch, and there are
> content-level conflicts between the changes made by one branch (while going
> from A to B) and by the other branch (while keeping it at A), we would end up
> having three stages for path B without any trace of path A.  I do not offhand
> know how much it helps to learn A in such a situation in the real life, but we are
> indeed losing information, and I do not have any problem with an extension that
> records in the index the fact that in the two (of the
> three) commits involved in the merge, the path was at A.

What you've described is true only for a certain class of rename conflicts,
for example the rename/edit conflict you've described above.

It's also true if you were to rename some item 'a' to 'b' in both branches.
But when 'b' is sufficiently dissimilar to become a rewrite, then I end up
with a rename of a->b on one side and deleting a and adding b on the other.
The result is a mysterious "added by us" conflict:

100644 e2dd530c9f31550a2b0c90773ccde056929d6d66 2       b

Worse yet is if I don't do the rename in my side, but I just add a new b so
that in theirs I've renamed a to b and in mine I have both a and b.  When I
do the merge, I'm told I have conflicts, except that I don't:

100644 08d4f831774aed5d4c6cb496affefd4020dce40c 0       b

The other branch's b is long gone and exists only as a dirty file in the
workdir.

> But people have been successfully using existing versions of Git without that
> information to merge branches with renames, and resolving the content-level
> conflicts.

But you aren't afforded the option to resolve content-level conflicts if you
don't know where the conflict came from.  For example, in a rename 1->2
conflict, we dutifully detect that a was renamed to both b and c and fail,
but that fact is never given to the index.  This conflict could be fed into
a merge tool or, better, automerged, with the user only needing to pick a
path:

100644 421c9102b8562ad227ba773ab1cf6bbed7b7496d 1       a
100644 421c9102b8562ad227ba773ab1cf6bbed7b7496d 3       b
100644 421c9102b8562ad227ba773ab1cf6bbed7b7496d 2       c

I hate to sound like a broken record here, but without some more data in the
index - anywhere, really - any tool that doesn't have the luxury of emitting
data about what happened to stdout certainly can't infer anything about what
happened in the merge.

-ed
