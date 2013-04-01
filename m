From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] checkout: add --no-widen for restoring files in
 sparse checkout mode
Date: Sun, 31 Mar 2013 22:12:14 -0700
Message-ID: <7vli92ltqp.fsf@alter.siamese.dyndns.org>
References: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
 <1364637753-18785-1-git-send-email-pclouds@gmail.com>
 <20130401044816.GI11704@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, kirill.mueller@ivt.baug.ethz.ch
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 07:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMX30-0001Rw-UI
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 07:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab3DAFMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 01:12:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab3DAFMR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 01:12:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B983FDFD;
	Mon,  1 Apr 2013 05:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aJtFDg+qxwZe
	OjC+GVQWZbMYGZc=; b=KYk5jPkfoG/J+XQiLILh1JGkxkJvJYiU4mxxVSmekAlu
	ZU3s5/jR8TRZKaoctiaCuQ2L2oZ2Fi8Hqro1RueLrqMlVIsORHO2VrP12As8Mtsl
	FttGCuQockwYBW3PoNjKZ5T2ANg6LaFMDN45ZJjFzHXPzxIdjVFAIR39P/9nOGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t3uARZ
	Or2QRi0hVDbFIF3jYw/9PieJrR7n15a6kZ1xevJkVAgUUcl+HBzITbdnFDjv1A8d
	q21JqfMaqBODupf4vyvC9pQliH+e4CXl5McYVo2S/VmfnA/7MW0PMimWd/pewXmw
	cB2/QafXQupIIncv8Urnkyvo3n8+oFkScUWj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92EA6FDFC;
	Mon,  1 Apr 2013 05:12:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AF1CFDFB; Mon,  1 Apr 2013
 05:12:16 +0000 (UTC)
In-Reply-To: <20130401044816.GI11704@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 31 Mar 2013 21:48:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B83598B6-9A8A-11E2-BEA8-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219670>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> "git checkout -- <paths>" is usually used to restore all modified
>> files in <paths>. In sparse checkout mode, this command is overloade=
d
>> with another meaning: to add back all files in <paths> that are
>> excluded by sparse patterns.
>>
>> Add "--no-widen" option to do what normal mode does: restore all
>> modified files and nothing else.
>
> In an ideal world, I would like "git checkout --widen" to modify the
> .git/info/sparse-checkout file, to be able to do:
>
> 	git clone --sparse-checkout=3DDocumentation git://repo.or.cz/git.git
> 	cd git
> 	git checkout --widen -- README COPYING INSTALL
>
> and hack on a tree with Documentation/, README, COPYING, and INSTALL
> present with no actual code to distract.  And "git checkout --no-wide=
n"
> could be a way to ask to respect the existing sparse pattern.

Yeah, I think the above makes tons of sense, and --widen would be an
ideal name for that optional behaviour.  When you are limited by
your original sparse pathspecs, that would be a way to explicitly
widen the paths you interact with.  In that sense, making it off by
default would be a sensible thing to do.  When you limited yourself
to a subset of dir/, you do not want "git checkout dir/" to
automatically widen it by accident.

> This patch isn't about tweaking the sparse-checkout pattern; instead,
> it's about how "git checkout" interacts with the skip-worktree bit.
> Maybe a good name would be --respect-skip-worktree?

Yeah, but when would one want to say --no-respect without widening
the sparce pathspecs?
