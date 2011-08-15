From: Shawn Pearce <spearce@spearce.org>
Subject: Re: shallow clone not very shallow due to tags
Date: Mon, 15 Aug 2011 10:16:52 -0700
Message-ID: <CAJo=hJv_NnZyGnedTQBL_mj3baS8O5Z2wiEbZCvv8305No4ehA@mail.gmail.com>
References: <CAJo=hJuyZMj+qwFr_=stbQtGh2SCCpjfsBxm+2wbfJK=i_VTdw@mail.gmail.com>
 <CACsJy8DF49PJtv41vZEOX0fLg4U1+m6JEW28+iYD6jJxGctEzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 19:17:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt0mu-0005l8-No
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 19:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab1HORRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 13:17:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48977 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab1HORRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 13:17:13 -0400
Received: by bke11 with SMTP id 11so3132005bke.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 10:17:12 -0700 (PDT)
Received: by 10.204.232.17 with SMTP id js17mr897824bkb.219.1313428632167;
 Mon, 15 Aug 2011 10:17:12 -0700 (PDT)
Received: by 10.204.116.207 with HTTP; Mon, 15 Aug 2011 10:16:52 -0700 (PDT)
In-Reply-To: <CACsJy8DF49PJtv41vZEOX0fLg4U1+m6JEW28+iYD6jJxGctEzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179381>

On Mon, Aug 15, 2011 at 07:03, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Mon, Aug 15, 2011 at 6:58 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> Uhm. That is not a very shallow clone. The clone copied 20234 objects
>> at 9.15 MiB... so its ~20 MiB lighter than a full clone. But nearly
>> all of the tags exist, because the clone client is declaring want
>> lines for them, making the server generate up to 1 commit back from
>> the wanted tag. I know shallow support is the feature nobody wants to
>> think about, but this just seems broken to me. Clients performing a
>> shallow clone shouldn't be asking for tags... but they should be using
>> the include-tag protocol option so that if they do happen to receive a
>> tagged commit, the tag object will also be sent.
>
> The same would apply if the repo in question has many branches. Should
> we fetch only master (or a user-specified set of refs) in shallow
> clone?

Yes, I think a user who is making a shallow clone should only get the
HEAD branch to the depth specified, nothing else. If they want
additional branches, they should either pass them on the command line
to a new flag for clone, or modify their fetch configuration
after-the-fact and fetch those separately.

>From what I can gather from some users I have talked to, the primary
usage of shallow clone is to try and (sort of) quickly grab a branch,
make a change, and post that change to the maintainers for review and
acceptance. E.g. correcting a spelling typo. Relatively simple changes
that can be built on a specific branch, and don't really require all
of the history.

And if a repository does have more than one branch, but is shallow
cloned at say depth of 1, the user probably doesn't get the merge
bases between them, so the value of the other branches is greatly
reduced. You can't make a merge between these, and a new developer
getting involved in the project cannot see how the branches relate to
each other. So there isn't a lot of value in sucking down those
additional branches during clone.

-- 
Shawn.
