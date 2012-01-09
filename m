From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Eliminate recursion in setting/clearing marks in
 commit list
Date: Mon, 09 Jan 2012 14:09:29 -0800
Message-ID: <7v4nw4edeu.fsf@alter.siamese.dyndns.org>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
 <1326081546-29320-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 23:09:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkNPN-0004G5-J7
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 23:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808Ab2AIWJd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 17:09:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab2AIWJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 17:09:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F197C33;
	Mon,  9 Jan 2012 17:09:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eAU9N/3Bel5K
	xr6JTs2yVFUGChs=; b=JQdXjXHhIEDsX56HMGNjS3Hr4/S+L8DATsB4sEPML2t/
	+LmLywjlvB3DTQVxtjgFy3oyka/qy+ytBwR/gEGKzlphj6OENjw9b8/vzX9FYKWN
	J6GgQx/yjqM4ACOP2w3+qZkJiudzMipxWpTiBwuj7u9Xzd73gCP0aijxzKrbvVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eU9TEb
	y0B3s4FX1Jkw7e4KzyhdmpQhDNlFIhrb0XZmWSqk+A2Yes8zyM1a5z0Fk+lGAffZ
	ZqZroUfLd0r/q6SLHLOzFMxO9h4cEr2sqyv9N7KifASg6EqzLiHg30wsGJ/1o/3s
	Cf9XUSAbX4XtlQU50Y97qZJRxcLJzNFAbAcSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EE5D7C32;
	Mon,  9 Jan 2012 17:09:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 003E67C31; Mon,  9 Jan 2012
 17:09:30 -0500 (EST)
In-Reply-To: <1326081546-29320-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Jan
 2012 10:59:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AC6A216-3B0E-11E1-AD6C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188193>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Recursion in a DAG is generally a bad idea because it could be very
> deep. Be defensive and avoid recursion in mark_parents_uninteresting(=
)
> and clear_commit_marks().
>
> mark_parents_uninteresting() learns a trick from clear_commit_marks()
> to avoid malloc() in (dorminant) single-parent case.

Looks cleanly done.

This retains the depth-firstness of the (supposedly less common case)
recursion in mark_parents_uninteresting() from the original code, by
adding the already parsed parent at the beginning of the queue. I suspe=
ct
that the original went depth-first primarily because that was the most
straightforward way to code it, but now you have more flexibility, I
wonder if there is a difference if we made it width-first, and if so, i=
f
the difference is positive or detrimental.

Thanks.
