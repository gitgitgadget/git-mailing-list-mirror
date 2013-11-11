From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Mon, 11 Nov 2013 11:04:02 -0800
Message-ID: <xmqqhabilpzx.fsf@gitster.dls.corp.google.com>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
To: Ken Tanzer <ken.tanzer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfwmW-00009B-C4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035Ab3KKTEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:04:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840Ab3KKTEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:04:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A553D50C50;
	Mon, 11 Nov 2013 14:04:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tGzQn7PtRA850K2YQ4udv/gembQ=; b=cHWHkQ
	MfcRnI3j+MC/bm0IS+mwCQat52lsuC5a6KSa3w2kdvOQAvi8CChWfxEY4Pw9LxUy
	N50MDzTCB+zIKPnb0NIld73Jk9XEd2c15CPHeA8NrkibX3y+JW9dCxK6nlL87EUW
	F+lDCSlCxDXDi+YNq6AW//aJwOoesJwWMQTJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=No/o72HCYKWLH3prGdOXMkRbooWu2CXi
	odhAs6w9cnT03WrFwipxAodjv7iDBxaqILRImeQ6ClxrktVzkaaH3+xb2kAMgc3d
	ug2E3adIu7Th2YWy6h0V1LyaerHrWk4RXk8FocA+h2zpqqKmW8qSUrI1QfVCG2i1
	oy+Rb4bkEPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98A6650C4F;
	Mon, 11 Nov 2013 14:04:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 021C250C4A;
	Mon, 11 Nov 2013 14:04:06 -0500 (EST)
In-Reply-To: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>
	(Ken Tanzer's message of "Sun, 10 Nov 2013 18:39:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 09F42058-4B04-11E3-AC41-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237632>

Ken Tanzer <ken.tanzer@gmail.com> writes:

> ASCII text, with very long lines, with CRLF, CR, LF line terminators

I am not very much surprised if such a file misbehaves, because the
"format-patch | am" pipeline is designed to be used on patches that
can be transferred in plain-text e-mail safely.  Long lines should
probably be OK, but mixed CRLF, CR and LF may be problematic.

Having said that...

> I've confirmed with the following test case on three machines, so it
> seems reproducible:
>
> mkdir temp_test_case
> cd temp_test_case
> git init
> # my file.  Sorry--couldn't find a saner link!
> wget -O jquery-ui-1.8.custom.min.js
> http://sourceforge.net/p/agency/code/ci/9358ea4dbe8e1540ec0b8bebfc7770f1bf8be0ec/tree/jquery-ui-1.8.custom.min.js?format=raw
> git add jquery-ui-1.8.custom.min.js
> git commit -m 'Adding jquery-ui'
> git rm jquery-ui-1.8.custom.min.js
> git commit -m 'Removing jquery-ui'
> git format-patch HEAD~1
> git reset --hard HEAD~1
> git am 0001*

... this does not break at all for me.
