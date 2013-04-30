From: John Keeping <john@keeping.me.uk>
Subject: Re: "git grep" parallelism question
Date: Tue, 30 Apr 2013 09:08:49 +0100
Message-ID: <20130430080848.GP472@serenity.lan>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
 <7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
 <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
 <7vip39w14d.fsf@alter.siamese.dyndns.org>
 <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
 <CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
 <20130429161814.GJ472@serenity.lan>
 <877gjldxid.fsf@hexa.v.cablecom.net>
 <20130429180857.GK472@serenity.lan>
 <7v1u9tgeov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 10:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX5ci-0005La-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 10:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759134Ab3D3IJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 04:09:11 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48762 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757879Ab3D3IJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 04:09:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8B512CDA5D9;
	Tue, 30 Apr 2013 09:09:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvBpjAWVf9W0; Tue, 30 Apr 2013 09:09:00 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 51A0ECDA602;
	Tue, 30 Apr 2013 09:08:51 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v1u9tgeov.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222918>

On Mon, Apr 29, 2013 at 03:22:24PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> > No, I was the one missing something (--root to be precise).  But with
> > TEST_OUTPUT_DIRECTORY you also get the result files in your temporary
> > location, not just the trash directory.
> 
> With your patch, doesn't "tXXXX-*.sh --root $there" automatically
> use the fast $there temporary location as the result depot, too?

No, the current code uses:

    $TEST_OUTPUT_DIRECTORY/$root/trash\ directory.tXXXX

where we don't prepend $TEST_OUTPUT_DIRECTORY/ if $root is absolute.

> If it doesn't with the current code, shouldn't it?

I think the current behaviour is fine and the two options complement
each other.

TEST_OUTPUT_DIRECTORY is something you set once and forget about which
says "all of the test output should go over here", whereas --root is
passed to a specific test and says "put your output here" but does not
affect the result aggregation which is not specific to that test.

Note that setting TEST_OUTPUT_DIRECTORY in config.mak affects all tests
no matter how you run them (via make or as ./tXXXX-yyyy.sh) whereas
setting --root=... in GIT_TEST_OPTS only affect tests run via make.
