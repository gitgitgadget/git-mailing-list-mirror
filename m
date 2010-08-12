From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 02:33:38 +0000
Message-ID: <AANLkTi=5biMga0=nAVwQLNd1jEJXXtUJBqdhuyt-YoWv@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<20100812014107.GA18937@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bo Yang <struggleyb.nku@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 04:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjNc2-0004c6-5i
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 04:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759368Ab0HLCdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 22:33:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41961 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab0HLCdj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 22:33:39 -0400
Received: by fxm13 with SMTP id 13so554921fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KHrweWu/WLc9autIZ1OMk2GPIV/uNxRZDgduCh9dSjA=;
        b=gQaLah6Jq98XrPpVyQRI9J3wUSWqjXTD+EuFQWVIjMn1HMgR9nvS3cs7hGZnbvpE+D
         Gga7ZZb7KjFK5+j02bUd+R8rxAA22Lmny0uJk+yH9OUwgDyv3oK0EpuqFm95ZrP0vrL4
         746m6Zl61Ozx/YuMrynbrjWMncG+JWWBUdFI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jYS/C8ZVveiLONLTQXDlsqZePDC9WKiVj3/kIuIjBMgEVmQQjZz873H+k+2uPebhiZ
         0Ew2YZaLz+tRSGLZTg1im5Yd81D0VHhgqQzjA7Iz0IUhqf9nI8SBtY7hRHiZ+P+N0U7W
         iqevcRLXJFljJAMLpDVPOKnz6DYIOokUhhIFM=
Received: by 10.223.109.2 with SMTP id h2mr20992687fap.95.1281580418393; Wed, 
	11 Aug 2010 19:33:38 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 19:33:38 -0700 (PDT)
In-Reply-To: <20100812014107.GA18937@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153325>

On Thu, Aug 12, 2010 at 01:41, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Junio C Hamano wrote:
>> * jn/commit-no-change-wo-status (2010-07-24) 9 commits
>> =C2=A0. commit: suppress status summary when no changes staged
>> =C2=A0. commit --dry-run: give advice on empty amend
> ...
>
> Could you revert the tip of this one? =C2=A0What remains is a good
> cleanup (+ change in --dry-run output for consistency), I think.
>
> There was no positive feedback about suppressing the status summary.
> I am afraid it might be a bad idea; I=E2=80=99d be happy if people ha=
ve other
> ideas for making the output friendlier.

I think it's a little unfriendlier with this patch than without. With
`color.ui =3D auto' on and `touch meh && git commit' you'll have "meh"
pointed out to you in bright red as the thing you forgot, so you know
what to "git add".

Just saying that you need to "git add" doesn't give you that context.

But maybe the wall of text from "git status" can be a bit confusing to
users, especially in the pathological case. Perhaps one way to solve
that would be to give the message more color:

    $ git commit
A   # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
X   #       blahblah
Y   nothing added to commit but untracked files present (use "git add" =
to track)

X is now red, but Y is the same color as the rest of the
message. Maybe we could give that the "info" color (used in
e.g. test-lib.sh). Then users might read it as Y->X->A instead of
A->X->Y.

But I don't know, the "git commit" output doesn't confuse me so I'm
not in the target audience.
