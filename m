From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Tue, 26 Jul 2011 12:57:46 +0700
Message-ID: <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net> <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
 <20110726051411.GB25046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 26 07:58:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlaet-0002kP-Gx
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 07:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab1GZF6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 01:58:19 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:55536 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab1GZF6R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 01:58:17 -0400
Received: by eye22 with SMTP id 22so141104eye.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 22:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CAXVvHfaMHwo+F/FeOyv1bQNEpzMrHhFJcJVmk4D8rk=;
        b=xzD92sqmSuJCaoCyd6B7g1V9jHQ95AMtCiyFo5dUK4eJzU2HMmfal0vllJy7pneL+l
         lqqIAodnbVE6pq9KUa2edCwb3nCog3Ea5q9HbxUwoiEUJxyPA+j4znRaBj6DHivCriBh
         YXfkBhQ0wnlUdD9VC6brMtXO+TftpLXeDhMug=
Received: by 10.204.35.207 with SMTP id q15mr1653667bkd.244.1311659896110;
 Mon, 25 Jul 2011 22:58:16 -0700 (PDT)
Received: by 10.204.121.142 with HTTP; Mon, 25 Jul 2011 22:57:46 -0700 (PDT)
In-Reply-To: <20110726051411.GB25046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177843>

On Tue, Jul 26, 2011 at 12:14 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 26, 2011 at 10:03:31AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Tue, Jul 26, 2011 at 4:55 AM, Jeff King <peff@peff.net> wrote:
>> > On Sun, Jul 24, 2011 at 12:11:29PM +0700, Nguyen Thai Ngoc Duy wro=
te:
>> >
>> >> Can we have "git add--interactive --patch --match=3Dregex" where =
only
>> >> (splitted if possible) hunks that match regex are shown?
>> >
>> > The patch below does this,
>>
>> Thanks!
>
> So I did this as a quick "that should be really easy" proof of concep=
t.
> I'm not too interested personally in taking it all the way to an
> acceptable patch. =C2=A0I'm happy to help out with the perl parts, th=
ough, if
> you want to do the rest (C scaffolding for calling add--interactive,
> tests, and docs).

It's my itch. I'm more than happy if you take care of the Perl part,
I'll do the rest. While you're doing the Perl part, should we have
both --match and --no-match? One filters in. The other filters out. I
guess people may find filter-in case more helpful than the other.

> The more I think about it, it is probably simpler both conceptually a=
nd
> in implementation to filter out those hunks entirely instead of marki=
ng
> them used. The latter gives the user a chance to manually find them a=
nd
> go back to them via 'J' and 'K'. But I find the chance that that is
> useful to be much less than the chance that somebody gets confused or
> annoyed by them being there (because they were iterating, or because
> they did a "/" search).

I thought of this way initially, but I needed to split hunks in
parse_diff and was stuck because I was not familiar with data
structure used in git-add--interactive.

> And it's not like everything needs to be in a single "add" call. The
> point of "add" is that you could call it multiple times, or even call
> it, then check what "git diff" says, then decide you want to stage so=
me
> more.

Yes, the point of this new feature, is to get me focus on a selected
parts I care.

>> > =C2=A02. What should we do with non-text changes, like mode change=
s are
>> > =C2=A0 =C2=A0 full-file deletion?
>>
>> Probably invalid use case for --match.
>
> Invalid, like we should have an error? I think that would be annoying=
,
> because you want to be able to do "git add -p --match=3Dfoo" even whe=
n
> there is an unrelated mode change. I think in the mindset of "this is=
 a
> filter for things you want to see", it probably makes sense to just
> pretend they aren't there (and the user can always follow up with
> another "add", as I mentioned above).

Agreed.

>> > =C2=A03. What should be shown for a file with no matching hunks? P=
robably
>> > =C2=A0 =C2=A0 nothing (i.e., as if it had been limited away by pat=
hname)? My
>> > =C2=A0 =C2=A0 patch shows the header, but that is easy to fix.
>>
>> Printing "Nothing to add" would be nice.
>
> If we treat it like path limiting, I think we could just print nothin=
g
> for that file. That is, doing:
>
> =C2=A0git add -p foo
>
> would not even look at "bar" or print anything about it. Similarly:
>
> =C2=A0git add -p --match=3Dfoo
>
> should probably say nothing whatsoever about files that didn't mentio=
n
> foo at all.

Hmm.. I did not thought of doing multiple files. Printing nothing
makes sense this case.
--=20
Duy
