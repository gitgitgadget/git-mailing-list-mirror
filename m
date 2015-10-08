From: Ray Donnelly <mingw.android@gmail.com>
Subject: Re: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Thu, 8 Oct 2015 21:42:45 +0100
Message-ID: <CAOYw7dsfKpQT4NXjKrNRVsoPCrAFDjp7Hnms_5SF7JLw6s9g-Q@mail.gmail.com>
References: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
	<xmqqlhbj3mfo.fsf@gitster.mtv.corp.google.com>
	<CAOYw7dv4iPQ4cq4Ab1ZeThrp=u51T5v387a1Y8QPO-yj=fyMcg@mail.gmail.com>
	<xmqqwpv21rej.fsf@gitster.mtv.corp.google.com>
	<CAOYw7duDLWYpu+NK2t2+hV3rtU=dK3eQ6R11mfwLKbQQowbWuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e01182dd6c344c305219de73c
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 22:42:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkI1d-0003Xi-21
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 22:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbbJHUms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 16:42:48 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36019 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839AbbJHUmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 16:42:47 -0400
Received: by lbcao8 with SMTP id ao8so60978625lbc.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O9ji+spZP+nz1SRNZj/0WRc2h2oPaiyONjatfQxDRn8=;
        b=nwiUiMCaUni6No5Jp7AUNGl4OOqaE/ntMe2FrrrXK32x+qcZIVomdGvalGw3GPfAlg
         /1DBQFO/b4p0PC/6OgBWtzEVHKWqePygXUeCBS4RSaBxrvzn/C1vvsZO95MxGAnWByct
         mrR5Sv+1EAHcDQgJELoFOEwZ8iWmF9sRE/HPViJWkPgPtsOQHBoOtiiEtjhJom/8kbwU
         /LgwhOLqle0GRYk1vcy4MJnjgPLYSMtmZbzTJ5TSzFpr/bEG5W6cqf7MjxRgNAX35caH
         1bJ0PqD+d83ij2Z/QUL3IkbUCPYDQUj06z90d1H4EiIj90ksjblm09hxXQFQI+ermavc
         jJpQ==
X-Received: by 10.112.162.162 with SMTP id yb2mr4722581lbb.94.1444336965448;
 Thu, 08 Oct 2015 13:42:45 -0700 (PDT)
Received: by 10.112.20.131 with HTTP; Thu, 8 Oct 2015 13:42:45 -0700 (PDT)
In-Reply-To: <CAOYw7duDLWYpu+NK2t2+hV3rtU=dK3eQ6R11mfwLKbQQowbWuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279278>

--089e01182dd6c344c305219de73c
Content-Type: text/plain; charset=UTF-8

On Mon, Oct 5, 2015 at 12:36 AM, Ray Donnelly <mingw.android@gmail.com> wrote:
> On Sun, Oct 4, 2015 at 6:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ray Donnelly <mingw.android@gmail.com> writes:
>>
>>>> Some callers of this function in real code (i.e. not the one you are
>>>> removing the check) do seem to depend on that condition, e.g. the
>>>> codepath in clone that leads to add_to_alternates_file() wants to
>>>> make sure it does not add an duplicate, so it may end up not noticing
>>>> /foo/bar and /foo/bar/ are the same thing, no?  There may be others.
>>>
>>> Enforcing that normalize_path_copy() removes any trailing '/' (apart
>>> from the root directory) breaks other things that assume it doesn't
>>> mess with trailing '/'s, for example filtering in ls-tree. Any
>>> suggestions for what to do about this? Would a flag be appropriate as
>>> to whether to do this part or not? Though I'll admit I don't like the
>>> idea of adding flags to modify the behavior of something that's meant
>>> to "normalize" something. Alternatively, I could go through all the
>>> breakages and try to fix them up?
>>
>> I agree with you that "normalize" should "normalize".  Making sure
>> that all the callers expect the same kind of normalization would be
>> a lot of work but I do think that is the best approach in the long
>> run.  Thanks for the ls-tree example, by the way, did you find it by
>> code inspection?  I do not think it is reasonable to expect the test
>> coverage for this to be 100%, so the "try to fix them up" would have
>> to involve a lot of manual work both in fixing and reviewing,
>> unfortunately.
>
> For the ls-tree failure, I ran "make test" to see how much fell out.
> I'm not familiar with the code-base yet, so I figured that at least
> investigating the changes needed to make the test-suite pass would be
> a good entry point to reading the code; I will study it at the same
> time to try and get my bearings.
>
>>
>> The first step of the "best approach" would be to make a note on
>> normalize_path_copy() by adding a NEEDSWORK: comment to describe the
>> situation.

I hope this is acceptable for the first part of this task.

>>
>> Thanks.

--089e01182dd6c344c305219de73c
Content-Type: application/octet-stream; 
	name="0001-normalize_path_copy-NEEDSWORK-for-trailing.patch"
Content-Disposition: attachment; 
	filename="0001-normalize_path_copy-NEEDSWORK-for-trailing.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ifiowyhs0

RnJvbSBlM2YwNzNiMWUxNTRmNDRjMWUxYzc3MTZhMmVkNjk3N2RkMTQ0MjI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXkgRG9ubmVsbHkgPG1pbmd3LmFuZHJvaWRAZ21haWwuY29t
PgpEYXRlOiBUaHUsIDggT2N0IDIwMTUgMTc6MTA6MjggKzAxMDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gbm9ybWFsaXplX3BhdGhfY29weTogTkVFRFNXT1JLIGZvciB0cmFpbGluZyAnLycKCkN1cnJl
bnRseSwgbm9ybWFsaXplX3BhdGhfY29weSAoKSBkb2VzIG5vdGhpbmcgcmVnYXJkaW5nIHRyYWls
aW5nICcvJ3MuCkluc3RlYWQgaXQgc2hvdWxkIHJlbW92ZSB0aGVtIGV4Y2VwdCBpbiB0aGUgY2Fz
ZSBvZiB0aGUgcm9vdCBmb2xkZXIuCi0tLQogcGF0aC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3BhdGguYyBiL3BhdGguYwppbmRleCA2
NWJlYjJkLi40YWU2ZGI2IDEwMDY0NAotLS0gYS9wYXRoLmMKKysrIGIvcGF0aC5jCkBAIC04OTMs
NiArODkzLDExIEBAIGNvbnN0IGNoYXIgKnJlbW92ZV9sZWFkaW5nX3BhdGgoY29uc3QgY2hhciAq
aW4sIGNvbnN0IGNoYXIgKnByZWZpeCkKICAqIG5vcm1hbGl6ZWQsIGFueSB0aW1lICIuLi8iIGVh
dHMgdXAgdG8gdGhlIHByZWZpeF9sZW4gcGFydCwKICAqIHByZWZpeF9sZW4gaXMgcmVkdWNlZC4g
SW4gdGhlIGVuZCBwcmVmaXhfbGVuIGlzIHRoZSByZW1haW5pbmcKICAqIHByZWZpeCB0aGF0IGhh
cyBub3QgYmVlbiBvdmVycmlkZGVuIGJ5IHVzZXIgcGF0aHNwZWMuCisgKgorICogTkVFRFNXT1JL
OiBUaGlzIGZ1bmN0aW9uIGRvZXNuJ3QgcGVyZm9ybSBub3JtYWxpemF0aW9uIHcuci50LiB0cmFp
bGluZyAnLycuCisgKiBGb3IgZXZlcnl0aGluZyBidXQgdGhlIHJvb3QgZm9sZGVyIGl0c2VsZiwg
dGhlIG5vcm1hbGl6ZWQgcGF0aCBzaG91bGQgbm90CisgKiBlbmQgd2l0aCBhICcvJywgdGhlbiB0
aGUgY2FsbGVycyBuZWVkIHRvIGJlIGZpeGVkIHVwIGFjY29yZGluZ2x5LgorICoKICAqLwogaW50
IG5vcm1hbGl6ZV9wYXRoX2NvcHlfbGVuKGNoYXIgKmRzdCwgY29uc3QgY2hhciAqc3JjLCBpbnQg
KnByZWZpeF9sZW4pCiB7Ci0tIAoyLjYuMQoK
--089e01182dd6c344c305219de73c--
