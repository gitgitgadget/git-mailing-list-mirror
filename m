From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv1 0/6] Fix bug in large transactions
Date: Thu, 22 Jan 2015 10:29:05 -0800
Message-ID: <CAGZ79kYH9qO8Dghk1WU8CF04L+6oH2FEX09z1inALv8LDbwP_g@mail.gmail.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
	<20150121234659.GE11115@peff.net>
	<xmqqsif3tfcf.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ5fdDiT=zXhQkt17kxLBbkJnh1F06nyZJN7ta9WZ2dmQ@mail.gmail.com>
	<xmqqk30eu271.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 19:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEMVD-0006B5-G7
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 19:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbbAVS3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 13:29:07 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:42708 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbbAVS3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 13:29:05 -0500
Received: by mail-ig0-f171.google.com with SMTP id r10so1995663igi.4
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qK/R3DId9EKlie6bAcV4mGKMfa8sxNBpnp8F0bnC9Sw=;
        b=bE+4Jnvcn4x6lDh9EeZ6quJbb9Yu1YUWkQdNCNtX4zw5OwBtEwRkW9pY/aXBsyTkJ6
         X3uBOLS/0hdwlVV47fxb6KBx9LyCCGdmJSkdUua6dA16MjVf7w0rierWYkibZSjWOwPi
         aFcjYc1vfBsZckBYlP2Yn28PO0T6t5uEft9TVZnKOp3cfii70Xp4HghqIdEknlLcyH8Z
         brqPYq5sr4baME/D+fT/dnzJ7lJbUGa/NEeZmeXjxVZb7061cWRh1vf4SMRqYK9EboJT
         xYkyef9gkor34zX+H96W3qC+AAIin32+WAgbZoZAVbJfITfAMazoRmsD/tWJfgOdUrZ4
         vj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qK/R3DId9EKlie6bAcV4mGKMfa8sxNBpnp8F0bnC9Sw=;
        b=QvWIhCz6pVqyqPeh1lLIMNptaE+Unf8TsWqKBle0UHuSgjsk2xiJRMPDZ3b5jTvmuX
         c1xLn1F0rZymz5I9j2K/hhkkr7kohghRcyEIvcWskOD27X+hyMN8fS/KnqRfK0PdlK+L
         ataLVJkVmR3+gv1Rg6oK0C/dkiJyVUfvc+fWjX8m5IH6Q6VDOoqb3rginWGTSWPPVeDm
         Iw5+m1vJyvDIagjnh303YqCkM83HDoT+qrXopyrx8jBEhKFe+ohZmbBZfGFy4c4n7/OU
         pQXVLGgDF/rXFOHn61+FgbB0aeBX69aS2bA/PrUhredmsKGde5aP4dGW+LWIi+cpMrHO
         guqg==
X-Gm-Message-State: ALoCoQlwfm7WwMAFq3PZPfcowJqQZ81BSa9dL+Z72ITtXvd7LD8MAgkQdUJNtK/2Y63AbhEnqyKL
X-Received: by 10.50.79.196 with SMTP id l4mr14520849igx.14.1421951345259;
 Thu, 22 Jan 2015 10:29:05 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 22 Jan 2015 10:29:05 -0800 (PST)
In-Reply-To: <xmqqk30eu271.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262853>

On Thu, Jan 22, 2015 at 9:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> v2 applies to sb/atomic-push instead of next and will result in a one
>> line merge conflict with next.
>
> I acctually tried to apply on 'next' and also on 'sb/atomic-push'
> and both failed.

That's strange indeed. I just checked out origin/sb/atomic-push (which
points at 04b39f195baf, 2015-01-12 16:24:02, Document receive.advertiseatomic)
and applied the patches v2 from my outgoing mailbox without problems.

I do not remember to have changed my development process a lot there.
(I was not using notes, but that should not matter at all)
git format-patch --subject-prefix=PATCHv2 --cover-letter
origin/sb/atomic-push..HEAD
$EDITOR 0000-cover-letter.patch
git send-email 00* --to=...

>I had to wiggle the patches to make them apply on
> the latter, and that is what is queued on 'pu' now, but I would not
> be surprised if I made silly mistakes while doing so, so please
> double check the result and catch them if I did.

I just fetched origin/sb/atomic-push-fix and the only difference I can spot
compared to the local branch is in d4ad3f1cdcb (refs.c: remove lock_fd
from struct ref_lock) in refs.c in the hunk:

@@ -2335,8 +2333,8 @@ static struct ref_lock
*lock_ref_sha1_basic(const char *refname,
  goto error_return;
  }

- lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
- if (lock->lock_fd < 0) {
+ if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
+ last_errno = errno;
  if (errno == ENOENT && --attempts_remaining > 0)
  /*
  * Maybe somebody just deleted one of the

(whitespaces broken here)
That hunk has the additional line "+ last_errno = errno;", which I do
not have locally, but that's the exact problem I spotted when trying to
merge my local branch to origin/next which then results in a merge
conflict with the patch from origin/jk/lock-ref-sha1-basic-return-errors
as that introduces the line "+ last_errno = errno;".

Sorry for the confusion,
Stefan
