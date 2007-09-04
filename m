From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32 API
Date: Tue, 04 Sep 2007 23:31:28 +0200
Message-ID: <85hcmajexb.fsf@lola.goethe.zz>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
	<46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
	<Pine.LNX.4.64.0709031428080.28586@racer.site>
	<46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com>
	<46DD3153.8060805@trolltech.com> <46DD3943.8040403@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:31:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISfzr-00085O-Ax
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 23:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbXIDVbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 17:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbXIDVbj
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 17:31:39 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:44024 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754166AbXIDVbi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 17:31:38 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id DBF0A2F2BE1;
	Tue,  4 Sep 2007 23:31:36 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id CD987212FB7;
	Tue,  4 Sep 2007 23:31:36 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-020-058.pools.arcor-ip.net [84.61.20.58])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 8D81D1C368A;
	Tue,  4 Sep 2007 23:31:28 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 364E41C0039C; Tue,  4 Sep 2007 23:31:28 +0200 (CEST)
In-Reply-To: <46DD3943.8040403@eudaptics.com> (Johannes Sixt's message of "Tue\, 04 Sep 2007 12\:53\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4155/Tue Sep  4 22:44:14 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57650>

Johannes Sixt <j.sixt@eudaptics.com> writes:

> Marius Storm-Olsen schrieb:
>
>> Ok, I can give it a performance test, but I tend to agree with
>> David Kastrup there. It would be better if we rather fix the places
>> where we check with the local timestamp instead; depending of
>> course on how many places we actually do this.  We'll see how much
>> the timezone conversion in the custom stat functions actually hurt
>> us performance wise.
>
> I'd make the decision on the grounds of a perfomance test. If it
> turns out that the penalty is bearable, we should keep this stuff
> private to the MinGW build. Otherwise, we would need MinGW specific
> code at the call sites (unless we can hide the opposite conversion
> in some other wrapper function).
>
> ... time passes ...
>
> Ok, I just tested FileTimeToLocalFileTime() in a tight loop, and I
> can run it 100,000,000 times per second. So I'm confident that there
> won't be any noticable degradation with my proposed change.

The problem is that it will break in the hour when day light saving
time ends.  Or when you travel between timezones.

Local time is not continuous or unique.  That is why it is a bad idea
to make decisions based on it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
