From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mergetools: add support for DeltaWalker
Date: Sat, 03 Mar 2012 14:47:07 -0800
Message-ID: <7vmx7x5ml0.fsf@alter.siamese.dyndns.org>
References: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com>
 <7vaa3ybpat.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4q7gmFeHuGM5hFruduHw-3mGa+CMU=U6X0jjXUsJLsvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:47:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3xjR-0002V8-AM
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 23:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab2CCWrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 17:47:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179Ab2CCWrK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2012 17:47:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A46CE5336;
	Sat,  3 Mar 2012 17:47:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P7M647uOLScd
	xXnEWwOrPZ4xA1k=; b=EAfedDoPMezUrF9IoFfFrYnW3JkhLPfcLbFSGNMSVeT2
	MwBYRFhf/Y0rAE38OH9czKCe5efN30KRodg3IqYQLziL7elgCZdS1bTAhpnsrRhX
	QcYcwSyw3hsatLq/FoWtnktXI6IUzgRLQRoU7WBZZfz7G+aDJuhB7PvXW90PYfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vsDsKI
	dvTg/t5ohnxtNOFCzA5O0FltagPfoNbxSrwCP8iLeq2H8iDlEGR22+hE0wla67EI
	OmZ0wG8WvGZwBxD37YlkYA9QyW35VgghLiwSTnVmPEQzVMaO0mDKJZ7OlpFhknRz
	Paoxc4lLvHBeXkp1QolHpI4JcH8EWP+MySEbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BA045334;
	Sat,  3 Mar 2012 17:47:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0F445333; Sat,  3 Mar 2012
 17:47:08 -0500 (EST)
In-Reply-To: <CAJDDKr4q7gmFeHuGM5hFruduHw-3mGa+CMU=U6X0jjXUsJLsvw@mail.gmail.com> (David
 Aguilar's message of "Sat, 3 Mar 2012 14:00:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEF280DE-6582-11E1-8424-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192142>

David Aguilar <davvid@gmail.com> writes:

>>> +merge_cmd () {
>>> + =C2=A0 =C2=A0 if $base_present
>>> + =C2=A0 =C2=A0 then
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$merge_tool_path" "$LO=
CAL" "$REMOTE" "$BASE" -merged=3D"$PWD/$MERGED"
>>> + =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$merge_tool_path" "$LO=
CAL" "$REMOTE" -merged=3D"$PWD/$MERGED"
>>> + =C2=A0 =C2=A0 fi >/dev/null 2>&1
>>> +}
>
> Is the $PWD/ prefix strictly needed?  The rest of the mergetools use
> $MERGED as-is.  Does it work without it?

Hrm, I didn't notice it but they do look fishy.  Thanks for good eyes.

Tim?
