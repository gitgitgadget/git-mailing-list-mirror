From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/3 v2] git-svn: Fix discarding of extra parents from svn:mergeinfo
Date: Tue, 23 Feb 2010 17:58:04 +0100
Message-ID: <201002231758.05297.trast@student.ethz.ch>
References: <1266825442-32107-4-git-send-email-tuomas.suutari@gmail.com> <1266862373-28365-1-git-send-email-tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Sam Vilain <sam@vilain.net>,
	Eric Wong <normalperson@yhbt.net>
To: Tuomas Suutari <tuomas.suutari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 17:58:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njy5u-0005iU-0g
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 17:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab0BWQ6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 11:58:32 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:29834 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516Ab0BWQ6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 11:58:30 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 17:58:27 +0100
Received: from thomas.localnet (129.132.210.179) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 17:58:06 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <1266862373-28365-1-git-send-email-tuomas.suutari@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140810>

On Monday 22 February 2010 19:12:53 Tuomas Suutari wrote:
> If parent J is an ancestor of parent I, then parent J should be
> discarded, not I.
> 
> Note that J is an ancestor of I if and only if rev-list I..J is emtpy,
> which is what we are testing here.
> 
> Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
> ---
> Thanks to Thomas Rast for pointing out that this can be made with a
> smaller change and there is no need swap rev-list to merge-base after
> all.
[...]
> -					undef($new_parents[$i]);
> +					undef($new_parents[$j]);

Just so this doesn't get lost...

I'm hesitating to give my "Ack", since I haven't looked into what the
surrounding code does.  I can't even see at a glance how the parent
reduction relates to the commit that introduced it, which was

  commit 7a955a5365d9ebd5e12c12ed926b2b51b61c02ee
  Author: Sam Vilain <sam@vilain.net>
  Date:   Sun Dec 20 05:26:26 2009 +1300

      git-svn: detect cherry-picks correctly.

      The old function was incorrect; in some instances it marks a cherry picked
      range as a merged branch (because of an incorrect assumption that
      'rev-list COMMIT --not RANGE' would work).  This is replaced with a
      function which should detect them correctly, memoized to limit the expense
      of dealing with branches with many cherry picks to one 'merge-base' call
      per merge, per branch which used cherry picking.

      Signed-off-by: Sam Vilain <sam@vilain.net>
      Acked-by: Eric Wong <normalperson@yhbt.net>


That being said, you have clearly addressed the points I raised in my
earlier mail.  The loop, taken by itself, now throws out elements of
the $new_parents list that are ancestors of another element which is a
sane thing to do if you're building a merge.

So with the catch that I only looked at the immediate neighbourhood in
the code:

  Acked-by: Thomas Rast <trast@student.ethz.ch>


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
