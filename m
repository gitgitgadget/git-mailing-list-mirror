From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [Survey] Signed push
Date: Tue, 13 Sep 2011 17:39:13 -0700
Message-ID: <CAJo=hJt-n0Xn85g7-7eEgxZhsBu8wd843dvvbaJgdYSx3t4Xug@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <4E6FF5D9.3080709@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 02:39:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3dVx-0001SG-Fr
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 02:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab1INAjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 20:39:35 -0400
Received: from mail-gx0-f170.google.com ([209.85.161.170]:46659 "EHLO
	mail-gx0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab1INAje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 20:39:34 -0400
Received: by gxk27 with SMTP id 27so1523542gxk.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 17:39:34 -0700 (PDT)
Received: by 10.236.181.101 with SMTP id k65mr37398986yhm.65.1315960774063;
 Tue, 13 Sep 2011 17:39:34 -0700 (PDT)
Received: by 10.236.105.148 with HTTP; Tue, 13 Sep 2011 17:39:13 -0700 (PDT)
In-Reply-To: <4E6FF5D9.3080709@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181332>

On Tue, Sep 13, 2011 at 17:31, Sam Vilain <sam@vilain.net> wrote:
> On 9/13/11 9:45 AM, Junio C Hamano wrote:
>>
>> =A0* "git push" prepares a "push certificate" (it is meant to certif=
y "these
>> =A0 =A0are the commits I place at the tips of these refs"), which is=
 a human
>> =A0 =A0and machine readable text file in core, that may look like th=
is:
>>
>> =A0 =A0 =A0 =A0 Push-Certificate-Version: 0
>> =A0 =A0 =A0 =A0 Pusher: Junio C Hamano<gitster@pobox.com>
>> =A0 =A0 =A0 =A0 Update: 3793ac56b4c4f9bf0bddc306a0cec21118683728 ref=
s/heads/master
>> =A0 =A0 =A0 =A0 Update: 12850bec0c24b529c9a9df6a95ad4bdeea39373e ref=
s/heads/next
>
> If the push certificate also has the previous commit IDs for the chan=
ged
> refs, then you actually have an audit log. =A0Otherwise, it does not =
certify
> the commit range they pushed.

Is that necessary? The range they are certifying is that commit, and
its entire ancestry. If the pusher doesn't trust his ancestry, why is
he working with it? Similar to an annotated tag. I make a signed
annotated tag, I am asserting that revision and its ancestry is
something I like as far as a project build goes. You don't need the
old revision to realize I like this commit.

If you want to get into the game of, maybe I push a branch, then
rewind it, and push something differently, and you want to be able to
verify that the 2nd push is the "right thing" and the 1st push should
be ignored, you can already see that by looking at the timestamp of
the push certificates (/me assumes there is a timestamp in there). If
you can create multiple signed pushes by yourself, using your GPG key,
within the same second, and they are conflicting... well, stop using
automated tools to create conflicting assertions as yourself. If you
are creating signed pushes on systems with clock skew, learn how to
configure NTP date.

> This is an important prerequisite for a fully distributed, peer to pe=
er git.
> =A0For this case it would also need something to distinguish which re=
pository
> is to be updated; such as a canonical repository URL (or list of URLs=
), or
> just a short project name. =A0A P2P protocol can then know projects a=
s (KEYID,
> projectname).

Why do we need a project name? Most Git based projects are uniquely
identified by the set of root commits they have. Why? Because most
root commits were created by different people, at different times,
with different commit messages, and different initial trees, resulting
in a unique commit SHA-1 for that root commit. Projects with more than
one root commit also disambiguate themselves from other projects that
maybe contain one of those roots (e.g. git.git vs. gitk).

If you wanted to identify a project on a P2P network, I think you
would want to do it based off the root commits, not some random name
people came up with and might try to publish forgeries under.

--=20
Shawn.
