From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Tue, 26 Mar 2013 13:27:14 +0530
Message-ID: <CALkWK0mXOHGJHQ85mMuoUyzti6b2QoijN1EEFzpJ+TKm3tWnXg@mail.gmail.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <51500C67.9040308@web.de> <CALkWK0kJ2QVA6is85Sdwn1mnGVbuNUSGqg_37WBxPYrepHz9ow@mail.gmail.com>
 <51509ABA.3040804@web.de> <CALkWK0mAkabTNrBjvv4s_YfTN9j2_Aros=7ZcF7j=KAjJE-yaw@mail.gmail.com>
 <5150D655.8000204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 08:58:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKOlf-0002zF-26
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 08:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759497Ab3CZH5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 03:57:35 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55422 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab3CZH5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 03:57:35 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so5436767iec.5
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XPcYFUbaeSFUyoUHR5wHpweBVgCc5a6ZKlK6vCtIQBo=;
        b=hkzaCQTaTIAgYGyDOkbCSZAzFMNuZXHXOsVLr95yLqRrIHJgVZWwyxNSn8oBH+qny8
         lUTpHtPpU1KGDOjdppkDqrVkNxoXZrvoRGwCz0zyB4dypih29gslItBZzSRAba8UvINv
         p4CntngdLh+g5YNNmIXZqWOSkEBNvreal5G/lxB192oBNkTsSj7Gw0hOcCNtd6qEL0rw
         tUi4b0HbfHx06vFBW5HiuYVtEQn/JmTRiBYqB15Zo0PW4UK84241qzzenm7ace9Ph19Z
         J0FlqqRSg4DQ7jfxsNNASnecAZqrUDTPVAbtEAZE4rb2YsBXCP/fNW//vJKwQVazjr9I
         0G9Q==
X-Received: by 10.50.17.71 with SMTP id m7mr721295igd.14.1364284654862; Tue,
 26 Mar 2013 00:57:34 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 26 Mar 2013 00:57:14 -0700 (PDT)
In-Reply-To: <5150D655.8000204@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219142>

Jens Lehmann wrote:
> Am 25.03.2013 20:57, schrieb Ramkumar Ramachandra:
>> Doesn't that sound horribly crippled to you?  Is there any advantage
>> to leaving the .git directory inside the submodule?  Isn't it always
>> better to relocate it?
>
> It's not crippled at all, that is just the way it was from submodule
> day one. And no, it isn't always better to relocate it. E.g. when
> you want to be able to just tar away work tree and history someplace
> else because you don't have (or don't want) an upstream to push to,
> you'd be very surprised a "submodule add" moved your .git directory
> someplace else effectively nuking the backup of your history and
> refs (guess under what circumstances you'll notice that). While I
> believe most submodule users would benefit from such a relocation, I
> consider the other use cases as valid and we would introduce silent
> breakage on them. On the other hand I made all relevant commands
> complain loudly about the .git directory in the submodule's work
> tree when it matters, so users can do something about it when they
> need it and are told so.

I see.  Thanks for the explanation.

>> Why a new subcommand?  Is there a problem if we do the relocation at
>> the time of 'add'?  Will some user expectation break?
>
> For me relocation at the time of 'add' would be ok with a new option
> (and it might also make sense to have a config option changing the
> default for users who want that), but not as the default.

Makes sense.  This seems trivial to implement: I'll get to work on it soon.

> And leaving aside 'add', there are tons of submodules out there
> which were cloned with older Git who have their .git directory
> inside the work tree. So a new subcommand (or at least a helper
> script in contrib) to relocate the .git directory would really help
> here to migrate these legacy submodules without users having to
> worry about data loss.

The question is: after using a "non-relocated submodule" for some
time, will the user suddenly decide to make it a "relocated submodule"
one day?

>> I meant a variant of add that would clone, but not stage.  I was
>> arguing for a new subcommand so that I don't have to touch 'submodule
>> add', not for a rename.
>
> Ah, now I get it, I was confused by your reference to 'git submodule
> add <repository> <path>'. I have to admit I still don't understand
> the use case you have for adding a submodule without staging it, but
> maybe it is just too late here.

I usually reset after running 'git submodule add', because I rarely
commit the added submodule immediately after adding it.
