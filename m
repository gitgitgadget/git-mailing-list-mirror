From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Wed, 13 Jun 2012 13:10:17 -0700
Message-ID: <7vbokngehi.fsf@alter.siamese.dyndns.org>
References: <20111022001704.3115.87464.reportbug@hejmo>
 <20120610090516.GA30177@burratino> <4FD78EA0.2090306@lsrfire.ath.cx>
 <20120612202953.GG9764@burratino> <20120612210003.GA16816@burratino>
 <4FD8C0F6.8060609@lsrfire.ath.cx> <7v4nqfi0vz.fsf@alter.siamese.dyndns.org>
 <20120613194347.GA7967@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Eduardo =?utf-8?Q?Tr=C3=A1pani?= <etrapani@gmail.com>,
	git@vger.kernel.org, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:11:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Setu8-00056l-Ii
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 22:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab2FMUKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 16:10:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162Ab2FMUKU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 16:10:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 173E4862C;
	Wed, 13 Jun 2012 16:10:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sEWcdehQRz1N
	NS0zOBjzBdd3O70=; b=d3iJ4E19/5wSrRKcD5rC+OpE9nPpxy/VIXM66L+1pMRl
	h1zG9jURq9cCuMjxIsETHpOeTd2UpxDSNhPIgllEeNKYZORcY006+J5IKeCjdzNQ
	sLpSQBsgYlJAk2Uu4Bd5Y29XUgR4pkfKujXdEgjRYgm6VmxnrHsPrefHfKfOr9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oh2AHV
	nObUDGjY9hYBLSt9c2QfSoS2IHspEcclUTn4fDr9RsuBBSa3FT8NOa2IgDU2yt11
	v1M07C75lCK/lLW1trdaRHN/+OifYUuAJM3YU2uS3HzFbLa/f1dCJmFvucR8pox6
	DD4Aka0hmk2WxMJ8RBuaKMg2izQZp0QrOudqo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D297862B;
	Wed, 13 Jun 2012 16:10:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B66D8629; Wed, 13 Jun 2012
 16:10:19 -0400 (EDT)
In-Reply-To: <20120613194347.GA7967@burratino> (Jonathan Nieder's message of
 "Wed, 13 Jun 2012 14:43:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCA234D0-B593-11E1-8B7D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199941>

Jonathan Nieder <jrnieder@gmail.com> writes:

> On Wed, Jun 13, 2012 at 10:21:04AM -0700, Junio C Hamano wrote:
>> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>> Am 12.06.2012 23:00, schrieb Jonathan Nieder:
>
>>>> Oh, hold on a second.  Won't this get confused by
>>>>
>>>> 	ssh://[::1]/foo/bar/baz:80/qux
> [...]
>>> It shouldn't, because the host part is NUL-terminated before
>>> get_port() is called.  Let's see (with the patch):
> [...]
>> Yeah, I was wondering how that would get confused myself.  Jonathan,
>> ack again?
>
> Yeah.  I had missed that when proto =3D=3D PROTO_SSH that means the p=
roto
> !=3D PROTO_LOCAL branch has been taken and the port is NUL-terminated=
=2E
>
> So
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> It seems like a good fix given the current code structure.  Sorry for
> the false alarm.

Thanks.

By the way, it seems that Debian/Ubuntu are still carrying a bit
more changes and rewrites in the connection code as local
patches. Mind upstreaming them for the next cycle?
