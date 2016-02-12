From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 13/21] refs: resolve symbolic refs first
Date: Fri, 12 Feb 2016 15:09:04 +0100
Message-ID: <56BDE780.2030407@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-14-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 15:16:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUEWN-0007Va-O4
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 15:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbcBLOQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 09:16:22 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49084 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752581AbcBLOQV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 09:16:21 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2016 09:16:21 EST
X-AuditID: 1207440f-d9fff70000007e44-28-56bde7838abf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F6.54.32324.387EDB65; Fri, 12 Feb 2016 09:09:07 -0500 (EST)
Received: from [192.168.69.130] (p548D685F.dip0.t-ipconnect.de [84.141.104.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1CE95al015646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Feb 2016 09:09:06 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-14-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqNv8fG+YwY+NphbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDMWz+hmKZgvWfHq/TWWBsYrIl2MnBwSAiYS
	a09uYu9i5OIQEtjKKNH0dhmUc55JYtuxQ8xdjBwcwgL2Eo3H5UAaRAQcJC7vOsoMUdPGKPHk
	1QUmkASbgK7Eop5mJoipchK93ZNYQGxeAW2JhfcnMYPYLAKqEs/f32MDsUUFQiTef33OClEj
	KHFy5hOwek4BT4lp9yeAzWEW0JPYcf0XK4QtL9G8dTbzBEb+WUhaZiEpm4WkbAEj8ypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkJDk38HYtV7mEKMAB6MSD6/hrT1hQqyJ
	ZcWVuYcYJTmYlER5w4/sDRPiS8pPqcxILM6ILyrNSS0+xCjBwawkwmvQBJTjTUmsrEotyodJ
	SXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwBjwDahQsSk1PrUjLzClBSDNxcIIM55IS
	KU7NS0ktSiwtyYgHxWR8MTAqQVI8QHuFQdp5iwsSc4GiEK2nGBWlxHkFQBICIImM0jy4sbBE
	84pRHOhLYd6PT4GqeIBJCq77FdBgJqDBO77vAhlckoiQkmpg1N2uHeyX9f/i4jUnFyVujun+
	ldo94/KN2+VV890O3ro9f6c7y/ySxesm7UmZeuo2x6lwb0WXr/JPlQoL9TklYn/uXq/Be5Nn
	co2tlbpp2irZmtkLJNQUBWRX5R0Iuq8jYdJz5Y6/tRWL+CWe5ffkS9Q57ujGmJVw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286050>

On 02/05/2016 08:44 PM, David Turner wrote:
> Before committing ref updates, split symbolic ref updates into two
> parts: an update to the underlying ref, and a log-only update to the
> symbolic ref.  This ensures that both references are locked correctly
> while their reflogs are updated.
> 
> It is still possible to confuse git by concurrent updates, since the
> splitting of symbolic refs does not happen under lock. So a symbolic ref
> could be replaced by a plain ref in the middle of this operation, which
> would lead to reflog discontinuities and missed old-ref checks.

This patch is doing too much at once for my little brain to follow.

My first hangup is the change to setting RESOLVE_REF_NO_RECURSE
unconditionally in lock_ref_sha1_basic(). I count five callers of that
function and see no justification for why the change is OK in the
context of each caller. Here are some thoughts:

* The call from files_create_symref() sets REF_NODEREF, so it is
unaffected by this change.

* The call from files_transaction_commit() is preceded by a call to
dereference_symrefs(), which I assume effectively replaces the need for
RESOLVE_REF_NO_RECURSE.

* There are two calls from files_rename_ref(). Why is it OK to do
without RESOLVE_REF_NO_RECURSE there?

  * For the oldrefname call, I suppose the justification is the "(flag &
REF_ISSYMREF)" check earlier in the function. (But does this introduce a
significant TOCTOU race?)

  * For the newrefname call, I suppose it's because the code a little
higher up tries to delete any existing reference with that name. It
looks to me like the old code was slightly broken: if newrefname was an
unborn symbolic reference, then: read_ref_full() would fail;
delete_ref() would be skipped; lock_ref_sha1_basic() would lock the
*referred-to* reference; the referred-to reference would be overwritten
instead of newrefname. So it could be that here REF_NODEREF indirectly
fixes a bug?

* The last call, from files_reflog_expire(), is also questionable before
your patch. If refname is a symref, then the function is expiring the
reflog of the symref. But (before this patch) it locks not the symref
but its referent. This was discussed in some length before on the
mailing list [1], and the conclusion was that the current behavior is
wrong, but for backwards compatibility reasons it would be safest to
change it to locking *both* the symref and its referent.

If possible, it would be better to split this patch up into several: the
first few would each add the REF_NODEREF flag at one callsite, with a
careful justification of why that is OK. Once all the callsites (except
the one in files_transaction_commit()) have been changed, then the last
patch could add the dereference_symrefs() machinery and change the last
callsite.

(I'm not certain that those steps are actually doable independently,
given that REF_NODEREF has other effects besides setting
RESOLVE_REF_NO_RECURSE.)

I'm not just being pedantic here. The patch as written is really too big
to review effectively.

Michael

[1]
http://thread.gmane.org/gmane.comp.version-control.git/263552/focus=263555

-- 
Michael Haggerty
mhagger@alum.mit.edu
