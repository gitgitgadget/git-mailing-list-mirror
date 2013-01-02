From: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gpakosz@visionobjects.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Wed, 2 Jan 2013 23:03:16 +0100
Message-ID: <CAC_01E2iHgNvh5PnBh3TcNKr2pLazZwRojVK9ksaE3x0a1QHmQ@mail.gmail.com>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
 <7vsj6mdqeo.fsf@alter.siamese.dyndns.org> <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
 <7vfw2kbs4h.fsf@alter.siamese.dyndns.org> <CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com>
 <7vk3rwaa3r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b4501800f67fb04d2556baf
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqWPx-00007v-If
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 23:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab3ABWDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 17:03:51 -0500
Received: from mail.elysmail.net ([188.165.34.231]:58472 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3ABWDt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 17:03:49 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=visionobjects.com; s=vo2010objects;
        h=received:received:received:mime-version:received:in-reply-to
          :references:from:date:message-id:subject:to:cc:content-type
          :x-declude-sender:x-declude-spoolname:x-declude-refid
          :x-declude-note:x-declude-scan:x-declude-tests:x-country-chain
          :x-declude-code:x-helo:x-identity;
        b=EfhbyHK8n5M9bnJjYG8WZ2lxqYbnhfMqPkpQieaUL8L4igTyS++acpyXl1Z7YN0O2
          puRgaHEOOsRsF5XHMqYn4t2Ex6IXYTdnXrMfLvmWsAfz5TGJuSrh/TVtpY+E6GvJb
          ylWTwF8tv6LwQ5Cf8dgI9P8nBUs8cFl2wYy5uGaWo=
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com [209.85.220.176]) by elysmail.net with SMTP;
   Wed, 2 Jan 2013 23:03:37 +0100
Received: by mail-vc0-f176.google.com with SMTP id fo13so14543975vcb.7
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 14:03:37 -0800 (PST)
Received: by 10.58.15.72 with SMTP id v8mr73188928vec.55.1357164217067; Wed,
 02 Jan 2013 14:03:37 -0800 (PST)
Received: by 10.52.65.233 with HTTP; Wed, 2 Jan 2013 14:03:16 -0800 (PST)
In-Reply-To: <7vk3rwaa3r.fsf@alter.siamese.dyndns.org>
X-Declude-Sender: gpakosz@visionobjects.com [209.85.220.176]
X-Declude-Spoolname: 21171060.eml
X-Declude-RefID: 
X-Declude-Note: Scanned by Declude 4.10.59 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [0] at 23:03:38 on 02 Jan 2013
X-Declude-Tests: Whitelisted
X-Country-Chain: 
X-Declude-Code: 0
X-HELO: mail-vc0-f176.google.com
X-Identity: 209.85.220.176 |  | vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212546>

--047d7b4501800f67fb04d2556baf
Content-Type: text/plain; charset=ISO-8859-1

> I was wondering if it should be
>
>         sha1=$(git rev-parse --verify "$ref")
>
> or something that does not dereference a tag at all.
>
> The way I read what that loop seems to want to do is:
>
>         Read each refname that was given originally from the file
>         $tempdir/heads, find out the object it used to refer to and
>         have it in $sha1, find out what new object the object was
>         rewritten to and have it in $rewritten, and:
>
>         (1) if the rewrite left the object unchanged, do nothing but
>             warn users just in case this was a mistake;
>         (2) if the rewrite told us to remove it, then delete the
>             ref; or
>         (3) if the rewrite gave us a new object, replace the ref to
>             point to that new one.
>
>         And in the latter two cases, save the original one in
>         $orig_namespace so that the user can choose to recover if
>         this filter-branch was done by mistake.
>
> So I do not think unwraping the ref at that point makes any sense,
> unless it is not prepared to handle annotated tags at all by
> unwrapping tags too early.
>
> What am I missing?
>
So we have an annotated tag that points to a commit that is rewritten
to nothing as the result of the filtering. What should happen?

My initial questions and patching suggestions are based on git
1.7.10.4 behavior.
However, playing with git HEAD exhibits a slightly different behavior:
it breaks when invoking git mktag line 459 (introduced by
1bf6551e42c79a594689a356a9b14759d55f3cf5):
  error: char7: could not get SHA1 hash
  fatal: invalid tag signature file
  Could not create new tag object for tag-a

It's basically the same problem. In my opinion, lines 447-466 should
take into account $new_sha1 is empty.

Please forgive me again for not having configured my mailer yet :(
When I'm ready to provide a patch that implements a solution we all
agree with I'll use git send-email.
In the mean time, I would like to pursue the discussion in this mail
thread so please find attached a patch that deletes a tag instead of
invoking the tag-name-filter when it detects $new_sha1 is empty.

I tested the patch doesn't break t7003. What do you think?

Gregory

--047d7b4501800f67fb04d2556baf
Content-Type: application/octet-stream; 
	name="0001-git-filter-branch-allow-deletion-of-tags-when-refere.patch"
Content-Disposition: attachment; 
	filename="0001-git-filter-branch-allow-deletion-of-tags-when-refere.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbh0igpp0

RnJvbSAyY2I5ZDViYzYwNWNjMmYyZDhhNjYwM2I2YTA2NjU3NTE2OTU5YWE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmVnb3J5IFBha29zeiA8Z3Bha29zekB2aXNpb25vYmplY3Rz
LmNvbT4KRGF0ZTogV2VkLCAyIEphbiAyMDEzIDIzOjAyOjAzICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gZ2l0LWZpbHRlci1icmFuY2g6IGFsbG93IGRlbGV0aW9uIG9mIHRhZ3Mgd2hlbiByZWZlcmVu
Y2VkCiBjb21taXQgZ2V0cyByZXdyaXR0ZW4gdG8gbm90aGluZwoKLS0tCiBnaXQtZmlsdGVyLWJy
YW5jaC5zaCB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9naXQtZmlsdGVyLWJyYW5jaC5zaCBiL2dpdC1maWx0ZXItYnJhbmNo
LnNoCmluZGV4IDUzMTQyNDkuLjJlODU2OWMgMTAwNzU1Ci0tLSBhL2dpdC1maWx0ZXItYnJhbmNo
LnNoCisrKyBiL2dpdC1maWx0ZXItYnJhbmNoLnNoCkBAIC00MzYsMzYgKzQzNiw0MSBAQCBpZiBb
ICIkZmlsdGVyX3RhZ19uYW1lIiBdOyB0aGVuCiAKIAkJWyAtZiAiLi4vbWFwLyRzaGExIiBdIHx8
IGNvbnRpbnVlCiAJCW5ld19zaGExPSIkKGNhdCAiLi4vbWFwLyRzaGExIikiCi0JCUdJVF9DT01N
SVQ9IiRzaGExIgotCQlleHBvcnQgR0lUX0NPTU1JVAotCQluZXdfcmVmPSIkKGVjaG8gIiRyZWYi
IHwgZXZhbCAiJGZpbHRlcl90YWdfbmFtZSIpIiB8fAotCQkJZGllICJ0YWcgbmFtZSBmaWx0ZXIg
ZmFpbGVkOiAkZmlsdGVyX3RhZ19uYW1lIgotCi0JCWVjaG8gIiRyZWYgLT4gJG5ld19yZWYgKCRz
aGExIC0+ICRuZXdfc2hhMSkiCi0KLQkJaWYgWyAiJHR5cGUiID0gInRhZyIgXTsgdGhlbgotCQkJ
bmV3X3NoYTE9JCggKCBwcmludGYgJ29iamVjdCAlc1xudHlwZSBjb21taXRcbnRhZyAlc1xuJyBc
Ci0JCQkJCQkiJG5ld19zaGExIiAiJG5ld19yZWYiCi0JCQkJZ2l0IGNhdC1maWxlIHRhZyAiJHJl
ZiIgfAotCQkJCXNlZCAtbiBcCi0JCQkJICAgIC1lICcxLC9eJC97Ci0JCQkJCSAgL15vYmplY3Qg
L2QKLQkJCQkJICAvXnR5cGUgL2QKLQkJCQkJICAvXnRhZyAvZAotCQkJCQl9JyBcCi0JCQkJICAg
IC1lICcvXi0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tL3EnIFwKLQkJCQkgICAgLWUgJ3An
ICkgfAotCQkJCWdpdCBta3RhZykgfHwKLQkJCQlkaWUgIkNvdWxkIG5vdCBjcmVhdGUgbmV3IHRh
ZyBvYmplY3QgZm9yICRyZWYiCi0JCQlpZiBnaXQgY2F0LWZpbGUgdGFnICIkcmVmIiB8IFwKLQkJ
CSAgIHNhbmVfZ3JlcCAnXi0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tJyA+L2Rldi9udWxs
IDI+JjEKLQkJCXRoZW4KLQkJCQl3YXJuICJncGcgc2lnbmF0dXJlIHN0cmlwcGVkIGZyb20gdGFn
IG9iamVjdCAkc2hhMXQiCisJCWlmIFsgLW4gIiRuZXdfc2hhMSIgXTsgdGhlbgorCQkJR0lUX0NP
TU1JVD0iJHNoYTEiCisJCQlleHBvcnQgR0lUX0NPTU1JVAorCQkJbmV3X3JlZj0iJChlY2hvICIk
cmVmIiB8IGV2YWwgIiRmaWx0ZXJfdGFnX25hbWUiKSIgfHwKKwkJCQlkaWUgInRhZyBuYW1lIGZp
bHRlciBmYWlsZWQ6ICRmaWx0ZXJfdGFnX25hbWUiCisKKwkJCWVjaG8gIiRyZWYgLT4gJG5ld19y
ZWYgKCRzaGExIC0+ICRuZXdfc2hhMSkiCisKKwkJCWlmIFsgIiR0eXBlIiA9ICJ0YWciIF07IHRo
ZW4KKwkJCQluZXdfc2hhMT0kKCAoIHByaW50ZiAnb2JqZWN0ICVzXG50eXBlIGNvbW1pdFxudGFn
ICVzXG4nIFwKKwkJCQkJCQkiJG5ld19zaGExIiAiJG5ld19yZWYiCisJCQkJCWdpdCBjYXQtZmls
ZSB0YWcgIiRyZWYiIHwKKwkJCQkJc2VkIC1uIFwKKwkJCQkJCQktZSAnMSwvXiQveworCQkJCQkJ
CS9eb2JqZWN0IC9kCisJCQkJCQkJL150eXBlIC9kCisJCQkJCQkJL150YWcgL2QKKwkJCQkJCX0n
IFwKKwkJCQkJCQktZSAnL14tLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLS9xJyBcCisJCQkJ
CQkJLWUgJ3AnICkgfAorCQkJCQlnaXQgbWt0YWcpIHx8CisJCQkJCWRpZSAiQ291bGQgbm90IGNy
ZWF0ZSBuZXcgdGFnIG9iamVjdCBmb3IgJHJlZiIKKwkJCQlpZiBnaXQgY2F0LWZpbGUgdGFnICIk
cmVmIiB8IFwKKwkJCQkJc2FuZV9ncmVwICdeLS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0n
ID4vZGV2L251bGwgMj4mMQorCQkJCXRoZW4KKwkJCQkJd2FybiAiZ3BnIHNpZ25hdHVyZSBzdHJp
cHBlZCBmcm9tIHRhZyBvYmplY3QgJHNoYTF0IgorCQkJCWZpCiAJCQlmaQotCQlmaQogCi0JCWdp
dCB1cGRhdGUtcmVmICJyZWZzL3RhZ3MvJG5ld19yZWYiICIkbmV3X3NoYTEiIHx8Ci0JCQlkaWUg
IkNvdWxkIG5vdCB3cml0ZSB0YWcgJG5ld19yZWYiCisJCQlnaXQgdXBkYXRlLXJlZiAicmVmcy90
YWdzLyRuZXdfcmVmIiAiJG5ld19zaGExIiB8fAorCQkJCWRpZSAiQ291bGQgbm90IHdyaXRlIHRh
ZyAkbmV3X3JlZiIKKwkJZWxzZQorCQkJZ2l0IHVwZGF0ZS1yZWYgLWQgInJlZnMvdGFncy8kcmVm
IiAiJHNoYTF0IiB8fAorCQkJCWRpZSAiQ291bGQgbm90IGRlbGV0ZSB0YWcgJHJlZiIKKwkJZmkK
IAlkb25lCiBmaQogCi0tIAoxLjguMC4xCgo=
--047d7b4501800f67fb04d2556baf--
