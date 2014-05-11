From: "Storm-Olsen, Marius" <Marius.Storm-Olsen@student.bi.no>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sun, 11 May 2014 01:34:10 +0000
Message-ID: <1399772049733.13154@student.bi.no>
References: <536E2C19.3000202@gmail.com>
 <xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com> <536ECC93.1070102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 03:34:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjIeg-0006YM-Vk
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 03:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805AbaEKBeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 21:34:15 -0400
Received: from mail-db3lp0076.outbound.protection.outlook.com ([213.199.154.76]:11792
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757601AbaEKBeO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2014 21:34:14 -0400
Received: from DBXPR07MB110.eurprd07.prod.outlook.com (10.242.138.148) by
 DBXPR07MB110.eurprd07.prod.outlook.com (10.242.138.148) with Microsoft SMTP
 Server (TLS) id 15.0.939.12; Sun, 11 May 2014 01:34:10 +0000
Received: from DBXPR07MB110.eurprd07.prod.outlook.com ([169.254.6.161]) by
 DBXPR07MB110.eurprd07.prod.outlook.com ([169.254.6.161]) with mapi id
 15.00.0939.000; Sun, 11 May 2014 01:34:10 +0000
Thread-Topic: optimising a push by fetching objects from nearby repos
Thread-Index: AQHPbFVRF04hHlEsxka8y+FpDjZfZZs6TapygABDioD//7Q3AA==
In-Reply-To: <536ECC93.1070102@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DBXPR07MB110.eurprd07.prod.outlook.com
 (15.00.0939.000)
x-originating-ip: [2601:e:a80:455:b9a8:d0db:3cae:ae12]
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009001)(6009001)(428001)(199002)(189002)(377454003)(479174003)(24454002)(51704005)(77982001)(74662001)(36756003)(92566001)(74482001)(92726001)(85852003)(74502001)(31966008)(87936001)(83322001)(83072002)(86362001)(21056001)(20776003)(76482001)(81542001)(46102001)(99396002)(50986999)(4396001)(79102001)(76176999)(80022001)(2656002)(101416001)(64706001)(54356999)(81342001)(3826001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR07MB110;H:DBXPR07MB110.eurprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (: student.bi.no does not designate permitted sender
 hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Marius.Storm-Olsen@student.bi.no; 
Content-ID: <9797BC73C5B1304EA6648C8E9A9D9B15@nbsstd.onmicrosoft.com>
X-OriginatorOrg: student.bi.no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248669>

On 5/10/2014 8:04 PM, Sitaram Chamarty wrote:
> On 05/11/2014 02:32 AM, Junio C Hamano wrote: That's an interesting
> thread and it's recent too.  However, it's about clone (though the
> intro email mentions other commands also).
>
> I'm specifically interested in push efficiency right now.  When you
> "fork" someone's repo to your own space, and you push your fork to
> the same server, it ought to be able to get most of the common
> objects from disk (specifically, from the repo you forked), and only
> what extra you did from the network.
>
...
>
> I do have a way to do this in gitolite (haven't coded it yet; just
> thinking).  Gitolite lets you specify something to do before
> git-*-pack runs, and I was planning something like this:

And here you're poking the stick at the real solution to your problem.

Many of the Git repo managers will neatly set up a server-side repo 
clone for you, with alternates into the original repo saving both 
network and disk I/O.

So your work flow would instead be:
   1. Fork repo on server
   2. Remotely clone your own forked repo

I think it's more appropriate to handle this higher level operation 
within the security context of a git repo manager, rather than directly 
in git.

-- 
.marius
