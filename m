From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] Raw gpg output support for verify-commit and verify-tag
Date: Mon, 15 Jun 2015 10:22:36 +0200
Message-ID: <557E8B4C.3030604@drmicha.warpmail.net>
References: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net> <xmqqd20ym1b0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	=?ISO-8859-15?Q?Nguye=5E=7En_Th=E1i_Ngo=2Ec_Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>
To: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:22:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4PfK-0002oH-Oo
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 10:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbbFOIWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 04:22:42 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59596 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753467AbbFOIWk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2015 04:22:40 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 76AC620AAF
	for <git@vger.kernel.org>; Mon, 15 Jun 2015 04:22:39 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 15 Jun 2015 04:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=5pOTOhhxec+VLy4rVJOm5h3Vzt4=; b=fPTUY+
	xLsfD4ooE7QLAf3o/vRKvEb49XGIIjUgidCebLguiz4eQvkWuu3ZIyyQ+QLGPpA3
	3scp5S+YMmE29dlOrXHqoQ1uURHzcKzeLztxf7W8WfqgDucE4bdh89BQLgJGGoGW
	v5a1gWt+Z3V3k+vxa9Ur/d1Fl4Ubt78Zly9tk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=5pOTOhhxec+VLy4
	rVJOm5h3Vzt4=; b=KsesDCJjgVlsHk8NroyZ6uAEj+okRHMucc32z6/42CH4aXe
	aGDnpYuXJBsgqZr2afNetnevrDdhA+UeefIsqwikGJ/f/oyUcBZx8mDkTEVrDv5P
	86VfkM4myxg+i03mVRBNzvV+V4Pjs8rUaMC/xajLMJlouxJUq9m7kATzkrkI=
X-Sasl-enc: Vrs+ICR2qUNsdIeMeqxTNOnYF2xln+tZp2YLStPybn8m 1434356559
Received: from localhost.localdomain (unknown [130.75.173.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id BF3AE68007F;
	Mon, 15 Jun 2015 04:22:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqd20ym1b0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271660>

Junio C Hamano venit, vidit, dixit 14.06.2015 23:23:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> Currently, verify-commit and verify-tag produce human-readable output.
>> This is great for humans, and awful for machines.  It also lacks a lot
>> of the information that GnuPG's --status-fd output provides.
>>
>> For example, if you wanted to know
>> * the hash algorithm;
>> * whether the signature was made with a subkey; or
>> * the OpenPGP signature version
>> none of that information is available in the human-readable output.
> 
> What this series wants to achieve makes a lot of sense to me.  One
> comment I have after skimming the patfches is that I want the new
> "raw" bit added not as a yet another parameter after "verbose", but
> by turning the existing "verbose" into an "unsigned flag" flag word
> (with "#define GPG_VERIFY_VERBOSE 01") and then defining use of a
> new bit in the same flag word "#define GPG_VERIFY_RAW 01" or
> something.  That way, over time other people add differnt things to
> the interface, we would not have to end up with 47 different
> parameters each of which signals a single bit.
> 
> Thanks.

Back then the idea was to have verify-commit available *yesterday*
(before any refactoring) since we needed a way to verify the new commit
signatures programmatically.

Maybe now would be a good time to do the refactoring between verify-tag
and verify-commit that is still missing, and to add new features then
(unless they are pressing matters or fixes).

BTW: verify-tag and verify-commit should treat untrusted good signatures
in exactly the same way. Anything else is an error that needs to be fixed.

Michael
