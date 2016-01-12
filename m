From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] lock_ref_sha1_basic: handle REF_NODEREF with invalid
 refs
Date: Tue, 12 Jan 2016 05:55:25 +0100
Message-ID: <5694873D.5000001@alum.mit.edu>
References: <20160111154651.GA25338@sigill.intra.peff.net>
 <20160111155239.GB22778@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 06:02:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIr6I-000800-91
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 06:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbcALFCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 00:02:30 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56594 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761AbcALFC3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2016 00:02:29 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2016 00:02:29 EST
X-AuditID: 1207440f-f79df6d000007c0f-64-5694873fb8bb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E6.F5.31759.F3784965; Mon, 11 Jan 2016 23:55:27 -0500 (EST)
Received: from [192.168.69.130] (p4FC97D56.dip0.t-ipconnect.de [79.201.125.86])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u0C4tPjc017678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 11 Jan 2016 23:55:26 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <20160111155239.GB22778@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqGvfPiXMYNMFdouuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bm7uh+xF6xVr1i05ShjA+Mb
	uS5GDg4JAROJj4vzuhg5gUwxiQv31rN1MXJxCAlcZpRoOriMFcI5zyRxqHEpO0iVsECIxOud
	v1lBbBEBI4kbH76xgdhCAtkSr1t6wWqYBdQk2jdNAathE9CVWNTTzASxQU6it3sSC4jNK6At
	Mf/iVbA4i4CqxMJ/+8F6RYHmv//6nBWiRlDi5MwnYPWcAtYSC1Y1sUDMV5f4M+8SM4QtL9G8
	dTbzBEbBWUhaZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2M
	kJDm38HYtV7mEKMAB6MSD28G+5QwIdbEsuLK3EOMkhxMSqK8zTFAIb6k/JTKjMTijPii0pzU
	4kOMEhzMSiK8TkFAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBG9+
	G1CjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCiC44uBMQyS4gHayw/SzltckJgL
	FIVoPcWoKCXO+6gVKCEAksgozYMbC0tUrxjFgb4U5j0EUsUDTHJw3a+ABjMBDbaImwwyuCQR
	ISXVwMgX0niMSTtJxbNNR5Hn/ufZ3ZkqSR/eb2owT5RKXpFwItHH6ogEU8O8kJj4xwoPjFV/
	Ji/WDzbsOzKvbyV78Zdv85J63xieL0i1YlpT+t2Z7Vk4c4Jkcbbkhz22ZdGms/ez 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283767>

On 01/11/2016 04:52 PM, Jeff King wrote:
> We sometimes call lock_ref_sha1_basic both with REF_NODEREF
> to operate directly on a symbolic ref.

^^^ This sentence seems to be missing some words.

>                                        This is used, for
> example, to move to a detached HEAD, or when updating
> the contents of HEAD via checkout or symbolic-ref.
> 
> However, the first step of the function is to resolve the
> refname to get the "old" sha1, and we do so without telling
> resolve_ref_unsafe() that we are only interested in the
> symref. As a result, we may detect a problem there not with
> the symref itself, but with something it points to.
> 
> The real-world example I found (and what is used in the test
> suite) is a HEAD pointing to a ref that cannot exist,
> because it would cause a directory/file conflict with other
> existing refs.  This situation is somewhat broken, of
> course, as trying to _commit_ on that HEAD would fail. But
> it's not explicitly forbidden, and we should be able to move
> away from it. However, neither "git checkout" nor "git
> symbolic-ref" can do so. We try to take the lock on HEAD,
> which is pointing to a non-existent ref. We bail from
> resolve_ref_unsafe() with errno set to EISDIR, and the lock
> code thinks we are attempting to create a d/f conflict.
> 
> Of course we're not. The problem is that the lock code has
> no idea what level we were at when we got EISDIR, so trying
> to diagnose or remove empty directories for HEAD is not
> useful.
> 
> The most obvious solution would be to call
> resolve_ref_unsafe() with RESOLVE_REF_NO_RECURSE, so that we
> never look beyond the symref (and any problems we find must
> be attributable to it). However, that means we would not
> correctly gather the "old" sha1. We do not typically care
> about it for locking purposes with a symref (since the
> symref has no value on its own), but it does affect what we
> write into the HEAD reflog.
> 
> Another possibility is to avoid the d/f check when
> REF_NORECURSE is set. But that would mean we fail to notice
> a real d/f conflict. This is impossible with HEAD, but we
> would not want to create refs/heads/origin/HEAD.lock if we
> already have refs/heads/origin/HEAD/foo.
> 
> So instead, we attempt to resolve HEAD fully to get the old
> sha1, and only if that fails do we fallback to a
> non-recursive resolution. We lose nothing to the fallback,
> since we know the ref cannot be resolved, and thus we have
> no old sha1 in the first place. And we still get the benefit
> of the d/f-checking for the symref itself.
> 
> This does mean an extra round of filesystem lookups in some
> cases, but they should be rare. It only kicks in with
> REF_NODEREF, and then only when the existing ref cannot be
> resolved.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is prepared on top of the jk/symbolic-ref topic. As shown by the
> tests, though, this can be triggered when checking out a detached HEAD,
> so it existed prior to that. The fix is independent, but some of the
> additions to the test suite rely on that topic.
> 
> I can split it into separate patches, but I'm not sure it's worth the
> trouble. The only case I found that triggers it is quite obscure, and
> prior to the jk/symbolic-ref topic, you can recover using a non-detached
> checkout (or symbolic-ref).
> 
>  refs/files-backend.c             |  4 ++++
>  t/t1401-symbolic-ref.sh          |  7 +++++++
>  t/t2011-checkout-invalid-head.sh | 20 ++++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 180c837..ea67d82 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1901,6 +1901,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  
>  	refname = resolve_ref_unsafe(refname, resolve_flags,
>  				     lock->old_oid.hash, &type);
> +	if (!refname && (flags & REF_NODEREF))
> +		refname = resolve_ref_unsafe(orig_refname,
> +					     resolve_flags | RESOLVE_REF_NO_RECURSE,
> +					     lock->old_oid.hash, &type);
> [...]

The main risk for this change would be that this new recovery code
allows the function to continue, but one of the outputs of the second
function invocation is not correct for the code that follows. Let me
think out loud:

* refname -- now will be equal to orig_refname. I think the main effect
is that it will be passed to verify_refname_available_dir(). This seems
to be what we want.

* type -- now reflects orig_refname; i.e., usually REF_ISSYMREF. This
also seems correct.

* lock->old_oid.hash -- is now ZEROS. This might get compared to the
caller's old_sha1 in verify_lock(), and it will also be written to the
reflog as the "old" value. I think this is also what we want.

So this change looks good to me.

Thanks for the good catch and especially the awesome commit message!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
