From: Karl Wiberg <kha@treskal.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push 
	operations
Date: Mon, 21 Dec 2009 14:48:10 +0100
Message-ID: <b8197bcb0912210548q67c1da4bhe023bed2811394d4@mail.gmail.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>
	 <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
	 <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>
	 <b8197bcb0912191550u300a9c20o351eba66c85292bb@mail.gmail.com>
	 <b0943d9e0912201521k73bdcb5fl333e845028954050@mail.gmail.com>
	 <b8197bcb0912202308p296207av416cd5590a11251b@mail.gmail.com>
	 <b0943d9e0912210348o37b71935x5fad4f1a4be4b70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Gustav_H=C3=A5llberg?= <gustav@virtutech.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 14:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMicU-0005At-OQ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 14:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbZLUNsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 08:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbZLUNsN
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 08:48:13 -0500
Received: from mail1.space2u.com ([62.20.1.135]:63293 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbZLUNsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 08:48:13 -0500
Received: from mail-fx0-f215.google.com (mail-fx0-f215.google.com [209.85.220.215])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nBLDlwnb004938
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Mon, 21 Dec 2009 14:47:58 +0100
Received: by fxm7 with SMTP id 7so4868520fxm.29
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 05:48:10 -0800 (PST)
Received: by 10.102.206.20 with SMTP id d20mr3417566mug.39.1261403290431; Mon, 
	21 Dec 2009 05:48:10 -0800 (PST)
In-Reply-To: <b0943d9e0912210348o37b71935x5fad4f1a4be4b70@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135556>

On Mon, Dec 21, 2009 at 12:48 PM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:

> 2009/12/21 Karl Wiberg <kha@treskal.com>:
>
>> By the way, you do realize there's another command that requires
>> two steps to undo completely: refresh? And that one is harder to
>> get out of---undoing it all in one step would mean throwing away
>> the updates to the patch.
>
> But it looks to me like refresh does this by running separate
> transactions.

Yes. So it won't be affected by whatever you do here. (Unless you
consider that refresh -p needs to reorder patches, which can result in
conflicts---right now, refresh -p can result in three log entries.)

> The push command does this in a single transaction, so the quickest
> fix for the HEAD != top undo problem was to only record one log per
> transaction.

I've seen more than one complaint that the current behavior is
confusing even if we don't count the bug, so I thought this was part
of the motivation.

> If we keep the current behaviour with two logs per transaction, we
> need to preserve the HEAD prior to the conflict so that logging
> doesn't get the wrong HEAD (which is the new conflicting HEAD
> currently). The patch below appears to fix this problem and still
> generate two logs per transaction. While I'm more in favour of a
> single log per transaction, if people find it useful I'm happy to
> keep the current behaviour.

I haven't seen anyone but me defent the current design, and it's not a
big deal for me either, so I'd say go with just one transaction.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
