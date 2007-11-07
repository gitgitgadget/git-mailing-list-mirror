From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Wed, 7 Nov 2007 23:16:06 +0100
Message-ID: <F783880C-A0F9-45D9-A23A-075600B31CEE@lrde.epita.fr>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-80--729281824"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Ralf.Wildenhues@gmx.de, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptCU-0003Gm-2l
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbXKGWQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbXKGWQW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:16:22 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:55436 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983AbXKGWQV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:16:21 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IptC1-0005tO-UW; Wed, 07 Nov 2007 23:16:14 +0100
In-Reply-To: <11944722214046-git-send-email-prohaska@zib.de>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63873>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-80--729281824
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi Steffen,

On Nov 7, 2007, at 10:50 PM, Steffen Prohaska wrote:

> This commits adds a discussion of the challenge of bisecting
> merge commits to the user manual. The text is slightly
> adapted from a mail by Junio C Hamano <gitster@pobox.com>
> to the mailing list
> <http://marc.info/?l=git&m=119403257315527&w=2>.
>
> The discussion is added to "Exploring git history" in a
> sub-section titled "Advanced topics". The discussion requires
> detailed knowledge about git. It is assumed that the reader will
> skip advanced topics on first reading. At least the text suggest
> to do so.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  Documentation/user-manual.txt |   89 ++++++++++++++++++++++++++++++ 
> +++++++++++
>  1 files changed, 89 insertions(+), 0 deletions(-)
>
> Some minor errors were fixed. Thanks to <Ralf.Wildenhues@gmx.de>.
>
> I kept the naming of the commits. Benoit Sigoure suggested to choose
> a different naming which he claims would be easier to remember.
> I'm not convinced. The current naming starts with X, Y, Z on the left
> and names the remaining commits on the right with A, B, C, D. This
> is simple and give sufficient orientation.

I still disagree but...  fair enough ;)
You end up comparing [ABCD] with [XYZ] which (to me) is hard to  
follow because it's like you were comparing two different kind of  
entities.  I tend to think more in term of branch (e.g. what's  
happened to the upper branch and what's happened to the lower branch,  
rather than think in terms of "before a point in time" and "after  
that point in time").  Because of that, I constantly need to look  
back at the scheme to find out what is `A', what is `Z' etc.

Some more comments below.  Sorry for not spotting these earlier.

>
> diff --git a/Documentation/user-manual.txt b/Documentation/user- 
> manual.txt
> index d99adc6..d0e738e 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -934,6 +934,95 @@ Figuring out why this works is left as an  
> exercise to the (advanced)
>  student.  The gitlink:git-log[1], gitlink:git-diff-tree[1], and
>  gitlink:git-hash-object[1] man pages may prove helpful.
>
> +[[history-advanced-topics]]
> +Advanced topics
> +---------------
> +This section covers advanced topics that typically require more
> +knowledge about git than the manual presented to this point.
> +
> +You may want to skip the section at first reading, and come back

I think the correct wording here is "on first reading".  If a native  
English speaker could confirm this...

> +later when you have a better understanding of git.
> +
> +[[bisect-merges]]
> +Why bisecting merge commits can be harder than bisecting linear  
> history
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
> ~~
> +The following text is based upon an email by Junio C. Hamano to
> +the git mailing list
> +(link:http://marc.info/?l=git&m=119403257315527&w=2[link:http:// 
> marc.info/?l=git&m=119403257315527&w=2]).
> +It was slightly adapted for this manual.
> +
> +Bisecting merges can be challenging due to the complexity of
> +changes introduced at a merge.  Bisecting through merges is not a

s/at a merge/& point/ ?

> +technical problem. The real problem is what to do when the
> +culprit turns out to be a merge commit.  How to spot what really
> +is wrong, and figure out how to fix.  The problem is not for the
> +tool but for the human, and it is real.
> +
> +Imagine this history.
> +
> +................................................
> +      ---Z---o---X---...---o---A---C---D
> +          \                       /
> +           o---o---Y---...---o---B
> +................................................
> +
> +Suppose that on the upper development line, the meaning of one
> +of the functions that existed at Z was changed at commit X.  The
> +commits from Z leading to A change both the function's
> +implementation and all calling sites that existed at Z, as well
> +as new calling sites they add, to be consistent.  There is no
> +bug at A.
> +
> +Suppose in the meantime the lower development line somebody

s/Suppose/& that/

> +added a new calling site for that function at commit Y.  The
> +commits from Z leading to B all assume the old semantics of that
> +function and the callers and the callee are consistent with each
> +other.  There is no bug at B, either.
> +
> +You merge to create C.  There is no textual conflict with this
> +three way merge, and the result merges cleanly.  You bisect
> +this, because you found D is bad and you know Z was good.  Your
> +bisect will find that C (merge) is broken.  Understandably so,
> +as at C, the new calling site of the function added by the lower
> +branch is not converted to the new semantics, while all the
> +other calling sites that already existed at Z would have been
> +converted by the merge.  The new calling site has semantic
> +adjustment needed, but you do not know that yet.  You need to

s/adjustment/&s/

> +find out that that is the cause of the breakage by looking at the
> +merge commit C and the history leading to it.
> +
> +How would you do that?
> +
> +Both "git diff A C" and "git diff B C" would be an enormous patch.
> +Each of them essentially shows the whole change on each branch
> +since they diverged.  The developers may have well behaved to
> +create good commits that follow the "commit small, commit often,
> +commit well contained units" mantra, and each individual commit
> +leading from Z to A and from Z to B may be easy to review and
> +understand, but looking at these small and easily reviewable
> +steps alone would not let you spot the breakage.  You need to
> +have a global picture of what the upper branch did (and
> +among many, one of them is to change the semantics of that
> +particular function) and look first at the huge "diff A C"
> +(which shows the change the lower branch introduces), and see if
> +that huge change is consistent with what have been done between
> +Z and A.
> +
> +If you linearize the history by rebasing the lower branch on
> +top of the upper, instead of merging, the bug becomes much easier to
> +find and understand.  Your history would instead be:
> +
> +................................................................
> +    ---Z---o---X--...---o---A---o---o---Y*--...---o---B*--D*
> +................................................................
> +
> +and there is a single commit Y* between A and B* that introduced
> +the new calling site that still uses the old semantics of the
> +function, even though that was already modified at X. "git show
> +Y*" will be a much smaller patch than "git diff A C" and it is
> +much easier to deal with.
> +
> +
>  [[Developing-with-git]]
>  Developing with git
>  ===================

Thank you!

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-80--729281824
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHMjkmwwE67wC8PUkRAhD5AJ4x+eYgSca8YcF2ftFVmbvQCNnFBACgsw0J
1d9wBWWIqgeR2xC36PciE6g=
=ggdX
-----END PGP SIGNATURE-----

--Apple-Mail-80--729281824--
