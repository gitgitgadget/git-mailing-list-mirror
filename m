From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: add known breakage of coloring when using extended
 patterns
Date: Mon, 02 May 2011 15:04:45 -0700
Message-ID: <7vwri8kbcy.fsf@alter.siamese.dyndns.org>
References: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com> <4DBEE672.5070707@lsrfire.ath.cx> <7vd3k1ngun.fsf@alter.siamese.dyndns.org> <4DBF1D2A.6030807@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Thiago dos Santos Alvest <hiago.salves@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue May 03 00:05:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH1F9-00071F-5g
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 00:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308Ab1EBWFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 18:05:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759177Ab1EBWFC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 18:05:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B68775938;
	Mon,  2 May 2011 18:07:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F1QZO6j8YIKN
	2QKOD9UjNQ1j+Ic=; b=BnNuBu/jmc9GS+eL2mZbkeAetKrjEs2PB6298XdgQ1Y8
	xGr6dxhNjMBXPeXgtVTeoTUPv7c3sUX/3HfbQ0HigmwpBSFW4BJFFVOnpH21lq+n
	nchsAH5KbnFnGqMc+Sr/nXQLQY6pJRaGAYqaPXk5COte13g+A7YMD9TFRqc4Rig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kC4HCw
	XeRIkPS2qjyEIMDANxeDhm+03jkUN7inMW7Aiwx5cNd0+U9rv5DrgJO0z4vtzceu
	TUD2kBy6KlLQ+WLmenCt20lW+pSM1wfswpnn+hubp/TLHkKVmSnVsCVJq+Z3/TFK
	obAw4K06xWbPGUnbqVfZFJN8A6nIQSiopyaUQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E2D65935;
	Mon,  2 May 2011 18:06:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2EC3B5933; Mon,  2 May 2011
 18:06:49 -0400 (EDT)
In-Reply-To: <4DBF1D2A.6030807@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 02 May 2011 23:07:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F75A8F8-7508-11E0-AC58-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172635>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Aggregating the set of matching characters and passing them back
> during expression evaluation can be more efficient, yes, as it would
> avoid calling regexec() on the printed lines again only to find out
> what to color.  But I wouldn't call it easy.  E.g. how to return the
> set of matching characters in the following case?
>
> 	$ git grep --color -e foo --and -e bar

I would na=C3=AFvely expect each of the "grep_expr" in the parsed grep =
tree to
have not just a one-bit "hit", but rm_so/rm_eo pair, but as I said, I w=
as
asleep while "coloring the parts that matched" discussion was in progre=
ss
;-)

But

> Also GNU grep doesn't only color the first sufficient match.
> E.g. this will color both b and d:
>
> 	$ echo abcde | grep --color -e b -e d

that is probably a useful thing to have.  Obviously, my suggestion shou=
ld
optimize away the match with 'd' to begin with, so keeping rm_so/rm_eo
pair would not help painting d at all.  Worse yet, I would expect that

	$ echo abcdeabcde | grep --color -e b -e d

would need to paint all occurrences for such a purpose, so obviously yo=
u
would need an extra pass to find all potential hits.  Ugly and makes me
personally wonder if it is really worth it, but the user is explicitly
asking for --color and is prepared to pay the price, so it probably is =
Ok.
