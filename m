From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Fri, 11 Sep 2009 01:54:55 -0700
Message-ID: <7veiqdzwrk.fsf@alter.siamese.dyndns.org>
References: <be6fef0d0909080610j89c0a4bkf1cb0119b9b11db@mail.gmail.com>
 <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
 <0016e6470f36315b8a0472bc75a8@google.com>
 <20090904212956.f02b0c60.rctay89@gmail.com>
 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
 <20090907172751.6cf38640.rctay89@gmail.com>
 <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
 <20090909203350.e3d7e5dc.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Tom Preston-Werner <tom@mojombo.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 10:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm1ui-0003e3-D5
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 10:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbZIKIzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 04:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbZIKIzN
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 04:55:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbZIKIzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 04:55:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB0744C288;
	Fri, 11 Sep 2009 04:55:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZZ0qeWyqtsQB5oehoB/0iHJbufE=; b=NoBzqSVLOxO5wcTX4z3ZSXE
	unKJ5qeanFUbqoe9mOXaWoCrJTR2tJe2umYQDwkUGMCNcQzyRHfqlDrYeO8VKQlo
	r17iFZrAhW7Ahj9mBLGvcTZpMs0MA2xwwa74OJCNKU9N4HpTR9vyTHLCfK9v26hK
	WWa8rnhDrTvmbIxg+PpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qBN33QkAr+t5zEfe+2UOQnyxcG1ZAQyCqNM8RGNft9306L6Q5
	HWRoNZRfsy0bcEL+2wQQtdUA9IZr168g9UwXbFVej/0QpgW9tCib2d3Rl5wHQGst
	UZ1GHMiSzkTyFDusS5sKRRzmJh4zgNcYHcVkBb01BVbuWpAsXis6GzFHRA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2A4F4C287;
	Fri, 11 Sep 2009 04:55:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8B9084C286; Fri, 11 Sep 2009
 04:54:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD762328-9EB0-11DE-9462-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128184>

Tay Ray Chuan <rctay89@gmail.com> writes:

>> I am in favour or removing this check, not just due to its
>> unreliability, but for the sake of consistency (we very rarely send a
>> HEAD request to poll data before doing a GET).

I think this is sensible.  The only case I think it could be a problem is
this scenario:

 - You clone from remote.

 - Remote works more and has two more packs, A and B. 

 - You fetch, but this does not need both of them (perhaps you fetched
   only one branch).  You get *.idx files for both, but *.pack file only
   for A.

 - Remote works a bit more and then repacks everything into a single pack
   C.

 - You fetch, and the walker walks the loose objects, and then finds one
   object that cannot be obtained as a loose object.  It tries to look up
   in the *.idx file and finds it in B.

   But the packfile B is long gone.

I didn't follow the codepath that uses http_get_info_packs() and then uses
repo->packs list to see what it does, but as long as the above does not
happen we should be Ok.

Thanks.
