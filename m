From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] log: pass rev_info to git_log_config()
Date: Fri, 05 Oct 2012 12:07:59 -0700
Message-ID: <7vtxu8u48g.fsf@alter.siamese.dyndns.org>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-6-git-send-email-gitster@pobox.com>
 <7v1uhe3efa.fsf@alter.siamese.dyndns.org>
 <7vk3v5v9ip.fsf@alter.siamese.dyndns.org>
 <20121005153341.GA24957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 21:08:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKDFv-0002wY-58
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 21:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab2JETIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 15:08:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab2JETID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 15:08:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C033924E;
	Fri,  5 Oct 2012 15:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C3c4xypFnmP28tcxdff8EWS0ijU=; b=GGdtkS
	t6KSm+J47ODCdNrm6/PgvbQe6xNWain5T2/AlAr7mJ/8HTmBGj/3WPPBvqQkbDt4
	MRIzTAGQczk3r1oOUNEPdUd+At0mrxFZCnQdtrEt66OrrgQyXBlUSAG7fQN418nv
	HDIO9P4J2HGZtx+5i6my3Q/rVN7oY/E4DR+iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m88k+N944N3zozMUMO6m/HQZUjQ5ir96
	oN70vW4fzbG0jqHx3OXSlle7mhITFa8rcronkutzAuNbf5Keyk97HzmlUc0mrwbG
	Nn3uVajctMFAlcrL/EvJ4HCYfhHo8+RjX3JsRZ+e0dglSDQlh9shUjNy8tADIu2S
	CdrWr1FfLmM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6910924C;
	Fri,  5 Oct 2012 15:08:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E53AF9246; Fri,  5 Oct 2012
 15:08:00 -0400 (EDT)
In-Reply-To: <20121005153341.GA24957@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 5 Oct 2012 11:33:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB5339CE-0F1F-11E2-907D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207115>

Jeff King <peff@peff.net> writes:

> Agreed. Maybe the simplest thing would be to have grep_config fill in a
> "static struct grep_opt grep_defaults", and then memcpy that into place
> during init_revisions?

Yes, I was doing that for a bit last night, but then realized that
the grep_config() should be split into two (grep specific part and
then the bits that cascade to others, which is "git grep" specific
requirement; it is far better to let other callers to arrange the
cascading themselves) before moving the grep specific bit to the
top-level, so that needs to come first.
