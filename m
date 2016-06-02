From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: rename free_pathspec() to clear_pathspec()
Date: Thu, 02 Jun 2016 15:03:15 -0700
Message-ID: <xmqqinxrs0yk.fsf@gitster.mtv.corp.google.com>
References: <xmqq60trthl4.fsf@gitster.mtv.corp.google.com>
	<20160602212938.GA13071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ai4-0002Rc-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 00:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888AbcFBWDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 18:03:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932259AbcFBWDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 18:03:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DD1F21153;
	Thu,  2 Jun 2016 18:03:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N3J4BxSug0SKMfE+8xm1sZiLpC0=; b=sMq2aU
	T8yInFm2RXvsg68pH/B7/UzvdZjDrx53Wzqf7gN7fGbmbdvk26PrMFkbR0UYCHA0
	2W3Q0LBhzvOLpXD1Ug3tVBhUbB98tEN67kNwiBddpcAUqcwiNeI4M+z10m0LUXJ/
	joqbshoNL6wkWZPktqrsa2l8b4QllFkEN2boU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ogZc849TUFAyOHJtf7zkf5K7jLwDKsIT
	j7clzbU+5668qgkBH8SbPpmF2QLXSRa9ILgFO7/fcOWg99OpZ7MKSLRcMAdo284d
	NcG1DXdOcghG9l5Ew6UWU9RmBUQlCADWTZQsUadfBe5/bI/nNEbOfwKyjGe/qFhm
	P/KwlFSGuaE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 663E721152;
	Thu,  2 Jun 2016 18:03:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF8362114D;
	Thu,  2 Jun 2016 18:03:17 -0400 (EDT)
In-Reply-To: <20160602212938.GA13071@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jun 2016 17:29:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFD10E64-290D-11E6-9FDC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296246>

Jeff King <peff@peff.net> writes:

> I think diff_filespec_clear() would not be quite right. It is freeing
> only the allocated _data_, but leaving the other portions intact.

You are (as usual) more right than I am ;-)

Yes, the free_data() is designed to retain enough information about
the filespec so that the data can be re-read by the next person who
needs to access it after free_data() is called; i.e. it was a
measure to reduce the memory pressure by trading it off with I/O
cost.  It is wrong to name it "clear", which is to "clear the slate,
make it into pristine state" whose side effect is to release held
resources.
