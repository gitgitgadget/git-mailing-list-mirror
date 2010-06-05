From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Sat, 05 Jun 2010 20:58:28 +0200
Message-ID: <4C0A9E54.50703@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net> <08e635cee993d97e2a38d7766ced11c064ef7d87.1275575236.git.git@drmicha.warpmail.net> <7vsk537p8k.fsf@alter.siamese.dyndns.org> <4C08AD75.6040307@drmicha.warpmail.net> <7vpr060ys0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 20:59:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKyap-0001Ej-F4
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 20:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab0FES6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 14:58:31 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50700 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940Ab0FES6a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 14:58:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83309F8AAE;
	Sat,  5 Jun 2010 14:58:19 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 05 Jun 2010 14:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Ob5ndgE6cmTxvfoXzsLP8Rq4Azg=; b=QkAllCrxwTpVbmx51OaTwAvp1063yOEzdjnaEhRm2hC2IccXtfX79mxGpwYMs7t2bkxwqiSFnObiEPTjlDYq/CxcEOyMUOGGotIGtr9MTUXgvQK76TGPcQ2PitwTk/eYOJ85Bg6FahNYUcP1xCtOjAp2WblE1cluYvhb4OOCwkc=
X-Sasl-enc: 7G4mmKAcOiQjyJfNjUPwvMcqParBBERSsbWxwJLOl+/H 1275764299
Received: from localhost.localdomain (p548580F5.dip0.t-ipconnect.de [84.133.128.245])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B95714A6B2E;
	Sat,  5 Jun 2010 14:58:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7vpr060ys0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148486>

Junio C Hamano venit, vidit, dixit 05.06.2010 08:38:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> In 3/4, that "No NL at EOF" is suppressed for symlinks *when textconv is
>> in effect only*, i.e. when we don't (necessarily) produce a diff fit to
>> be applied anyways.
> 
> Sorry, that doesn't change a thing at all.  The presense of incomplete
> line is part of the information diff gives you.
> 
> It can be done by defining a custom textconv filter that adds a trailing
> LF to a blob that ends in an incomplete line, and what your patch 3/4 does
> is essentially to create such a built-in textconv filter and *force* users
> to use it unconditionally for all paths unless the user explicitly asks
> not to use *any* textconv.

No, not for all paths, only for symlinks. And, as not only I have
pointed out, diffs with textconv (which is the default) may produce
"incomplete" diffs anyways. The only difference is that people would
have to set up textconv filters before.

That is why there seems to be consensus in statu nascendi (on that other
branch of the thread) that we should protect against textconv in the
same way as we do for color, i.e. based on whether stdout = tty. Then my
symlink treatment would be conditional in the same way as it is
conditional on textconv.

Michael
