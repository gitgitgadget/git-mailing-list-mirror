From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] ignoring a fetch that overwrites local symref
Date: Wed, 12 Dec 2012 11:38:44 -0800
Message-ID: <7vip873vsr.fsf@alter.siamese.dyndns.org>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
 <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
 <7v62488j8a.fsf_-_@alter.siamese.dyndns.org>
 <CAJo=hJu2X5u4oCGRVHK5a4sbf4X2meUbq_8kaGiQB1mdQspaXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Jay Soffian <jaysoffian@gmail.com>,
	Stefan Zager <szager@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:39:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tis92-00023Y-C5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab2LLTir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:38:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212Ab2LLTiq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:38:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88244AD32;
	Wed, 12 Dec 2012 14:38:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uLF9ObKtLNPm1ctZ7THonZdG0cY=; b=DXMi+7
	JEt7n0vQtfe7m+LoVATQflgpFXd/Q4CQflULGvjtkpxvd/Iq3fvtelwuVPIlJFRu
	QeMJ0ZR7MiA7elLGWgsg9KyaDRtXiTAVO5L3Pxf+aSzRwDH5th6LrfxYOc3At0Yl
	OGuqabpobvwZMjA/AsrI7QdJzYithfW+Ms00E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CzrJ8PD6maslufCq71ZuoBs6AHPUEWdm
	wj6gHEi7WKJ/HGMsS9hWNe5L7i6O1YyXsI4SfauSUuBG6cgU64U/vF3KphViWkEC
	F1yZ8XsO5SN5qT48RjUvwxBSxfPuL5wg1K1tYVef41nUV9wpzhdMEEYtFx891arQ
	9NQJJ8qfSCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74D3FAD2D;
	Wed, 12 Dec 2012 14:38:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB4A2AD28; Wed, 12 Dec 2012
 14:38:45 -0500 (EST)
In-Reply-To: <CAJo=hJu2X5u4oCGRVHK5a4sbf4X2meUbq_8kaGiQB1mdQspaXw@mail.gmail.com> (Shawn
 Pearce's message of "Wed, 12 Dec 2012 11:13:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B22C9F4-4493-11E2-A441-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211387>

Shawn Pearce <spearce@spearce.org> writes:

>> Work it around by noticing a wildcard match that attempts to update
>> a local symbolic ref and ignoring it.
>
> At what point should we just support symrefs on the protocol? :-(

I think it is entirely an orthogonal matter.  When we learn that the
other side now has this ref as a symref pointing to this other ref,
an update of the local ref on the RHS of the refspec that has such a
symref on its LHS will not be using the current codepath to call
update_ref() to write the object name thru an existing symref.
