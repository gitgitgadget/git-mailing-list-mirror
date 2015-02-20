From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Fri, 20 Feb 2015 11:36:27 +0100
Message-ID: <54E70E2B.8000604@drmicha.warpmail.net>
References: <20150218170007.784be6aa@pc09.procura.nl> <54E4CFDC.40401@drmicha.warpmail.net> <20150218182547.GA6346@peff.net> <xmqqpp972h1n.fsf@gitster.dls.corp.google.com> <20150218185734.GB7257@peff.net> <54E5BBDD.7040100@drmicha.warpmail.net> <20150219121438.59050ce8@pc09.procura.nl> <54E5C6E2.9040101@drmicha.warpmail.net> <20150219125433.GA1591@peff.net> <54E5E347.4070401@drmicha.warpmail.net> <20150220014801.GB16124@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:36:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkwk-0005o1-6f
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbbBTKga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:36:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60375 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753358AbbBTKg3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 05:36:29 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F4E4209FE
	for <git@vger.kernel.org>; Fri, 20 Feb 2015 05:36:28 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 20 Feb 2015 05:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LdJ48Nl2Ur8XlRkS5nyVRU
	GQFLg=; b=qmWAHixyAwuCBTa5uvjLOyKC1ISWFNc4l+MYvP4t6t6NcfHC+HviVo
	WfOB9KD1hf3EJbXKTF4+6wJmKA5Ua4ZLjJ7lPo7enKqoP+ujVsdoU+dlWo/1TRMF
	e0TRyK8Nq1jQTq/CsFkt6oUQ5o2zv/6ZbIOSqlICp3Pmgdppr+XGY=
X-Sasl-enc: BGdF608L3jFXkHA3I8RsTl5YXIvrAoQykWEAjz7scyKd 1424428588
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 08E30C002A6;
	Fri, 20 Feb 2015 05:36:27 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150220014801.GB16124@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264157>

Jeff King venit, vidit, dixit 20.02.2015 02:48:
> On Thu, Feb 19, 2015 at 02:21:11PM +0100, Michael J Gruber wrote:
> 
>>> It passes NO_ICONV through to the test suite, sets up a prerequisite,
>>> disables some test scripts which are purely about i18n (e.g.,
>>> t3900-i18n-commit), and marks some of the scripts with one-off tests
>>> using the ICONV prereq.
>>
>> Hmm. I know we pass other stuff down, but is this really a good idea? It
>> relies on the fact that the git that we test was built with the options
>> from there. This assumptions breaks (with) GIT_TEST_INSTALLED, if not more.
>>
>> Basically, it may break as soon as we run the tests by other means than
>> "make", which is quite customary if you run single tests.
>>
>> (And we do pass config.mak down, me thinks, but NO_ICONV may come from
>> the command line.)
> 
> It's not quite so bad as you make out. We write the value to the
> GIT-BUILD-OPTIONS file during "make", no matter where it comes from, and
> load that in test-lib.sh. So:
> 
>   make NO_ICONV=Nope
>   cd t
>   ./t3901-i18n-patch.sh
> 
> works just fine (for this and for any of the other options we mark
> there).

It survives a cd, sure... Now, change your config.mak before the cd and
forget the make. Not everyone does

make -C t t3901-i18n-patch.sh

Though, having just discovered that shell completion works for that
form, too, I may do it more often (and then complain about having to use
GIT_TEST_OPTS ;) )

> It won't work for GIT_TEST_INSTALLED, but that is not a new problem.
> Fundamentally you cannot expect to test a version built without option X
> without telling git _somehow_ that it was built that way.
> 
> I suspect GIT_TEST_INSTALLED is not all that widely used, or somebody
> would have complained before. But if we really want to support it, I
> think the right thing is to bake GIT-BUILD-OPTIONS into the binary, so
> that "git --build-options" dumps it. It might also have value for
> debugging and forensics in general.

Yep, that would be helpful in general. I don't think we should worry
about GIT_TEST_INSTALLED too much. Who came up with that feature anyway...?

Michael
