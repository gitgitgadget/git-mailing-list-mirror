From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Clone to an SSH destination
Date: Mon, 3 Sep 2012 19:56:53 +0530
Message-ID: <CAMK1S_jL-U_U8BcEaiTqgy3Z+KvsvmfUoz8GkCkDjQJafgY_zw@mail.gmail.com>
References: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
	<CACBZZX7Pe5gsfpFTihE33a1Exia_4dbMQ9p_Xc_z4Ry=Et9KLA@mail.gmail.com>
	<alpine.LFD.2.01.1209031351200.5945@sys880.ldn.framestore.com>
	<20120903180832.f6e9fc03a450011ea2b22737@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Hills <Mark.Hills@framestore.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Sep 03 16:27:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8XcE-0002eg-MR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 16:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab2ICO0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 10:26:55 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53348 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129Ab2ICO0z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 10:26:55 -0400
Received: by lbbgj3 with SMTP id gj3so2507201lbb.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k279r9k7sbAXrvgNMRfctw3PdR7RPGelJlpLujqm6Rs=;
        b=V+UCC0ofP9bZtywI2HlF/g+iy4IC0yPG8GzTfEk4LgPvCGkfe6aI2ecC5/BiTDuopJ
         olYkdpWbgP3ISiORfZoHbdEYjhwJGi909S2Hc9iSHeeJ3J0cp+28LYPa8symgei8oooQ
         5oJjU4K9G9TXSOtlg+H1mM6lOQTRD/MOAZFZ/695A441ky4bKDB67qM3m7GOPZeqNwL/
         OHjXb2q8SjXQOqdyFNWqieoq06uzSI1CO/bMLa+Wg34Fztw72J+O0RbDVKCP4oILr3Lp
         nbe0WKeFSxXDKwTZKq2In3HCqKJ9//rp2CN4TrPqlcYJjeK2diVPDbXfNFMJewlUhNRq
         24ww==
Received: by 10.112.83.35 with SMTP id n3mr5295824lby.68.1346682413344; Mon,
 03 Sep 2012 07:26:53 -0700 (PDT)
Received: by 10.112.129.227 with HTTP; Mon, 3 Sep 2012 07:26:53 -0700 (PDT)
In-Reply-To: <20120903180832.f6e9fc03a450011ea2b22737@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204697>

On Mon, Sep 3, 2012 at 7:38 PM, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Mon, 3 Sep 2012 14:07:48 +0100 (BST)
> Mark Hills <Mark.Hills@framestore.com> wrote:
>
> [...]
>> > But I'm actually more curious about why you need this in the first
>> > place, there's a bunch of devs where I work as well, but they never
>> > have the need to create new repos on some NFS drive in this manner.
>>
>> Without a command-line onto the filesystem (either local or NFS), how
>> do you create a new repository for a new project?
>>
>> We have a fairly large team on a diverse set of projects. Projects
>> come and go, so it's a burden if the administrator is needed just to
>> create repos.
>>
>> Likewise, it's a step backwards for the developer to need to login
>> themselves over SSH -- whereas 'git clone' is so easy to NFS.
>>
>> > What are your devs doing when they do clone their current working
>> > directory to some NFS location, maybe there's a better way to do it.
>>
>> Most projects start as a small test at some point; eg.
>>
>>   mkdir xx
>>   cd xx
>>   git init
>>   <write some code>
>>   git commit
>>   ...
>>
>> When a project becomes more official, the developer clones to a
>> central location; eg.
>>
>>   git clone --bare . /net/git/xx.git
>>
>> This is the step that is inconvenient if only SSH access is available.
>
> Well, then it looks you want something like github.
> In this case look at some more integrated solution such as Gitlab [1]
> -- I did not try it, but it looks like you import your users there and
> then they can log in, add their SSH keys and create their projects.

Anything web based would be even more overhead than a simple:

    ssh server git init --bare foo/bar.git && git push --mirror
ssh://git/~/foo/bar.git

Gitolite of course is even closer, as we discussed earlier.

> I also think gitolite has some way to actually use regular SSH users
> (or even users coming from a web server which is a front-end for Smart
> HTTP Git transport, doing its own authentication).  This is explained
> in [2], and I hope Sitaram could provide more insight on setting things
> up this way, if needed  (I did not use this feature).

As I said earlier, regardless of how he does it, authentication will
change, since he is no longer using a local (well, locally mounted)
file system as the "server".  That may be "get everyone to send us a
pub key" or "give everyone an http password and use smart http".

In addition, if they choose smart http, they *have to* use gitolite.
Unlike ssh, where that two command sequence above would do it all for
them, there is no eqvt if your git server is behind http.

>
> 1. http://gitlabhq.com/
> 2. http://sitaramc.github.com/gitolite/g2/auth.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Sitaram
