From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for check_refname_component
Date: Mon, 09 Jun 2014 16:05:04 -0700
Message-ID: <xmqqvbs9d6qn.fsf@gitster.dls.corp.google.com>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>
	<xmqqfvjdenk5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:05:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8cy-0007Ja-RD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbaFIXFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:05:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63316 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932475AbaFIXFK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:05:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E8721D00B;
	Mon,  9 Jun 2014 19:05:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+n1H0wtMvW1EOG97V2CAn/4PCfc=; b=tjcQKI
	filkzHIuT1AV8QS06cOnwnW/+kbu1gohmQSZAOyc9ObVn6eHWZ98deHKYbtnYlFA
	nL8MbwO5LBp737yVc9rSHHkgzFw0n5y720eUQ9UTpH7c7CM/7wV2O2d/flN9MQYI
	AH896kBciP14PwAAbvQ5DKUgesAvZBZdvbnbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KMcplBwTJ0MEjTb1P1XVqbbhbU3aAEae
	GskDwTw7ziGRNHAMl2gz49xI4cvPShXzGJR5FwwwSCIpzGdM1K6VXZDyunoGPIf9
	7gWFVcx1IdxO/yOVGm45BZEC+fh2zXkO/ydr6MhWlvK498sdXIF4GJK7J2+eataG
	ap51/1Xspxk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 907C31D00A;
	Mon,  9 Jun 2014 19:05:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A54CD1D007;
	Mon,  9 Jun 2014 19:05:05 -0400 (EDT)
In-Reply-To: <xmqqfvjdenk5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 Jun 2014 15:16:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7EBD3E3A-F02A-11E3-8139-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251130>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> Since Junio has picked up the first patch from previous versions of
>> this series, I'm just going to send the second (SSE) one.  I decided
>> not to s/NO_SSE42/!HAVE_SSE42/ because it looks like git mostly uses
>> the former convention (for instance, that's what GIT_PARSE_WITH
>> generates).
>
> Yeah but NO_FROTZ is used only when FROTZ is something everybody is
> expected to have (e.g. it's in posix, people ought to have it, but
> we do support those who don't), isn't it?  For a very arch specific
> stuff like sse42, I'd feel better to make it purely opt-in by
> forcing people to explicitly say HAVE_SSE42 to enable it.

Just FYI: I am getting

compat/cpuid.h:8:12: error: 'processor_supports_sse42' defined but
not used [-Werror=unused-function]
cc1: all warnings being treated as errors

while building 'pu'; I'll have to rebuild 'pu' without this patch
before I can push the day's result out.
