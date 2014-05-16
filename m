From: Junio C Hamano <gitster@pobox.com>
Subject: Re* regression: request-pull with signed tag lacks tags/ in master
Date: Fri, 16 May 2014 09:47:14 -0700
Message-ID: <xmqqbnuxbrhp.fsf_-_@gitster.dls.corp.google.com>
References: <20140515163901.GA1403@redhat.com>
	<xmqqzjiiev1a.fsf@gitster.dls.corp.google.com>
	<xmqqr43uetyp.fsf@gitster.dls.corp.google.com>
	<20140515213925.GI1699@redhat.com>
	<xmqqtx8qd716.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 16 20:53:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlNFn-0008KL-7n
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758138AbaEPSxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 14:53:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63622 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758101AbaEPSxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 14:53:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DFFEE17F3D;
	Fri, 16 May 2014 14:53:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A+diOIJAQQctakXHxyLoEIP1ahk=; b=TPnqAp
	Z/Z7iwOGkHT4QtB7+mQpDof2WMpzl8aewOCh4MwmaWRQeBYsxq+jAzFkd5DABTLi
	h4TLp1dyy92b0Z0BEQs1iHPJ9wm1eTwbbrCGqW+H75eP2orL0mBqmluxh1IdU24q
	Hs670qvxHS2nHCjpSfhyx1TNScbBjuwemaFKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CCmbGlnCMEh99kHyKya41OBF6Og/fuZO
	qVOvWGOvwkSj6D4S/NAlOjIV31u+79dR3lQWGXEvh0BhNaeD11JErgidWuEZwtRu
	AqlQH2/mmgVFx7wp0hFXe5SGqPPQic5lxj+MjhIkWAPXrYF2DJojm1HQ0w+Csryp
	vmKYDxSx0mE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5B5417F3A;
	Fri, 16 May 2014 14:53:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AAFD515B55;
	Fri, 16 May 2014 12:47:17 -0400 (EDT)
In-Reply-To: <xmqqtx8qd716.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 15 May 2014 15:13:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BDA95148-DD19-11E3-A20A-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249411>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>>> My reading of the earlier parts of the series is that Linus wanted
>>> us never dwim "for-upstream" to "tags/for-upstream" or any other ref
>>> that happens to point at the same commit as for-upstream you have.
>>> The changes done for that purpose covered various cases a bit too
>>> widely, and "request-pull ... tags/for_upstream" were incorrectly
>>> stripped to a request to pull "for_upstream", which was fixed by
>>> 5aae66bd (request-pull: resurrect "pretty refname" feature,
>>> 2014-02-25).
>>> 
>>> But that fix does not resurrect the dwimming forbid by the earlier
>>> parts of the series to turn "for_upstream" into "tags/for_upstream".
>>> 
>>> What would you get if you do this?
>>> 
>>>     $ git request-pull origin/master \
>>>       git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git \
>>>       tags/for_upstream | grep git.kernel.org
>>
>>
>> I get
>>  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> Thanks for double-checking.  Let's close this as working as
> intended, then.
>
> I personally feel that the "intention" tightened the logic a bit too
> much [*1*], and with the updates mentioned in [*2*], existing users
> may find it still too tight, but that is what we have today.
>
>
> [References]
>
> *1* http://thread.gmane.org/gmane.comp.version-control.git/240860
> *2* http://thread.gmane.org/gmane.comp.version-control.git/240886

An update.

In the ideal world, I think it would be nice to make

    $ git request-pull $mine $URL for_upstream

explicitly say "Please pull tags/for_upstream" rather than without
"tags/" prefix to accomodate older Git, where

    $ git pull $URL for_upstream

did not DWIM to fetch and merge tags/for_upstream and the user had
to say "tags/for_upstream" instead.

That "older Git" refers to those without 47d84b6a (fetch: allow "git
fetch $there v1.0" to fetch a tag, 2011-11-04).  v1.7.10 (tagged on
April 6th, 2012) and later versions of Git will notice that the name
refers to the tags/for_upstream just fine, so I think it is fair to
label this as a minor cosmetic regression whose fix can wait for a
future maintenance release, rather than a blocker for the upcoming
release.

I _think_ the fix, without breaking the spirit of Linus's "I do not
want the thing DWIM based on what the remote end has" original,
would be as simple as this patch.  We can queue it as a regression
fix and do another round of -rc4 if those who depend on request-pull
heavily feel strongly about it.

Comments?


 git-request-pull.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 5c15997..d5500fd 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -119,6 +119,12 @@ then
 	status=1
 fi
 
+# Special case: turn "for_linus" to "tags/for_linus" when it is correct
+if test "$ref" = "refs/tags/$pretty_remote"
+then
+	pretty_remote=tags/$pretty_remote
+fi
+
 url=$(git ls-remote --get-url "$url")
 
 git show -s --format='The following changes since commit %H:
