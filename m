From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: modernise style: more uses of test_line_count
Date: Wed, 11 Apr 2012 10:11:25 -0700
Message-ID: <7vty0qkxc2.fsf@alter.siamese.dyndns.org>
References: <e701486509c3306420e6bcf82e7d0d79fb2e7ae1.1334143281.git.stefano.lattarini@gmail.com> <7vy5q2ky7d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 19:12:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI15Y-0001aX-EN
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706Ab2DKRLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 13:11:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418Ab2DKRL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 13:11:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A4BF6AAF;
	Wed, 11 Apr 2012 13:11:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I6OjL7opERWLTp1PVIEwb4U8BlY=; b=GDnjJk
	BKr3ipPmcn2sr09o1Ab1Xq2ydPdcXnI2c4LFLoA3+O0J7B92RbhE5RhipyVXNqQi
	E0Md4xGZO+NNMREap5/42wu0t11vIa9vZpAGkFWh87zi5hZ8izRK1x9vGPDryBjW
	c5DrtRa/C+lksiO7Kz7hbOCYy+WxkUCIr49b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mc022ssy1l5hK1J9qS+flhTVF9PC950c
	0lef3CKNNaHvWXFsrfVjqQ9WhhShBDXUaNgnXZMNg+g8uYoJ419mYy2tiIGYYIfi
	fcZ6tbZpcAfF45jO/KAkacPuelhb/lUgClujGal+M/6H0jP6ck+suX51GaViiGim
	dnm498yxHXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 408226AAE;
	Wed, 11 Apr 2012 13:11:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C05E16AAD; Wed, 11 Apr 2012
 13:11:26 -0400 (EDT)
In-Reply-To: <7vy5q2ky7d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 11 Apr 2012 09:52:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F5F15E4-83F9-11E1-8178-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195217>

Junio C Hamano <gitster@pobox.com> writes:

> I'll squash this in, but otherwise it looks good.  There is nothing
> conflicting in flight right now.

In case somebody is curious, I've eyeballed the result of applying this
patch to v1.7.10 and the result of running the following on v1.7.10 to
find these three.  The other differences looked fine; we lost a few
variables like $loglen but they are not otherwise used, which was harder
to see without enough context.

-- >8 --
#!/bin/sh

perl -i -p -e '
	s/test\s+\$\(wc\s+-l\s+<\s*([.\/a-zA-Z0-9_]+)\)\s+(?:=|-eq)\s+"?(\d+)"?
	    /test_line_count = $2 $1/x;
	s/test\s+"?(\d+)"?\s+(?:=|-eq)\s+\$\(wc\s+-l\s+<\s*([.\/a-zA-Z0-9_]+)\)
	    /test_line_count = $1 $2/x;
	s/test\s+\`wc\s+-l\s+<\s*([.\/a-zA-Z0-9_]+)\`\s+(?:=|-eq)\s+"?(\d+)"?
	    /test_line_count = $2 $1/x;
	s/test\s+"?(\d+)"?\s+(?:=|-eq)\s+\`wc\s+-l\s+<\s*([.\/a-zA-Z0-9_]+)\`
	    /test_line_count = $1 $2/x;
' t/t[0-9][0-9][0-9][0-9]-*.sh
