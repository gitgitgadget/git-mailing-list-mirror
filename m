From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase -i: avoid --cherry-pick when rebasing to a direct ancestor
Date: Sat, 20 Feb 2010 14:38:29 +0100
Message-ID: <201002201438.29635.trast@student.ethz.ch>
References: <dfb660301002191324i7aeca7f5x990501bbca1475a9@mail.gmail.com> <201002200102.15777.trast@student.ethz.ch> <20100220072728.GA12168@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Laine Walker-Avina <lwalkera@pasco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 14:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NipXg-0006S7-3Z
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 14:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690Ab0BTNic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 08:38:32 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:48702 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab0BTNic (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 08:38:32 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 14:38:30 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 14:38:29 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <20100220072728.GA12168@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140528>

On Saturday 20 February 2010 08:27:28 Jeff King wrote:
> But it is probably the source of the slowness to xdiff that
> gigantic files.

BTW, here's a weird data point:

$ ls -l a b
-rw-r--r-- 1 thomas users 3300765 2010-02-20 12:48 a
-rw-r--r-- 1 thomas users 3253762 2010-02-20 12:48 b
$ time diff -u a b | wc -l
54530

real    0m0.644s
user    0m0.562s
sys     0m0.044s
$ time git diff --no-index a b >/dev/null

real    0m22.848s
user    0m21.956s
sys     0m0.137s
$ time git diff --no-index --patience a b >/dev/null

real    0m19.508s
user    0m18.673s
sys     0m0.273s

'a' and 'b' are two pnm's as per the OPs specification, I made 'a' a
gradient and 'b' the same with two crosses drawn over it.  You can
find them at

  http://thomasrast.ch/download/slow-diff-pnms.zip

if you want to reproduce.

So what on earth does 'diff' do that makes it 35 times as fast?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
