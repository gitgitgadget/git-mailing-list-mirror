From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Fri, 13 Jun 2014 11:55:22 +0200
Message-ID: <539ACA8A.90108@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net> <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net> <20140613080229.GJ7908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 11:55:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOCo-0000fY-5p
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 11:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbaFMJzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 05:55:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34079 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751449AbaFMJzZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 05:55:25 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 58FEC20E11;
	Fri, 13 Jun 2014 05:55:24 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 13 Jun 2014 05:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=VWX54+tvktpgHCPDn4Jv1h
	Cntvw=; b=VDOVL1Fj2hONNYfzKtWnth8Xy/qrTW/rsjgJXcN7PpUbXaK4k3AW3v
	ZCKsj7VBlfc1Axz/fcChvkYXN64FutIVw9yEF363v6fFWEJmYqSLBTGWAEnY5Apu
	EhO4ZT4u9ve8bQgrNDyxigaefAr8Utmct5MI8O1dnyDlgpIl182I4=
X-Sasl-enc: 760g6JF1/r24Mmz8shPsEMXIZaNFju8G2EiHNQGmxKxu 1402653324
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BD8C36800BF;
	Fri, 13 Jun 2014 05:55:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140613080229.GJ7908@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251536>

Jeff King venit, vidit, dixit 13.06.2014 10:02:
> On Fri, Jun 06, 2014 at 04:15:28PM +0200, Michael J Gruber wrote:
> 
>> Commit signatures can be verified using "git show -s --show-signature"
>> or the "%G?" pretty format and parsing the output, which is well suited
>> for user inspection, but not for scripting.
>>
>> Provide a command "verify-commit" which is analogous to "verify-tag": It
>> returns 0 for good signatures and non-zero otherwise, has the gpg output
>> on stderr and (optionally) the commit object on stdout, sans the
>> signature, just like "verify-tag" does.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
> I think the general direction of this series is reasonable.
> 
> Did you give any thought to just having a "git verify" command, instead
> of separate tag/verify commands?

Yes. (mathematician's answer)

You know not only the outcome but also why I refrained from doing so:
compatibility. We would need to deprecate verify-tag.

But there is also a more subtle reason: If you want to verify a signed
commit, you want to be sure that it actually is a commit. "verify" could
easily branch code paths based on the object type, but I'm not sure that
is desirable, at least not by default.

> Another thought, that may be orthogonal to your series: what does it
> mean to verify a commit? We check for _some_ signature from a key that
> is in your keyring. But we do not check whether the signature matches
> the committer field (or for tags, the tagger field). You have to parse
> the gpg output, run "git cat-file", and then correlate the two. Should
> there be an option to have git check that one of the signed uids from
> gpg matches the commit's committer?
> 
> -Peff
> 

That is a general issue with verifying signatures: it can be automated
only if you employ a strict trust model and a very limited keyring.
"valid signature" means only as much as the signatures that your gpg
accepts can be really trusted.

Comparing uid's really buys you nothing in the sense that everyone can
have a key with uid "Jeff King <peff@peff.net> signed by some other
keys. On the other hand, it's perfectly OK to use different uids for git
commits and signatures. The e-mail address I use for the git list and
commits, for example, is clearly a "plus address", which helps me
organize things; my personal key has the primary address as uid.

I really think all this is up to local policies for individual use cases.

Michael
