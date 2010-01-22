From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Thu, 21 Jan 2010 22:17:33 -0800
Message-ID: <7vhbqeacjm.fsf@alter.siamese.dyndns.org>
References: <718290.769818367-sendEmail@darysmbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "David Rydh" <dary@math.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Jan 22 07:17:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYCq5-0004MS-2k
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 07:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab0AVGRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 01:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551Ab0AVGRo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 01:17:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab0AVGRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 01:17:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7ABB93B5E;
	Fri, 22 Jan 2010 01:17:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9AyLz9022BBQTy5nkE8/HQOGX2A=; b=uUj351
	fbPosF3TzF3RDDo9zbWY72rN/W5/mC8SP2PsPJYtQ3b8j5IT8/Bc9qOynrkfuDqZ
	ahPB07FK08blCeOJ9Jh0qsLwWvEJp74xfsPN63q/JZDRVsF4eHn/xUM1CXRjY44+
	qhudvbY4bjr/FGkNP/Z8hUJKXgPSwctdyHv5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WFJ3OHQMQnPm1aC1ivaW3Makuf2VIrb1
	HfIGXCTOA/jODOCfrDB6z9kjOLyB15ilfl0Gw6LH3NS/uZQGnzHQThYZS+Ux1B86
	3JMMKZNvgSl3bILVxk0YAKZm/zfjKXi9llOjEBOq0qE99wi4RfEK/Z/9y4ihmDxw
	PxURspEwoqo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82BE393B5C;
	Fri, 22 Jan 2010 01:17:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C027693B5B; Fri, 22 Jan
 2010 01:17:34 -0500 (EST)
In-Reply-To: <718290.769818367-sendEmail@darysmbp> (David Rydh's message of
 "Thu\, 21 Jan 2010 12\:39\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6E24736-071D-11DF-8642-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137741>

"David Rydh" <dary@math.berkeley.edu> writes:

> This commit also fixed two potentially dangerous uses of
> prefix_filename() -- which returns static storage space -- in
> builtin-config.c and hash-object.c.

This should probably be a separate patch.  builtin-hash-object.c also uses
prefix_filename() first to obtain vpath without strdup() and then uses the
function to create arg, which seems to be unsafe to me.  I've looked at
all the hits from 

    $ git grep -n -e prefix_filename\( -- '*.c'

and other places seem to be Ok.
