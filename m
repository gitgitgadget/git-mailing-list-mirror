From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] Take four on fixing OPT_SET_PTR issues
Date: Mon, 31 Mar 2014 10:23:44 -0700
Message-ID: <xmqq4n2e8eov.fsf@gitster.dls.corp.google.com>
References: <7vtxago359.fsf@alter.siamese.dyndns.org>
	<cover.1396177207.git.marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:23:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUfwA-0008Ak-SA
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 19:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbaCaRXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2014 13:23:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbaCaRXr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 13:23:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0810787DB;
	Mon, 31 Mar 2014 13:23:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2i29JEDFyFtQ
	d9E6aVkAUcyZbE8=; b=xXAy/3u6sbHwShXTZwP04FSd2sLlyhoWAbRlopLbvMQj
	M+OC6c3gr5b/Tod0jBVleKQTaKV9tQg7Wi/cdUusMW0JS7W+pmmpvGXqqdvcEk5x
	Wj2wxxO+uXjDkUlDDFNTOowDCT001RYgLTDUubnigAEGrkFxhzbpttV5uCLdT5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xxMFND
	lCN5/wpy8e6t4/ujdoniNCNLiOu2908tQmlf9n4/zYqfUjbTgukv0QDvqQhDZ0+/
	rf7yKySrp+63MeY6OzGA0xYOUV8RmcvCovzPsjT1wHchLDfUNnFCtJ7lrvCEQnT+
	RaUNqjnNipNn/9gYBgPId9jsR3taDFin2fcYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD910787DA;
	Mon, 31 Mar 2014 13:23:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06258787D9;
	Mon, 31 Mar 2014 13:23:45 -0400 (EDT)
In-Reply-To: <cover.1396177207.git.marat@slonopotamus.org> (Marat Radchenko's
	message of "Sun, 30 Mar 2014 15:08:20 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36FF7ECC-B8F9-11E3-BAB4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245497>

Marat Radchenko <marat@slonopotamus.org> writes:

> Patches summary:
> 1. Fix initial issue (incorrect cast causing crash on 64-bit MSVC)
> 2. Improve OPT_SET_PTR to prevent same errors in future
> 3. Purge OPT_SET_PTR away since nobody uses it
>
> *Optional* patch =E2=84=963 is separated from =E2=84=961 and =E2=84=96=
2 so that if someone someday
> decides to return OPT_SET_PTR back by reverting =E2=84=963, it will b=
e returned
> in a sane state.
>
> Decision of (not) merging =E2=84=963 is left as an exercise to the re=
ader due to
> my insufficient knowledge of accepted practices in Git project.

SET_PTR() may not be used, but are there places where SET_INT() is
abused with a cast-to-pointer for the same effect?  I didn't check,
but if there are such places, converting them to use SET_PTR() with
their existing cast removed may be a better way to go.

My suspicion is that there would be none, as switching the behaviour
based on a small integer flag value is far easier than swapping the
pointer to a pointee to be operated on, when responding to a command
line option.
