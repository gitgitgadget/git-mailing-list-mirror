From: John Clemens <clemej@gmail.com>
Subject: Re: mirroring and development with three levels of repositories?
Date: Tue, 28 Sep 2010 14:27:29 -0400
Message-ID: <AANLkTin2UPUPn5Sr=7dqT5bxFB7a-BYFzJhGV74r6taF@mail.gmail.com>
References: <AANLkTinFiOA6Grzk16W2D=k8Xt+EgTanrS7iryW2evop@mail.gmail.com>
	<20100928173710.GA31419@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 20:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ets-00039Z-6a
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 20:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757338Ab0I1S1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 14:27:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46799 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab0I1S1a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 14:27:30 -0400
Received: by bwz11 with SMTP id 11so4382112bwz.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=D+gS/dmX4/081Uh7QTHxphlsARuy0RQCUeYWBuBXy9E=;
        b=N8Sziw0L9fBtgJebV3NlglO2Tevjm0QJXCQ7uhLBjlHkQYjfwwWBRsfTVONY9tP0vP
         sk9iWSrIQdv61jurReJRqkqqCkOxaeOpNQhP0uyPzGYcgjCxoPtdKJlYoxbC5BxeQNd2
         8YznAUcYiaNOvFw7feG43GCTPWxvfoJaF1C6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=xXBLmdWOiUUC3CGtGh3SaPSPdZd1aqItD+LV7fkbGct/Gp6o6jAUYkCHt6Gbq7VkpF
         tbudLaPHxcgcP6symekyXs6Y8H3OQzNJHnLYj3OGlwP19pgwmcd1I7pk7mRgUyQVeMpU
         z6BXwmc0EQCPM97xEfQHiRj2zOkytCCQPuw/A=
Received: by 10.204.180.75 with SMTP id bt11mr323431bkb.115.1285698449298;
 Tue, 28 Sep 2010 11:27:29 -0700 (PDT)
Received: by 10.204.153.10 with HTTP; Tue, 28 Sep 2010 11:27:29 -0700 (PDT)
In-Reply-To: <20100928173710.GA31419@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157451>

On Tue, Sep 28, 2010 at 1:37 PM, Enrico Weigelt <weigelt@metux.de> wrot=
e:
> * John Clemens <clemej@gmail.com> wrote:
>
>> Short question:
>> It it possible for a bare repository to have both local (company-wid=
e) and
>> remote (mirroring upstream) branches, as well as serving those branc=
hes to our
>> devs? If so, how?
>
> Yes. Just set up the proper remotes in the config files (same as w/
> non-bare repos). The main problem for you might be that the hub-repo'=
s
> remotes wont show up as remotes in it's clones - that's because per
> default only remote's refs/heads/* namespace is mapped into local's
> refs/remotes/*.
>
> Most convenient would probably doing this in the local hub repo.
> Add a proper fetch statement in the upstream remote's config section.
> Suppose the upstream's remote name is "origin":
>
>
> [remote "origin"]
> =A0 =A0url =3D ...
> =A0 =A0fetch =3D +refs/heads/*:refs/heads/origin/*
> =A0 =A0fetch =3D +refs/tags/*:refs/tags/origin/*

Hmm.. I do actually see the branches on dev machine.  When I clone from=
 our
local mirror, everything works fine UNTIL I create a new branch and pus=
h it
to our local mirror.  From that moment on, all new clones fail (more pr=
ecisely,
they do download all the blobs, but the refs only point to the newly cr=
eated
branches, and HEAD is messed up.

config on the local mirror is this:

[remote "origin"]
        fetch =3D +refs/*:refs/*
        mirror =3D true
        url =3D xxx

presumably, fetch is recursive, so this should catch everything from up=
stream?

So, the problem appears to be that creating a new branch in the local m=
irror
repo (level 2 in the diagram), messes up all the upstream refs, even th=
ough
they still exist in packed-refs.  Any new clones clone to the dev machi=
ne
(level 3) only see the new branches, and not any of the other in the
main mirror.

> This will make the upstream's heads and tags as they were pushed
> to the hub repo directly, but with the "origin/" prefix.
>
>> $ git clone http://local-server/local-mirror.git
>> Initialized empty Git repository in /home/clemej/git/local-mirror/.g=
it/
>> warning: remote HEAD refers to nonexistent ref, unable to checkout.
>
> What does the refs/HEAD file tell in the local mirror repo ?

On the local mirror, HEAD is:
ref: refs/heads/xxx/stable

On any new clone, HEAD still points to refs/heads/master (presumably
because the checkout failed).

Thanks,
john.c

--=20
John Clemens <clemej@gmail.com>
