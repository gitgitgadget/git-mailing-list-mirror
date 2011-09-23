From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] diff_index: honor in-index, not working-tree, .gitattributes
Date: Fri, 23 Sep 2011 17:32:20 -0400
Message-ID: <CAG+J_DwGuR6bqE4iG26-xwc0_TuRRKUDmmJZ44Qr+y5EEzTnNA@mail.gmail.com>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
	<1316727861-90460-2-git-send-email-jaysoffian@gmail.com>
	<7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
	<CAG+J_DzUQ3OGfiX=vHVGC7SHvwToVjD7uwFyDa8Tq6t7YwX12Q@mail.gmail.com>
	<CAG+J_Dyh=t2VAZ6rAqcF2meEgBCN5c+J_m_YvVQbKfvXeJ8WGA@mail.gmail.com>
	<7vobybw6mv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 23:32:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7DMF-0000U9-Hg
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 23:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab1IWVcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 17:32:22 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48457 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab1IWVcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 17:32:21 -0400
Received: by ywb5 with SMTP id 5so3004405ywb.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E5rtsGHj0Dz+BPW8tKjhUHw4eY4bBOD155s4j+I6rBo=;
        b=eJMf1hPw0iXv4C6idflC6X853tXEW8Gk4leoIpawFFcH45huP/qD5+Icgw63rqBptV
         fciMnNqd5NaITCtqNw4NNOKDTg5FiDF12qnKnJnbT2/thDOanJ6GufVoxCIvjiqkOMuP
         gVX5RPQwrDtMVEeyYpJ6/k/K844I5ummgDTKI=
Received: by 10.236.155.1 with SMTP id i1mr5869132yhk.8.1316813540919; Fri, 23
 Sep 2011 14:32:20 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 23 Sep 2011 14:32:20 -0700 (PDT)
In-Reply-To: <7vobybw6mv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182003>

On Fri, Sep 23, 2011 at 12:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If you want to allow use of in-tree attributes in _all_ callers of
> diff_tree_sha1(), then the right approach is to add an instance of "struct
> index_state" to "struct diff_options", have the caller _explicitly_ ask
> for use of in-tree attributes by setting a bit somewhere in "struct
> diff_options", and read the tree into that separate index_state using
> tree.c::read_tree(). I however doubt it is worth it.
>
> I would think it makes more sense to add a codeblock like that at the
> beginning of builtin/diff.c::builtin_diff_tree() when a new command option
> asks for it. In that codepath, you _know_ that we are not using the index
> at all, and reading the index there will not interfere with other uses of
> the index in the program.

Hmm, I looked at that, but then it would work for git-diff, but not
git-diff-tree. I don't think there's any other diff options that work
only at the porcelain layer, are there?

j.
