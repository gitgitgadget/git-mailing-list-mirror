From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads
 list
Date: Mon, 17 Sep 2012 14:55:37 +0200
Message-ID: <50571DC9.2030602@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu> <7v7gs3sdjx.fsf@alter.siamese.dyndns.org> <20120909130532.GA27754@sigill.intra.peff.net> <7vhar7qd07.fsf@alter.siamese.dyndns.org> <504E62DF.5030408@alum.mit.edu> <7vhar5leal.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:55:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDare-0006aj-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 14:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416Ab2IQMzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 08:55:41 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:45365 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754278Ab2IQMzl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 08:55:41 -0400
X-AuditID: 12074414-b7f846d0000008b8-69-50571dcc09ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 06.45.02232.CCD17505; Mon, 17 Sep 2012 08:55:40 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8HCtbOI015335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Sep 2012 08:55:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vhar5leal.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqHtGNjzAYO5vQYuuK91MFg29V5gt
	frT0MFt0TpV1YPFYvnQdo8ez3j2MHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ1x4MMy1oJp
	/BVtUw6zNDAu4uli5OSQEDCROHellxHCFpO4cG89WxcjF4eQwGVGiZsrXrBDOMeZJH5M2M7U
	xcjBwSugLXFlDztIA4uAqsSz/ddYQWw2AV2JRT3NTCC2qECIxIzLk5lBbF4BQYmTM5+wgNgi
	AmoSE9sOgdnMAokS/xY9BusVFgiQOL2+H6xeSGAik8TZNSUgNqeAmcTUX7OZIep1JN71PYCy
	5SW2v53DPIFRYBaSFbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6FXm5miV5q
	SukmRkgwi+xgPHJS7hCjAAejEg+v8aSwACHWxLLiytxDjJIcTEqivJelwgOE+JLyUyozEosz
	4otKc1KLDzFKcDArifDeFgDK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2Cycpw
	cChJ8O6QAWoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VqfDEwVkFSPEB774C0
	8xYXJOYCRSFaTzHqctz9uOI+oxBLXn5eqpQ47zGQIgGQoozSPLgVsNT1ilEc6GNh3kcgVTzA
	tAc36RXQEiagJRVPwkCWlCQipKQaGEUFN4h+33tIz5WFNfnpRUemP69PeF7dv/y/qez32KIZ
	Br2zHe5vqlpyXvPVryenxFMDdCPOPtUx+9WutspSON4yq68hazPzj7vZisZpj/7n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205684>

On 09/11/2012 12:10 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> OK.  As long as the sort order matches the order string-list
>>> internally uses for its bisection search, it won't be a problem,
>>> then.
>>
>> The sorting is crucial but there is no bisection involved.  The sorted
>> linked-list of references available from the remote and the sorted
>> string_list of requested references are iterated through in parallel.
> 
> What I meant was that the order used by string-list is pretty much
> internal to string-list implementation for its "quickly locate where
> to insert" bisection.  It happens to be the byte value order, I
> think, but the point is whatever order it is, that has to match the
> order we keep references in the other data source you walk in
> parallel to match (i.e. the linked list of references).

Yes, your point is good that the two sort orders have to agree.
Currently, they both use strcmp() order, so the situation is OK.

It is interesting that you consider the sort order of string_list to be
somewhat of an internal implementation detail.  I had thought of its
current behavior as being the obvious thing and considered it part of
the API's contract.  For example, the current sort order is already
observable via the API through iteration or by calling
print_string_list().  Therefore I think that we should document the
strcmp() sort order as part of the string_list contract.  Patch coming soon.

If, at some future time, somebody wants a string_list that is sorted by
a different criterion, then the order should be determined via a
callback function specified by the user.  The callback function could
even be stored in the string_list header, to allow such lists to be used
in combination with the "functions for sorted lists only".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
