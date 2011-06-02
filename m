From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Thu, 02 Jun 2011 15:44:33 -0700
Message-ID: <7vfwnrdfam.fsf@alter.siamese.dyndns.org>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <1306887870-3875-2-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>,
	Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSGdN-0005EG-N6
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 00:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1FBWow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 18:44:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab1FBWow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 18:44:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D818444B;
	Thu,  2 Jun 2011 18:46:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fpu2tJICSLUbTgKzp48xp4XL5x0=; b=Ur6vqT
	IiSDeuMsikpN7JJIrnzVcDDgQpFSs0cvg3Ytt2OJrKKlIHgT7iuVf2Upj3Y4HMHs
	TbqPxksZa9b/DzcTqdOVcNybzpMLpEQcZ6dgWDhcUoZkRjbUI0Dzzj/7XvTp3Cxm
	re2KRrH/chsF69MB9C+q67tAZxjFiWqHeYIQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJsbpU0vC2tkJnYYq4gibqAHoEn0tYMf
	/wJPQdT1zK8NN66sMLyP2ewSrnl3pIlFwwSa/u2v/OTZqny1S/GVefx11nusyTs/
	n06PPTAalwQl/PrRtYIs2m7QO5qPyBl8grQGVtbrmvKKot0+vQmTYk3y2rU1JmEE
	8X9Cwwrqik4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E366444A;
	Thu,  2 Jun 2011 18:46:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A5BF44449; Thu,  2 Jun 2011
 18:46:42 -0400 (EDT)
In-Reply-To: <1306887870-3875-2-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Tue, 31 May 2011 17:24:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34F59192-8D6A-11E0-9A8B-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174983>

Jamey Sharp <jamey@minilop.net> writes:

> Note that namespaces which include a / will expand to a hierarchy of
> namespaces; for example, GIT_NAMESPACE=foo/bar will store refs under
> refs/namespaces/foo/refs/namespaces/bar/.  This makes GIT_NAMESPACE
> behave hierarchically, and avoids ambiguity with namespaces such as
> foo/refs/heads.

Sorry, but I fail to see what problem you are trying to solve here.  I am
not suggesting that it would be better to do things in a way different
from what your patch does, but what problem will you have if you stored
the branch head for baz in refs/namespaces/foo/bar/refs/heads/baz given
the namespace foo/bar, and how does it solve that problem to store it
instead at refs/namespaces/foo/refs/namespaces/bar/refs/heads/baz?


> +int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)

Just a naming and interface preference, but I would have called this
for-each-ref-in-namespace, perhaps giving the namespace as a parameter.
