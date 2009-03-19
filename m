From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 04:02:19 -0700
Message-ID: <7vhc1pai84.fsf@gitster.siamese.dyndns.org>
References: <49C0DE23.8020809@viscovery.net>
 <20090319041837.GA32642@coredump.intra.peff.net>
 <20090319044313.GA341@coredump.intra.peff.net>
 <alpine.DEB.1.00.0903191135530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 12:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkG2s-0003fP-By
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 12:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbZCSLCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 07:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZCSLCb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 07:02:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbZCSLCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 07:02:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76F40A3AB3;
	Thu, 19 Mar 2009 07:02:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9570AA3AAC; Thu,
 19 Mar 2009 07:02:21 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903191135530.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu, 19 Mar 2009 11:36:50 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FA6FA08-1475-11DE-A08C-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113758>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 19 Mar 2009, Jeff King wrote:
>
>> @@ -163,9 +163,15 @@ static int cmp_items(const void *a, const void *b)
>>  	return strcmp(one->string, two->string);
>>  }
>>  
>> +void sort_string_list_with_fn(struct string_list *list,
>> +			      int (*fn)(const void *, const void *))
>> +{
>> +	qsort(list->items, list->nr, sizeof(*list->items), fn);
>> +}
>> +
>
> Do we really want an API for that?  Calling qsort() directly should be 
> obvious enough, no?

I think so.  If it were done like this (notice the lack of double
indirection in the cmp_fn signature):

    typedef int string_list_item_cmp_fn(const struct string_list_item *, const struct string_list_item *);

    void sort_string_list_with_fn(struct string_list *list, string_list_item_cmp_fn *);

it would have made more sense, though.
