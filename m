From: Eugen Konkov <kes-kes@yandex.ru>
Subject: Re[2]: Improving auto conflict resolving while merge
Date: Tue, 8 Sep 2015 21:08:09 -0300
Organization: ISP FreeLine
Message-ID: <1059528292.20150908210809@yandex.ru>
References: <856611441646146@web13j.yandex.ru> <20150908070645.GH26331@sigill.intra.peff.net>
Reply-To: Eugen Konkov <kes-kes@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: KES <kes-kes@yandex.ua>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:17:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNSA-0005Yo-8F
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbbIHSRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:17:08 -0400
Received: from forward18m.cmail.yandex.net ([5.255.216.149]:39458 "EHLO
	forward18m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751864AbbIHSRF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2015 14:17:05 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2015 14:17:04 EDT
Received: from smtp3m.mail.yandex.net (smtp3m.mail.yandex.net [77.88.61.130])
	by forward18m.cmail.yandex.net (Yandex) with ESMTP id D3AA421686;
	Tue,  8 Sep 2015 21:08:33 +0300 (MSK)
Received: from smtp3m.mail.yandex.net (localhost [127.0.0.1])
	by smtp3m.mail.yandex.net (Yandex) with ESMTP id 7519027A05DE;
	Tue,  8 Sep 2015 21:08:33 +0300 (MSK)
Received: by smtp3m.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Cie0pbx2F9-8UcSq5HY;
	Tue,  8 Sep 2015 21:08:32 +0300
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1441735712;
	bh=w2uyvfdso8ym4z1wF92RVrAkChKA2PtXGGhojmfLZHg=;
	h=Date:From:X-Mailer:Reply-To:Organization:X-Priority:Message-ID:To:
	 CC:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Kwmfxx22JQe9E56oJ93iJq6Laz0jjJGeYXZ7uwq1pFnSP4CRB9ZeT9Gz8zKLjPk1i
	 d2B3ag2uvsFd+0+wivPNv4Dgd1BIfXNyvfpddTojCDXPs0fvzzA4lKAJ4a6JnLoZ1z
	 XnmcoER1EeIJQ+oWCHv4Iljvy0iVCQmP+6RMPJ8U=
Authentication-Results: smtp3m.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: The Bat! (v4.0.24) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20150908070645.GH26331@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277512>

Hi, Jeff.

JK> For example, if you have the content:

JK>   foo();
JK>   bar();
JK>   baz();

JK> and one side makes it:

JK>   foo();
JK>   x = 1;
JK>   bar();
JK>   baz();

JK> and the other side does:

JK>   foo();
JK>   bar();
JK>   y = 2;
JK>   baz();

JK> you _could_ argue that those changes are independent But it's close 
JK> enough that there's a good chance the two need to be reconciled, 
JK> and a human should at least take a look.

You are right and your words make sense. But this thought may apply for this: We have one method/function about 200 lines. One author make change at line 1 of this method and other on 199 line. Both changes are done in one method so **human should at least take a look**

Example 2:
one author make change in method 1
second author make change in method 2
Method 1 is called from method 2. Those changes work fine on its own branch and does not work together. **human should at least take a look**

This task is not for human and must be left for test system. So your example and two mine must not rise conflicts. This make useless noise. 

Another example of useless merge conflicts

A--C--C'--F--?     master
 \  \       /
  B--C--D--G       feature


Here I start branch feature.
While developing update my branch from master by (C) changes
While developing feature (C) were changed by (C') on master
When I merge feature branch back to master I will get merge conflicts on lines in patch (C). I am not author of (C) and I do not care about it. Even  more I can not care and must not.

Implemented option (like --theirs in last example) to not be so conservative and do not rise merge conflicts for enough close changes will be good.
