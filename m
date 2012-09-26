From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: DWIM .git repository discovery
Date: Wed, 26 Sep 2012 09:28:37 +0200
Message-ID: <5062AEA5.9000903@drmicha.warpmail.net>
References: <CACsJy8DOtPWgkq=KSHCb=J3qg4o1aPaLo4aj7U5f_qa+kCCipQ@mail.gmail.com> <7v7grhv2fu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 09:28:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGm39-00079d-AJ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 09:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab2IZH2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 03:28:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45399 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752147Ab2IZH2k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 03:28:40 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3D69620C56;
	Wed, 26 Sep 2012 03:28:40 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 26 Sep 2012 03:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=RIipYumeuW2MwtmnNkId8w
	sRrKg=; b=A4qHb7T6bDZdtmQFer5eT2ivn/rEqNHHaFBGRV9Etfzvr7w7oQ6qgs
	qIGVIm67GhEFmFxpCgMptJ7LL9SEtwbls6/hbwu2oh1VDmVgNYkXCFeVF7OKct71
	VDAb5SJtl5J2AIgsr6b3+pCsY13GtrDB0sNC+rQz7uRqh+neCSyhI=
X-Sasl-enc: XvwoXFvk7iT4m10kxiSI7ou/94RWw6ILXTfX4Sk96ojp 1348644519
Received: from localhost.localdomain (unknown [88.70.158.21])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9044748278E;
	Wed, 26 Sep 2012 03:28:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v7grhv2fu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206396>

Junio C Hamano venit, vidit, dixit 26.09.2012 06:21:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> I often find myself attempting to examine another repository,
>> especially in projects that are closely related but put in different
>> git repos. It's usually just a diff or log command
>>
>> git log --patch ../path/to/another/repo/path/to/file.c
> 
> I personally do not think it is _too_ bad to internally do
> 
> 	(cd ../path/to/another/repo/path/to &&
> 	 git log --patch file.c)
> 
> but I doubt it is worth the numerous implications (I am not talking
> about implementation complexity at all, but the conceptual burden).

Yeah, but doing the above from an alias or help script should be fine
and can be tailored to your use case. Say, a script like

arg1="$1"
shift
cd $(dirname "$arg1")
git "$@" $(basename "$args1")

should cover a couple of use cases already. (Error checking is for the
faint of heart only.)

> For example, where in the working tree of the other project should
> the command run?  The output from "log -p" happens to be always
> relative to the top of the working tree, but that does not
> necessarily hold true for other subcommands.
> 
> A worse thing is that there is an oddball case "diff[ --no-index]"
> that changes behaviour depending on the pathspec points at inside or
> outside the repository.
> 
> I think that this is a road to insanity; anybody who thinks along
> this line is already on the other side of the line, I would have to
> say ;-).
> 

Don't we all just walk on the line?

Michael
