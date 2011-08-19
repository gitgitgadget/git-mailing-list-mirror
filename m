From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] clone: replace relative paths in the alternates
Date: Thu, 18 Aug 2011 23:22:12 -0700
Message-ID: <7vy5yp53aj.fsf@alter.siamese.dyndns.org>
References: <1313731396-10458-1-git-send-email-jason77.wang@gmail.com>
 <1313731396-10458-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 08:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuITD-0006BW-UV
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 08:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab1HSGWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 02:22:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48140 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab1HSGWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 02:22:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 523F34EDF;
	Fri, 19 Aug 2011 02:22:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nATJLbThvNcy0QXvGjqycVFCZAE=; b=xwSUkZ
	25PVXXP3EEpq6A4XFPMKy+v57kSoZfIFGXibU5RZ513FXnr6HrvSup/goiIb1xF6
	9hKn9a6FjQlqLUryCZilCl1HLXlmu9AJat6qH+XMgwSCcf8rQOye8tp5SpnEuLRJ
	Y+F1dEPYIWmV4qnKXCZ55MBeb+jvFXSK3p7sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jGUyLDiQ9i2NTAlbpnn+VqF9s4dXo2wy
	TLT7j0Roi8o3WZ5Z9zPURVCRC5rKmLdWPQggTpDJMru0yYeuAGsSo6LZbPP3S/F0
	jt3LmIV39l6I0JP5KuLeEV1/u3hig6egqE48rewGm5T2vj1XTZo0H8PE83W8MEnu
	GQONeTMlT+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A65E4EDE;
	Fri, 19 Aug 2011 02:22:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D571B4EDD; Fri, 19 Aug 2011
 02:22:13 -0400 (EDT)
In-Reply-To: <1313731396-10458-2-git-send-email-jason77.wang@gmail.com> (Hui
 Wang's message of "Fri, 19 Aug 2011 13:23:16 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 942312B8-CA2B-11E0-A060-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179681>

Hui Wang <jason77.wang@gmail.com> writes:

> +	mapsz = xsize_t(st.st_size);
> +	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
> +	close(fd);
> +
> +	tmpbuf = mapsz > 4096 ? xmalloc(mapsz * 2) : xmalloc(mapsz + 4096);

Where do these magic numbers come from, and what guarantee do we have that
these magic numbers give safe upper bound for pathnames that are expanded
to be absolute?

Wouldn't it be a lot cleaner and much less error prone if you open the
original, read from it with strbuf_readline(), convert the path using
strbuf manipulation functions and write the resulting line out to the
lockfile you obtained to update it, line by line?
