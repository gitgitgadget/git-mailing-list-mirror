From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add a --nosort option to pack-objects
Date: Fri, 07 Dec 2007 13:37:47 -0800
Message-ID: <7vzlwmyyms.fsf@gitster.siamese.dyndns.org>
References: <1197061832-8489-1-git-send-email-mh@glandium.org>
	<7v4peu19kr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kuV-0002rJ-D2
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbXLGViL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755062AbXLGViJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:38:09 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbXLGViI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:38:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 07F861B98;
	Fri,  7 Dec 2007 16:38:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 457EF1B97;
	Fri,  7 Dec 2007 16:37:54 -0500 (EST)
In-Reply-To: <7v4peu19kr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 07 Dec 2007 13:25:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67468>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> The --nosort option disabled the internal sorting used by pack-objects,
>> and runs the sliding window along the object list litterally as given on
>> stdin.
>
> I think this is a good way to give people an easier way to experiment.

Actually, I take the half of this back.

We need a pair of two good sort orders.  The order of objects fed to
pack-objects determines the final layout of the resulting pack, and
using something like the "recency order" we currently have is to
optimize the layout in the resulting pack for typical access patterns.

By using your --nosort, you may be able to influence the deltification
process, but the order you use will most likely not match the access
pattern of the resulting pack.  So it will be an easy, quick-and-dirty
way to _experiment_ how the deltification sort order affects the final
pack size, but I suspect that the resulting "small" pack won't be useful
in the real life.
