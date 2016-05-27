From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] config: return configset value for current_config_ functions
Date: Thu, 26 May 2016 19:11:34 -0700
Message-ID: <xmqqa8jctfl5.fsf@gitster.mtv.corp.google.com>
References: <20160518223712.GA18317@sigill.intra.peff.net>
	<20160518224323.GD22443@sigill.intra.peff.net>
	<20160519000821.GA22543@sigill.intra.peff.net>
	<CACsJy8Ad=yN6aLkH9B6ujUNUvPT-b+jw+CwJORD5Fh1jYeOUZQ@mail.gmail.com>
	<xmqq7fegydmf.fsf@gitster.mtv.corp.google.com>
	<20160526165033.GA20355@sigill.intra.peff.net>
	<xmqqd1o8wwk3.fsf@gitster.mtv.corp.google.com>
	<20160527004146.GA4996@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 04:11:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67FX-0008Cn-5x
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbcE0CLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:11:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932104AbcE0CLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:11:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C07701FEC3;
	Thu, 26 May 2016 22:11:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1So0X6cSVJ8G067nOrZ+XwT6j90=; b=YkLJLd
	bNb6qcZoukklngslZp6B/EkZ+03EjJIC6Oe1HcNXcQ8LQkoETF7oTmzs26/X13Z0
	G1rlz+RrTXlS9U9EbQhL8sED0nFA5uxiEc395npgwCJxOwr1YAg2h3NEZRb0vVtX
	XCylKckyQaBAx3hjt+7B19LYG3eIGRMypZKNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RcNhqh4pW8bidRNm5+R6/U0QHDPYZetc
	I4x3cfJ13PPu8BMkidbOPcE6qilMMsHAY63I996s34NQVmJdZNibE+/x9GQ577sU
	89pX9Y3vmU25i/T+S29VjtheP4pT9fBpKnHdWM2yuuiUgroX4jxeP8/hhMfWRkSU
	Nhw1RbVCHXU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B840F1FEC2;
	Thu, 26 May 2016 22:11:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F98D1FEC1;
	Thu, 26 May 2016 22:11:36 -0400 (EDT)
In-Reply-To: <20160527004146.GA4996@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 20:41:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57083D48-23B0-11E6-B5CE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295707>

Jeff King <peff@peff.net> writes:

> I think the issue is that bin-wrappers serves two purposes. One is for
> testing, but the other is for people who run git directly without
> installing.

Hmph.  It may have been a useful way to "run without installing"
once in the past, but with the "check and run it under GDB" etc.,
I am not sure if it still is.  I certainly did not think about that
as a valid use case when I wrote the message you are responding to.

> I think you can make it even simpler by not really doing a "make
> install", but just linking or bin-wrappering a fake exec-path. It would
> be great if we could truly just "make install" into a fake area and test
> that (dropping bin-wrappers entirely), but git cares too much about some
> hard-coded paths, I think. We'd have to first have a truly relocatable
> binary.

Looking at what bin-wrappers do, I do not think "hard coded paths"
is something we need them for.  If we wanted to make the "test what
we just built" and the "test what is already installed" closely
mimic each other, I have a feeling that setting of the environment
variable done by the bin-wrappers can and should be moved to the
test framework.  When testing what we just built, set these
environment variables you see in any of the bin-wrappers/ script to
point at various places in the "make DESTDIR=there install" tree,
and when testing what is installed, set them to different values
(possibly "nothing", e.g. GIT_EXEC_PATH would not be needed if we
are testing an installed and already working version).

So I suspect "truly relocatable binary" is necessary for testing.
