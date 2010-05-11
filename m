From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Multiple line ranges and files in line level history browser
Date: Tue, 11 May 2010 13:43:27 +0800
Message-ID: <AANLkTimCT7euE0CjGBx88MlfVJhxVo1GdOtnMhtZqBQs@mail.gmail.com>
References: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
	 <7v1vdl9btm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 11 07:46:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBiI9-0000f7-6v
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 07:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab0EKFna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 01:43:30 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:49406 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab0EKFn3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 01:43:29 -0400
Received: by qyk13 with SMTP id 13so7540800qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 22:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=empdd8191N9nZyWzZ0A81gUdbeCidSBPjX5rBhBcak8=;
        b=jlzuZRbFrDg3dqhx/QyFE73/apx6Zd+0W39aHkNN//k7TEdbRoEvNxql0D5FKKMK+U
         wv0RVAUcKeWvKbYvLi+vPP0cSf+N6LkErCFKM1rnPq3qssJy5CDT0yK9jnylckggR4Zx
         EzykHR4cJdedw8I45f7bX7F1pQ52CciTQ0bnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JJVhIHCoQuSOsUBV8MAAz4dahMVm1TVZAwbIDvmaNfdKJMhwm81iZ2IonWzzShie90
         PwQMI5g6QfLPAtsFB8pbhmClLC1yD7tM6TUYezdxg3hH8u7D7gztBH98RWhL0byjHY4D
         ZcuTeE1l/4oJahgx4WkkmvC3zYc4qq8a9PbQM=
Received: by 10.229.185.1 with SMTP id cm1mr4159632qcb.57.1273556607701; Mon, 
	10 May 2010 22:43:27 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Mon, 10 May 2010 22:43:27 -0700 (PDT)
In-Reply-To: <7v1vdl9btm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146868>

Hi,
On Mon, May 10, 2010 at 2:20 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> If there is no opposition for this kind of option syntax, I will try
>> to implement it in revision.c. ;-)
>
> I'd rather not to see this in revision.c at all. =A0The revision.c pa=
rser
> has always been options and then pathspecs and never takes individual
> filnames, except for "--follow" that is an afterthought checkbox hack=
 that
> lets the main parser parse and then reject a generic pathspec after t=
he
> fact.

Ok, this will be put in the builtin/log.c

> I think the right place to do this sort of thing is in the incrementa=
l
> output of "blame". =A0The command only takes individual filenames and=
 never
> takes general pathspecs, it knows about -L as line-range (and as far =
as I
> see, it is the only command that does so) and I think its output rout=
ine
> already has the right infrastructure for doing this. =A0The "--increm=
ental"
> output itself is designed for porcelain scripts to interpret and do t=
he UI
> around it, but that does not mean it can have another mode that gives
> human readable output. =A0When "blame --incremental" emits the record=
 that
> says "these lines are blamed to this path in this commit", it has alr=
eady
> run internally necessary "diff" between blobs to find that
> information---you should be able to re-run the diff (or keep the outp=
ut
> from "diff" around, but I would suggest against it) and show somethin=
g
> like "git log -p" output but is limited to the hunks that actually to=
uch
> the areas that we are following.
>

Hmm, maybe I should say something about my general plan about how to
implement the line level browser here.

Generally, I plan to change two place in major to make the history of
line ranges.
1. The definition of TREESAME. TREESAME will be changed to consider
the line ranges if -L option is given;
With this, the history simplification can be done very well for line
level history traversal. And even well for parent rewriting to support
--graph option.
Also, line tracing will be done along the process of the history
simplification in the same time. And the tracing algorithm will be
written in another new source file and get called in revision.c (maybe
file_change and file_add_remove)...

2. The diff format, maybe a DIFF_FORMAT_LINE option will be added, and
a new function builtin_diffline() will be added to output the line
level diffs.

This has some difference with my original proposal on the source files
which need to modify. But I think this is the right way to do things
after I have digged more into git source code.
I hope this very rough idea can help you to understand what my
following patches will look like.

Regards!
Bo
--=20
My blog: http://blog.morebits.org
