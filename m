From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make http-backend REMOTE_USER configurable
Date: Thu, 29 Mar 2012 18:52:35 -0700
Message-ID: <7vk422q2ho.fsf@alter.siamese.dyndns.org>
References: <1333051139-14262-1-git-send-email-willsk@bnl.gov>
 <7vzkazoyk3.fsf@alter.siamese.dyndns.org>
 <20120329222230.GB1413@sigill.intra.peff.net>
 <20120329222632.GC1413@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Strecker-Kellogg <willsk@bnl.gov>,
	Git List <git@vger.kernel.org>, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 03:53:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDR1d-0001T8-1t
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 03:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759698Ab2C3Bwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 21:52:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759654Ab2C3Bwh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 21:52:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 669EB6F60;
	Thu, 29 Mar 2012 21:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TdDon93I8RM0Kdt/d63mvIUcV2s=; b=qzSxk8
	4kzLdB0pwxMsXdklvKqr/lAuHQmFfu/PRrwLJitumAmUWmoD0mKLB1VEnRsRPmd2
	U0tu/8iVsx5X5hhVorV7DTNx/DI/ij4rODY9Q+N4DpQdeBFLugd+TLWur8TzyYTz
	iRGokkStgIRQIEHSMlxWgeqpXlGwEmeqzjg9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h/RaVi5xUwRZjbfXvmIdl1sCHltgXg78
	lKDaxNexwwGxA/U8iaPRCsXaeY9n/aXzc7wLABJoDt1FtIKilw2g7QsV7mPBPBWu
	1ssLg4XH/8sqCjoPJUbtN7qGHdBGqz0vCXosbpiz0ui2zNDUIXgJ9bMeoeG6VINg
	z40NQHtvigs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D85B6F5F;
	Thu, 29 Mar 2012 21:52:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC9C66F5E; Thu, 29 Mar 2012
 21:52:36 -0400 (EDT)
In-Reply-To: <20120329222632.GC1413@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 29 Mar 2012 18:26:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06719846-7A0B-11E1-BB67-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194310>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 29, 2012 at 06:22:30PM -0400, Jeff King wrote:
>
>> I think an even better thing would be for http-backend to leave
>> GIT_COMMITTER_* alone if it exists; that is the usual well-known
>> interface for setting such things. And then you could specify a
>> detailed committer name and email if you want, or leave them blank to
>> pull from $REMOTE_USER as we do now. As it is now, even if you specify
>> GIT_COMMITTER_EMAIL, it gets overwritten with
>> "$REMOTE_USER@http.$REMOTE_ADDR".
>
> That patch would look something like this:

It would regress for somebody who is running the CGI program while
exporting these environment variables pointing at himself and relying on
the fact that these are canceled by REMOTE_USER/ADDR (perhaps a web-based
editor can write into some repository and commits made by that editor
takes the ident information from COMMITTER variables, while another part
of the webserver takes a push by spawning the http backend???).

Which is very unlikely.

If somebody else comes up with a valid scenario to show why this patch is
a bad idea, I'd stand corrected but at the same time I'd be very surprised.

But I think this is the right thing to do, even though it is not related
to the issue William wanted to address with his patch.

Care to sign it off?
