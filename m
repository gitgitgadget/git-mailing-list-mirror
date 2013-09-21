From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sat, 21 Sep 2013 17:52:05 -0500
Message-ID: <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Sep 22 00:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNW2A-00051a-57
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 00:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab3IUWwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 18:52:09 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:58563 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab3IUWwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 18:52:07 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so1652346lbi.32
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0T1Zcm3rG2LgqbF8stnIMFFpTiy4bhBMSFEVn8IT1jU=;
        b=uOX3pE5wJIAeQB4t04GERHNQmSAz0Vn3kkaXj6lPvbC8TNUY0YPtDn1OrGd9Rn9Jhz
         DucrUSegeyhoj3P9Zjs5KG8rN3kr2rKTb7dgfYbHPNJxYp03AONdBqlPfctWaSh3LCfw
         V/lojv03pZSfGDRo+6zvwF1CqdtIK3jTAQRpSL8+MBGQnfISxQ84aJp+xI4MxAzRDMd9
         VJ22QPlbBS1uvLuYv253t39Bg6FznMFx12xg7inGrWQ1w/CHAkeC0l7NT6S06FPRLjQh
         e3SyiUuLvc9ugpLq3gpYiReAJHeY7W5Qv0cBjMTVfwPdUc6yK7nLsnAQvls2I7m5US4s
         WkgA==
X-Received: by 10.152.44.225 with SMTP id h1mr12827968lam.15.1379803925255;
 Sat, 21 Sep 2013 15:52:05 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 21 Sep 2013 15:52:05 -0700 (PDT)
In-Reply-To: <20130921212904.GA235845@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235150>

On Sat, Sep 21, 2013 at 4:29 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sat, Sep 21, 2013 at 01:48:08PM -0500, Felipe Contreras wrote:
>> Hi,
>>
>> It was discussed before that there was a need to replace Git scripts
>> from perl and sh that utilize the 'git' binary to do everything they
>> need, which requires many forks, and that creates problems on
>> platforms like Windows.
>>
>> This is a first step meant to show how a solution using Ruby would look like.
>>
>> Other alternatives just don't cut it. Shell scripts are too simple, and
>> invariably require forks. Perl could use Git's internal C code, but it's syntax
>> is too cumbersome and it's loosing more and more popularity. Python and Ruby
>> are the only modern languages that could fit all the needs, but Python's syntax
>> is not ideal, specially considering the background of the Git community, and
>> also, Ruby's C extensibility is simply superb.
>>
>> This patch series introduces Ruby bindings for Git's C internal library, and
>> add example commands to show how it could be used, and how it resembles the
>> original C code, shell code, and perl code. Basically, Ruby fits like a glove.
>
> A couple of things: first, I'm not opposed in principle to using Ruby
> for git.  As you say, it's a good language and it has much nicer C
> bindings.
>
> As Junio has also pointed out in the past, there are people who aren't
> able to use Ruby in the same way that they are Perl and Python.  If it's
> announced now, Git 2.0 might be a good time to start accepting Ruby
> scripts, as that will give people time to plan for its inclusion.

Yes, and there are people who aren't able to use Perl/Python in the
same way they use Ruby. That's why I tried to show why Ruby makes a
perfect choice.

> On a more technical note, my objection to your binding implementation is
> that fundamentally, Ruby is an object-oriented language, but your
> bindings don't take advantage of that; they're completely procedural.  I
> realize most of the git codebase is as well, but that's because it's
> written in C.  It seems a shame not to take advantage of what the
> language offers, especially since I know others are going to want to
> take advantage of the provided bindings.

For the moment the bindings are only for Git commands, so the primary
users are Git developers, that's why I tried to leave them close to
the current C/shell/perl code.

Having said that, it does use a little bit of object-oriented stuff:

  commit = lookup_commit_reference(sha1)
  p commit.buffer

Now, if anybody has ideas into how the bindings could be more object
oriented, I'm all ears, but unfortunately what I foresee is that
nobody will consider this proposal seriously.

Cheers.

-- 
Felipe Contreras
