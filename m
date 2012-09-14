From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 15:03:49 +0200
Message-ID: <50532B35.9050607@drmicha.warpmail.net>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
X-From: git-owner@vger.kernel.org Fri Sep 14 15:04:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCVZ0-0002Sa-BW
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 15:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab2INNDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 09:03:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45249 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751008Ab2INNDv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 09:03:51 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 98D622072B;
	Fri, 14 Sep 2012 09:03:50 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 14 Sep 2012 09:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=YDthgMWwz78Sx3GD6MUWAl
	CSJ50=; b=TrjjJqSq7v3NN3tW107doJCjpv+2dkGVDYeVKw94EWHPaEXB455oqb
	qClvAnwwAcUDrrSOo35YKDiHQ4tZyo0O/EiwtTCPGad5zPkZz9e71dk1SL/Q34dz
	UfCLTqIWkKBR7/Ty6UtUApz4m93w2qoljMAdC3ZuhuWT9L4StzBNc=
X-Sasl-enc: hDS0DQ/1VfQZPRLGokOIr1ICL6RkCbPwERR7QNVg4mVJ 1347627830
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1B21F483612;
	Fri, 14 Sep 2012 09:03:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205487>

Mestnik, Michael J - Eagan, MN - Contractor venit, vidit, dixit
14.09.2012 14:20:
> I must have missed something reading through the documentation for this.  git version 1.7.11.3
> 
> $ git check-attr -a -- autorepair.d/AR02_new_rttest.sh
> autorepair.d/AR02_new_rttest.sh: ident: set
> autorepair.d/AR02_new_rttest.sh: export-subst: set
> 
>   echo "0..$_expected_tests"
>   diag 'Script Version: $Id: 1ca40f8395ea361cc07d2ec1a2961c3df749dc3c $'
>   diag 'By: $Format:%cn$ $Format:%ce$'
>   diag 'At: $Format:%cD$'
> 

'$Format:' is processed when creating an archive. It's mentioned with
export-subst only under the heading "create archive". So, that is as
described, I think.

> I also believe that the documentation could try and better explain under what conditions "$Id" will be processed, it doesn't seam to happen on commit and even after a checkout this is not updated.  It does seam to update during a pull and that's basically all I need.

"git replaces $Id$... upon checkout.  Any byte sequence that begins with
$Id: and ends with $ in the worktree file is replaced with $Id$ upon
check-in."

Now, the there are two problems after you add $Id$ and check-in (commit):

- commit does not check out, i.e. your work-tree copy is not updated
with expanded $Id$
- Not even "git checkout thatFile" updates your work-tree copy.

The first one could be considered OK, but at least the second one seems
to be a bug. Together they create the following problem: Say, you've
corrected that problem (rm that file and checkout) and then update your
file, add and commit. It will keeping having the old (now wrong) Id
expansion.

We should do something about this.

Michael
