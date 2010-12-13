From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/19] tree_entry_interesting(): remove dependency on
 struct diff_options
Date: Mon, 13 Dec 2010 11:11:34 -0800
Message-ID: <7vbp4p1o9l.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:11:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSDoK-0007tr-Fn
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab0LMTLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 14:11:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab0LMTLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 14:11:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1866F377D;
	Mon, 13 Dec 2010 14:12:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2YGHaYLgjPeE
	nM63Fr6GSLiu1Gw=; b=gwLBkkavcFYLrq839BAREOvS7673c4TWE04SGAztBQkp
	BwW434e5YUEYTAY1/goSxKu+L2BtYvoDX8q+HQ2lGNmgHr8gl7u1fr095rIJZXUl
	Nfe6KpJAr1EV195WlMzfsa06EaUI5qoxODjZ2kE2cZ1xcAuaAp4GVZsdHitrBj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DgFoPS
	cYM8fBK/7G+LuWsLXrlJ3TmLR90QzJT9lltgZLCVBj6EjE4UvN1vgUnrdTV4XEX6
	XZ4GrEfHZqnuDpKfs9Uxo/HklWhSAPs+knrn6xSmEBhnQzjP0DNxzpo2XKE4Ba7J
	/ZeNUOuTKHPTn0aZppGtI36I816myhSe5nybA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6544377C;
	Mon, 13 Dec 2010 14:12:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 10580377B; Mon, 13 Dec 2010
 14:12:01 -0500 (EST)
In-Reply-To: <1292233616-27692-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 13 Dec
 2010 16\:46\:42 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DF44C1F4-06EC-11E0-8E64-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163581>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This function can be potentially used in more places than just
> tree-diff.c. "struct diff_options" does not make much sense outside
> diff_tree_sha1().
>
> While removing the use of diff_options, it also removes
> tree_entry_extract() call, which means S_ISDIR() uses the entry->mode
> directly, without being filtered by canon_mode() (called internally
> inside tree_entry_extract)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

The patch looks good, but the second paragraph above sounded unnecessar=
ily
alarming and I had to read it three times to make sure nothing fishy is
going on ;-).

It bypasses tree-entry-extract call and uses fields of "entry" directly=
=2E
With the change, entry->mode is used without first getting normalized w=
ith
canon_mode(), but the only use of the mode information in this function=
 is
to check the type of the entry by giving it to S_ISDIR() macro, and the
result does not change with or without canon_mode(), so it is Ok.
