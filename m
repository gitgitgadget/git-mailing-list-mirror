From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Fwd: Uninit'ed submodules
Date: Tue, 07 May 2013 20:01:04 +1200
Message-ID: <5188B4C0.50206@gmail.com>
References: <CAFOYHZCfL2uqnUkb=7kSdpudKvYrfMo9saJ8eNsj5mYDQgHVuA@mail.gmail.com> <CAFOYHZDKTYFNRHUwdas7kZKs8UbdrY=hAA0SVqbz48NjWsHKww@mail.gmail.com> <51880191.2070809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue May 07 10:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZcon-0003Vm-O3
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 10:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342Ab3EGIAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 04:00:06 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:48804 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3EGIAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 04:00:05 -0400
Received: by mail-da0-f53.google.com with SMTP id o9so187079dan.40
        for <git@vger.kernel.org>; Tue, 07 May 2013 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Bo9rYue9iRVqYqB975rHydHpEKERDb0zKYUd7aVbK+c=;
        b=Hz9ACiDJcQ6tkZ2a9pf5MfxgQWae7mVLYkInxN7Z+JedgbWX55NsHXfZt6NyLpHI1M
         C3EGXLCvLWH+TEvlKrBZblGiQJPacYzLnbEzMxXikFLXU04I792jXCNJdf1yAbAl9QRP
         SDZudD9DJGLOgyxeH5gPUuuyvfSlPnHL4qvVnedIsUjV79AzHx3dvlaijW2rKgCCicza
         TgckelVkx4p3RVIlWHLjM/OkY+HdEszrE6g4IYCubRtOesb9BSUjeb8zU9Mwfuj9mLRR
         JxByftrCX3tKGBNFh3+RKFLwXIZ9Qo66Qgi9dHesm0fjrp4XDzxBXyhIdDwGpu6Q+e9I
         37Bw==
X-Received: by 10.68.195.234 with SMTP id ih10mr1036282pbc.162.1367913604037;
        Tue, 07 May 2013 01:00:04 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id fx2sm29336788pac.4.2013.05.07.01.00.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 May 2013 01:00:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <51880191.2070809@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223566>

On 07/05/13 07:16, Jens Lehmann wrote:
> Am 06.05.2013 02:19, schrieb Chris Packham:
>> This did get me thinking. Why does an uninitialized submodule need to
>> have an empty directory? If it didn't the maintainer in question
>> probably would have realized that he needed to run "git submodule
>> update --init" when his "cd submodule" command failed.
>>
>> I'm guessing there is a good reason for the empty directory - perhaps
>> so that git can notice the fact that it exists in the worktree but is
>> out of date?  If it does need to have some presence in the worktree
>> why not as a file? That way the cd command would still fail (albeit
>> with a different error) providing the necessary indication to the
>> user. The submodule update --init could then change from file -> dir
>> when it actually gets populated.
> 
> Hmm, to me an empty directory is the natural representation of an
> unpopulated submodule, but I see why that made it hard for your
> maintainer to notice the fact that the submodule was uninitialized.
> I suspect changing an unpopulated submodule to be represented by a
> file will surprise quite some users (some of which will probably
> come up with perfectly valid use cases such a change will break).
> 
> What about the following: Today's Git completely ignores empty
> submodule directories, but I think that when the recursive checkout
> support is there, the "submodule.autoupdate" flag - which I believe
> should control that behavior - could also make those empty submodule
> directories show up in "git status" as being unpopulated (after all
> they are configured to be updated automatically, so not having them
> populated is something Git should show). Would something like this
> have helped here?
> 
> Until then I can only propose to establish a best practice of using
> "git clone --recurse-submodules" in these situations to avoid the
> problem you described.
> 

Yeah I think training people to use --recurse-submodules is probably the
best thing we can do with the current version of git on our developers
work stations. There is a bit of an issue when we add a new submodule
(people aren't used to using submodule update --init), but that isn't a
frequent occurrence.

The recursive checkout sounds like something we'd benefit from.
