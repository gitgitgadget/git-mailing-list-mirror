From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 16:08:13 -0700
Message-ID: <7vvc4jtjqa.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 10 01:08:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwh1B-0007UV-Gt
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 01:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab3GIXIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 19:08:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab3GIXIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 19:08:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D12662F0B7;
	Tue,  9 Jul 2013 23:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fxz9Ty6/Qlhhl7+cGAhXzWl3DTQ=; b=Y9YBWo
	MjBN5h/HZQbHlOk04l14mKaaITLWFroBxPJ8VNQ1FZeXRkmO6En1QMsmiBeEzLWO
	80RjJdfrc9CmQ/ge/86KojW4ooxRHBeRo00BdlAjSHwSZ0QP6De8qRFm2bwSGoxb
	3FxnBjq14kEFiufiK4Gzh38RVzEQpuLiYXtBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JIz3ViEEeFSgS1UizgJy0B7F79pJEdF7
	O+i2q1hKPWZ7yIzCJrsYTGlptw4qgWG/VgsuLrR6zlBRAouxJxgkTNqLvFvMN69f
	KWdbheQ0ybmXFSkDeqdfi9CP/aZVCTkEiPRbo8bVPEl801tu+nE2PsIbrvrt7eO7
	L2JfjMZL//s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C795C2F0B6;
	Tue,  9 Jul 2013 23:08:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33BFD2F0B4;
	Tue,  9 Jul 2013 23:08:15 +0000 (UTC)
In-Reply-To: <7v38rnv0zt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 09 Jul 2013 15:09:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F539732-E8EC-11E2-89C7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230013>

Junio C Hamano <gitster@pobox.com> writes:

> I _think_ I am OK if we introduced "--allow-no-ff" that means the
> current "--force" (i.e. "rewinding is OK"), that does not defeat the
> "--lockref" safety.  That is the intended application (you know that
> push does not fast-forward because you rebased, but you also want to
> make sure there is nothing you are losing by enforcing --lockref
> safety).
>
> If that is what happens, then I think "--force" that means "anything
> goes" makes sense.

Or perhaps you were implicitly assuming that "--lockref" would
automatically mean "I know I am rewinding, so as soon as I say
--lockref, I mean --allow-no-ff", and I did not realize that.

If that is the semantics you are proposing, then I think it makes
sense to make "--force" the big red button that lets anything go.

I was considering "--lockref" to be orthogonal to the traditional
"ff only check", and rejecting a push when the updated ref's current
value is expected (i.e. --lockref satisfied) but the update does not
fast-forward, and that was where my resistance to allow "--force" to
override "--lockref" comes from (because otherwise there is no way
to say "I know I want to bypass 'ff-only' check, but instead make
sure the current value is this").
