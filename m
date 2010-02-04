From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 16:48:20 -0800
Message-ID: <7vvded4yi3.fsf@alter.siamese.dyndns.org>
References: <ron1-32BD5F.10255403022010@news.gmane.org>
 <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com>
 <ron1-5F71CB.11234903022010@news.gmane.org>
 <alpine.LFD.2.00.1002031436490.1681@xanadu.home>
 <ron1-34F9C6.12273203022010@news.gmane.org>
 <32541b131002031240p6b67536ame6b69c6d662a7968@mail.gmail.com>
 <ron1-9FA846.14332803022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 01:48:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcptY-00009l-UD
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 01:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab0BDAs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 19:48:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468Ab0BDAs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 19:48:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B353977B2;
	Wed,  3 Feb 2010 19:48:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CxQGYsaKjEb6GE+GKmuOddslXXM=; b=VsRV84
	C3qpTPRzs5nD5SvJqS/ja7xCh6rOLu3AMn1GGbIvOVG0RQWbhyMqwbUHbnYWlDJ0
	VopRfP2PJ/EA5V+R553liYOlLeDzotoAr4Qr2U4yk5ICUd/hkqydCNGj/AbpYpaK
	gko8+jZWqX8GIiiGHmD9cZbNsiF1Kd19IC5Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HhuzYoOKMMgjXFMOORmhviRraGVBH3mP
	XGtY+yIZj4TBsmwJOqSQLDXeaTLEi9mQ4an6wkMIAmRdg7xnbaeAW4QrbHCUCXg/
	MvdzcIg6teraMBI8Pn7coP7oMP+DDsY7FBFDm/2gqPhqEkIiT5nVo/VZK0K6srG6
	yl1DKZm8VGU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5C63977B1;
	Wed,  3 Feb 2010 19:48:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DDD6977AE; Wed,  3 Feb
 2010 19:48:22 -0500 (EST)
In-Reply-To: <ron1-9FA846.14332803022010@news.gmane.org> (Ron Garret's
 message of "Wed\, 03 Feb 2010 14\:33\:28 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 00286810-1127-11DF-B738-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138922>

Ron Garret <ron1@flownet.com> writes:

> A and B start with a file named config.  A and B both make edits.  In 
> addition, B renames config to be config1 and creates a new, very similar 
> file called config2.  B then merges from A with the expectation that B's 
> edits to config would end up in config1 and not config2.  It seems to me 
> that without tracking renames, it would be luck of the draw which file 
> the patch got applied to.

I don't think the above is necessarily "rename" issue, but touches an
interesting point -- it is so "interesting" to the point that no sane SCM
would even consider that is a problem they need to solve.

If config1 and config2 are about two different ways to configure the
software (e.g. two different build for different customers), and change
made by A was to accomodate new configuration option made in the upstream,
B might even want to have that addition reflected in _both_ of his
configuration files, config1 and config2.

Earlier in this message, I said that this is not an issue SCM should even
be solving, because a sane way to handle this would _not_ be to copy and
edit config1/config2 and keep track of them in SCM; instead, saner people
would maintain a build procedure (e.g. Makefile target) to transform the
template "config" into necessary "config1" and "config2" customized
variants.
