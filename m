From: Christoph Mallon <mallon@cs.uni-saarland.de>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Mon, 01 Dec 2014 23:30:00 +0100
Message-ID: <547CEBE8.8070301@cs.uni-saarland.de>
References: <547C8610.8080301@cs.uni-saarland.de> <547C9088.7000800@cs.uni-saarland.de> <CAGZ79kaLaWK57m9_1aFOkSubECUvFcEvGjid8EuUmYNUO5Z5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 23:30:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvZTy-0004nm-CG
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 23:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbaLAWaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 17:30:08 -0500
Received: from triton.rz.uni-saarland.de ([134.96.7.25]:15096 "EHLO
	triton.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbaLAWaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 17:30:07 -0500
Received: from [192.168.2.100] (p549CD20E.dip0.t-ipconnect.de [84.156.210.14])
	(authenticated bits=0)
	by triton.rz.uni-saarland.de (8.14.1/8.14.0) with ESMTP id sB1MTxvb015178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Dec 2014 23:30:00 +0100
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.98.5 at HIZ-Mailrelay triton.rz.uni-saarland.de
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.5; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <CAGZ79kaLaWK57m9_1aFOkSubECUvFcEvGjid8EuUmYNUO5Z5jw@mail.gmail.com>
X-Enigmail-Version: 1.4
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (triton.rz.uni-saarland.de [134.96.7.25]); Mon, 01 Dec 2014 23:30:00 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260514>

Am 01.12.14 19:53, schrieb Stefan Beller:
> So I am running a 3.13.0-40-generic x86_64 linux (so its's amd64) and
> git version 2.1.2
> and I cannot reproduce the bug you are describing. :(

):

I can reproduce it with
* OS X, i386 binary, git 2.2.0
* FreeBSD, amd64, git 2.1.0 and up (bisected it there)
* FreeBSD, amd64, git 2.1.2 (different machine)

I cannot reproduce it with
* Linux, amd64, git 2.1.0

> $ git rev-parse 'master@{52}'
> 0000000000000000000000000000000000000035

On a machine, where you see the bug, you get entry /0...036/.
This btw causes havoc:
git stash list shows all entries, but e.g. git stash drop drops the
wrong stash after @{52}.

> What I noticed though is there are 2 linefeeds at the end of each
> line, is that intended or did it break during transmission?

That broke.
It should be a normal reflog file.
Try this:
	http://tron.yamagi.org/zeug/reflog.bad

Still 4207ed285f31ad3e04f08254237c0c1a1609642b seems a plausible cause,
because it's about reflogs.
Though I suspect the actual bug was introduced before, because this
commit only uses machinery, which was added earlier.

	Christoph
