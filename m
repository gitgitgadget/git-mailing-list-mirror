From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v7 03/11] trailer: read and process config information
Date: Fri, 07 Mar 2014 22:59:54 +0100
Message-ID: <87ob1hbrfp.fsf@fencepost.gnu.org>
References: <20140306221409.29648.10706.chriscool@tuxfamily.org>
	<xmqqmwh1u2gf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 23:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM2oK-0004Y1-Et
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 23:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbaCGWAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 17:00:01 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:48402 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbaCGWAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 17:00:00 -0500
Received: from localhost ([127.0.0.1]:47433 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WM2o6-0006NS-MP; Fri, 07 Mar 2014 16:59:54 -0500
Received: by lola (Postfix, from userid 1000)
	id 2A013DF3F3; Fri,  7 Mar 2014 22:59:54 +0100 (CET)
In-Reply-To: <xmqqmwh1u2gf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 07 Mar 2014 13:24:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243632>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> This patch implements reading the configuration
>> to get trailer information, and then processing
>> it and storing it in a doubly linked list.
>
> "Read and process the ...", perhaps?
>
>> The config information is stored in the list
>> whose first item is pointed to by:
>>
>> static struct trailer_item *first_conf_item;
>
> If feels somewhat strange if a doubly linked list has only the first
> pointer without the last pointer, unless the previous field of the
> first one by convention points at the last one, forming a cycle
> (which I think is a reasonable thing to do, as a desire for a quick
> access to the top and the bottom is often a reason to use doubly
> linked list---I didn't check if you implement it that way, though).

Can't say I agree here.  Basically all my doubly-linked lists are not
for traversing data forwards and backwards but for making it possible to
delete list members that have not been reached by list traversal but
rather by orthogonal data access methods.  Consequently, my back links
usually don't point to the previous list member (which would require
special-casing the first element) but rather to its referring
forward-pointing link (which for the first list element means a pointer
to the list head).

Having a "last" pointer is an orthogonal concept: you need it if you
want to append to a list's end without actually looking at its members.
The presence of such a last pointer actually makes it quite more ugly to
delete the last member of a doubly-linked list reached by some other
means as you then need to have some way of adjusting the tail pointer
accordingly.

-- 
David Kastrup
