From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Tue, 26 Jan 2016 10:35:34 +0100
Message-ID: <56A73DE6.5050201@drmicha.warpmail.net>
References: <20160125212208.GB26169@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Santiago Torres <santiago@nyu.edu>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 10:35:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO02L-00011p-1X
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933384AbcAZJfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:35:41 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43732 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280AbcAZJfh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 04:35:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B1775223DC
	for <git@vger.kernel.org>; Tue, 26 Jan 2016 04:35:36 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 26 Jan 2016 04:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=W6mAwx9Rd3C/471vs9xOUFZ7bPU=; b=gHdTFl
	yLblIQTrLOOoF2vfdQWyBRLAJ1mxgexWrgZixI/4mG0lagT8CoWnHGnDXn8/oc0M
	gu4hiWQfm6CJSR3875tfvLdyRbrZbq+i5A5r+5LCy+Py8f8LWFh/29UhBS+czNVE
	0NygmlX15tgx7prUhQSSyzi6DQn/7mmQHuyck=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=W6mAwx9Rd3C/471
	vs9xOUFZ7bPU=; b=GuwC5RSSdqN+RsJ+Yef37czN7x/v4jYO+bSPi5fF8wwopR5
	uvp55e/K87H38xdmSar+Q7jn315Sp3YqZUvcvAwGip/NKvJtcZ+JMpu7gxj9Faf6
	qTREET8uc9JZBkplCewlzMoMRBeqizyxVWDlKgZHVzrwcYPsu5eOU09zSwA4=
X-Sasl-enc: 5YqFpzG3PPrYMRiokhU8I8CDFIylCIe84Y7H69va0QjM 1453800936
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 36A926801F5;
	Tue, 26 Jan 2016 04:35:36 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <20160125212208.GB26169@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284792>

Santiago Torres venit, vidit, dixit 25.01.2016 22:22:
> Hello everyone.
> 
> I've done some further research on the security properties of git
> metadata and I think I've identified something that might be worth
> discussing. In this case, The issue is related to the refs that point to
> git tag objects. Specifically, the "loose" nature of tag refs might
> possibly trick people into installing the wrong revision (version?) of a
> file.
> 
> To elaborate, the ref of a tag object can be moved around in the same
> way a branch can be moved around (either manually or by using git
> commands). If someone with write access can modify where this ref points
> to, and points it to another valid tag (e.g., an older, vulnerable
> version), then many tools that work under the assumption of static tags
> might mistakenly install/pull the wrong reivision of source code. I've
> verified that this is possible to pull off in package managers such as
> PIP, rubygems, gradle(maven), as well as git submodules tracking tags.
> 
> In order to stay loyal to the way files in the .git directory are
> ordered, I don't think that making the ref file (or packed refs) files
> differently is an option. However, I think that it could be possible to
> store the "origin ref" in the git tag object, so tools can verify that
> they are looking at the appropriate tag. There might also be a simpler
> solution to this, and I would appreciate any feedback.
> 
> What do you guys think?
> 
> Thanks!
> Santiago.

If you cannot trust those with write access to a repo that you are
pulling and installing from you might want to re-check where you are
pulling or installing from ;)

In fact, just like you shouldn't blindly download and install a tarball
(but check its signature) you shouldn't blindly pull and install from a
repo.

Your best bet is checking the signature of signed tags. Now, if you're
worried about someone maliciously pointing you to the wrong, correctly
signed tag then you should verify that the tag object contains the tag
"name" that you expect (for example by using "git verify-tag -v" or "git
cat-file -p"), since that is part of the signed content.

Michael
