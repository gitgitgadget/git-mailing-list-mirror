From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git log --follow support --find-copies-harder.
Date: Wed, 21 Apr 2010 09:56:46 -0700
Message-ID: <7v8w8gbv75.fsf@alter.siamese.dyndns.org>
References: <1271860641-29305-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 18:57:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4dET-0007Rw-D8
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 18:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab0DUQ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 12:56:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab0DUQ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 12:56:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F13E4AC656;
	Wed, 21 Apr 2010 12:56:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f1I1fbOpkcT5zm9epF6oSuFsEbQ=; b=uM+ad4
	9jN1DSwV5yl1Knkp34nx/B6OBhwUWHPxjLPcLgDFhDKV385ZKMH39XHfzHc3M0At
	JdYJ/31BAlHQqGHKXYBev2BdoGIqIUIOk2RIxLuX2CBZGvtdNCtUIjk/SglEF2p7
	nBd+Cjt/5nIGcE3mRxTtfhzKz4RDZ/6eayLlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XZSk+U9zAWshhcQV6bdS79w//mcGCX0c
	C72+xL/UMlNN3pzk2vv0x9PAJfa4FFWw9uJY3anPdkerHpX7HARwkNj/T4R0XfpU
	dLTjP/zereinwwXLtw0BV/itahNxkxKkcfHoh93xvoPzzT7vnqsJ/EKz2dlh07mx
	rhY8EBs3nAY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7C5EAC64F;
	Wed, 21 Apr 2010 12:56:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C579AC64B; Wed, 21 Apr
 2010 12:56:47 -0400 (EDT)
In-Reply-To: <1271860641-29305-1-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Wed\, 21 Apr 2010 22\:37\:21 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1F35FEA-4D66-11DF-B968-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145443>

Bo Yang <struggleyb.nku@gmail.com> writes:

> 'git log --follow --find-copies-harder <path>' don't track copies
> from unmodified files, and this patch fix it.

What does the command do when given a single -C instead of --f-c-h, with
or without your patch?  What should it do?

Because try_to_follow_renames() is supposed to be a rare-event (it only
happens when a path we have been following disappears), I am having this
feeling that it would make more sense to do this change unconditionally.

Two possible outcomes that this patch allows the users to have by giving
them a choice to give (or not to give) --f-c-h are:

 (1) the path is judged to be new in a commit and traversal finishes
     there; or 

 (2) the path is found to be a copy from another path from one of the
     parents and traversal continues.

But I think using --follow is a sure sign of the user wanting the latter
and never the former, no?
