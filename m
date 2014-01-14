From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 4/5] get_sha1: speed up ambiguous 40-hex test
Date: Tue, 14 Jan 2014 12:34:37 +0100
Message-ID: <52D520CD.7070902@alum.mit.edu>
References: <20140107235631.GA10503@sigill.intra.peff.net> <20140107235953.GD10657@sigill.intra.peff.net> <52CD7835.2020708@alum.mit.edu> <20140110094120.GB17443@sigill.intra.peff.net> <20140114095002.GA32258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 14 12:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W32Gc-0006QG-N2
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 12:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaANLen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 06:34:43 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58489 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342AbaANLel (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 06:34:41 -0500
X-AuditID: 1207440f-b7f306d000006d99-3d-52d520d0b6cd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C6.22.28057.0D025D25; Tue, 14 Jan 2014 06:34:40 -0500 (EST)
Received: from [192.168.69.148] (p57A241AD.dip0.t-ipconnect.de [87.162.65.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0EBYbcQ008236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Jan 2014 06:34:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140114095002.GA32258@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsUixO6iqHtB4WqQwb81chYHXj5lsei60s1k
	0dB7hdmie8pbRosfLT3MDqweO2fdZfd41ruH0ePiJWWPZwdusnl83iQXwBrFbZOUWFIWnJme
	p2+XwJ2x5cMmtoImlYo9N/vYGhjfyXQxcnJICJhIvJ/6ixnCFpO4cG89WxcjF4eQwGVGifmb
	O1kgnPNMEos6v7GCVPEKaEvseLOeBcRmEVCVWPm3F8xmE9CVWNTTzARiiwoES6y+/IAFol5Q
	4uTMJ2C2iICsxPfDGxlBhjILbGCUOPXnHiNIQljAReLqy9WsENueM0psXf+BDSTBKWAtMWf/
	baCpHED3iUv0NAaBmMwC6hLr5wmBVDALyEtsfzuHeQKj4Cwk62YhVM1CUrWAkXkVo1xiTmmu
	bm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkjo8+9g7Fovc4hRgINRiYf3BOOVICHWxLLi
	ytxDjJIcTEqivHskrwYJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuF9ApLjTUmsrEotyodJSXOw
	KInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwSgNjXEiwKDU9tSItM6cEIc3EwQkynEtKpDg1
	LyW1KLG0JCMeFMHxxcAYBknxAO31kgfZW1yQmAsUhWg9xajLsWLDpz+MQix5+XmpUuK8iiA7
	BECKMkrz4FbAEt0rRnGgj4V5nUCqeIBJEm7SK6AlTEBLau9fAVlSkoiQkmpgnPUgWjrdudW2
	wvLU4xmFvqmf1WonpC7i2l1u0Kh3eE/H9k8f/8qZTrrG8VvJruBoQ6PZrClFNvZi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240395>

On 01/14/2014 10:50 AM, Jeff King wrote:
> On Fri, Jan 10, 2014 at 04:41:20AM -0500, Jeff King wrote:
> 
>> That being said, we could further optimize this by not opening the files
>> at all (and make that the responsibility of do_one_ref, which we are
>> avoiding here). I am slightly worried about the open() cost of my
>> solution. It's amortized away in a big call, but it is probably
>> noticeable for something like `git rev-parse <40-hex>`.
> 
> I took a look at this. It gets a bit hairy. My strategy is to add a flag
> to ask read_loose_refs to create REF_INCOMPLETE values. We currently use
> this flag for loose REF_DIRs to mean "we haven't opendir()'d the
> subdirectory yet". This would extend it to the non-REF_DIR case to mean
> "we haven't opened the loose ref file yet". We'd check REF_INCOMPLETE
> before handing the ref_entry to a callback, and complete it if
> necessary.
> 
> It gets ugly, though, because we need to pass that flag through quite a
> bit of callstack. get_ref_dir() needs to know it, which means all of
> find_containing_dir, etc need it, meaning it pollutes all of the
> packed-refs code paths too.
> 
> I have a half-done patch in this direction if that doesn't sound too
> nasty.

A long time ago I write a patch series to allow incomplete reading of
references, but my version *always* read them lazily, so it was much
simpler (no need to pass a new option down the call stack).  It didn't
seem to speed things up in general, so I never submitted it.

Reading lazily only from particular callers is more complicated, and I
can see how it would get messy.

Given the race avoidance needed between packed/loose references, lazy
reading would mean that after each reference is read, the packed-refs
file would need to be stat()ted again to make sure that it hasn't been
changed since the last check.  I know this isn't an issue for your use
case, because you plan *never* to read the file contents.  But it does
increase the price of lazy reference reading to most callers.

On the other hand, if we ever go in the direction of routing *all*
reference lookups--including lookups of single references--through the
cache, then lazy reading of references probably becomes essential to
avoid populating more of the cache than necessary.

>>> This doesn't correctly handle the rule
>>>
>>> 	"refs/remotes/%.*s/HEAD"
>> [...]
> 
>> I'll see how painful it is to make it work.
> 
> It's actually reasonably painful. I thought at first we could get away
> with more cleverly parsing the rule, find the prefix (up to the
> placeholder), and then look for the suffix ("/HEAD") inside there. But
> it can never work with the current do_for_each_* code. That code only
> triggers a callback when we see a concrete ref. It _never_ lets the
> callbacks see an intermediate directory.
> 
> So a NO_RECURSE flag is not sufficient to handle this case. I'd need to
> teach do_for_each_ref to recurse based on pathspecs, or a custom
> callback function. And that is getting quite complicated.

Another possibility would be to have an "int recurse" parameter rather
than "bool recurse", telling how many levels to recurse.  Then one could
do a

    do_for_each_ref(..., "refs/remotes", ..., recurse=2)

to get all of the refs/remotes/*/HEAD references.  Though since all of
the heads for a remote are also siblings of "refs/remotes/foo/HEAD", it
could still involve a lot of superfluous file reading.  And the integer
wouldn't fit conveniently in the flags parameter.

> I think it might be simpler to just do my own custom traversal. What I
> need is much simpler than what do_for_each_entry provides. I don't need
> recursion, and I don't actually need to look at the loose and packed
> refs together. It's OK for me to do them one at a time because I don't
> care about the actual value; I just want to know about which refs exist.

Yes.  Still, the code is really piling up for this one warning for the
contrived eventuality that somebody wants to pass SHA-1s and branch
names together in a single cat-file invocation *and* wants to pass lots
of inputs at once and so is worried about performance *and* has
reference names that look like SHA-1s.  Otherwise we could just leave
the warning disabled in this case, as now.  Or we could add a new
"--hashes-only" option that tells cat-file to treat all of its
arguments/inputs as SHA-1s; such an option would permit an even faster
code path for bulk callers.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
