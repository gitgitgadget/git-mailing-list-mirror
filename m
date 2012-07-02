From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame gives an ambiguous short revision
Date: Mon, 02 Jul 2012 00:17:08 -0700
Message-ID: <7vipe63a4r.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1207010825370.1873@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
X-From: git-owner@vger.kernel.org Mon Jul 02 09:17:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slasn-0005gx-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 09:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab2GBHRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 03:17:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab2GBHRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 03:17:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD2676425;
	Mon,  2 Jul 2012 03:17:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kIfETs5a5b5pHR4Q85kyolKOCqQ=; b=Vhj3fu
	JPM3hqREOy2uazm4jEXhRIjsvu4jv/rNVJeeP/0w4QvX+kDQEtsjRaOPV6E3KVRQ
	+vDpDaxpak7SQNwKmy6T2zd2+7uPWv1rM3tt9ecQ7sozZsBG742C2+tBthXrtOpt
	dBBpKPjcvmU1xbQRN+x/bt2d+37NGRFVVpUBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dLaqgnm2hf1iARGgP6HR11iseAsVMyR9
	KU5NhteNTp2AJ3IUSCK90U0zhxF7CWRpmn6qPFSy78PYZUhUQOdAa/0CNPa/i/6J
	ELpfyLQ99jAOUJxGN+TTFI6splFdEPShqTadC9NKfcGgU4+lATtmGyCBf7+Kh8G4
	dMRyl7h0vAU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B47AE6424;
	Mon,  2 Jul 2012 03:17:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DE2C6419; Mon,  2 Jul 2012
 03:17:10 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1207010825370.1873@hadrien> (Julia Lawall's
 message of "Sun, 1 Jul 2012 08:30:11 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F037288E-C415-11E1-8B7F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200846>

Julia Lawall <julia.lawall@lip6.fr> writes:

> Using linux-next cloned today (July 1), I then checkout out the
> revision 60d5c9f5b.  The command
>
> git blame drivers/staging/brcm80211/brcmfmac/wl_iw.c -L3675,3675
>
> then gives:
>
> 60d5c9f5 (Julia Lawall 2011-04-01 16:23:42 +0200 3675)  if (!iscan->iscan_ex_params_p) {
>
> Then I try:
>
> git show 60d5c9f5
>
> which gives:
>
> error: short SHA1 60d5c9f5 is ambiguous.
> error: short SHA1 60d5c9f5 is ambiguous.
> fatal: ambiguous argument '60d5c9f5': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions
>
> If I give git blame the -l option, every thing is fine.

Or you can use --abbrev to explicitly set the width; as the length
necessary to make the abbreviated object names depends on the
project, there is no good default.

I think it should be an easy patch to add a post-processing phase
after all lines are blamed to automatically compute an appropriate
value of abbreviation to ensure the uniqueness, but the current
blame output does not bother to do so.
