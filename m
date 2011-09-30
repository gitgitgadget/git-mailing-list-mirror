From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Fri, 30 Sep 2011 09:45:34 -0600
Organization: CAF
Message-ID: <201109300945.34728.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109291913.34196.mfick@codeaurora.org> <7vwrcqpuc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 17:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9fHV-0002tm-2O
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 17:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab1I3Ppg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 11:45:36 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:58240 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab1I3Ppg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 11:45:36 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6484"; a="123821576"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 30 Sep 2011 08:45:35 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 9B19E10004DF;
	Fri, 30 Sep 2011 08:45:35 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vwrcqpuc7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182489>

On Thursday, September 29, 2011 09:44:40 pm Junio C Hamano=20
wrote:
> Martin Fick <mfick@codeaurora.org> writes:
> > This works for me, however unfortunately, I cannot find
> > any scenarios where it improves anything over the
> > previous fix by Ren=C3=A9.  :(
>=20
> Nevertheless, I would appreciate it if you can try this
> _without_ Ren=C3=A9's patch. This attempts to make
> resolve_ref() cheap for _any_ caller. Ren=C3=A9's patch
> avoids calling it in one specific callchain.
>=20
> They address different issues. Ren=C3=A9's patch is probably
> an independently good change (I haven't thought about
> the interactions with the topics in flight and its
> implications on the future direction), but would not
> help other/new callers that make many calls to
> resolve_ref().

Agreed.  Here is what I am seeing without Ren=C3=A9's patch.

Checkout in NON packed ref repo takes about 20s, with patch=20
v3 of binary search, it takes about 11s (1s slower than=20
Ren=C3=A9's patch).

Checkout in packed ref repo takes about 5:30min, with patch=20
v3 of binary search, it takes about 10s (also 1s slower than=20
Ren=C3=A9's patch).

I'd say that's not bad, it seems like the 1s difference is=20
doing the search 60K+times (my tests don't quite scan the=20
full list), so the search seems to scale well with patch v3.

-Martin

--=20
Employee of Qualcomm Innovation Center, Inc. which is a=20
member of Code Aurora Forum
