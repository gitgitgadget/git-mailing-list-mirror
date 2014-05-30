From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Fri, 30 May 2014 11:47:33 +0200
Message-ID: <538853B5.1080308@alum.mit.edu>
References: <1401311055-480-1-git-send-email-dturner@twitter.com> <1401311055-480-2-git-send-email-dturner@twitter.com> <538658C0.8050001@alum.mit.edu> <1401320968.18134.98.camel@stross> <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com> <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com> <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com> <20140529234109.GA28683@sigill.intra.peff.net> <CACsJy8BgriBBWJ6ZzQS8S7p4SUB=bdZHdnUQsyN03g+vtApbxA@mail.gmail.com> <20140530000728.GC28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 11:47:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqJPb-0007o7-08
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 11:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbaE3Jrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 05:47:39 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57757 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754750AbaE3Jrh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2014 05:47:37 -0400
X-AuditID: 1207440c-f79656d000000c83-a2-538853b9cb74
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 27.38.03203.9B358835; Fri, 30 May 2014 05:47:37 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3ADC.dip0.t-ipconnect.de [93.219.58.220])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4U9lYDw027805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 30 May 2014 05:47:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140530000728.GC28683@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqLszuCPYYPofFosPV54zWszfdILR
	outKN5NFQ+8VZovuKW8ZLX609DA7sHnsnHWX3eNZ7x5Gj4uXlD0udj9h9ljw/D67x+dNcgFs
	Udw2SYklZcGZ6Xn6dgncGcdPrmEuaJGqOPD0BFMD4z2RLkZODgkBE4mFM9czQdhiEhfurWfr
	YuTiEBK4zCjR/Gs9K0hCSOA8k8TPjX4gNq+AtsSOGavAGlgEVCU+tO9kA7HZBHQlFvU0A8U5
	OEQFgiT+nFWEKBeUODnzCQuILSJgK/F093+w+cwC2xgl7l9bzw6SEBYwk7h8aBMLxOJpLBIf
	JrUwgiQ4BawlvnQ/YwYZKiEgLtHTGARiMguoS6yfJwRSwSwgL7H97RzmCYyCs5Csm4VQNQtJ
	1QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYIbHAs4Px2zqZQ4wCHIxK
	PLwZLu3BQqyJZcWVuYcYJTmYlER5nTw6goX4kvJTKjMSizPii0pzUosPMUpwMCuJ8O71Acrx
	piRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4PwUBNQoWpaanVqRl5pQg
	pJk4OEGGc0mJFKfmpaQWJZaWZMSDoje+GBi/ICkeoL1rAkH2Fhck5gJFIVpPMepynLpzrI1J
	iCUvPy9VSpx3H0iRAEhRRmke3ApY4nvFKA70sTDvC5BLeIBJE27SK6AlTEBLnnS2giwpSURI
	STUwlqbecXr7wWDF0v3WD7h++7dGhlSoKp3RPzDpbO1S/7PR5/OnTGE/wvnUq0q/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250437>

On 05/30/2014 02:07 AM, Jeff King wrote:
> On Fri, May 30, 2014 at 06:43:18AM +0700, Duy Nguyen wrote:
> 
>>>> The first time we read packed_refs, check_refname_format() is called
>>>> in read_packed_refs()->create_ref_entry() as usual. If we find no
>>>> problem, we store packed_refs stat() info in maybe packed_refs.stat.
>>>> Next time we read packed_refs, if packed_refs.stat is there and
>>>> indicates that packed_refs has not changed, we can make
>>>> create_ref_entry() ignore check_refname_format() completely.
>>>
>>> I'm confused. Why would we re-open packed-refs at all if the stat
>>> information hasn't changed?
>>
>> No, not in the same process. In the next run.
> 
> Ah, I thought "packed_refs.stat" was a struct member, but I guess you
> mean it as a filename.
> 
> But then we're just trusting that the "trust me" flag on disk is
> correct. Why not just trust that packed-refs is correct in the first
> place?
> 
> IOW, consider this progression of changes:
> 
>   1. Check refname format when we read packed-refs (the current
>      behavior).
> 
>   2. Keep a separate file "packed-refs.stat" with stat information. If
>      the packed-refs file matches that stat information, do not bother
>      checking refname formats.
> 
>   3. Put a flag in "packed-refs" that says "trust me, I'm valid". Check
>      the refnames when it is generated.
> 
>   4. Realize that we already check the refnames when we write it out.
>      Don't bother writing "trust me, I'm valid"; readers can assume that
>      it is.
> 
> What is the scenario that option (2) protects against that options (3)
> and (4) do not?
> 
> I could guess something like "the writer has a different idea of what a
> valid refname is than we do". But that applies as well to (2), but just
> as "the reader who wrote packed-refs.stat has a different idea than we
> do".

If we want to be robust to future changes to refname rules, we could add
a header flag like

    # pack-refs with: peeled fully-peeled check-level=1.0

which promises that the reference names in the file conform to the
current ("version 1.0") check_refname_format() rules.

If we ever make the rules stricter (a "backwards-compatible" change), we
would increment the check-level to 1.1.  That way, an old reader, who
knows about check-level=1.0 but not check-level=1.1, can still trust
that the refnames in the file conform to its check_refname_format()
rules and avoid the verification step.  (Of course if that version
writes the file again, it would have to set the check-level=1.0 tag, and
newer software would be forced to validate on reading to be sure that
the refnames still conform to check-level=1.1.)

If we make the rules looser (a "backwards-incompatible" change), we
would increment the check-level to 2.0.  In that case readers who only
know about check-level 1.x would have to turn their verification code
back on when reading the file to ensure that they can work with the
refnames that it contains.

Format changes should be infrequent enough, and the cost of verification
is low enough, that sometimes ping-ponging back and forth between
software versions shouldn't be a problem in practice.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
