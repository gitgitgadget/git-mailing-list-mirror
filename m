From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Sun, 27 Jan 2013 22:36:53 -0800
Message-ID: <7vpq0pyfsq.fsf@alter.siamese.dyndns.org>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com>
 <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com>
 <7vpq0t3x60.fsf@alter.siamese.dyndns.org>
 <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com>
 <CACsJy8BwCCAZyMZ2w9fyMaNJsHRNp2V3Aen8g3drAkZ4y9mfBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 07:37:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TziLO-0002tW-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 07:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab3A1Gg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 01:36:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab3A1Gg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 01:36:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFA228960;
	Mon, 28 Jan 2013 01:36:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f66e22h5IYst+OGIFTbSJ56Sbz4=; b=pAAOE3
	G0vgX09bmf8tGzW7aPNUCsxEHWbPJ7oswLCsy3pQuDzOAeX2ux2DYRKKQvV/gWb1
	iFXaa+S3WasRV7cIArRADG7HXZ49785IfQWkQqBdcTrC7I1aSibqMyAt/iHffmem
	ORzY2+SLLkLjHPYOpy5wBgpXlacaiF8WTKzyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kDE9x8qwZD/Rr8dMLwkM0YYWvwmNftj5
	MLi7UZZlTUJxE3alUxd2zXg+5yFx4ba/fiHlTqEsGxb79DwrbDlsAMqhj5vJJoOv
	7UxsBmbr5LFd9MUv1mAMKUHvGOKQ9l0QvNyXieq0Fm10+fidiCrbtLvfaJRjKLWk
	a/kufxIz82I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E161F895E;
	Mon, 28 Jan 2013 01:36:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C5AA8959; Mon, 28 Jan 2013
 01:36:55 -0500 (EST)
In-Reply-To: <CACsJy8BwCCAZyMZ2w9fyMaNJsHRNp2V3Aen8g3drAkZ4y9mfBg@mail.gmail.com> (Duy
 Nguyen's message of "Mon, 28 Jan 2013 13:18:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BB3A114-6915-11E2-8274-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214813>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jan 28, 2013 at 12:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Regardless the submodule odb issue, I think we should prefer
>> reading local loose objects over alternate packed ones.
>
> I think I went from one problem to another and did not make it clear.
> The reason behind this preference is security.

Reading from ours first would not help you at all if you are lacking
some that you do need from your local repository and the only
solution is not to borrow from untrustworthy sources, I think.

You borrow only from a trusted source in the first place, no?
