From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Mon, 3 Aug 2015 21:03:16 +0700
Message-ID: <CACsJy8B6Fg-1haJZ_xMGk8Xy0zUpeOJYgRWKbZxy_RB11JfF7g@mail.gmail.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
 <55BC4438.8060709@alum.mit.edu> <CACsJy8Cx_PTehaeQgXxGaTNRF2DUSNqbBYPQ5gQ0BYGpz6kQvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 03 16:04:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMGLc-0000co-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 16:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbbHCOEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 10:04:07 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37960 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbbHCODq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 10:03:46 -0400
Received: by iggf3 with SMTP id f3so56148173igg.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IVQQvRI68dgCNiXJD/+SI1vFpajbVscGyP8geMYXwVY=;
        b=wM1mGO18MZBB+gadOr2fuWqbiX3QKaZ55VjF3YaQyMIvZH0pD0Zd+XXxm6lUSc5B7W
         3SiQilgAJ+EOk7fH5/CDl+yzTURQrSZ1eEquHfUD03ogAEe/v9Du4HcBtTg6w0ktRq2L
         /1QJ7uQMNgj0jtyq4Ov2/6OBAvxNohR1sozL7hwvX6xbyp1ULr8aiqmWCCB2SwvtYVN1
         BMHppNK6KJwf5DfrqYveWHvtyoSyFwf+26olTMUAUvJKIS/+c/yQQMQ+kGQAmoTYBQIr
         LMEwbDISExy45xGCCSd/u+CRy8F8TLa2dor03TQYi4Rip0QvyVY1QPsNsuYdiYNciANI
         aFhA==
X-Received: by 10.50.4.67 with SMTP id i3mr21738289igi.65.1438610625991; Mon,
 03 Aug 2015 07:03:45 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 3 Aug 2015 07:03:16 -0700 (PDT)
In-Reply-To: <CACsJy8Cx_PTehaeQgXxGaTNRF2DUSNqbBYPQ5gQ0BYGpz6kQvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275169>

On Mon, Aug 3, 2015 at 8:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Aug 1, 2015 at 10:59 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Either way, there's also the question of who should know how to find the
>> worktree-specific references--the program that wants to access them, or
>> should there be a secret invisible mapping that is done on lookup, and

After re-reading some code, I think this invisible mapping on lookup
is already done for our file-based ref backend. Take
resolve_ref_unsafe_1 for example, the call strbuf_git_path() may
return ".git/worktrees/foo/HEAD", not ".git/HEAD", given the input ref
"HEAD". So ref names are already separated from where they are stored.

>> that knows the full list of references that want to be worktree-specific
>> (for example, that in a linked worktree, "refs/bisect/*" should be
>> silently redirected to "refs/worktree/<name>/bisect/*")?

My decision to hard code these paths may turn out a bad thing (it's
common_list[] in path.c). Perhaps I should let the user extend them,
but we will not allow to override a small subset of paths because that
may break stuff horribly.

>> It's all a bit frightening, frankly.
>
> I would think all work to make pluggable backends happen should allow
> us to do this kind of transparent mapping. We can add a new file-based
> backend with just this redirection, can't we? I haven't read the
> updated refs.c though, need to do it now..
-- 
Duy
