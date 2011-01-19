From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 11:24:40 -0800
Message-ID: <7v4o94u26f.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
 <4D373296.6030101@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfdeO-0002KX-Vg
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab1ASTYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:24:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1ASTYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:24:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DFCB14B73;
	Wed, 19 Jan 2011 14:25:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ZLgLpav7LOsPy7e1W3WsMPrddI=; b=bWdkj4
	RCIUPVg51L4hQVWaf9T04/IoW90y2dxr6HL0gThZaxeur/kzFo8GhMfUweL3fxBJ
	gS4hmCWojsqryA72i5E9j2JHvs6VmBQSWTH1x4wj9xTP78M7vC9/F8ZvocOlTXhZ
	K4rAm9I9ABzKA2ZBlxAN3PKTp4p4JnqWl96yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vIS4c4jGNoGiKd42D7Iwi1RMPKAqtaDz
	KBBke6GOl+CcRAXFj/+8og+oD0WrUQviL5BMDguK4Rk32+fWRQ/xIpz+m5aQbz4E
	Y7E10yYmEgO9oTGnD6WWHfSbfrVp/i4i3zi1cJ8sewqZ7Rsx/cV3NLk4IBrOOmWi
	OqJ4dMSUR7M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DCB04B6F;
	Wed, 19 Jan 2011 14:25:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 44CA84B6E; Wed, 19 Jan 2011
 14:25:28 -0500 (EST)
In-Reply-To: <4D373296.6030101@seznam.cz> (Maaartin's message of "Wed\, 19
 Jan 2011 19\:51\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E293AA1E-2401-11E0-91CE-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165279>

Maaartin <grajcar1@seznam.cz> writes:

> On 11-01-19 13:42, Jonathan Nieder wrote:
>> Unfortunately the existence of GIT_WORK_TREE makes it tempting to
>> use without setting GIT_DIR.
>
> Maybe I'm asking nonsense, but why should I always use both? On the
> command line, I either cd to my (alternate) working tree and use GIT_DIR
> only or the other way round.

As long as you were at the root level of these two sets of "working trees",
you don't need GIT_WORK_TREE at all.

We originally had only GIT_DIR and people who wanted to use a working tree
without an embedded .git (hence having to use GIT_DIR) complained that
they cannot work from subdirectories while cd'ing around, because you
declare that you are at the root of your working tree by using GIT_DIR
(naturally, there is no discovery of .git so we won't know where the root
is).  GIT_WORK_TREE was added to augment the mechanism to allow them to
specify where their root is, so that they can set both and then chdir
around inside their working tree.
