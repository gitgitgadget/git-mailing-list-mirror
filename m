From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sun, 05 Feb 2012 13:12:16 -0800
Message-ID: <7v4nv5gf2n.fsf@alter.siamese.dyndns.org>
References: <1328368255-10591-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0xfbxLs_r81ppO9hYf3ML_gaYCaW3TKpLM=BjfaM8vHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9No-0001S8-09
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab2BEVMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 16:12:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2BEVMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 16:12:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CE0F57F8;
	Sun,  5 Feb 2012 16:12:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=adMzqsfGgJef
	Q+IcLH60AkVb7uw=; b=T2hwqQVcw/He1S6pfFRF/1we61/0RQKZ/dn4mcFgBUub
	cTwPecNnLSkJMPG+0OJpSeOXx4aeqH1Y2IMRuYYNTsVO7sGDcGYI/Yre5UQxVQw7
	mlTumR/YV39sLlF7WzPgJLXGFujWklvx7qdOdWScuhC0BmYjrAF+ffuULl+7cQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I6kSuQ
	WWbTodywsFJ755IAfoiDq2VciDkthGD91iSxfJdxh5JvWaIQhXKu/+6OecYYwqry
	CdCy3iw/oHMx77hllJlHs+M4cx4lT4yPcqgiZ7mKuEtIQNU2PVTiW8YNyi2RYqLk
	US3abtouGhCc7L8jMeTdIIJMdIXS+JniXH5pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9354657F7;
	Sun,  5 Feb 2012 16:12:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FD9557F6; Sun,  5 Feb 2012
 16:12:18 -0500 (EST)
In-Reply-To: <CAMP44s0xfbxLs_r81ppO9hYf3ML_gaYCaW3TKpLM=BjfaM8vHg@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 4 Feb 2012 17:26:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15C77B5E-503E-11E1-8F49-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189963>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, Feb 4, 2012 at 5:10 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Otherwise, 'git send-email' would be happy to do:
>>
>> =C2=A0% git send-email --to '<foo@bar.com>>'
>>
>> And use '<foo@bar.com>>' in the headers.
>
> Er, actually that's not correct: '<foo@bar.com>>' will remain the
> same, but 'Foo <foo@bar.com>>' will be sanitized.

I suspect that this "Er" is merely a sympotom of a larger issue in the
approach taken by this patch.  The code takes a potentially malformed
input, and applies a rewrite logic without telling the user what it is
doing.  If the rewrite logic is perfect, that may be OK, but if not, th=
e
logic to rewrite may or may not trigger, or when it triggers it may or =
may
not produce a correct result, and it all depends on the nature of break=
age
in the input.

Wouldn't a better approach to detect problem on the input side and reje=
ct
a wrong one by erroring out, so that the user has a chance to fix?
