From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3703, t4208: add test cases for magic pathspec
Date: Mon, 09 May 2011 09:18:35 -0700
Message-ID: <7vvcxjq23o.fsf@alter.siamese.dyndns.org>
References: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
 <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <7v7ha1t6o9.fsf@alter.siamese.dyndns.org>
 <BANLkTikONPUVvAEw+fSDva8RUp-YSm-Nxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 18:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJTAb-0007QZ-BE
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 18:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab1EIQSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 12:18:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1EIQSq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 12:18:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F38E41DC;
	Mon,  9 May 2011 12:20:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U5WzGu1aijJt
	xZc/OmYNFHYP2Pk=; b=YZvWMOotvcGi1EVwCVzIBNNXqkR9ZVjP9dD6o9R9PhSv
	CZb5jfINtjvVYRr8Melo/nUlYpAKBH/9R2w8qHmlhDxLAN61NqW7FMDtF7MCPxaB
	slMda4uRP/FPAj1Pi/4pXQSKj4zih4Dmasi/ztRpXVmfONtrofCldSfh0wwb2T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qPAVBg
	oTlW3bRbkJ/RwmwguAQjOzPV+lH8IHuyUV2zupmfAcs+0vhiQmHdXlVtX/b8ejqf
	YnE6gSi+LMpXje8aCIW2HavuiKTdDAXGRJX24bzuV1glV6cHOctl5zadl2fTzHF9
	xrDVDnl1rQ9yVrUMw71vbDWi8W66jM4KiP0eg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1DC241DA;
	Mon,  9 May 2011 12:20:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98C9D41D5; Mon,  9 May 2011
 12:20:41 -0400 (EDT)
In-Reply-To: <BANLkTikONPUVvAEw+fSDva8RUp-YSm-Nxw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 9 May 2011 19:33:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BC05D46-7A58-11E0-9DDD-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173242>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> Shouldn't
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git anycmd :
>>
>> be equivalent to
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ (cd $(git rev-parse --show-cdup)/. && g=
it anycmd)
>>
>> for any command? =C2=A0I doubt this test is expecting the right outc=
ome.
>> Shouldn't it result in "Nothing specified, nothing added."?
>
> It's gray area.

I do not see anything gray in it.

"git add :" in subdirectory is simply broken because we have used "No
remaining command line argument means no pathspec" when deciding to sto=
p
and say "Nothing specified, nothing added".  That was a sensible
assumption back then, but it needs to be updated to take the new "The
remaining command line argument may say that there is no pathspec" real=
ity
into account.
