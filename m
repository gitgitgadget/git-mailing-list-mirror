From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Finding leaf nodes.
Date: Mon, 13 Apr 2015 16:23:16 +0200
Message-ID: <552BD154.6040609@drmicha.warpmail.net>
References: <038FFBDD688D4EC6B0B42A339DF246B0@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Jason Pyeron <jpyeron@pdinc.us>, 'GIT' <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 16:23:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhfGm-0005pC-4w
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 16:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbbDMOXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 10:23:19 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48318 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752789AbbDMOXS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 10:23:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id CE12720CD1
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 10:23:17 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 13 Apr 2015 10:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=CSiN461tm4jQ7yTq5tMWIWbz9tU=; b=ivjvYJ
	+8MYz9aPyrTQ5lFTjYtaSwG5sKhUbwGVUppKVMa2x3evfrFBT/76QYKQ0jxyWuRT
	2MS85g2ho8PqcTvU/9cDaTTAw/5UERQ12MByUWAq4sIasDOWNFS/Kvyvci1lmvmW
	z8u5p1toUsGBShC7AW3c8lxn2Z00sa9PK94ew=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=CSiN461tm4jQ7yT
	q5tMWIWbz9tU=; b=LCHbE81380US8qpeG1uBA8kpyVClu3JhbBCVJvqghIMPRlZ
	JXvbY8rl/QsRMAqZR7xrLvoefrDpEBEVu4wjuAqZhEuOXzD0pNG9n0MjWkcAlK3B
	xqlAiWGI5O9iLYLbT54mimvV1WjiStRPyTiM0DkQuXgbFPFwWmTpMr0tw+/k=
X-Sasl-enc: ynX+WEflX299dO/Y1lToh0ac/K3Nu9AgPmLf194MqpRg 1428934997
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4E99FC00011;
	Mon, 13 Apr 2015 10:23:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <038FFBDD688D4EC6B0B42A339DF246B0@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267081>

Jason Pyeron venit, vidit, dixit 12.04.2015 06:04:
> I am trying to find all the unmerged commits [5].

"Unmerged" to which branch?

It's not clear to me which commits you are looking for. By "leaf node" I
would describe a commit without child commits. "unmerged" can only be
understood relative to a specific branch.

Maybe you are looking for commits from remote refs which are not on any
local branch?

> I can find, as a human, all the commits by git log --oneline --graph --all [1] but I am looking for a scripted way.
> 
> But git show-branch  -a --independent misses some [2]

This finds refs which are not "contained in" (can be reached from) any
of the other refs. If a remote ref is contained in another remore ref it
is not listed.

> find .git/refs/ -type f -exec cat '{}' ';' | sort -u; finds too much [3].

This finds all refs.

> The closest I get is with refs=`git show-ref -s`; git log --format=%H $refs --not $(echo "$refs" | sed 's/$/^/') but it too [4] gives me extra, but I am really not sure why. 

This finds all commits which are on some ref (branch/tag/..), excluding
those which are next to the tip or higher up from those refs.

> 
> * | a54a4fb 
> * | a0d2e63 
> * | dd4400d 
> | | *   68ea2c8
> | | |\
> | |/ /
> |/| |
> | | * c74d3c5 ??? Why is this the only extra commit listed ???

Because it is not "next to the tip", more specifically: not a first
parent (foo^) of a referenced commit, and neither a predecessor of one.

> | |/
> |/|
> * | 9c87570 
> * | 717e33d 
> * | 159799f 
> 
> 
> What should I do to automate this?
> 

Please try and restate what you mean by "unmerged commits". Maybe remote
commits not on any local branch, or remote commits not on master?

> 
> 
> 1:
> 0748f668b7fe0cba7a0edf1684ae84ddf87104ee
> 13916782bebe690149bfd1c3fb31d6d08942585b
> 383f3ae77393c2e303b3c32ef7dee122f0b623be
> 473093c214ba578cd7aecb6e2e5caaad70d173e4
> 4d0579c438e9d750f158124284bd740a5a0e0e26
> 68ea2c83978a7c023d76ebe438dd7d98fb1fd074
> 6900b076d790593a909bc84a1d062217e4a32941
> 9802bc44da0a35e4c7a917cd23468c387897cccd
> 982243cfde0dc6dfb1733d8e95748b7e687f57b8
> c197b7f71cd6d601b99adbe0a5cf5bf6bc749b6e
> c4bc3c4eb0015c73b50ea280a4a380e3cffc5160
> c5234422373d0425fa9cd610cb0848b7c33fe436
> d6af1c103b0cdeb7e7d45ffce2a838fa7a287aea
> eb50b82c6f3f55b66693482a913a5c1cfc19a03d
> f9c41c1a17df4358558a23a7c45bc2c60bf97e27
> Fb962761aa2ce6fbf77e4769c9e418bbe6f9f47f
> 
> 2:
> 4d0579c438e9d750f158124284bd740a5a0e0e26
> 68ea2c83978a7c023d76ebe438dd7d98fb1fd074
> 982243cfde0dc6dfb1733d8e95748b7e687f57b8
> C4bc3c4eb0015c73b50ea280a4a380e3cffc5160
> 
> 3:
> 00ea00e8e6a23a4243316f860aa07ed59203ab97
> 144eb9f673f14010c600766762b99cba1a64cc6e
> 2250af4ad29b92b07365320c5ccb7a22c17f588e
> 26bdfdfe71f7ceb4e0954bc5ab6c198481a280ae
> 283be0f77477fcd8c8bc878c602538f8a3451403
> 2f47330df8fb0357ef4e4d605d5c402150892a18
> 3ec60ab0dbdc63760429187605ede4549d7b2bad
> 43813b0fc44f7c41d2cdd4573145dbeb1aae1aee
> 4d5b52d440d3a64953a6d7ef3cbb81c8d289e392
> 556a5c2d759b51080e3bfe07a89b67e927749328
> 6fe0b6db2718625e5eeb3cbadeb58aa858ab4f1b
> 717e33d67ad3297a15cb432d3f70f7c12d353fa3
> 7587a45658aa689cc774d7253007be3feb2eec23
> ad9b5fa90c8f52b3ca31dd433c2c4b408e5f2a8f
> b3d7623b74dd75cc4f965d6b37dc461d2786f912
> c19fc45c87de85122952d63d28a0c7d3a18b79d5
> e8529e95d89d3f519a31ef7de5bd7f0d0d318e8c
> f2e86371e7fe3391023adccd61856d088db773dd
> fceca0050ceee8c4996a5740f7122e96c4948dd8
> 
> 4:
> c74d3c5cda60d8be7f38f1ec89c554a1346d57f8
> 
> 5: My remotes:
> https://github.com/CipherShed/CipherShed.git
> https://github.com/pdinc-oss/CipherShed.git
> https://github.com/discnl/CipherShed.git
> https://github.com/eaglgenes101/CipherShed.git
> https://github.com/erkinalp/CipherShed.git
> https://github.com/GigabyteProductions/CipherShed.git
> https://github.com/jeffallen/CipherShed.git
> https://github.com/kaydiechii/CipherShed.git
> https://github.com/srguglielmo/CipherShed.git
> 
> --
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> -                                                               -
> - Jason Pyeron                      PD Inc. http://www.pdinc.us -
> - Principal Consultant              10 West 24th Street #100    -
> - +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
> -                                                               -
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> This message is copyright PD Inc, subject to license 20080407P00.
> 
