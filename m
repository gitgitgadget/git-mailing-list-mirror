From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Wed, 28 May 2014 16:21:25 +0200
Message-ID: <5385F0E5.4010306@alum.mit.edu>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>	<1400174999-26786-42-git-send-email-sahlberg@google.com>	<537F67DD.5010101@alum.mit.edu> <xmqqzji3f55i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 16:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpejY-000404-L3
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 16:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbaE1OVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 10:21:30 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47753 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753685AbaE1OV2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 10:21:28 -0400
X-AuditID: 12074414-f79f86d000000b9f-ee-5385f0e7345a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 42.E5.02975.7E0F5835; Wed, 28 May 2014 10:21:27 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97A4D.dip0.t-ipconnect.de [79.201.122.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4SELPjt010534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 28 May 2014 10:21:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqqzji3f55i.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqPv8Q2uwwcGfuhZdV7qZLBp6rzBb
	vL25hNHi34QaBxaPnbPusnss2FTqcfGSssfnTXIBLFHcNkmJJWXBmel5+nYJ3Bk3OloZC35L
	Vlz79Zm9gXGTSBcjJ4eEgInElcNPWCFsMYkL99azgdhCApcZJZ63s3QxcgHZ55kkriy6ztjF
	yMHBK6AtsXMZJ0gNi4CqxNO7U8F62QR0JRb1NDOBlIgKBEn8OasIEuYVEJQ4OfMJC4gtIqAm
	MbHtEJjNLJAr0fl5AzuILSyQJ9H5oYsNYtVpRomeD1/BbuAUsJZo27uGFWSmhIC4RE9jEESv
	jsS7vgfMELa8xPa3c5gnMArOQrJuFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3S
	tdDLzSzRS00p3cQICW+RHYxHTsodYhTgYFTi4T2wuCVYiDWxrLgy9xCjJAeTkijv3PetwUJ8
	SfkplRmJxRnxRaU5qcWHGCU4mJVEeB+8BMrxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1O
	TS1ILYLJanBwCFw5eGQ2oxRLXn5eqpIE7waQBYJFqempFWmZOSUIpUwcnCCLuKREilPzUlKL
	EktLMuJBUR1fDIxrkBQP0A2nQNp5iwsSc4GiEK2nGBWlxHm/vwNKCIAkMkrz4MbCktkrRnGg
	j4V5p4K08wATIVz3K6DBTECDn3SCDS5JREhJNTBOXzPF2mHHnaf5R3d2tnVW3lzwoEn80I25
	/K2TlXds/xf2V1Dt/a5HaavY83+KTrJw3/lm+sWIwstSGwJnCUkwLYkxtJ/Aq/mW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250283>

On 05/27/2014 08:27 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This suggests to me that our current structure is best modeled as two
>> independent reference back ends, with a third implementation of the same
>> reference API whose job it is to compose the first two.  In pseudocode,
>> ...
> 
> That is an interesting view.
> 
> How does reflog fit into the picture?  Is it a completely
> independent thing that is called from any implementation of
> ReferenceBackend interface?

That's a good question.  It certainly wouldn't work for each of the
loose and packed backends to try to do logging.  I think the best
solution would be to have a logging wrapper as explained below.

>> From this point of view it is clear that packing refs is not an
>> operation that belongs in the ReferenceBackend API, but rather in the
>> StackedReferenceBackend interface.
> 
> When an implementation of ReferenceBackend has skewed performance
> characteristics (e.g. PackedReferenceBackend really prefers to be
> modified in bulk), how would that interact with the abstraction?
> 
> For example, when the application does:
> 
>     begin_transaction()
>     for ref in many_refs():
> 	delete_reference(ref)
>     commit_transaction()
> 
> StackedReferenceBackend() that consists of Loose on top of Packed
> may want to implement the commit phase like so:
> 
>     - tell Packed backend to repack without the deleted refs
>     - tell Loose backend to delete the deleted refs

I think for any two backends that are stacked, you would need to break
down a transaction as follows (here generalized to include not only
deletions):

    packed->begin_transaction()
    loose->begin_transaction()

    # And this part is done within stacked->commit_transaction():
    for entry in many_ref_updates():
        if have_old:
            stacked->verify_reference(ref, old_sha1)

        if entry is a delete:
            packed->delete_reference(entry)
        loose->update_reference(entry)

    if (!packed->commit_transaction())
        loose->commit_transaction()

Verifying old values is impossible to do batchwise with the current API,
because the old value of the packed ref has to be verified if and only
if there is no corresponding loose ref.

> But the above would not quite work, as somebody needs to remove logs
> for refs that were only in the Packed backend, and "repack without
> these refs" API supported by the Packed backend cannot be that
> somebody---"repack packed-refs without A B C" cannot unconditionally
> remove logs for A B C without checking if A B C exists as Loose.

Correct.  That's another reason that logging has to be the
responsibility of something at the "stacked" level of abstraction or higher.

I think the logging should be done by yet another outer layer of wrapper
that only does the logging, while also passing all updates down 1:1 to
the backend that it wraps (which in our case would be a stacked
backend).  Then the loose and packed backends could remain completely
ignorant of the fact that reference updates can be logged.  I think the
logging layer could implement the same reference backend API as the
other backends.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
