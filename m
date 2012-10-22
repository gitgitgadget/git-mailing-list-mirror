From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 6/8] longest_ancestor_length(): require prefix list
 entries to be normalized
Date: Mon, 22 Oct 2012 22:04:50 +0200
Message-ID: <5085A6E2.3060807@kdbg.org>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu> <1350799057-13846-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 22 22:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQOFc-0007xd-QE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 22:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab2JVUFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 16:05:14 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:15845 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750798Ab2JVUFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 16:05:13 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id F15D8CE008
	for <git@vger.kernel.org>; Mon, 22 Oct 2012 22:05:11 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7FC822C4002;
	Mon, 22 Oct 2012 22:04:52 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 246EF19F391;
	Mon, 22 Oct 2012 22:04:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1350799057-13846-7-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208201>

Am 21.10.2012 07:57, schrieb Michael Haggerty:
> Move the responsibility for normalizing the prefixes passed to
> longest_ancestor_length() to its caller.  In t0060, only test
> longest_ancestor_lengths using normalized paths: remove empty entries
> and non-absolute paths, strip trailing slashes from the paths, and
> remove tests that thereby become redundant.

t0060 does not pass on Windows with this change. Bash's path mangling
strikes again, but the real reason for the failure is that
test-path-util does not normalize its input before it calls into
longest_ancestor_length(). It is not sufficient to reduce the test cases
to normalized ones, because due to path mangling on Windows they are
turned into unnormalized paths (with backslashes instead of forward
slashes).

I suggest to export the new normalize_ceiling_entry() and use it from
test-path-util. Then don't change or remove existing tests.

-- Hannes
