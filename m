From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Shell aliases & paths
Date: Tue, 4 May 2010 17:30:28 -0500
Message-ID: <20100504223028.GA15548@progeny.tock>
References: <19424.34226.564684.613674@winooski.ccs.neu.edu>
 <20100504211122.GA15091@progeny.tock>
 <19424.36914.867693.327548@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 05 00:37:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9QkR-0008VJ-3D
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 00:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934508Ab0EDWhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 18:37:09 -0400
Received: from mail-iw0-f203.google.com ([209.85.223.203]:49304 "EHLO
	mail-iw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934463Ab0EDWhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 18:37:06 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2010 18:37:06 EDT
Received: by iwn41 with SMTP id 41so5351369iwn.20
        for <git@vger.kernel.org>; Tue, 04 May 2010 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Trs+/OB7nXyQ/El2qFJWDO3L9MUXRXW/abq64t0BPaM=;
        b=d2487n56o2R58VpyEjs0qKf6+rwLlLdwu7tqAfrKnCj+MMtbEBLOFAQPtO1/nPofzR
         wQ4C6X2qQ9OMYKWVBGIaQmtctnvRTRNkECNpdi19z0MA4UN5pUeWLDjFDODZQAU1+U6m
         NfjFUcuZeCiZKUDNXNBgXKvmH7YM1+CqSQazc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RIBleyKwn7TkPjvVus7kq/DeXskzbJ+m8sN7Dj1ycWzaHRsdTb6MUjBrhPTv2c4YFW
         WAHZNnXOV65GY0dmp9GTeKidZHQUtlXXrbn+mEoD6jFIkWFq4+art63HHPGZoD5UTR/A
         wrpT6+M37sxq0Z9Xz3CijeExQoTtEzRASfhHQ=
Received: by 10.231.153.67 with SMTP id j3mr611669ibw.37.1273012207753;
        Tue, 04 May 2010 15:30:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5626017iwn.15.2010.05.04.15.30.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 15:30:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19424.36914.867693.327548@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146352>

Eli Barzilay wrote:
> On May  4, Jonathan Nieder wrote:

>> Maybe a new GIT_PATHNAME_PREFIX environment
>> variable would help.
>
> Yeah, I was searching the environment for something like that, and wa=
s
> surprised when I didn't find any shred of the original path in there.
> (In any case, I'd like to see something like that, although it's too
> late for me to use it since I need a solution that works now...)

Care to write a patch?  But yeah, sounds like for now you=E2=80=99re sc=
rewed. :(

>> At that point, why not just add a git-foo script to $PATH?  (=E2=80=98=
git
>> foo=E2=80=99 will still call it.)
>
> The same can be said on all shell aliases, no?

True shell aliases have the advantage of not being inherited by
subprocesses, so they can be made to apply in interactive shells only
and avoid breaking scripts.  Similarly, if you write an alias in
=2Egit/config, it does not pollute the command namespace for other
repositories.  I am not sure how much people take advantage of this.

Aliases also do the work to detect a git repository and set GIT_DIR,
which I guess some people would want; and the non-! aliases avoid
forking a new process.

> FWIW, I find these aliases more convenient in having "extensions" wor=
k
> for other people -- ie, it's easier to say "here's some text, dump it
> in your ~/.gitconfig" than it is to explain where some script should
> be added and how

Hmm, maybe teaching git to respect a core.toolpath setting would help
in some situations[1].  I am thinking of two scenarios:

 A. To simplify its installation process, such-and-such git extension
    does not require access to a directory on the user=E2=80=99s $PATH.
    Instead, you just extract it wherever (~/opt/the-extension, say)
    and then add =E2=80=9C[core] toolpath =3D "~/opt/the-extension"=E2=80=
=9D to your
    .gitconfig.

 B. On an insane platform, the user might want git to look for the
    standard tools in /usr/sfw or something instead of /usr/bin or
    /usr/xpg4/bin.  Making this a run-time configurable setting gives
    the user a chance to override a misguided system-wide choice or
    experiment with what works best.

I don=E2=80=99t fall into either of these categories, so I can=E2=80=99=
t say whether
it would be actually helpful, though.

Thanks for the explanations.
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/121063/focus=
=3D121085
