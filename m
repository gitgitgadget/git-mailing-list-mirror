From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: remove duplicate free()
Date: Wed, 02 Dec 2009 11:06:43 -0800
Message-ID: <7vws15ci0s.fsf@alter.siamese.dyndns.org>
References: <20091202153950.c18095b7.rctay89@gmail.com>
 <alpine.LNX.2.00.0912021120440.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuXZ-0001y8-De
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbZLBTGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbZLBTGx
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:06:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbZLBTGx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:06:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4736AA35A4;
	Wed,  2 Dec 2009 14:06:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFIYSqdTGNrWEgkeVFC3PZkwvlM=; b=JsqfQ6
	IGwXNqqlcntu+CV65UqeNLoACSMyVwwzUJjuPxu4ekB4BO2jD5Csf9htqkb0Hckq
	2Mu9TRWIVi73mhkXZM09VFdOkEW79kcoCmus8wWzU/1uiLTTEmOH+HNWu63xoXab
	xJ94wn1rPHGX2dC1vjGIr6d5WRtdxbGolZm6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OBVifG44nfO4MbnWtIk+4UY5JK9oRJv/
	vTNaRvX4BoItJ9Kl+M1+4ZL6jcaxDshbFFB0MScDfeHAMhkUHTtnWonwWnXHD/5h
	7w+ILZCjjWOv6wTLmxbXSWpmcPF6I5ZBQrR7QVUj4idpS6mU4EGrYoqAJZcsG+J2
	6k/Azal7CRM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09419A35A3;
	Wed,  2 Dec 2009 14:06:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F07CAA359D; Wed,  2 Dec 2009
 14:06:45 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.0912021120440.14365@iabervon.org> (Daniel
 Barkalow's message of "Wed\, 2 Dec 2009 11\:23\:56 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA094042-DF75-11DE-B442-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134373>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 2 Dec 2009, Tay Ray Chuan wrote:
>
>> Remove the free() invocation on transport->data in release_helper(), as
>> disconnect_helper() has already done so.
>
> You need to remove the one in disconnect_helper, because the entire point 
> of disconnect_helper as opposed to release_helper is to *not* free that 
> memory. If you remove this one, you'll access freed memory in any case 
> where the helper has to be quit and restarted.

Thanks.  I did two things:

 - Since the bottom commit cannot be rewritten (as it is based on the
   version that is before the change in the caller to free it), I queued a
   one liner to remove the free from the callee in 'next'.

 - The problem will surface when the series is later merged to 'master'.
   I told my rerere database about the necessity of this "evil merge", so
   that we will automatically have the equivalent of the one-liner when it
   happens.
