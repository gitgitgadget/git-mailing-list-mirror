From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: LF terminate line sent to
 cut
Date: Fri, 17 Sep 2010 11:38:05 -0700
Message-ID: <7vsk182p2q.fsf@alter.siamese.dyndns.org>
References: <60d13fc6a7d5b1b08f35f91b2d90eb7c13922390.1284733059.git.chris_johnsen@pobox.com> <XhMLJaG8mUbh4rzLnU3IrGDXbMd9-p7UFO6kn9Uke7n_H4NNOG6glg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Johnsen <chris_johnsen@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 17 20:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwfpI-0005xL-Oh
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 20:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab0IQSiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 14:38:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab0IQSiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 14:38:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81FABD6EEB;
	Fri, 17 Sep 2010 14:38:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/zaDGEG3BGnc/KLVEkLccFo7r9c=; b=gzE46K
	j/88tOnpNiaUpmeaYCu0aIGM5OmGYwNtiz8zj4DbRcVJoPoG53KvI1J2waNgUR3U
	3OJWGYFejwtQlOCbRZX9yr3yGUSYr/7GE0AsuohA8HFb4z3CKFnS5VnBdSRnuZ/X
	iRXVjwTeA8BByapnrixJtBSXk/u/ZzhfjTw94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SyCi82OEMgGkL780Fx8L1z+XHH2nheK+
	WrBhgYr9bTHNPsXquGNXnDmJSBuka0ihG0AYkVjIaKwi3JC5DIkcHNoNcGiTEQza
	kYtYmHOc+/qPT18hzz4DlYwWO0BQIttWOCKzt6EHVmRRgnWTvgHIIJ07wYeWWy/F
	2i1O2lrUk+4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D99D6EE8;
	Fri, 17 Sep 2010 14:38:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D302FD6EE5; Fri, 17 Sep
 2010 14:38:06 -0400 (EDT)
In-Reply-To: <XhMLJaG8mUbh4rzLnU3IrGDXbMd9-p7UFO6kn9Uke7n_H4NNOG6glg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 17 Sep 2010 10\:10\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA392BA8-C28A-11DF-9E71-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156407>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> Or we could write it like:
>
>    sha1=${rest%% *}
>
> which I wish I had changed it to in the first place when I made some
> recent modifications.

Agreed; the less use of 'cut' we see, the better ;-)

As to portability guideline in our shell script:

    ${param#word} ${param##word} ${param%word} ${param%%word}

are permissible POSIX constructs (together with more traditional -/=/?/+), and
their use is encouraged over 'cut', 'expr', etc. [*1*]

    ${param:ofs} ${param:ofs:len} ${param/pattern/string}

are bashisms we avoid (unless of course in the bash completion script).

We do not seem to use ${#param}, not because it is forbidden, but I think
because it is not very useful without ${param:ofs:len}.


[Footnote]

*1* In 2005 back when I took over the git maintenance, I used to be a lot
more conservative/traditionalist and as a result, you may see overused
"expr" in contrib/examples/ and "git log -p -- '*.sh'" output.  But we
have been eradicating them a bit by bit for the past few years.
