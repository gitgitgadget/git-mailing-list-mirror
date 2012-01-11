From: Junio C Hamano <gitster@pobox.com>
Subject: Re: leaky cherry-pick
Date: Wed, 11 Jan 2012 00:16:50 -0800
Message-ID: <7vipki7ix9.fsf@alter.siamese.dyndns.org>
References: <20120109223737.GA1589@padd.com>
 <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
 <20120110195017.GA19961@sigill.intra.peff.net>
 <CALkWK0kDnxjtQ+ihH_dif_7yivHLd=pibao4KPs_PDXfc2UMOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 09:17:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RktMg-00050x-QV
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 09:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab2AKIQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 03:16:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab2AKIQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 03:16:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94D715B39;
	Wed, 11 Jan 2012 03:16:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IXlTD5n+h1MyUPluXVzmrjuPpu8=; b=KBU0NW
	OAQM56jz2k2VEzQKp3Rdif8kD+esFMRyaWdNfxeBMVgrTh8PCl3tvPcUpdyZ/xsM
	S3bW11/ULfw+2gpBvOAkDVZ/0x2aj5CHT2zkM4j3s2Fery5aabR4s0oXgI26H55F
	ujM5LQA+fGd/A+exgauIqvb5ZBoSswGgez7xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3qtNWIgFt45m6iqZx6y43+vRtyp5FGI
	Cgk5w17HaX+BEedDgTkUd0pUvfJszRgRvPg79QzMn3qyQRlsmkR3ObuQ36e1Scft
	4SuDXR52Hoyl8KBF3Xec7EI3yPZbJKrkRMOOnPaPtQQpowstXuB1lNCI6g2qRzEP
	Hdm6op1YF/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CA255B38;
	Wed, 11 Jan 2012 03:16:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 127825B37; Wed, 11 Jan 2012
 03:16:51 -0500 (EST)
In-Reply-To: <CALkWK0kDnxjtQ+ihH_dif_7yivHLd=pibao4KPs_PDXfc2UMOA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 11 Jan 2012 09:00:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DC34E00-3C2C-11E1-A8E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188343>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> If you then do a lookup for "foo/bar/baz/file2", it can use the exact
>> same stack without looking for or reparsing the attribute files. If you
>> then do a lookup for "foo/bar/bleep/file", it pops only the entry for
>> "foo/bar/baz/.gitattributes", and pushes only the entry for
>> "foo/bar/bleep/.gitattributes".
>
> I see.  Thanks for the excellent explanation-  I'll try implementing
> this scheme.

I somehow have a feeling that you did not read the conclusion in Peff's
message correctly.  The code only keeps data from one active path of
per-directory .gitattributes files to the leaf of a working tree and
releases unneeded data (IOW, it "pops" the attr_stack elements) when it
goes on to look at the next path, so my understanding is that there is
nothing to "try implementing" here.

Unless attr.c::free_attr_elem() is leaky, that is. If that were the case,
such a leak will accumulate and would make a difference.
