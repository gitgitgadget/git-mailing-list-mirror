From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Applying .gitattributes text/eol changes
Date: Tue, 11 Jan 2011 13:11:46 +0100
Message-ID: <4D2C4902.4010705@drmicha.warpmail.net>
References: <4D220500.2000104@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 13:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcd7M-0002du-PR
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 13:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab1AKMOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 07:14:24 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33661 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753484Ab1AKMOX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 07:14:23 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9B46F20594;
	Tue, 11 Jan 2011 07:14:22 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 11 Jan 2011 07:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fRB2Kl85OKMhv366YDizRvx8N44=; b=Iu0MmOoiMU3QuFAx/CnPABzFSTQrBScyAF0MF7odObLCd3kcdBCQEQ4G358UQ6n7CaAWruuzcklqiiZ+MfFaw+xFvwINMKKhS5boTwIfXFxsOVKZFpGpEt3y6n6p/X7J2aDdTAzMOyGtFboVgKQy59dFWPHk0Y8sXUTjqRQLSxQ=
X-Sasl-enc: kKF9lzIM0DS/eH+Hd2AD0LUuxjquM7b+gtbrJc3wtghF 1294748062
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1D91144852D;
	Tue, 11 Jan 2011 07:14:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D220500.2000104@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164930>

Marc Strapetz venit, vidit, dixit 03.01.2011 18:18:
> I'm looking for an unobtrusive way to apply (committed) changes for
> text/eol attributes to the working tree. For instance, after having
> changed "*.txt eol=crlf" to "*.txt eol=lf", all *.txt files should be
> converted from CRLF to LF endings. The only advice I found so far is to
> remove .git/index and do a reset --hard. The disadvantage of this
> approach is that every file will be touched:
> 
> - although the content does not change, timestamps will be changed. This

The bytewise content does change.

> makes tools like IDEs assume that the file content has been changed.

It may be that the content is semantically equivalent.

> (Even if the timestamps would be properly reset, the replacement of the
> files would have triggered system file change notifications and I'd
> expect various tools to still reload these files)
> 
> - there will be warnings for files which are locked by other processes
> (at least on Windows). I'm usually seeing this for JAR files which are
> not affected by eol-attribute changes at all.
> 
> One solution I could think of which might be helpful in other situations
> as well would be to have an "--unobtrusive" option for reset which would
> only replace a file if the content has actually been changed.

How about

git ls-files \*.txt | xargs touch -a
git ls-files \*.txt | git checkout

?
