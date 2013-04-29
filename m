From: John Keeping <john@keeping.me.uk>
Subject: Re: "git grep" parallelism question
Date: Mon, 29 Apr 2013 17:18:14 +0100
Message-ID: <20130429161814.GJ472@serenity.lan>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
 <7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
 <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
 <7vip39w14d.fsf@alter.siamese.dyndns.org>
 <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
 <CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:18:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWqml-0001cp-G2
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832Ab3D2QSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:18:31 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52674 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031Ab3D2QS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:18:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C5A98CDA5D1;
	Mon, 29 Apr 2013 17:18:28 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sdZM0YwllxFH; Mon, 29 Apr 2013 17:18:27 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 6CFCECDA5CC;
	Mon, 29 Apr 2013 17:18:24 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5FED9161E266;
	Mon, 29 Apr 2013 17:18:24 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vryn5tZY1bwm; Mon, 29 Apr 2013 17:18:23 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 11838161E0B3;
	Mon, 29 Apr 2013 17:18:16 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222807>

On Mon, Apr 29, 2013 at 07:35:01PM +0530, Ramkumar Ramachandra wrote:
> On a related note, one place that IO parallelism can provide massive
> benefits is in executing shell scripts.  Accordingly, I always use the
> following commands to compile and test git respectively:
> 
>     make -j 8 CFLAGS="-g -O0 -Wall"
>     make -j 8 DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="-j 16" test
> 
> i.e. always use 8 threads when the task is known to be CPU intensive,
> and always use 16 threads when the task is known to be IO intensive.

On this tangent, I recently added a TEST_OUTPUT_DIRECTORY line to my
config.mak which points into a tmpfs mount.  Keeping all of the test
repositories in RAM makes the tests significantly faster for me and
works nicely when you have the patches in jk/test-output (without those
patches the individual tests work but the reporting of aggregate results
doesn't).
