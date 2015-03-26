From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFH/PATCH] git-svn: adjust info to svn 1.7 and 1.8
Date: Thu, 26 Mar 2015 17:02:38 +0100
Message-ID: <55142D9E.2010408@drmicha.warpmail.net>
References: <2036c42d7eae00d9cce33fc5fafc729f16a0b451.1427209737.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 17:02:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbAF4-0001Vu-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 17:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbCZQCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 12:02:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37234 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751673AbbCZQCk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2015 12:02:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3AF112090A
	for <git@vger.kernel.org>; Thu, 26 Mar 2015 12:02:37 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 26 Mar 2015 12:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:message-id:date:from:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	 s=mesmtp; bh=Q9YnaGeQZ/cX9c5MToGl2EYnpb0=; b=jMljlWt4laRdd6T4Zg
	11dlYCASlVRDcRK36kg3uRjR5eUPv2jVg/TCfopF2eWQ/zbJ0pzETlgQtcq6Fm/3
	WBLURrWzhOv+oJz1nxjCbOnwqyiCocuyAw6j5/EsXSyaEB3GNSBNjLyDZbZc7Vww
	kT0o6f0tHisOqp1Y8wuBDZjTc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Q9YnaGeQZ/cX9c5MToGl2E
	Ynpb0=; b=XnCQv1E55G9L42Qmg/yhPxyOEwL7iRYv/3245PRYHk5hliU/egF/Pd
	+fWpYjBccn3YqQg0nzbCROH5QWyVGeb3pf6U9dvAsw8iyvTMdpPquqGN31FUeZS3
	mcnXR5u5reD8Xdk0Od7AhPrhyzoNNLIF1lFNXKxuhjnGvhDxWKxXo=
X-Sasl-enc: jTF5PMnWz0dBD2WFRbgTmIpoicjKiLrftcGRFfPAoq7O 1427385759
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 85370C0001C;
	Thu, 26 Mar 2015 12:02:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <2036c42d7eae00d9cce33fc5fafc729f16a0b451.1427209737.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266333>

Michael J Gruber venit, vidit, dixit 24.03.2015 16:10:
> t9119 refuses to run with svn versions greater than 1.6 since "git svn
> info" does not even try to match the output of "svn info" for later
> versions.
> 
> Adjust "git svn info" to match these versions and make t9119 run with
> them. This requires the following changes:
> 
> * compute checksums with SHA1 instead of MD5 with svn >= 1.7.0
> * omit the line "Revision: 0" for added content with svn >= 1.8.0 (TBC)
> * print the "Repository UUID" line even for added content with svn >=
>   1.8.0 (TBC)
> * add a "Relative URL" line for svn >= 1.8.0
> * add a "Working Copy Root Path" line for svn >= 1.8.0 (TBC, RFH)
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> 
> Notes:
>     While trying to increase my test run coverage I noticed that most of us won't
>     run t9119 at all. Bad bad.
>     
>     My svn is 1.8.11 (r1643975) on Fedora 21.
>     
>     I would appreciate help with the following items:
>     
>     TBC = to be confirmed: confirm the svn version where this change kicked it,
>     or run this patch and t9119 with an svn version other than mine. Please
>     run with "-v" to make sure only the RFH item fails, see below.
>     
>     RFH = request for help: I couldn't figure out how to get the working
>     copy root path in cmd_info.
>     
>     18 subtests will fail because of the RFH item.

I've figured out the exact revisions meanwhile - there's a git repo for
svn :)

I would appreciate help with the RFH item, though: How to teach "git svn
info" to output the "Working Copy Root Path"?

Michael
