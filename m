From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 18:44:35 +0200
Message-ID: <87bo7sbeoc.fsf@linux-k42r.v.cablecom.net>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 18:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui5xy-00005Y-A2
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 18:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025Ab3E3Qoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 12:44:39 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:59204 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964828Ab3E3Qoh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 12:44:37 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 18:44:34 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 30 May 2013 18:44:35 +0200
In-Reply-To: <87ip20bfq4.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 30 May 2013 18:21:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226022>

Thomas Rast <trast@inf.ethz.ch> writes:

> I had a brief look around sha1_file.c, in particular sha1_object_info,
> and it turns out we lack the "deflate only early part" logic as I
> suspected.  So that'll have to be fixed first.  After that I *think* it
> should automatically carry over into the tag readers.

Strike that, I'm wrong.  sha1_object_info is fast even for these big
loose objects.

The culprit, according to some callgrind investigation, is
lookup_commit_reference_gently() [for the unannotated case] or
deref_tag() [annotated case] calling parse_object().

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
