From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] checkout --conflict=diff3: add a label for
 ancestor
Date: Mon, 15 Mar 2010 01:20:00 -0700
Message-ID: <7vvdcy0zf3.fsf@alter.siamese.dyndns.org>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock> <20100315074748.GA28827@progeny.tock>
 <20100315075509.GD8824@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 09:20:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5XO-0007sh-Qr
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759826Ab0COIUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:20:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759794Ab0COIUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 04:20:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C389A1E42;
	Mon, 15 Mar 2010 04:20:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NfnimBOa6IG4
	6nv4ZkM280DlI8w=; b=KKnpc7TPeK4Ywd0ZtmGCrr2czR/vE5WSd+fimjthU51w
	vkCGrgoAeg8bvZMxFE/mdInU6gxYjivmdzOkhJpfTWEGYNSSp+swlUHW2JG1t2X0
	VJVW7U7sXIc+4bJfEaYGfzEZOafI+urX+X9gZRAX19UXcQafagZ54hGLNxcTaFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Y/b/U/
	ggKZACANfgUKPJsb4e7TWdnV7t5quVI24VaT4pPDksRzgqE7kVGVBLjWBNH15shO
	wBt8AgwB8+3SPoc/YQ94+pBc3MGBUKPxF+THCoz9YGOK9Mw/AlKmQHWwoyRS52JD
	J2beLKSBOt93wRfrMCzbd3XTmmz5HGuTLOAPs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B541A1E3E;
	Mon, 15 Mar 2010 04:20:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 925F9A1E3D; Mon, 15 Mar
 2010 04:20:01 -0400 (EDT)
In-Reply-To: <20100315075509.GD8824@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 15 Mar 2010 02\:55\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F62B122-300B-11DF-AE13-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142188>

Jonathan Nieder <jrnieder@gmail.com> writes:

> git checkout --conflict=3Ddiff3 can be used to present conflicts hunk=
s
> including text from the common ancestor:
>
> 	<<<<<<< ours
> 	ourside
> 	|||||||
> 	original
> 	=3D=3D=3D=3D=3D=3D=3D
> 	theirside
> 	>>>>>>> theirs
>
> The added information can be very helpful for resolving a merge by
> hand, and merge tools can usually understand it without trouble
> because it looks like output from =E2=80=98diff3 -m=E2=80=99.
>
> Unfortunately, not all can: =E2=80=98diff3=E2=80=99 includes a label =
for the merge
> base on the ||||||| line and it seems some tools cannot parse conflic=
t
> hunks without such a label.  Humans could use help in interpreting th=
e
> output, too.  So mark the start of the text from the common ancestor
> with the label =E2=80=9C||||||| original=E2=80=9D.
>
> git rerere will not have trouble parsing this output, since instead o=
f
> looking for a newline, it looks for whitespace after the |||||||
> marker.

Missing:

    "... and adding the extra label will not affect the computed the co=
nflict
    identifier, so existing rerere database will not be invalidated wit=
h this
    change either".

I didn't verified the above claim, but if it does not hold true, then w=
e
need to think the transition strategy.  I don't expect a problem, thoug=
h.

> Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

This "Reported" feels very odd for a feature enhancement ("Requested"
would be more appropriate) not a bugfix.

> ---
> Since =E2=80=9Coriginal=E2=80=9D a good name for the common ancestor?=
  I also
> considered =E2=80=9Cbase=E2=80=9D and =E2=80=9Cancestor=E2=80=9D; the=
 latter is too jargon-y for my
> taste, but =E2=80=9Cbase=E2=80=9D seems all right.

Yeah, base sounds good.  Even though at the lowest level, a merge is a
merge between two equals, people tend to think of the contents of their
own side "original" (vs the merge outcome "result").
