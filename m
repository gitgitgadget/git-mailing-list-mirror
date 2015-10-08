From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] GIT_INDEX environment variable ignored?
Date: Thu, 8 Oct 2015 09:56:17 +0200
Message-ID: <561621A1.8090609@drmicha.warpmail.net>
References: <3316005380861448B5340D39CF27A7242F2375BE@us-voo-mb04.internal.sungard.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "McAuley, Ben" <Ben.McAuley@sungard.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 10:01:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk63x-0001f7-4k
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 09:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbbJHH4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 03:56:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46053 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760AbbJHH4T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 03:56:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DC1D5203AA
	for <git@vger.kernel.org>; Thu,  8 Oct 2015 03:56:18 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 08 Oct 2015 03:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=+k2AM59WsOnP6DeR5RB8tuB9TF8=; b=TzH0hX
	vXKXzcmwrv68zvosxirVncRr/VB0h71YYXnP8S2LqKCwbj4h0IylGJcrRN7c+Xvm
	mNrVYSNm4SL7u24DHDYgzhkZMoqT8UuC8gu1KDWvfWIY8xVvK7UkIQomUYyPmDZW
	ExhSHFhdmE/4xackvl9LOp9IeiYPj6eXYT/9g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+k2AM59WsOnP6De
	R5RB8tuB9TF8=; b=jSwLetbDbyojLL3xEJyNikPx91Kcxv/5l+hSUZwgJL86xbh
	Ycd11In2ElvwMxfmgrUMDkkNr0HSvmHthyPd99RxR8iac7P9mdfuejxzwbQqt8fH
	IPkNUFX8EeA7e94XZqniTFtek+mxi9Kn7CJ0UBQnCsaj5QlJU7HBRiF1cT7k=
X-Sasl-enc: Be5v5ZIZGFK6EcTb0VxwHsKbaoll1dYqoEcWWhNXQxs/ 1444290978
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5A894680114;
	Thu,  8 Oct 2015 03:56:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <3316005380861448B5340D39CF27A7242F2375BE@us-voo-mb04.internal.sungard.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279220>

McAuley, Ben venit, vidit, dixit 08.10.2015 06:48:
> Hello,
> 
> I was trying to use multiple indexes earlier, and ran into an issue which I've summarised into a test case:
> 
> $ git init
> $ touch file1 && git add file1 && git commit -m "file1"
> $ git branch release 
> $ touch file2 && git add file2 && git commit -m "file2"
> $ cp .git/index .git/indexMaster
> $ git checkout release
> $ touch file3 && git add file3 && git commit -m "file3"
> 
> I then ran ls-files with the --stage option to look at what the index contains.
> As expected file1 and file3 are present, we're on the 'release' branch still.
> 
> $ git ls-files --stage
> 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       file1
> 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       file3
> 
> However when I run the same command again, this time using the 
> GIT_INDEX env variable to provide the index I previously saved on master,
> I don't see file2 like I'd expect...
> 
> $ GIT_INDEX=.git/indexMaster git ls-files --stage
> 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       file1
> 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       file3
> 
> Is this something going wrong, or am I misunderstanding the role of the index/GIT_INDEX variable?
> 
> Replicated on 2.5.0.windows.1 and 2.6.1 (Linux).

Maybe try GIT_INDEX_FILE instead of GIT_INDEX? ;)

Michael
