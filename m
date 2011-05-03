From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] specifying ranges: we did not mean to make ".." an
 empty set
Date: Tue, 03 May 2011 08:39:26 +0200
Message-ID: <4DBFA31E.40207@drmicha.warpmail.net>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org> <20110502193321.GB10487@sigill.intra.peff.net> <7vhb9clu0n.fsf@alter.siamese.dyndns.org> <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org> <20110502210141.GA15753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 08:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH9Gg-0008WQ-3z
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 08:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab1ECGj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 02:39:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55990 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752334Ab1ECGj2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 02:39:28 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0C71320580;
	Tue,  3 May 2011 02:39:28 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 03 May 2011 02:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=J33rAPjD4rZSBCdgLDiabkP/1Yg=; b=ivPw0ZJAe8hp9yS6j1FzSlhVVWbqNyTD7fvCMRNXSDbwirDHVX4Fdjz1hQ6mvCyK10aLmx9Y9MbTTVLzD66dqCwBldqNnHBJyuzSFBipmbDjcG8UCVp2dMZ9njwLgC/5EfF7VgOG0FDrISBFfdLY82HUGz4q1/KtHdHLUdVIGMU=
X-Sasl-enc: ZzWv236wh7GzZGY+fJhmYecZTcLi3d4TXIsKQbCEaotf 1304404767
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 691D2443710;
	Tue,  3 May 2011 02:39:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110502210141.GA15753@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172646>

Jeff King venit, vidit, dixit 02.05.2011 23:01:
> On Mon, May 02, 2011 at 01:56:51PM -0700, Junio C Hamano wrote:
> 
>> Either end of revision range operator can be omitted to default to HEAD,
>> as in "origin.." (what did I do since I forked) or "..origin" (what did
>> they do since I forked).  But the current parser interprets ".."  as an
>> empty range "HEAD..HEAD", and worse yet, because ".." does exist on the
>> filesystem, we get this annoying output:
>>
>>   $ cd Documentation/howto
>>   $ git log .. ;# give me recent commits that touch Documentation/ area.
>>   fatal: ambiguous argument '..': both revision and filename
>>   Use '--' to separate filenames from revisions
>>
>> Surely we could say "git log ../" or even "git log -- .." to disambiguate,
>> but we shouldn't have to.
>>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Looks good to me.

I'm sorry but I don't like this at all, because:

> Doing "..." is still allowed, but will never produce any useful results.
> I don't know if it is worth disallowing it to catch errors. I am tempted
> to say it should be magic for "@{u}...HEAD", but I think just "..." is
> getting unreadably magical. "@{u}...HEAD" is already pretty concise and
> is much more readable.

We need to disambiguate any pathspec with "--" which could be a revision
parameter. Therefore I find it very unnatural to disambiguate ".." to a
pathspec automatically (and have "..." error out). "../" is really
simple enough to type.

For "..", we should either catch the error or, better, have ".." default
to "@{u}..HEAD" and do the same for "...". Those are used much more
often, and this goes with "try to parse as a rev first, then pathspec".

Michael
