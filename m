From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: RFD: concatening textconv filters
Date: Thu, 21 Feb 2013 11:28:31 +0100
Message-ID: <5125F6CF.50105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 11:28:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8TOZ-00068F-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 11:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab3BUK2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 05:28:31 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56347 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403Ab3BUK2a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 05:28:30 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 57E45209B1
	for <git@vger.kernel.org>; Thu, 21 Feb 2013 05:28:29 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 21 Feb 2013 05:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=J
	NwN3bk2XmrVQAstjZwtk60Ix3I=; b=jiiFDniSccBf+R+2Ly+0gNnp1xm3wFU8M
	KCYNRYGV/owGAUHskDNYrLwlNgB5ovTP4Fwap4Ne0nQMeGaKEMfmJJGFRxGFad2o
	5Fne9M1aiTQCiwZAPgGsuihFZBTQOBmj++4Z0RU/ss4QUnCqP+5tAmmuOhgj/Xbv
	6z4gIk1SUk=
X-Sasl-enc: 7lvAgxfBSRp+e4HsBOrGfqa+VT7nhaITh7ZS5d1eJlu1 1361442509
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E2AAB4825EC
	for <git@vger.kernel.org>; Thu, 21 Feb 2013 05:28:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216763>

During my day-to-day UGFWIINIT I noticed that we don't do textconv
iteratively. E.g.: I have a file

SuperSecretButDumbFormat.pdf.gpg

and textconv filters with attributes set for *.gpg and *.pdf (using
"gpg" resp. "pdftotext"). For Git, the file has only the "gpg"
attribute, of course. In this case, I would have wanted to pass the gpg
output through pdftotext.

Now, I can set up an extra filter "gpgtopdftotext" for *.pdf.gpg (hoping
I get the ordering in .gitattributes right), of course, but wondering
whether we could and should support concatenating filters by either

- making it easy to request it (say by setting
"filter.gpgtopdftotext.textconvpipe" to a list of textconv filter names
which are to be applied in sequence)

or

- doing it automatically (remove the pattern which triggered the filter,
and apply attributes again to the resulting pathspec)

Maybe it's just not worth the effort. Or a nice GSoC project ;)

Michael
