From: Kevin Williams <kevwil@gmail.com>
Subject: Re: git-svn rebase can change branches during merge?
Date: Mon, 16 Mar 2009 22:34:44 -0600
Message-ID: <683a886f0903162134q2d8069ect1554e1b32ca6a3fb@mail.gmail.com>
References: <683a886f0903161349k172679a6t24cc4e393aea8f2d@mail.gmail.com>
	 <20090316233641.248f2e81@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Mar 17 05:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjR2G-00021h-FO
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 05:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbZCQEes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 00:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbZCQEer
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 00:34:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:6779 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbZCQEer convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 00:34:47 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1353976ywh.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lyY37jkbEaoOBaC4Lt0sT+L2mA7ImKccfyhye9d00rM=;
        b=mKA6pSR73DPIRxPBEfZMSo2vww0NFydGL7j7a0gMKxaOZgAQvXyIoo3CBMoQ7vm8jl
         wMQcSnIRnBjY2yXjr1EYQxJ1WLtvqhaDOhPSoYn7DMakKWxOxv66pl9O2H68fc3XORfV
         gxvEGFwc2SnI8hs80hz5YBGIRSkUd4ihxeluM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n74cG+4WIvzSsoEJuwQgtxZQLjTpXX5VRp91P38ENX4ay2UKAFU6aKZ4C8aWUunUvR
         6mU2x7/lowtGGs7kaJnBCg4HUvrqAgOlDEhp1j4Kvcfdq6d0hxxreO85uYZ8NFZfRRqf
         ARqtPbCERMkxljBikTMLgv6iOe3UFV0bDKnU8=
Received: by 10.150.157.17 with SMTP id f17mr310154ybe.95.1237264484196; Mon, 
	16 Mar 2009 21:34:44 -0700 (PDT)
In-Reply-To: <20090316233641.248f2e81@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113417>

On Mon, Mar 16, 2009 at 4:36 PM, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> Hi Kevin,
>
>> I've outlined steps where I can reproduce this bug here:
>> http://gist.github.com/80058
>>
>> When using "git svn rebase" and there is a conflict between a local
>> (git) change and an upstream (svn) change, the local git repository =
is
>> left in a ghost-branch. It shouldn't change branches during a rebase=
,
>> should it? I also seem to be unable to recover from the merge
>> conflict, but that may be just due to the noob at the keyboard (me).
>
> rebase doesn't actually switch to another branch here, but it does
> detach HEAD. To get back to a state you can work from, it's a simple
> case of following the instructions rebase outputs:
>
> 1) edit conflicted files to fix the conflicts.
> 2) stage new versions of files (e.g. git add file.txt)
> 3) git rebase --continue
>
> Here's what happens:
>
> jast@perceptron 1% cat test.txt
> <<<<<<< HEAD:test.txt
> git svn rebase blows up here
> =3D=3D=3D=3D=3D=3D=3D
> hello from svn
> hello from git
>>>>>>>> add to txt file from git:test.txt
> jast@perceptron % git branch
> * (no branch)
> =C2=A0master
> jast@perceptron % vim test.txt
> [...]
> jast@perceptron % git add test.txt
> jast@perceptron % git rebase --continue
> Applying: add to txt file from git
> jast@perceptron % git branch
> * master
> jast@perceptron %
>
> Make sense?
> -Jan
>

I think so. Thanks for the detailed examples.

I think sometimes I was committing after adding the fixed files, which
would seem to succeed but then the 'git rebase --continue' would blow
up and I couldn't get back to master without 'git rebase --abort'.

Thanks again!


--=20
Cheers,

Kevin Williams
