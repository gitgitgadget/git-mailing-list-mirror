From: Shawn Pearce <spearce@spearce.org>
Subject: Re: shallow clone not very shallow due to tags
Date: Wed, 17 Aug 2011 07:19:31 -0700
Message-ID: <CAJo=hJvySfuWmz6vGUveC5KoR1NZGC4ji0saByVX40UxLqHqdg@mail.gmail.com>
References: <CAJo=hJuyZMj+qwFr_=stbQtGh2SCCpjfsBxm+2wbfJK=i_VTdw@mail.gmail.com>
 <CACsJy8DF49PJtv41vZEOX0fLg4U1+m6JEW28+iYD6jJxGctEzg@mail.gmail.com>
 <CAJo=hJv_NnZyGnedTQBL_mj3baS8O5Z2wiEbZCvv8305No4ehA@mail.gmail.com> <CACsJy8CXiZ8uGruAk5XGFhY8MJsTHAPv3Mvh0euQdFE3U43MCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 16:20:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtgyM-0001Rr-9O
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 16:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab1HQOTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 10:19:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33588 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab1HQOTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 10:19:52 -0400
Received: by bke11 with SMTP id 11so729716bke.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 07:19:51 -0700 (PDT)
Received: by 10.204.197.130 with SMTP id ek2mr383879bkb.63.1313590791176; Wed,
 17 Aug 2011 07:19:51 -0700 (PDT)
Received: by 10.204.135.81 with HTTP; Wed, 17 Aug 2011 07:19:31 -0700 (PDT)
In-Reply-To: <CACsJy8CXiZ8uGruAk5XGFhY8MJsTHAPv3Mvh0euQdFE3U43MCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179512>

On Tue, Aug 16, 2011 at 19:49, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Aug 16, 2011 at 12:16 AM, Shawn Pearce > Yes, I think a user
> who is making a shallow clone should only get the
>> HEAD branch to the depth specified, nothing else. If they want
>> additional branches, they should either pass them on the command line
>> to a new flag for clone, or modify their fetch configuration
>> after-the-fact and fetch those separately.
>
> I'd like maintain all refs of the repo, even though we though we only
> have objects for one branch. If I do a shallow clone and want to
> change branch, I could just list available branch locally instead of
> going to gitweb.somewhere for the branch name.
>
> Do we have someway to represent a ref placeholder?

Not currently, no. I haven't checked refs.c, but you may be able to
create an empty (0 byte) ref file for each remote reference we didn't
obtain. These should be ignored since they aren't a valid reference..
Though they might cause warnings to be sent to stderr on every
command, since they exist in the refs directory but aren't a valid
reference.

Of course a placeholder ref cannot be used as a starting point to
checkout something, can it? It has no commit object available. So if
you did decide to checkout a placeholder, you would need to first
fetch that placeholder. So why not use git ls-remote to list the
remotely available branches?

-- 
Shawn.
