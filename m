From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Thu, 26 Feb 2009 03:48:07 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngqc47n.t1k.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
 <7vzlgbhh95.fsf@gitster.siamese.dyndns.org>
 <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net>
 <7vab8aap6t.fsf@gitster.siamese.dyndns.org>
 <slrngqaa5n.mp1.sitaramc@sitaramc.homelinux.net>
 <7vvdqyyzsr.fsf@gitster.siamese.dyndns.org>
 <slrngqbrpd.t1k.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 04:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcXFv-0004Jk-CU
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 04:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbZBZDsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 22:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbZBZDsX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 22:48:23 -0500
Received: from main.gmane.org ([80.91.229.2]:38869 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250AbZBZDsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 22:48:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LcXEO-0000gR-9D
	for git@vger.kernel.org; Thu, 26 Feb 2009 03:48:16 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 03:48:16 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 03:48:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111520>

On 2009-02-26, Sitaram Chamarty <sitaramc@gmail.com> wrote:

> On 2009-02-25, Junio C Hamano <gitster@pobox.com> wrote:

> I see you've used 'pattern' and 'sign' to break the
> overloading of '/'.
>
>>     - an optional ! sign whose meaning is "unignore paths that match=
es
>>       this pattern, instead of ignoring them"; followed by
>>
>>     - an optional / sign whose meaning is "a match with this pattern=
 must
>>       be made at this directory and not in its subdirectories"; foll=
owed
>>       by
>>
>>     - a pattern that never begins nor ends with a slash whose meanin=
g is
>>       "this is a shell glob pattern to test paths against"; followed=
 by
>
> I wish[1].  But in reality, a slash 'inside' anchors the
> match the same as a leading slash does.
>
> Boy this is tough :-) and I'm almost tempted to relook at my
> first attempt, where your only concerns were the words
> 'otherwise' and 'anywhere else' for non-native speakers.
>
> I'll think about this some more and get back to you.

How about this:

----8<----

    - an optional leading ! symbol meaning "unignore paths
      that match this pattern, instead of ignoring them"

    - an optional trailing / symbol meaning "this pattern
      matches only with a directory (i.e., files and
      symlinks won't match)"

    - the above two symbols (if present) are then removed.
      What remains is treated as a normal shell glob
      pattern, with the additional restriction that if the
      pattern still contains a slash, it matches only at the
      current directory and not in its subdirectories

----8<----

I'm not going into the 'descend' thing; based on how the
email from Bj=C3=B6rn Steinbrink plays out, we can describe that
later.  Same for 'current directory', which stands for the
root of the work-tree if the pattern came from
=2Egit/info/exclude or a core.excludesfile; this also can be
added as a footnote.
