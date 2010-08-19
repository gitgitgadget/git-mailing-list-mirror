From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] mergetool: Skip autoresolved paths
Date: Thu, 19 Aug 2010 12:02:36 +0200
Message-ID: <201008191202.36508.trast@student.ethz.ch>
References: <7veie0gy3r.fsf@alter.siamese.dyndns.org> <1282036966-26799-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Magnus =?iso-8859-1?q?B=E4ck?= <magnus.back@sonyericsson.com>,
	Charles Bailey <charles@hashpling.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 12:03:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om1xr-0000cg-HF
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 12:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab0HSKDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 06:03:01 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:10493 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab0HSKC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 06:02:59 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 19 Aug
 2010 12:03:00 +0200
Received: from thomas.site (129.132.149.163) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 19 Aug
 2010 12:02:37 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1282036966-26799-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153913>

David Aguilar wrote:
> When mergetool is run without path limiters it loops
> over each entry in 'git ls-files -u'.  This includes
> autoresolved paths.
[...]
> +test_expect_success 'mergetool merges all from subdir' '
> +    cd subdir && (
> +    git config rerere.enabled false &&
> +    test_must_fail git merge master &&
> +    git mergetool --no-prompt &&
> +    test "$(cat ../file1)" = "master updated" &&
> +    test "$(cat ../file2)" = "master new" &&
> +    test "$(cat file3)" = "master new sub" &&
> +    git add ../file1 ../file2 file3 &&
> +    git commit -m "branch2 resolved by mergetool from subdir") &&
> +    cd ..
> +'

This test never worked in my automatic testing (it fails and bisects
to this commit).

It might be because the cronjob doesn't have a tty, as I'm seeing the
output below (note the error at the end).  Any insights?

expecting success: 
    cd subdir && (
    git config rerere.enabled false &&
    test_must_fail git merge master &&
    git mergetool --no-prompt &&
    test "$(cat ../file1)" = "master updated" &&
    test "$(cat ../file2)" = "master new" &&
    test "$(cat file3)" = "master new sub" &&
    git add ../file1 ../file2 file3 &&
    git commit -m "branch2 resolved by mergetool from subdir") &&
    cd ..

Merging:
a8bf666 branch1 changes
virtual master
found 1 common ancestor(s):
775c381 added file1
Auto-merging file1
CONFLICT (content): Merge conflict in file1
Auto-merging file2
CONFLICT (add/add): Merge conflict in file2
Auto-merging subdir/file3
CONFLICT (content): Merge conflict in subdir/file3
Automatic merge failed; fix conflicts and then commit the result.
Merging:
file1
file2
subdir/file3

/local/home/trast/git/t/valgrind/bin/git-mergetool: line 302: /dev/tty: No such device
 or address
/local/home/trast/git/t/valgrind/bin/git-mergetool: line 299: /dev/tty: No such device
 or address

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
