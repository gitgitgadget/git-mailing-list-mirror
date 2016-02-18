From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 13/21] refs: resolve symbolic refs first
Date: Thu, 18 Feb 2016 12:59:58 +0100
Message-ID: <56C5B23E.6090905@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-14-git-send-email-dturner@twopensource.com>
 <56BDE780.2030407@alum.mit.edu> <1455755367.7528.57.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 13:07:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWNMi-0007NS-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 13:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426111AbcBRMHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 07:07:10 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51455 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423108AbcBRMHH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2016 07:07:07 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2016 07:07:07 EST
X-AuditID: 1207440c-c0bff70000002d40-bd-56c5b2415252
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 6D.A8.11584.142B5C65; Thu, 18 Feb 2016 07:00:01 -0500 (EST)
Received: from [192.168.69.130] (p548D6911.dip0.t-ipconnect.de [84.141.105.17])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1IBxx1R030092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 18 Feb 2016 07:00:00 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1455755367.7528.57.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqOu46WiYQddxfYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bm/N21nLnijXPF49Rz2BsZzMl2MnBwSAiYS
	S9ZvZuti5OIQEtjKKPFz+2NmCOc8k8Skj9NZuxg5OIQF7CUaj8uBNIgIOEhc3nUUquYKo0T/
	8pssIAk2AV2JRT3NTBBT5SR6uyeBxXkFtCXWndvABmKzCKhKHOmYyg5iiwqESLz/+pwVokZQ
	4uTMJ2D1nAIWEmf2HASrYRZQl/gz7xIzhC0v0bx1NvMERv5ZSFpmISmbhaRsASPzKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQkOTZwfhtncwhRgEORiUeXo7XR8KEWBPL
	iitzDzFKcjApifIKLzoaJsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd8N6oBxvSmJlVWpRPkxK
	moNFSZxXdYm6n5BAemJJanZqakFqEUxWhoNDSYK3awNQo2BRanpqRVpmTglCmomDE2Q4l5RI
	cWpeSmpRYmlJRjwoJuOLgVEJkuIB2vsMpJ23uCAxFygK0XqKUVFKnPc+SEIAJJFRmgc3FpZo
	XjGKA30pzCu6EaiKB5ik4LpfAQ1mAhqcc+kQyOCSRISUVANj2ave6u7Pj7v5ZHpXvc/S51ki
	oHVIKWLOKvcdPR7Cz05zfHz9ZBaPArf2iuWaSTybhLZ/e2rhkSuodrJc5yVfq1zO4eeGjDNN
	ms85PUp7Vszd3rjLuaX8baui4dalgmwHjxaxTvgptbebc93WCf9NV2by2N3Oskxb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286605>

On 02/18/2016 01:29 AM, David Turner wrote:
> On Fri, 201-02-12 at 15:09 +0100, Michael Haggerty wrote:]
>> On 02/05/2016 08:44 PM, David Turner wrote:
>>> Before committing ref updates, split symbolic ref updates into two
>>> parts: an update to the underlying ref, and a log-only update to
>>> the
>>> symbolic ref.  This ensures that both references are locked
>>> correctly
>>> while their reflogs are updated.
>>>
>>> It is still possible to confuse git by concurrent updates, since
>>> the
>>> splitting of symbolic refs does not happen under lock. So a
>>> symbolic ref
>>> could be replaced by a plain ref in the middle of this operation,
>>> which
>>> would lead to reflog discontinuities and missed old-ref checks.
>>
>> This patch is doing too much at once for my little brain to follow.
>>
>> My first hangup is the change to setting RESOLVE_REF_NO_RECURSE
>> unconditionally in lock_ref_sha1_basic(). I count five callers of
>> that
>> function and see no justification for why the change is OK in the
>> context of each caller. Here are some thoughts:
>>
>> * The call from files_create_symref() sets REF_NODEREF, so it is
>> unaffected by this change.
> 
> Yes.
> 
>> * The call from files_transaction_commit() is preceded by a call to
>> dereference_symrefs(), which I assume effectively replaces the need
>> for
>> RESOLVE_REF_NO_RECURSE.
> 
> Yes.
> 
>> * There are two calls from files_rename_ref(). Why is it OK to do
>> without RESOLVE_REF_NO_RECURSE there?
>>
>>   * For the oldrefname call, I suppose the justification is the
>> "(flag &
>> REF_ISSYMREF)" check earlier in the function. (But does this
>> introduce a
>> significant TOCTOU race?)
> 
> The refs code as a whole seems likely to have TOCTOU issues. In
> general, anywhere we check/set flag & REF_ISSYMREF without holding a
> lock, we have a potential problem.  I haven't generally tried to handle
> these cases, since they're not presently handled.  

I agree that we don't do so well here, though I think that most races
would result in reading/writing a ref that was pointed to by the symref
a moment ago, which is usually indistinguishable to the user from their
update having gone through the moment before the symref was updated. So
I don't think your change makes this bit of code significantly worse.

> The central problem with this area of the code is that commit interacts
> so intimately with the locking machinery.  I understand some of why
> it's done that way.  In particular, your change to ref locking to not
> hold lots of open files was a big win for us at Twitter.  But this
> means that it's hard to deal with cross-backend ref updates: you want
> to hold multiple locks, and backends don't have the machinery for it.
> 
> We could add backend hooks to specifically lock and unlock refs. Then
> the backend commit code would just be handled a bundle of locked refs
> and would commit them.  This might be hairy, but it could fix the
> TOCTOU problems.  So, first lock the outer refs, then split out updates
> for any which are symbolic refs, and lock those. Finally, commit all
> updates (split by backend).

As chance would have it, for an internal GitHub project I've implemented
hooks that can be called *during* a ref transaction. The hooks can, for
example, take arbitrary actions between the time that the reflocks are
all acquired and the time that the updates start to be committed. I
didn't submit this code upstream because I didn't think that it would
benefit other users, but many it would be useful for implementing
split-backend reference transaction commits. E.g., the primary reference
transaction could run the secondary backend's commit while holding the
locks for the primary backend references.

Let me think about it.

I don't think this is urgent though. The current code is not
significantly racy in mainstream usage scenarios, right?

> One downside of this is that right now, the backend API is relatively
> close to the front-end, and this would leak what should be an
> implementation detail.  But maybe this is necessary to knit multiple
> backends together.  
> 
> But I'm not sure that this is necessary right now, because I'm not sure
> that I'm actually making TOCTOU issues much worse. 

Agreed.

> [...]
> That's a legit complaint.  The problem, as you note, is that doing some
> of these steps completely independently doesn't work.  But I'll try
> splitting out what I can.

Thanks!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
