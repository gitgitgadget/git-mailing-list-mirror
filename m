From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git-archive and tar options
Date: Mon, 18 Jul 2011 14:31:58 -0500
Message-ID: <4E248A2E.3090902@gmail.com>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net> <7vei1s36bl.fsf@alter.siamese.dyndns.org> <20110714212502.GA29848@sigill.intra.peff.net> <7vwrfk1lv3.fsf@alter.siamese.dyndns.org> <4E20AA42.7000003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jul 18 21:32:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QitY7-0006Zz-CR
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab1GRTcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 15:32:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59011 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1GRTcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 15:32:09 -0400
Received: by gyh3 with SMTP id 3so1463090gyh.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eco9YkeZ4NDn9rXY3e5vZ5Xj10tzLpGHYblmOhLK0z0=;
        b=cWmj1PEYM/gHXukfSFlKEkU2FLlobZ410fSNSO75N8EKzaqLXRT36IiNYPiFJjmajA
         UXMDsVX4s2YDDR61YmBDQNHDpDKa0e73Ux4NCyvtH572S5d5LIeQrxuOyunbTGWzlo0i
         ovkROKphg6gSn7dxpQ0+c1y5QuQPHRq37vFl0=
Received: by 10.236.37.233 with SMTP id y69mr6184481yha.59.1311017527890;
        Mon, 18 Jul 2011 12:32:07 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id z28sm3378034yhn.7.2011.07.18.12.32.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 12:32:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4E20AA42.7000003@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177399>

On 7/15/2011 3:59 PM, Ren=E9 Scharfe wrote:
> Am 15.07.2011 01:30, schrieb Junio C Hamano:
>> Jeff King<peff@peff.net>  writes:
>>
>>>> Why?
>>>>
>>>> The tree you are writing out that way look very different from
>>>>  what is recorded in the commit object. What's the point of
>>>> introducing confusion by allowing many tarballs with different
>>>>  contents written from the same commits with such tweaks all
>>>> labelled with the same pax header?
>>>
>>> See my later message. I think it depends on how the embedded id
>>> is used. Is it to say "this represents the tree of this git
>>> commit"? Or is it to help people who later have a tarball and
>>> have no clue which commit it might have come from?
>>
>> People, who have no clue which part of the subtree was extract and
>>  what leading path was added, would still have to wonder where the
>>  tree came from even with the embedded id. Without your patch, if
>> the tarball has an embedded id, wouldn't they at least be able to
>> assume it is the whole thing of that commit? If you label a
>> randomly mutated tree with the same label, you cannot tell the
>> genuine one from manipulated ones.
>>
>> Not that I have strong opinions on this, either, but that is what I
>> meant by "_introducing_" confusion.
>
> When we started to write the ID into generated archives, there was
> only git-tar-tree and no<rev>:<path>  syntax.  It would write the ID
>  only if it was given a commit and not if it got a tree or if the
> user started it from a subdirectory.  The result was that only the
> full tree of a commit was branded with the commit ID.
>
> Now we have git archive, a more flexible command line syntax all
> around, path limiting as well as attributes that can affect the
> contents of the files in the archive.  Back then the commmit ID was
> sufficient as a concise and canonical label of the archive contents,
>  but now things are a bit more complicated.
>
> Which use cases are we aiming for?  Do we want to include all of the
> command line arguments (with revs resolved to SHA1-IDs)?  Only those
> that modify archive contents?  And any applied attributes?  Or do we
> want to get stricter and only write the commit ID if a full unchanged
> tree of a commit is being archived?
>
In regards to the use cases you enumerated, I think logging the command
line syntax along with the appropriate ref context (HEAD value, etc)
would document exactly what's in the archive.

In regards to use cases in general, my impression is that git-archive i=
s=20
for producing archives useful for deployment.  The target deployed=20
structure may vary so expecting the source git repo to reflect this is=20
unfeasable.  It seems like utilizing the local tar installation would=20
effect the necessary transformations. I'm not sure what the source and=20
target tar version disparity problems might me.

A practical problem with the pax header is that its only useful if you
still have the archive.  Archives usually get deleted after being
extracted.  Therefore, an option to also generate (and add to the=20
archive) an automatic "VERSION.TXT" file of some sort which specifies=20
the context of the archive would be much more useful.  It would need it=
s=20
own --prefix option because oftentimes it would be dynamically generate=
d=20
based on the git-archive request.

Another use case is that it seems like there should also be the option=20
to only tar the objects changed between a specified range of commits.=20
However, I'm not sure if tar can handle deletions (moves, deletions,=20
renames) upon extraction in this context.

I can see that my use cases are something that I can script myself, but=
=20
to do so it seems like I would be better off using a non-bare repo=20
checkout as an intermediary.  If that is what I am expected to do then =
I=20
am not sure what the usefulness of git-archive is intended to be.  Mayb=
e=20
I don't understand what others use it for.

v/r,
neal
