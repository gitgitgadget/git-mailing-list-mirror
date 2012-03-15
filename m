From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git branch -m doesn't update tracked branch config
Date: Thu, 15 Mar 2012 13:52:43 -0700
Message-ID: <7v7gylk2n8.fsf@alter.siamese.dyndns.org>
References: <CAD0k6qRWR9H8BejcXx3gzy2yQT_MjRBDtbZzhLVM215HQiaVhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 21:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8HfM-0001zs-05
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 21:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032307Ab2COUwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 16:52:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032176Ab2COUwr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 16:52:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE56F78E0;
	Thu, 15 Mar 2012 16:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vmDjjOD9yEbE
	t/iCUs7LkRJX1PM=; b=M/iNz7WLtsFYWXReaCMhF555BrB8Fr8bouJJCE0AHUXF
	NplVFeKdM3h0JdEo71eAVf6Ik/4Cg0wPmJOZkDrWxspabo/YxZXp+VMROAkqdraL
	CDqLl6rIbCMDbpqEH5RQbUIm/LViyy8hiR8gdlewcdjLshcNIk/RFFJZLbpH1NE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nsL+wX
	SMA8efLvsfwQMDpsdjmERaohF2mwF2aGCZVs7l2pGzT17MHMpXfDoIc9gt54dn4n
	N2NJtKktIjehZM/O3kpsNmsehgFTWIf5Kr/IwXuYBL4I5HMlHDQhLr868egYo1oX
	QT9LSnyWwjmW52J8O9JbzWNCLJuMnSv+goXT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2E2378DF;
	Thu, 15 Mar 2012 16:52:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C1F878DD; Thu, 15 Mar 2012
 16:52:46 -0400 (EDT)
In-Reply-To: <CAD0k6qRWR9H8BejcXx3gzy2yQT_MjRBDtbZzhLVM215HQiaVhg@mail.gmail.com> (Dave
 Borowitz's message of "Thu, 15 Mar 2012 08:51:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D15A7216-6EE0-11E1-8962-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193225>

Dave Borowitz <dborowitz@google.com> writes:

> $ git branch --track branch master
> Branch branch set up to track local branch master.
> $ git branch -m master newmaster
> $ git branch -vv
> =C2=A0 branch =C2=A0 =C2=A0e8fadc2 [master] foo
> * newmaster e8fadc2 foo
>
> I would have expected branch's upstream to now be newmaster rather
> than master, or at the very least some warning that branch now has a
> nonexistent upstream. Is this intended behavior, or a bug?

I think "branch -m A B" moves everything in "branch.A.*" over to
"branch.B.*" and does nothing else.

You would also want to find all Cs that have "branch.C.merge =3D A"
and "branch.C.remote =3D ." and update A in them to B, or something.
