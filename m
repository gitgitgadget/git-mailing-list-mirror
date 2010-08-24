From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-notes: Run partial expensive test everywhere
Date: Tue, 24 Aug 2010 09:46:19 -0700
Message-ID: <7vd3t8x8kk.fsf@alter.siamese.dyndns.org>
References: <1281470164-27008-1-git-send-email-avarab@gmail.com>
 <1281483468-24388-1-git-send-email-avarab@gmail.com>
 <AANLkTikfwbtKt2WrxzRyKHnP3ySGtBF33=z_rJwjPx5Y@mail.gmail.com>
 <20100824071453.GA3064@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 18:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onwdw-0007i5-OE
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 18:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab0HXQqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 12:46:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab0HXQqa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 12:46:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BE79D084C;
	Tue, 24 Aug 2010 12:46:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RYQS7BK91tl2
	pg5I8RmxvOqqEi0=; b=R9MI97QCPMI5IFFCJwKVVvqrTeM7iLX0tcl4gpmPIZSr
	HySgrMp48oNZ4fyTXu9BxBkdCvUNBo2LyjGU51ajvHJfuXugdl93NGqOH9UAUWM6
	eCRdXoqlOkMJkikPKHqlgHfIICjDzrt6nTFzl5soElf6XTHlWVD8lSWj2gH2n6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hsSyvW
	6aA0CRwKnLmezAgqT6FidyOrGiIvHUjgUIJNLLLsGjiQ2G4Hf345GOn0SjKgI/NU
	VmTQV1peRYN2PKaq7GZ3lXWY0PCNAwcIIo17Jk3l/XOlkrVsdA1BIbg+22aEQyeb
	8WXCJwot2ej+huyTtglGn0KZCahZ+bwFQ/+K8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B03D0845;
	Tue, 24 Aug 2010 12:46:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2494FD083D; Tue, 24 Aug
 2010 12:46:20 -0400 (EDT)
In-Reply-To: <20100824071453.GA3064@burratino> (Jonathan Nieder's message of
 "Tue\, 24 Aug 2010 02\:14\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 22A7DBE8-AF9F-11DF-BC2A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154323>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Odd.  Different how?  As far as I can tell, all that test asks
> of time is to execv() its arguments and pass on a 0 exit status.
>
> Ah, maybe this is it: perhaps /usr/bin/time sh runs /bin/sh.  Does th=
e
> following help?
>
> Patch is against next.  Untested except on Linux where it wouldn't
> make a difference.

Makes sense, although I don't have access to Solaris boxes right now...

> -- 8< --
> Subject: t3302 (notes): Port to Solaris
>
> The time_notes script, which uses POSIX shell features, is
> currently sometimes run with a non-POSIX /bin/sh.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-e=
xpensive.sh
> index 7c08e99..e35d781 100755
> --- a/t/t3302-notes-index-expensive.sh
> +++ b/t/t3302-notes-index-expensive.sh
> @@ -96,7 +96,7 @@ time_notes () {
>  	for mode in no-notes notes
>  	do
>  		echo $mode
> -		/usr/bin/time sh ../time_notes $mode $1
> +		/usr/bin/time "$SHELL_PATH" ../time_notes $mode $1
>  	done
>  }
> =20
> --=20
