From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: can git-describe learn first-parent behavior?
Date: Wed, 22 Sep 2010 08:52:43 +0200
Message-ID: <4C99A7BB.50401@drmicha.warpmail.net>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com>	<4C987C2E.3060001@drmicha.warpmail.net>	<4C98830A.70203@viscovery.net>	<4C989BBD.80106@drmicha.warpmail.net>	<4C989E6B.1070703@viscovery.net>	<4C98A0B7.9050501@drmicha.warpmail.net>	<4C98A645.8070601@viscovery.net>	<4C98CEA1.2050405@drmicha.warpmail.net> <AANLkTinDYae7yxSaRKNwOvkRe3yQ2GCBT=tiXhDe7NVR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 08:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyJC6-0006j5-Ph
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 08:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab0IVGwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 02:52:37 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41947 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750899Ab0IVGwg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 02:52:36 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0E35428F;
	Wed, 22 Sep 2010 02:52:36 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 22 Sep 2010 02:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5KnONhNf15iVDwIjEX3/WH+XuJQ=; b=EPKENMYwN7av6C3Rg7CQVapAvjPS60QjL90b+ass7t/FqZOIKXEKQpj8RlMU791lTzjg+n98R3/vwV4mtRYI88b3fsT/jy/UV+K/MuE21z5v+9v8HKHnDk004F7e5aIxAkc99wJ7JcDqB3EoCsUINlarW50BDAJqMZcBF8e78sw=
X-Sasl-enc: sHuO5K45l7+bnP/sAB+lRHSjb6vKEzaOsOMpSpHpxpxx 1285138355
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 689505E0C22;
	Wed, 22 Sep 2010 02:52:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <AANLkTinDYae7yxSaRKNwOvkRe3yQ2GCBT=tiXhDe7NVR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156786>

Joshua Shrader venit, vidit, dixit 21.09.2010 21:57:
> I think I need to apologize to the list.  I did not actually observe
> what I had stated in my original post.  Given the description (and my
> possibly naive understanding) of git-describe, I hypothesized that
> what I originally stated was possible. If git-describe is in fact
> implemented with a first-parent-like behavior, as some people believe
> to be true, then I believe it is working correctly - I've seen nothing
> to the contrary.  However, I do believe that the documentation is
> unclear if this is the case.  My interpretation of "depth," which I
> believe to be consistent with the graph-theoretical definition, does
> imply that what I stated could happen.

Josh, no need to apologize. You simply tried to understand "git
describe". The mere fact that a Git long time contributor (J6t) and an
occasional contributor (I) are discussing "git describe"'s behaviour
tells you that it can't be that easy ;)

The man page says "most recent tag", and that is true, but with a
definition of "most recent" that you wouldn't expect. The description
there under "Search Strategy" is wrong, and has been at least since
80dbae03. I'll try to come up with a better explanation fit for the man
page, possibly after writing some more tests.

The intended behaviour is explained really well in Shawn's commit
message for 80dbae03. And if you look at the algorithm you see that the
order of the parents (as stored in a merge commit), in particular
first-parent relationship plays no role at all. The algo takes all
parents and inserts them in date order into a list to be looped over
afterwards.

The more I understand the algo the more I realize that --first-parent is
useful and completely different, and that I can optimize more in my patch.

Cheers
Michael
