From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pushing a git repository to a new server
Date: Tue, 12 Feb 2013 12:28:53 +0100
Message-ID: <511A2775.9050209@drmicha.warpmail.net>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com> <20130211075040.GJ5210@localhost.localdomain> <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com> <20130211162714.GB16402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ethan Reesor <firelizzard@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 12:29:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5E32-0002az-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 12:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843Ab3BLL2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 06:28:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33035 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932303Ab3BLL2w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2013 06:28:52 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0DE6320D6C;
	Tue, 12 Feb 2013 06:28:52 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 12 Feb 2013 06:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=qEfDF05Mkn3IDYMWrc9Rdu
	8QK/g=; b=oQ5N83EojxRspXifvpwIkaoJ1QjIebpWiDim2mT5wZmF5K5Eag64vd
	/ys0NkVYSmLbBVUGbt/Xt+PQwBY7gouQcQsNNcgu65YAkasC0lmHw8+ZqLB6XMjI
	/JSZE3Sxs6lKtPmMN737isL4uAbisidhzOfrk9YIFWLOos/A6A3M8=
X-Sasl-enc: 0RTr3Mn5ulSupcU9xZlgUwAI14nfjU5AdEMrpAc1omNW 1360668531
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5694B4827A6;
	Tue, 12 Feb 2013 06:28:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130211162714.GB16402@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216147>

Jeff King venit, vidit, dixit 11.02.2013 17:27:
> On Mon, Feb 11, 2013 at 02:57:51AM -0500, Ethan Reesor wrote:
> 
>> On Mon, Feb 11, 2013 at 2:50 AM, Konstantin Khomoutov
>> <kostix+git@007spb.ru> wrote:
>>> What's wrong with
>>> $ ssh myuser@remotehost 'mkdir /path/to/MyRepo.git; cd $_; git init --bare'
>>> $ git push --all git@remotehost:MyOtherRepo.git
>>> ?
>>
>> Nothing, I just wanted to make myself a command to do that for me.
> 
> We talked about this a long time ago. One problem is that it's
> inherently unportable, as the procedure to make a repo is potentially
> different on every server (and certainly that is the case between a
> regular user running stock git and something like GitHub or Google Code;
> I imagine even gitolite has some special procedures for creating repos,
> too).
> 
> One proposal made in the previous discussion was to define a microformat
> for repository administration commands. So that you could connect and
> say "git admin-create-repo /path/to/MyRepo.git", and the server-provided
> admin-create-repo command would take care of the details. Then stock git
> could forward it to "git init --bare", GitHub could do the same and
> create the necessary database records, etc.
>
> And once that standardized method was in place, it would be easy to add
> a "--create" option to "git push" to request an "admin-create-repo"
> before pushing.
> 
> I still think that's a reasonable way forward, but nobody was interested
> enough to start writing code for it.
> 
> -Peff
> 

I'm not sure providers like GitHub would fancy an interface which allows
the programmatic creation of repos (giving a new meaning to "fork
bomb"). But I bet you know better ;-)

An alternative would be to teach git (the client) about repo types and
how to create them. After all, a repo URL "ssh://host/path" gives a
clear indication that "ssh host git init path" will create a repo. I'm
wondering whether it's more likely to convince providers (the server
side) or more is gained by covering the simpler cases client-side (our
side).

Michael
