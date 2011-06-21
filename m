From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/13] revert: Eliminate global "commit" variable
Date: Tue, 21 Jun 2011 12:23:48 -0700
Message-ID: <7vei2n7zuj.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 21:24:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ6YH-00016a-0p
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 21:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430Ab1FUTXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 15:23:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab1FUTXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 15:23:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC96A47F9;
	Tue, 21 Jun 2011 15:26:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mfsb/4QkyIAbm3OMaKCmcHQ0auM=; b=RirmhN
	8FNzMXFT7KoSNf0FwugCAiGiPHA+bFoRzuz7fulX3WCq+JVmkwPLoo1QA/pk68Mx
	fmhqaW8vGrpigXvK4r1womD49ckzPFXhSELVWeJQhbmQHZwLAw/hbyn0D9mWrsFX
	Sk9SQfERhqsBmeAk7zmDDCGfdm0kTrGNNZJMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FQB5sHk9nqB3AX4aBa0+a7gp7oNNuO9Z
	LUSA5gP0TCwnYWIKwILqIV30qdjtJXe9NYed8wnCppzhsD0GUkrd1zmPVyYr1q/l
	U34cLVYKumC3oZTrbyKswT+5+AOuhdhCjWk+C6DK0Q1u+LTdcx3JE2pNfhQ38nD9
	IB4gRD5urxw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5A5547F8;
	Tue, 21 Jun 2011 15:26:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 50C9547F7; Tue, 21 Jun 2011
 15:26:02 -0400 (EDT)
In-Reply-To: <1308661489-20080-6-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 21 Jun 2011 13:04:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CE88508-9C3C-11E0-9FF5-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176185>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Since we want to develop the functionality to either pick or revert
> individual commits atomically later in the series, make "commit" a
> local variable.  Doing this involves changing several functions to
> take an additional argument, but no other functional changes.

Actually you didn't make it a local variable. You made it a parameter to
be passed around, which is even better ;-).

> -static void write_cherry_pick_head(void)
> +static void write_cherry_pick_head(const char *commit_sha1_hex)

Wouldn't we prefer to see this parameter also to be a commit objet, not a
preformatted hex string?  The only exception would be if you are going to
introduce a future callsite that does not have a commit object but may
know the commit object name, but if you are not going to do so, then...
