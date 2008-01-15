From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Print Precedes/Follows in git log
Date: Tue, 15 Jan 2008 07:38:49 +0100
Message-ID: <e5bfff550801142238h3746841asb8c37110d49908cb@mail.gmail.com>
References: <Pine.LNX.4.64.0801150031480.2315@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Engelhardt" <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 07:39:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEfSC-0007QN-JD
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 07:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbYAOGix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 01:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYAOGiw
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 01:38:52 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:24540 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYAOGiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 01:38:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1998724rvb.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 22:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SYZGRLbG49C2CUl9Q870jXucciGmcwFKO0ClzuIcJIE=;
        b=WDygm4JIcO+d6ut6nADArXAEbRkaWTzNod1rEAaBOEVLn4Chkv0lohKSlW/n5i7WMy7tM6oC0Bx/5ga+TqEMULuQZnmrow+pwqNkhO5TPpN7Jw7gILJd3sBkwD3jajUK8RlWkqIndDeZ7dZrlp6fRW0AWLb72jFNr2ST9f95gmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RiD8pYEUENiLZVSbgurMstmTdMeYRk6qBt42YmrZIOZt00Pqk8AHSl03hFi/UWDdK8YxQfNPRBy0hpIx6DoJH07X6kKdIoYK/paK0FuT1R2D9e/UQvDi6bhxfgmudVW495NA1d/faHmfh9aydz9IxiMG/czQbzTkMOdCsPS+nMU=
Received: by 10.140.251.1 with SMTP id y1mr4381077rvh.102.1200379129377;
        Mon, 14 Jan 2008 22:38:49 -0800 (PST)
Received: by 10.140.185.19 with HTTP; Mon, 14 Jan 2008 22:38:49 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801150031480.2315@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70505>

On Jan 15, 2008 12:34 AM, Jan Engelhardt <jengelh@computergmbh.de> wrote:
>
> And it would be really nice if `git log` would also show the
> Precedes/Follows lines so one can identify much more easily in
> big logs like those of the Linux kernel what the next release to
> have a given patch is.
>
>

You need two complete revisions walk for this, one from the newest to
oldset to compute the 'precedes' and one from the oldest to newest to
compute the 'follows', so I would say it's more suitable used together
with --topo-order option of git log that already does a walk, at least
the slowdown is hidden in this case.

Anyhow being able to compute precedes/following info in timely fashion
and with low memory consumption is quite not trivial code, I have
implemented for qgit long time ago and I remember gave a kook at the
gitk code for reference also if at the end my implementation it's a
bit different (less memory used but slightly more complicated).

Just to give an idea of timing, on my new and awesome ;-) laptop
loading full Linux tree it takes 3316ms, then calculating
precedes/follows info (indexing the tree) it takes 233ms.

Perhaps the slowest part is to load refs info, you need this to know
what sha a tag/branch has and is a prerequisite to indexing, also if
refs are compacted it takes almost 1 second on my PC because there is
heavy disk activity in any case.

Marco
