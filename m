From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 2/2] alloc.c: remove the redundant commit_count variable
Date: Fri, 11 Jul 2014 01:59:53 +0100
Message-ID: <53BF3709.6000307@ramsay1.demon.co.uk>
References: <53BF28F4.8050704@ramsay1.demon.co.uk> <20140711003053.GB11360@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 03:00:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5PBz-0006hv-LV
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 03:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbaGKA76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 20:59:58 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:57854 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752176AbaGKA76 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 20:59:58 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id D9E56A64F49;
	Fri, 11 Jul 2014 00:54:00 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id A7880A64F36;
	Fri, 11 Jul 2014 00:54:00 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Fri, 11 Jul 2014 00:54:00 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140711003053.GB11360@sigill.intra.peff.net>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253247>

On 11/07/14 01:30, Jeff King wrote:
> On Fri, Jul 11, 2014 at 12:59:48AM +0100, Ramsay Jones wrote:
> 
>> The 'commit_count' static variable is used in alloc_commit_node()
>> to set the 'index' field of the commit structure to a unique value.
>> This variable assumes the same value as the 'count' field of the
>> 'commit_state' allocator state structure, which may be used in its
>> place.
> 
> I don't think we want to do this, because there is a bug in the current
> code that I have not reported yet. :)

:P OK, I will simply drop this one then.

> 
> The code you're touching here was trying to make sure that each commit
> gets a unique index, under the assumption that commits only get
> allocated via alloc_commit_node. But I think that assumption is wrong.
> We can also get commit objects by allocating an OBJ_NONE (e.g., via
> lookup_unknown_object) and then converting it into an OBJ_COMMIT when we
> find out what it is.

Hmm, I don't know how the object is converted, but the object allocator
is actually allocating an 'union any_object', so it's allocating more
space than for a struct object anyway. If you add an 'index' field to
struct object, (and remove it from struct commit) it could be set in
alloc_object_node(). ie _all_ node types get an index field.

Hmm, that was just off the top of my head, so take with a pinch of salt.

ATB,
Ramsay Jones
