From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Fri, 05 Feb 2010 20:43:45 -0800
Message-ID: <7vbpg3dldq.fsf@alter.siamese.dyndns.org>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
 <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
 <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
 <7vtytvf4vp.fsf@alter.siamese.dyndns.org>
 <76718491002052018s324747ecj31963b493868dbbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 05:50:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndcci-0000Dz-G4
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 05:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab0BFEn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 23:43:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab0BFEn5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 23:43:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE22997F2A;
	Fri,  5 Feb 2010 23:43:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QLlnCmOAszuJ
	0pEBOx+6fHYeizU=; b=l0amgnYT5Cv3VXKVOe9nZj/kpN4KoX8VAfxGWedYIi2y
	su8Soi5zPd3vQbzUE9RVh3uApU/4oQQ4DW+V9SVGlhUFxHRNdn+exZAMYyc6I87I
	UnqJwjL/WqlW/tipivG9OLUd0i4GbFziht5HcaZPD/OcLuvT8Sqag5KPB8mco1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TtTcb8
	eGaF/SsBxQCwsZjhDU6sPsgSj/XeeHK6xHUebV7gaUBN/+Bd/z5c4oRfCQyVB1xk
	kVOPA4cgM8mIld+NNa5euq9azbUpIfrKsNW12VUrygjbRYIkddBM/2gzHCVsD6YS
	fj2lvl8dCvH6iiw/z54ExTHTI1x7EDhczoTZ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 832D997F29;
	Fri,  5 Feb 2010 23:43:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A316597F28; Fri,  5 Feb
 2010 23:43:46 -0500 (EST)
In-Reply-To: <76718491002052018s324747ecj31963b493868dbbd@mail.gmail.com>
 (Jay Soffian's message of "Fri\, 5 Feb 2010 23\:18\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39218EE4-12DA-11DF-9279-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139143>

Jay Soffian <jaysoffian@gmail.com> writes:

> Since there is a difference of opinion here, how about this proposal:
>
> 1) We keep -x in cherry-pick
>
> 2) I convince you to add my -x patch to rebase.sh (hmm, how to do tha=
t?) :-)
>
> 3) We add a -X option to both cherry-pick and rebase.sh that records
> in the notes instead of in the log message.

How could that be a counterproposal to a deprecation of -x and adding
hooks as a replacement, as a solution to more general issues?

>> I ended up using this hacky script for that. =C2=A0It finds the svn =
uuid from
>> the metadata file, and then finds ".rev_map.$uuid" files from all ov=
er the
>> place to see if any of them contains a record that points at the git
>> commit I am interested in.
>>
>> I really wish "git svn" has a built-in way to do something like that=
;
>> perhaps I didn't look hard enough.
>
> Is git svn find-rev not what you want? (Caveat, it doesn't seem to
> work for me, but it's claimed description seems to be what you're
> asking for.)

Maybe, but it calls cmt_metadata() which is "grep ^git-svn-id:" of the
commit object, so we know why it doesn't X-<.
