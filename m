From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Project idea: strbuf allocation modes
Date: Fri, 18 Apr 2014 22:04:30 +0200
Message-ID: <5351854E.1080602@alum.mit.edu>
References: <vpqr457omgs.fsf@anie.imag.fr> <53512DB6.1070600@alum.mit.edu> <xmqq8ur2d04g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 22:04:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbF1a-00054Y-RL
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 22:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbaDRUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 16:04:35 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47029 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753068AbaDRUEd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 16:04:33 -0400
X-AuditID: 1207440d-f79d86d0000043db-4a-535185503b98
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 18.80.17371.05581535; Fri, 18 Apr 2014 16:04:32 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9714E.dip0.t-ipconnect.de [79.201.113.78])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3IK4UdL027495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 18 Apr 2014 16:04:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqq8ur2d04g.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqBvQGhhssP6kmUXXlW4mi4beK8wW
	lz6vZ3Vg9pj45Tirx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGcsadrJXDCHv2L+/MtsDYz9
	PF2MnBwSAiYSW88dZoawxSQu3FvPBmILCVxmlGhbYtTFyAVkn2eSmNM/kxEkwSugLXFucicL
	iM0ioCpxqGk2mM0moCuxqKeZqYuRg0NUIEjiz1lFiHJBiZMzn4CViAioSUxsOwRmMwt4SXRM
	7GEHKRcWMJKYe9IPYm2lRPfBZrBzOAWsJdZvAGnlADpNXKKnMQiiU0fiXd8DZghbXmL72znM
	ExgFZyFZNgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQz
	7w7G/+tkDjEKcDAq8fBuCAgMFmJNLCuuzD3EKMnBpCTK+6cJKMSXlJ9SmZFYnBFfVJqTWnyI
	UYKDWUmEd74vUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMHL0wLU
	KFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K3fhiYPSCpHiA9nKAtPMWFyTmAkUh
	Wk8x6nJcaFjRwiTEkpeflyolzvunGahIAKQoozQPbgUsdb1iFAf6WJiXF2QUDzDtwU16BbSE
	CWjJ3zMBIEtKEhFSUg2Mql+e22eYp77nOpwzMeeUIdNpFQMBwRwJxg33tyR7/Kr8revN/vHz
	yZpj4Z7P5/zQvyPkp5N96N2p5RMXJc253X/2aGYXf5L056Arr5OqGLpvnC9Ql337 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246482>

On 04/18/2014 07:21 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The Idea
>> ========
>>
>> I would like to see strbuf enhanced to allow it to use memory that it
>> doesn't own (for example, stack-allocated memory), while (optionally)
>> allowing it to switch over to using allocated memory if the string grows
>> past the size of the pre-allocated buffer.
> 
> I'd like to see these characteristics, but I would want to see that
> this is done entirely internally inside the strbuf implementation
> without any API impact, other than the initialisation.  I do not
> think the current API contract is too rigid to allow us doing so.
> 
>  - The API users may peek strbuf.buf in-place until they perform an
>    operation that makes it longer (at which point the .buf pointer
>    may point at a new piece of memory).
> 
>  - The API users may strbuf_detach() to obtain a piece of memory
>    that belongs to them (at which point the strbuf becomes empty),
>    hence needs to be freed by the callers.
> 
> As long as the above two promises are kept intact, it is all
> internal to the strbuf implementation, current iteration of which
> does not have any initial (possibly static) allocation other than
> the fixed "terminating NUL", but your updated one may take a caller
> supplied piece of memory that is designed to outlive the strbuf
> itself as its initial allocation and the memory ownership can be
> left as an internal implementation detail to the strbuf without
> bothering the callers.

I think that's exactly what I described.  The only thing that would have
to change in the strbuf behavior (aside from initialization) is that a
buffer-growing operation might die if the string would grow outside of
the bounds of the existing buffer when STRBUF_FIXED_MEMORY is set.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
