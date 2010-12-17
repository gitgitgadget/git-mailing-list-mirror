From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/21] grep: use writable strbuf from caller in
 grep_tree()
Date: Thu, 16 Dec 2010 16:15:04 -0800
Message-ID: <7vy67pjlvb.fsf@alter.siamese.dyndns.org>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-20-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 01:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTNyi-00031R-OI
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 01:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab0LQAPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Dec 2010 19:15:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab0LQAPM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 19:15:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C3DB38B3;
	Thu, 16 Dec 2010 19:15:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YgR7lUU+UM0h
	MFw2sUOiNPs3BfI=; b=a11IkfW1NcPhX4xdG3HwJJVEEWwM6+9Ql2Zq+WcrY+UA
	zYtU6FUKMUoOX/N3vtT8fejgC8rx1k7UFxnI0PcBplXQhzyHum/ugqClKHhWyV/z
	jKUoanAGIh+nUEeJUMabJnorDEfGb/Qc7xDIpngzRZ21udgv8bP+VCntaUAVrSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Kdr8jh
	FM/v1J6O/2/fZPgvPJtF+Qpnyb71cGZUIH3rx0E+C2xEQQhtGL9ODpWILs+x+7LM
	wvAsdl/gKy2aZC5uVlu+Sw1goLmUH+5kESq27Y2xfCTrxaoGEMl21rq9Ft10oTL1
	wtxtu3+85la1ET/XjAIhCCFIQwdoQMYXxwZKg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3968338B1;
	Thu, 16 Dec 2010 19:15:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 539C338B0; Thu, 16 Dec 2010
 19:15:32 -0500 (EST)
In-Reply-To: <1292425376-14550-20-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 15 Dec
 2010 22\:02\:54 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4B09A2E-0972-11E0-95CB-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163844>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +		hit =3D grep_tree(opt, pathspec, &tree, &base, base.neglen);

If you are going to let the users of strbuf API to refer directly to th=
e
field, I think "neglen" should be renamed to something more reasonable,
say, "offset".

I am still debating myself if this strbuf_offset is anugly hack merely =
to
allow the implementation of "grep" not to carry one extra offset around
throughout its callchain, or if it is generic enough that other/future
callers would benefit from.  I am leaning toward to think this is an ug=
ly
hack, as a new caller that wants to carry _two_ offsets into a strbuf
wouldn't get much benefit from this new API.  But I may be missreading
your code.
