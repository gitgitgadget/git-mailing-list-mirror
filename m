From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] pack-objects: do not get distracted by broken
 symrefs
Date: Thu, 08 Oct 2015 21:15:36 +0200
Organization: gmx
Message-ID: <5ee759ac37b2561eef9ab60d446ac463@dscho.org>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1444139796.git.johannes.schindelin@gmx.de>
 <f04229b0881eb7518a306ae07fe11ffc9589b1f1.1444139796.git.johannes.schindelin@gmx.de>
 <xmqq8u7evahd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:15:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGfM-0006kl-M9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbbJHTPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 15:15:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:50709 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831AbbJHTPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:15:43 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M3RZI-1aarDW0zia-00r1hU; Thu, 08 Oct 2015 21:15:38
 +0200
In-Reply-To: <xmqq8u7evahd.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:fTiFTucblJJpcO9IEr/buGEINlvtSuIw/f8blUuVdAe2d3jyC/r
 nmpaYCdV2Kth5Wh+H7uRnl4yt4QQRTeYHnr//qBR1aWp6LBfGzA26g/CSNyvxLvaJwfwoXX
 GVk2SM7S9NA/3fpbLMel7V/ssOImB2cu/k7sb8L/Nhhz08wDMJtZkhhbinjJK9hXUUcN+EP
 c7V3lWKqVFa99dUFIFTJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hcz0dGEM9pc=:t+eek4TO7Dr/ggl57SVlDH
 GMRpgMmu/Y/RAARHebiuuSmK5oL5UY1H92E4xKxWRxkk79MqUMssJ/wALIVVSsZd/34AWRppa
 nw9LQ2KfRRH789TtVZEoUGvBfBM2iReZ1/SVBHc8ruy6CQV4LPSD2RZt2PdcOgpbZczmQpjE7
 UW2Vxf/rqdDIIbLep8t/4XEBfdsOf6SXHtuATgEkUvgVzaqiakPMhar1RDYXH/rocKK2zJ+Ec
 8xqJF8PE4HMEejVHl4k1oKKAfIFEEQ1aViTgoNHz3oxlOkGuHpwVyPjhLGCHI8eu8KvlXl0VO
 3nnuuIrRD/EVggq4ATKwUuB1xTa3gpklkZJ/YXDfCYEpPjQUneIUbhfQzKuXI0pP5cxL6imYq
 Jt/FB0sP/TrdSZH8nVQpPFUXZavAlbO2X2JlNKQzrunYLUWbun9eLZgcTe86vaQ1oi5AsnwTw
 VszA5jcsK22DKp8Uq4ckI5lVDNPZ9w3Q41cBxP2pLIs6aAIlpAO/UufCrj4gA9TL74WHHmrX4
 2mcX4HxpwHmZV53Pc/KmtUjt4942qykmWSycxJKNX5TtSU+dA9jGMP8af0XUAtr1nifFLiJl0
 gkniZuF0NbjcbiXB9v50T14cv5VKUlE8vh0G+l9kkiSF/KD24z357SZsRmMbT7ZOiby/nLihE
 NpbObgmscMqfLVevC/KmaDP02xcBWwbYm6mu5D5bzAR0EA1QBmj8QpfbalqCxlE8XEZSuAsu6
 yPOWAg6JofQM18S7ZvldO8lGRjsglUj+eTpdQ+OHEarl3Vvmwe4z9noEciTxpFdvHW43isd5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279264>

Hi Junio,

On 2015-10-07 19:45, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> It is quite possible for, say, a remote HEAD to become broken, e.g.
>> when the default branch was renamed.
>>
>> We should still be able to pack our objects when such a thing happens;
>> simply ignore broken symrefs (because they cannot matter for the packing
>> process anyway).
>>
>> This fixes https://github.com/git-for-windows/git/issues/423
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
> 
> It seems that the result of applying these two patches and log
> messages of them are the same with what I queued on 'pu', except
> that the first of these two patches adds a test with a wrong name
> and then this one does "oops, that was misnamed".  So I'll keep what
> is already queued.

Sorry for fixing up the wrong commit. I honestly meant to fix up the first one. And thank you for fixing it up in `pu` already; I should have known better and check first whether you fixed it.

However, there was one more change I made: I wanted to have that link to https://github.com/git-for-windows/git/issues/423 in the commit message to better link the original report with the commit.

Would yo kindly add the line

    This fixes https://github.com/git-for-windows/git/issues/423

before the Signed-off-by lines?

Thanks,
Dscho
