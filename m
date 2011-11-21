From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command.c: Accept EACCES as command not found
Date: Mon, 21 Nov 2011 15:54:09 -0800
Message-ID: <7v62idf2vy.fsf@alter.siamese.dyndns.org>
References: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
 <7vbos5f7ix.fsf@alter.siamese.dyndns.org> <op.v5bjtk1r0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Frans Klaver" <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 00:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSdgn-0002MX-Sd
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 00:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab1KUXyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 18:54:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496Ab1KUXyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 18:54:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2398E5328;
	Mon, 21 Nov 2011 18:54:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VnD4q8/pNQ3dhP4wMZtlGqjer0w=; b=qqIBlL
	6ZS3KQI+2PbWy4f8feOeGG97/rEwAesIshwRyU159fFSeCSnIsQoF8mPxOMB/lOj
	JkNIApDU2qPAVlN9a95S8WRf2c6M0hWXFaHNkSvhJo2Kz/q/4TsVqYhXk4lA4GC1
	2L/HveiZICMv7VwdP+ufvaG7zdaZWRcNCcI/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mPFAfh93cZGmANHaoqdNLUCP7y2Md3hO
	tJdjvO31tEZFDkLFJH8+53DPUtP5he3F9X3+xm5U9YpAmApMxVY1KqoqpPrWi3OI
	BumUIQVPDRXYaM94UJauOzDjjtBYJxvihUlHr7xlePuyx8vHUvVuZv1UrLzh/F4+
	2GDcJnWV8BU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C18C5327;
	Mon, 21 Nov 2011 18:54:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 821725326; Mon, 21 Nov 2011
 18:54:10 -0500 (EST)
In-Reply-To: <op.v5bjtk1r0aolir@keputer> (Frans Klaver's message of "Tue, 22
 Nov 2011 00:06:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B6D54C6-149C-11E1-91E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185771>

"Frans Klaver" <fransklaver@gmail.com> writes:

> Actually I went through diagnosing and fixing it. After tracking it
> down, I did wonder about this question myself and I didn't come to a
> definitive  conclusion on it. On one hand I do agree that it may be an
> incentive for  the user to fix his path. On the other hand I found it
> an obscure one to  track down; git's behavior doesn't match bash
> behavior:
>
> $ git config --global alias.aliasedinit init &&
> mkdir searchpath && chmod 400 searchpath &&
> PATH=$(pwd)/searchpath:$PATH && export PATH &&
> mkdir someproject && cd someproject &&
> git aliasedinit
> fatal: cannot exec 'git-aliasedinit': Permission denied

Imagine you did not have alias.aliasedinit in ~/.gitconfig but had a
script called $(pwd)/searchpath/git-aliasedinit which we would fail to
execute. What message would we get in that case? Currently I think we get
permission denied.

Would we get the same with your patch, or something that does not hint
at all that there is a permission problem?

See also the "tangent" part of

    http://thread.gmane.org/gmane.comp.version-control.git/171755

and the discussion that follows it. I do not think we reached any
conclusion nor a patch.
