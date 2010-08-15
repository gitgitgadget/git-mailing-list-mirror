From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Confused about "degenerate" combined diff for merge commits
Date: Sun, 15 Aug 2010 21:54:57 +0200
Message-ID: <201008152154.57578.trast@student.ethz.ch>
References: <1jna5yt.1pm42a3uw2yquM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Aug 15 21:55:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkjIS-0002LF-JE
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 21:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab0HOTzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 15:55:01 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:2168 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab0HOTzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 15:55:00 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 15 Aug
 2010 21:54:59 +0200
Received: from thomas.site (217.162.250.31) by cas10.d.ethz.ch (172.31.38.210)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 15 Aug 2010 21:54:59
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1jna5yt.1pm42a3uw2yquM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153618>

Stefan Haller wrote:
> However, for some of these merge commits I see diff output such as this:
> 
> diff --cc Src/ClipBoard.cpp
> index 4357ea0,4357ea0..3fad79a
> --- a/Src/ClipBoard.cpp
> +++ b/Src/ClipBoard.cpp
> @@@ -71,7 -71,7 +71,7 @@@ AClipBoard* AClipBoard::SNew(
>   
>   AClipBoard* AClipBoard::SClipBoard()
>   {
> --  static AClipBoard* spClipBoard = SNew();
> ++  static TPtr<AClipBoard> spClipBoard = SNew();
>     return spClipBoard;
>   }
>   
> It looks like both merge parents had an identical diff here, so this is
> not a conflict; why does diff --cc even show this to me?

The --cc output has one column per parent, and if you removed all
other +/-/space columns, then (for that hunk) you'd have a unified
diff with that parent.

So I'd say the above means that both parents had

  static AClipBoard* spClipBoard = SNew();

but your merge result was

  static TPtr<AClipBoard> spClipBoard = SNew();

This is usually called an "evil merge" in git terms: it is introducing
changes that are neither coming from one side, nor part of a benign
merge resolution.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
