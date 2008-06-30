From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot clone?
Date: Mon, 30 Jun 2008 13:26:10 +0200
Message-ID: <200806301326.12140.jnareb@gmail.com>
References: <200806301149.18115.J.Wielemaker@uva.nl> <m3r6afgrme.fsf@localhost.localdomain> <200806301230.38980.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Wielemaker <J.Wielemaker@uva.nl>
X-From: git-owner@vger.kernel.org Mon Jun 30 13:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDHXW-0000et-CM
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 13:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756950AbYF3L0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 07:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756919AbYF3L0Z
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 07:26:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:58556 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234AbYF3L0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 07:26:24 -0400
Received: by nf-out-0910.google.com with SMTP id d3so422309nfc.21
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iGDknMz+//zMbZ6k4kuBQ73RZ2hXiotV+ywwnZDE2jM=;
        b=Eme8TlodDEyl+9Jbm3C9lO/3xFntON7AdyxqJI4ewqmwMwRlVfyBwZCnGmT2uhF3ab
         MmN26yhP+N7aH55osn8PxqPOsi8uyDNOamaEp6OtAkZPSdZsuKgbNEuAhAhsc2WK9+Wt
         lgMoq9BACBjA+fFOOQ0YxOTC5Lp0vVr9/0MJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pvZhYa6QVEo3lhQALYVDVU6V2R2w7lM3v00rIa+Y6+b4SWWAfz7Lx1zJcgi0nEzwpx
         zjQm9cg5isbrd5/7dZUdadvdn/h8HxwITxT1yXcB0bxg5gGe1U5BE0Evz+TYcmFqDyM8
         p+cQWcZ6fC8CW+PSRFpgBu5pM+6cbelmXWrK8=
Received: by 10.210.87.14 with SMTP id k14mr4070320ebb.60.1214825183051;
        Mon, 30 Jun 2008 04:26:23 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.210.122])
        by mx.google.com with ESMTPS id h7sm1250191nfh.34.2008.06.30.04.26.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 04:26:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200806301230.38980.J.Wielemaker@uva.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86906>

Jan Wielemaker wrote:
> On Monday 30 June 2008 12:10, Jakub Narebski wrote:
>> Jan Wielemaker <J.Wielemaker@uva.nl> writes:
>>>
>>> I'm a bit puzzled. I have a bare repository, somehow without any files
>>> in refs/heads.
>>
>> Do you have .git/packed-refs file?
> 
> Its a bare repo, so I'll forget the .git.  Yes, I have that file and
> it contains nice references,  I checked a few by hand, and they have
> the same SHA1 as the files I copied.

That is where the refs are instead of being in individual files under
refs/ - those are so called "packed refs".

  When a ref is  missing from  the traditional $GIT_DIR/refs hierarchy,
  it is looked up in $GIT_DIR/packed-refs and used if found.

I'm not sure why branches are also packed, because git used to pack
only tags and refs which were packed already.

>> How do you have gc.packrefs set ("git config --get gc.packrefs")?
> 
> This gives no output, so I guess the answer is 'no'.

In git-config(1) you can find the following:

  gc.packrefs::
        `git gc` does not run `git pack-refs` in a bare repository by
        default so that older dumb-transport clients can still fetch
        from the repository.  Setting this to `true` lets `git
        gc` to run `git pack-refs`.  Setting this to `false` tells
        `git gc` never to run `git pack-refs`. The default setting is
        `notbare`. Enable it only when you know you do not have to
        support such clients.  The default setting will change to `true`
        at some stage, and setting this to `false` will continue to
        prevent `git pack-refs` from being run from `git gc`.

Unless something changed (and git Documentation was not updated) git
should not pack refs by default.

>> What are the git version on the
>> clients that have trouble accessing repository, and what protocol
>> (transport method) do they use: "file", http(s)/ftp, git, ssh?
> 
> I could reproduce the problem using the same git that maintains the bare
> repository, which started as git-1.5.3.4 and is now 1.5.6.rc3. It
> reproduces both using local file access and ssh. Other people have a
> variety of versions. I know of concrete problems using the stable 1.5.5
> over ssh.
>
> The problem that I can't even clone is indeed after running a git-gc.

Hmmm... strange. I know that there can be problems with older clients
(those which do not understand packed-refs format) accessing
repositories with packed refs (without loose refs) via "dumb"
protocols.  Problems with accessing repositories locally and via ssh
might point to some troubles with permissions and ownership of
$GIT_DIR and $GIT_DIR/packed-refs.
 
git-gc can pack refs, that is what running it causes problems.

> So, now I have all branch head refs double (in packed-refs and in
> refs/heads). That explains ar least where they come from, but it fails
> to explain why doing exactly the same using the same git on the same
> repo as two users yields a different result. Of course, besides the
> desire to understand how his works, I'm mostly interested in how to fix
> this :-)

Unfortunately as it is not caused by the issue I thought about I cannot
help you further...

-- 
Jakub Narebski
Poland
