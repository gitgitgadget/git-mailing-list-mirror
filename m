From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: git2 cli (GSOC)
Date: Thu, 24 Mar 2011 02:02:32 +0000
Message-ID: <20110324020232.GA10441@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 03:02:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Zso-0000sD-3S
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 03:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab1CXCCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 22:02:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58589 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1CXCCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 22:02:35 -0400
Received: by wwa36 with SMTP id 36so10870486wwa.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=EDvvB8eNij6ImaDvFwixP/JHrIWXau82Z+y9a7RHNWw=;
        b=te1pGQw1UFvhunSvIy1gHosxMSvCJ59vcb51a8BfYnojoAKmfnpLbGi5aQ0WumZaDl
         VIjqy8Ih/YXZSKXE95IhbMQd65PKauoMKZOIX0DmklGScxTqAptQc0DwFA397KJX2Msj
         ETv5VpcuZfUqtol7cIYWVdkmeBVoV4IaTbOrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=dBN5XpyGeAZpg9g9OZKSGivoM2v6G8TdDsyHjpgz5Ahw2CYdSBXgRZSBm+mbUSfpLR
         icAi3lau0JDP9dbvK8+X15qP33ey/c7WOoBH3sxlVJxuVYqRa/CdPAJsi4Qtcd2zDneV
         xJuit+AQrQS0rsIwpVgE6768gV1JQ12QEfeic=
Received: by 10.216.145.154 with SMTP id p26mr169414wej.11.1300932154260;
        Wed, 23 Mar 2011 19:02:34 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id h11sm4080925wbc.60.2011.03.23.19.02.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2011 19:02:33 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169886>

Hello folks,

IMHO libgit2 is the best thing happening in Git world. Why? In world of
good software:

1) You implement a prototype of a thing (e83c516 probably)
2) See it's cool
3) Make it work and and all others start using it
4) Clean it up
5) Make it run on your watch.

libgit started git's way to (4). Note: I'm not saying git is "bad". It
has just hell too many dependencies for a watch.  When libgit2 and git2
are mature enough, it will run on Android and my watch.

There were some ideas in this mailing list about merging libgit2 to git
a couple of days ago. I think that's pointless, it should be the other
way around. Git features should get to libgit2 and git2.

Working is better than talking, so I created a git2 cli prototype[1]. I=
t
has one feature, which is (should be?) equivalent to:
    $ git rev-list HEAD

You can run it like this:
    $ git2 rev-list <anything>

I created a very, very rough draft of git2.c. Thanks Jeff King for
advise[3] starting with a basic plumbing command. Those couple of hours
were quite interesting, because none of the human-readable API
documentation examples[4] I've tried actually worked. :)

We have some architecture questions to answer before getting started.
Are we aiming for a distributed 100s of executables architecture
(current git), or single huge binary (linux/busybox)? I would count for
single executable due to higher portability. However, plugging git2 for
git unit tests should require more thought.

Build configuration. Git-send-email is not really a must-have for an
embedded device, so we should be able to specify these features in
configure-time. How do you think it should be taken care of?
1) <buildtool> configure  --disable-everything --enable-email
2) make menuconfig and enjoy the blue screen of choice
3) ?

Build tool. I am not against waf (I've chosen waf for SoundPatty), I've
been using it, but it's too clumsy for me. Is it me that lacks
experience and it's a great tool, or am I not the only one who sometime=
s
feels confused and pissed off when trying to do some really simple
things? Should I stick to waf because libgit2 uses waf?

I want to do this hell a lot. I'm a student and I have C++
experience[2]. Actually I think it's not really my taste, since it is
too high-level for me. I love C and currently I am a full-time Python
web developer (django/friends)... I couldn't sleep for the last two
nights because libgit2 peaked my interest and my performance at work wa=
s
quite terrible. I see you are + for this tool as I am, so we might have
some great work together. Anyone would like to be a mentor?

About me.. I already told quite a lot, but you can find more info
(probably that means only CV) in my personal websites[5][6].

[1] https://github.com/Motiejus/git2/
[2] https://github.com/Motiejus/SoundPatty/
[3] http://marc.info/?l=3Dgit&m=3D130081966214059&w=3D4
[4] http://libgit2.github.com/api.html
[5] http://m.jakstys.lt/
[6] https://github.com/Motiejus/ :-)

Regards,
Motiejus Jak=C5=A1tys
