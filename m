From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 31/31] rebase -i: remove unnecessary state rebase-root
Date: Tue, 28 Dec 2010 17:40:52 +0100
Message-ID: <201012281740.52374.trast@student.ethz.ch>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-32-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 17:41:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXcbi-0007u2-3Z
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 17:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab0L1Qk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 11:40:56 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16281 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263Ab0L1Qkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 11:40:55 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 28 Dec
 2010 17:40:47 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 28 Dec
 2010 17:40:53 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1293528648-21873-32-git-send-email-martin.von.zweigbergk@gmail.com>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164274>

Martin von Zweigbergk wrote:
> @@ -168,11 +168,6 @@ pick_one () {
>  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
>  	test -d "$REWRITTEN" &&
>  		pick_one_preserving_merges "$@" && return
> -	if test -n "$rebase_root"
> -	then
> -		output git cherry-pick "$@"
> -		return
> -	fi
>  	output git cherry-pick $ff "$@"
>  }
[...]
> While factoring out the state writing code a few patches back, I went
> through each of the pieces of state that was written. I was a bit
> hesitant to include this patch since I'm not quite sure why the code
> was introduced, but I thought I would include it anyway to hear what
> you have to say.
> 
> There used to be bug when using --ff when rebasing a root commit. This
> was fixed in 6355e50 (builtin/revert.c: don't dereference a NULL
> pointer, 2010-09-27). Could this have been the reason for the check?
> Thomas, do you remember?

I think this just ended up being such a strange test because of the
following hunk in 8e75abf (rebase -i: use new --ff cherry-pick option,
2010-03-06):

@@ -232,16 +232,7 @@ pick_one () {
                output git cherry-pick "$@"
                return
        fi
-       parent_sha1=$(git rev-parse --verify $sha1^) ||
-               die "Could not get the parent of $sha1"
-       current_sha1=$(git rev-parse --verify HEAD)
-       if test -z "$no_ff" && test "$current_sha1" = "$parent_sha1"
-       then
-               output git reset --hard $sha1
-               output warn Fast-forward to $(git rev-parse --short $sha1)
-       else
-               output git cherry-pick "$@"
-       fi
+       output git cherry-pick $ff "$@"
 }
-- 
Thomas Rast
trast@{inf,student}.ethz.ch
