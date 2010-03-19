From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Fix CDPATH problem
Date: Fri, 19 Mar 2010 16:43:28 -0700
Message-ID: <7vd3yz513z.fsf@alter.siamese.dyndns.org>
References: <d557014b1003191436r4d141825p6c5b8e1b3bee4fc8@mail.gmail.com>
 <7veijgc6md.fsf@alter.siamese.dyndns.org>
 <d557014b1003191525m490d1bfam4e8ce40681ff2214@mail.gmail.com>
 <20100319234033.GA18035@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Cox <mhcox@bluezoosoftware.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 00:43:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nslr9-0007Mn-Df
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 00:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab0CSXnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 19:43:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab0CSXnj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 19:43:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DF52A37B2;
	Fri, 19 Mar 2010 19:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cCqzkn84u0eC
	P2ARE8XS+ISb7+Q=; b=PlFiemJ0JdUUlMytC+fZE2nCunRWp6l+3xNta7ZH8FeR
	PreeSa9tWF/4Ai4SeFBBce2re2q7ngS5JjB3jz+u388bsy9qEVZ0qkNfVnEEHqnE
	wU3IxCIa3YzFJ9C8v6cBWU3NxzXtvAjHqLhctmGIcYUlmROs3ERCTrQXeaMUKDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=chicVB
	Hw98QQHsvC87IXIXY25VLylax3RcskfXot4bOudGEfav0RD1PFt3SInPDHTDQGJM
	kAOD5Wb84vANgAlaq0CFwVvq9CQfWKgrRpH7NcYMQR1TRfJ8iaII9pilwfoFYQ4M
	rv9hY5RloXd9LRbGi4BF3Br5P+x9Hml8mjzEU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AA68A37B0;
	Fri, 19 Mar 2010 19:43:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E02BA377B; Fri, 19 Mar
 2010 19:43:29 -0400 (EDT)
In-Reply-To: <20100319234033.GA18035@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 19 Mar 2010 18\:40\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AC72798-33B1-11DF-94CB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142663>

Jonathan Nieder <jrnieder@gmail.com> writes:

> CDPATH takes scripts to unexpected places.  For example, with a CDPAT=
H
> including a blt directory:
>
>  make -C templates DESTDIR=3D'' install
>  make[1]: Entering directory `/users/e477610/exptool/src/git-1.7.0.2/=
templates'
>  install -d -m 755 '/home/e477610/exptool/share/git-core/templates'
>  (cd blt && gtar cf - .) | \
> 	(cd '/home/e477610/exptool/share/git-core/templates' && umask 022 &&=
 gtar xof -)
>  gtar: This does not look like a tar archive
>
> The CDPATH mechanism does not implicitly add "." at the beginning of
> CDPATH, which is the most irritating part.
>
> Most git scripts already protect against use of CDPATH through
> git-sh-setup, but the Makefile doesn=E2=80=99t.

Eh, the rationale and the in-code comment need to be fixed.  The issue =
is
not "taking us to random places", but "reporting the name of the random
place in its standard output".

But other than that, this is something we have seen on the list a few
times, and I think it is about time to do this.

Thanks.
