From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Approaches to SVN to Git conversion
Date: Wed, 7 Mar 2012 17:33:39 -0500
Message-ID: <CABURp0pLnMdFVgQ2+S_rW-KEjUBjKbEbMepEdPUkRJD+JQ_Ehg@mail.gmail.com>
References: <4F536FE9.1050000@pileofstuff.org> <3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail>
 <CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com> <4F5690FB.9060800@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathan Gray <n8gray@n8gray.org>, Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 23:34:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5PQt-0001vt-T7
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030785Ab2CGWeC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 17:34:02 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41502 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030771Ab2CGWeA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 17:34:00 -0500
Received: by lahj13 with SMTP id j13so7844497lah.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 14:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CcnAtm1Pf7e+oUpK7DjwwCk79forYIg4YJlvH35E5SM=;
        b=Eg+xstFagNT2XzOD/VNT4Y3ECyk/vQWTtzo4n2OU8v6kjxoSukU/8NmrZCpqw//qu4
         Ex1Zeoo8QlY3C3Ga3ItL5awxG6mazOh6i26Ykj+vymF1sTctgpLfeAIX/3y3+QW05Ip3
         /Sl1ytLYePnOJU6Q8lJSLa4rUHROKIO5egN7YFQ+ZqGDbxudNH3UBdjxk2f1ZnYjWAr5
         sFVopFTMGvIBNI54ht/gAg42gHPSJpyraxqBWCUAXPEPhkjnVCnGVcNx0LqIs7XM9d9z
         kOCXTbo8amM8O80c1Mn/vtdp3VJXHQvCGZDn8RyDGE9MERky70eMga0U8M00772dHt+2
         LPgA==
Received: by 10.112.86.229 with SMTP id s5mr1373300lbz.0.1331159639261; Wed,
 07 Mar 2012 14:33:59 -0800 (PST)
Received: by 10.112.8.133 with HTTP; Wed, 7 Mar 2012 14:33:39 -0800 (PST)
In-Reply-To: <4F5690FB.9060800@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192498>

On Tue, Mar 6, 2012 at 5:34 PM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:
> This is quite close to the implementation I've got. =A0The SVN export=
er
> runs in two stages:
>
> In the first stage, the script treats any non-blacklisted file as a
> marker file, but only looks for trunk branches. =A0It looks all throu=
gh
> the history, traces back through the copyfroms, and tries to find the
> original directory associated with the file. =A0Usually it decides th=
at
> the only branch without a copyfrom is /trunk. =A0Searching just for t=
runks
> with this weak heuristic makes it much easier to hand-verify the resu=
lt.
>
> In the second stage, the script looks through the history again, trac=
ing
> the copies of known branches in a slightly less clever way than
> described in my previous e-mail. =A0There's no need for marker files =
this
> time round, as we just assume any `svn cp /trunk
> /directory/not/within/a/branch` is a new branch. =A0In my experiments=
 this
> has been a pretty solid way of detecting branches without too much hu=
man
> input - I might be missing something (or have mis-explained something=
),
> but I'd be interested to hear examples of where this would go wrong.

I think what you're describing would work perfectly for my weird svn
repo.  I have branches named like this:

branches/developer/hordp/foo
branches/developer/hordp/bar
etc.

Since these were created with 'svn cp' originally, they would be
properly considered branches by your algorithm, right?    If so,
sweet!

> Having said that, here's a dodgy example I'd like to pre-emptively de=
fend:
>
> =A0 =A0 =A0 =A0svn add tronk
> =A0 =A0 =A0 =A0svn ci -m "Created trunk" # r1
> =A0 =A0 =A0 =A0svn cp tronk trunk
> =A0 =A0 =A0 =A0svn ci -m "D'oh" # r2
> =A0 =A0 =A0 =A0svn rm tronk
> =A0 =A0 =A0 =A0svn add trunk/markerFile.txt
> =A0 =A0 =A0 =A0svn ci -m "Double d'oh!" # r3
>
> You could argue that the correct branch history description for the
> above would be:
>
> =A0 =A0 =A0 =A0In r3, create branch "trunk"
>
> In other words, ignore everything that happened before the marker fil=
e
> was created. =A0However, I would argue the following representation i=
s
> more correct:
>
> =A0 =A0 =A0 =A0In r1, create branch "tronk"
> =A0 =A0 =A0 =A0In r2, create branch "trunk" from "tronk" r1
> =A0 =A0 =A0 =A0In r3, delete branch "tronk"
>

I prefer your interpretation. It doesn't look dodgy at all.

Phil
