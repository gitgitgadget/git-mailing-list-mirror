From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 11:14:19 +0100
Message-ID: <201002181114.19984.trast@student.ethz.ch>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 11:14:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni3PL-0001L9-BU
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 11:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274Ab0BRKOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 05:14:49 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:50373 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992Ab0BRKOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 05:14:48 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 18 Feb
 2010 11:14:45 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 18 Feb
 2010 11:14:24 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140313>

On Thursday 18 February 2010 02:16:23 Junio C Hamano wrote:
> When creating a loose object, we normally mmap(2) the entire file, and
> hash and then compress to write it out in two separate steps for
> efficiency.
> 
> This is perfectly good for the intended use of git---nobody is supposed to
> be insane enough to expect that it won't break anything to muck with the
> contents of a file after telling git to index it and before getting the
> control back from git.

This makes it sound as if the user is to blame, but IMHO we're just
not checking the input well enough.  The user should never be able to
corrupt the repository (without git noticing!) just by running a git
command and manipulating the worktree in parallel.  The file data at
any given time is just user input, and you also cannot (I hope;
otherwise let's fix it!) corrupt the repository merely by typoing some
command arguments.

(Mucking around in .git is an entirely different matter, but that is
off limits.)

> This teaches the index_mem() codepath to be paranoid and hash and compress
> the data after reading it in core.  The contents hashed may not match the
> contents of the file in an insane use case, but at least this way the
> result will be internally consistent.

Doesn't that trigger on windows, where xmmap() already makes a copy?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
