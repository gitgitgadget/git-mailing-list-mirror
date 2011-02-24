From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive
 filesystems
Date: Wed, 23 Feb 2011 17:26:55 -0800
Message-ID: <7v8vx643z4.fsf@alter.siamese.dyndns.org>
References: <201102231811.45948.johan@herland.net>
 <AANLkTi=gAM3LGwU47_EkENerZeKmjwuhWhpHZJGSiW=n@mail.gmail.com>
 <7vfwre8sax.fsf@alter.siamese.dyndns.org>
 <201102240158.24363.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 02:27:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsPzg-0000LQ-O1
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 02:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105Ab1BXB1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 20:27:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719Ab1BXB1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 20:27:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CC68300B;
	Wed, 23 Feb 2011 20:28:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pqyfeLHcisPUBDUqJMSIdyROSdk=; b=fR/Z45
	CKpXW1uMm0N1SwgavieohIrpOavro5Mh6UBZ6obnHbt4GcEANqK94wqmDhNoBdkJ
	Pnh/qrZsxFh8BUagvMpJ1e4Q9Q+eiFB2RWLINv44KQ2UP6D97YjER+kxfu0s48cZ
	un7frTcg2QFG4z1ie2+vQYcxrR/lU+aCd40mM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PlQjEReg259b6z58EluDDx/45v7fcneP
	bseysaJh2uIMzoIEK1ud71exFnZkfehBxtsqmRB/NyMS0wyNfbCkW3eGnBNMFbrY
	qaLEziTi+jkMo3H5ChJPlEj2DPWDT/+/ZnKetkV/BEYmJ3aG5RGxQiTxQEjgEg4e
	O5xJkonebrM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 686EE300A;
	Wed, 23 Feb 2011 20:28:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 18C8C3007; Wed, 23 Feb 2011
 20:28:10 -0500 (EST)
In-Reply-To: <201102240158.24363.johan@herland.net> (Johan Herland's message
 of "Thu\, 24 Feb 2011 01\:58\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AA971A4-3FB5-11E0-BBD2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167764>

Johan Herland <johan@herland.net> writes:

> On Wednesday 23 February 2011, Junio C Hamano wrote:
>> I think two things are sensible to do, are relatively low hanging fruits,
>> and are of low risk:
>> 
>>  - break checkout on such a tree on incapable filesystems; and
>
> Wouldn't that be a regression from the current state (where the poor user in 
> a case-insensitive worktree can at least "git rm" the offending files, and 
> keep working without assistance from a case-sensitive worktree)?

Depends on the definition of "break".  I meant "exit with non-zero
status", not necessarily changing what is left in the working tree from
what the current code gives us.
