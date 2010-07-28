From: Elijah Newren <newren@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Tue, 27 Jul 2010 21:31:55 -0600
Message-ID: <AANLkTi=8u5VROYQygAXoCS4c+eAoEoP8V4t5rJ=wXL8q@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 05:32:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdxNH-00084r-Ft
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 05:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab0G1Db5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 23:31:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36803 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0G1Db4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 23:31:56 -0400
Received: by vws3 with SMTP id 3so4016168vws.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 20:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ORl+e63sro7jmKU/99PHClDhPKJXrOArQvrQeR/ncUg=;
        b=ct4cQVr4h4Hv0qmgLKoiejFdF4WygfWuoUb0xBsxiizS/SwlzzNijoF/B4cYjJLztR
         k7atQ1PWryo8wDQVUo3SFf5G61Bbaw2FhhsQqbRFwz/6XHyuNzTxjUC2Y/qB6sGxiXOt
         2hwTPXdLfnHW3EIIdldu//tT/P5UuFelaNYs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vFmbMRbhr0EotCWXe9gkMd2TUi1GMaPzfa6gd3FF5xZQSvLhl87QFOEO9Cl2dHKi2j
         PsFrh9UHIePHo8FmRE6FhJBve7Lyclh+vLv7oo5RDqsX7iWXidxq/RsxCGaCmW1yckri
         VTc/cqoutYcNbBGYkj29EzeGCEICvCslz3NuU=
Received: by 10.220.98.140 with SMTP id q12mr5609841vcn.268.1280287915622; 
	Tue, 27 Jul 2010 20:31:55 -0700 (PDT)
Received: by 10.220.97.15 with HTTP; Tue, 27 Jul 2010 20:31:55 -0700 (PDT)
In-Reply-To: <AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152032>

2010/7/27 Avery Pennarun <apenwarr@gmail.com>:
> Note that if you happen to want to implement it in a way that you'll
> also get all the commit objects from your submodules too (which I
> highly encourage :)) then downloading the trees is the easiest way.
> Otherwise you won't know which submodule commits you need.

Makes sense.  Seems like a good reason to include all the trees.

> Since downloading commits is so cheap anyway, I'd suggest just
> defaulting to downloading all the refs, as clone currently does. =C2=A0=
If
> people don't like it, they can do what they currently do:
>
> =C2=A0 git init
> =C2=A0 git remote add ...
> =C2=A0 git fetch
>
> Not that pretty, but then again, it's rarely needed.

Would you suggest then parsing the limiting arguments passed to clone
and disallowing refs?  Or just making it non-useful by always
appending "--all HEAD"?

>> 2) Sparse checkouts are automatically invoked with the path(s) from
>> =C2=A0 the specified rev-list arguments.
<snip>
> I don't totally understand what you mean here. =C2=A0But I do think t=
hat if
Basically, I mean what you stated much more succinctly and eloquently
right here:
> I guess my point is, more complex exclusions could always be added
> later but they aren't so important right away.

>> 4) All revision-walking operations automatically use these limiting =
args.
<snip>
>=C2=A0It does sound sort of elegant: this way they *won't* run into th=
e missing objects.
> Beware, however, that
>
> =C2=A0 git log -- Documentation
>
> outputs a different set of commits than just
>
> =C2=A0 git log

Yes, exactly.  In a sparse clone, why wouldn't one want the behavior
of the former automatically, without having to specify the paths on
the command line every time they ran log (or rev-list or fast-export
or...etc., especially if they cloned N directories rather than just
1)?

Actually, I can kind of see the desire to see the 'real' log since the
users do happen to have all commits locally, but it almost seems like
it should be the case that requires a special option to be passed to
git log ('--ignore-sparse-limiting'?).  But trying to get that option
to work in conjunction with other options (--stat, -S, -p, etc.) would
be really hard, if not impossible.

>> 5) "Densifying" a sparse clone can be done
<snip>
> I think this would work, but unless you want to re-download some
> (possibly lots of) objects you've already got, it would require some
> kind of extra support from the server, I think. =C2=A0Maybe that's a =
rare
> enough case that few people will care and it could be fixed later.

=46or my first implementation, my plan was to simply re-download ALL
(not just some or lots of) objects I've already got in such a case.  A
bit wasteful to be sure, but I was hoping it was rare enough to
"densify" a clone that it wouldn't be a big deal...and that support
for smarter downloads could be added later.

> I don't think the pull vs. fetch distinction is valid; I would be ver=
y
> surprised if pull un-sparsified my checkout, just as I would be
> surprised if merge did. =C2=A0And pull is just fetch+merge.

Right, I don't think pull should un-sparsify either the checkout OR
the clone by default (it should have fetch pass the same limiting
arguments and only download an equivalently sparse set of updates).
Your point about pull=3Dfetch+merge (or fetch+rebase) makes sense, whic=
h
I guess means that un-sparsifying a clone+checkout should be a
separate toplevel command ("densify"?) rather than a special option
for fetch/pull.

>> 6) Cloning-from/fetching-from/pushing-to sparse clones is supported.
>>
>> Future fetches and pushes also make use of the limiting arguments.
>> Receives do as well, but only to make sure the pack obtained is not
>> "more sparse" than what the receiving repository already has.
>> (uploads ignore the stored rev-list arguments, instead using the
>> rev-list arguments passed to it -- it will die if asked for content
>> not locally available to it.)
>
> This scares me a little. =C2=A0It's a reminder that it's all-too-easy=
 to
> get your repository into a really messed up state by going in and
> screwing with your sparseness parameters at the wrong time.

I don't follow.  Why would people be "screwing with sparseness paramete=
rs"?

My basic idea was that there would be only three ways to change
sparseness parameters for clones, with only the first two documented:
the initial clone command, the "densify" command (someone probably
needs to think of a better name), and reading the source code to
figure out what bits on your disk to change and changing them.


Here's why I want the clone-able/fetch-able/pull-able sparse clone
functionality:

I like having translators (who only need maybe one file) or technical
writers (who only need the Documentation/ subdirectory) or other
similar folks having the ability to collaborate on the subset of the
repository that they need to do their work.  Thus, it makes sense for
them to be able to clone from, pull from, and push to each other.  The
only two rules that I think are necessary to enable such behavior are:

* No repository can provide information that it doesn't have (should
be pretty easy to enforce...)
* No repository accepts less data than it expects in its repository
(i.e. you can push to a sparse clone or a real clone, but need to
provide data that fulfills it's rev-list limiting arguments)

> It would make me more comfortable if there was some kind of "oh god,
> just fix it by downloading any objects you think are missing" mode :)
> In fact, git could benefit from that in general - every now and then
> someone on the list asks about a repository they managed to mangle by
> corrupting a pack or something, and there's no really good answer to
> that.

=46or sparse clones, Isn't that mode just running the "densify" command
with no limiting arguments?

>> 7) Operations that need unavailable data simply error out
>>
>> Examples: merge, cherry-pick, rebase (and upload-pack in a sparse
>> clone). =C2=A0However, hopefully the error messages state what extra
>> information needs to be downloaded so the user can appropriately
>> "densify" their repository.
>
> That sounds good to me.

Thanks for the detailed feedback.  :-)
