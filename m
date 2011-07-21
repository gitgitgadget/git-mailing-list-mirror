From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git-archive and tar options
Date: Thu, 21 Jul 2011 11:59:23 -0500
Message-ID: <4E285AEB.8090603@gmail.com>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net> <4E2477E1.5090406@gmail.com> <4E249C94.3040002@lsrfire.ath.cx> <4E24CBFD.9090909@gmail.com> <4E25C54D.2070007@lsrfire.ath.cx> <4E278B34.70300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Neal Kreitzinger <neal@rsss.com>,
	git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Jul 21 19:00:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjwbE-00032w-AB
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 18:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab1GUQ7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 12:59:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40194 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab1GUQ7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 12:59:39 -0400
Received: by ywe9 with SMTP id 9so751233ywe.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4dqJrV88Xcy6rc8JvlnMZcnB0VQPlxrQGMzTBHCodts=;
        b=VOkkdXzbJPsGNhyx5nMiG5kuxUpUADVnQ/SFJvGCJr1U9U059BcmFkQut1y7NWB+JW
         +3HBAECFD4Fl5cI7o0blhspR/QCB4eRdcFNb2Fw0Om3VyDa8nLB4C129yB303QJfz8pi
         X0SkLqxB6dTVtb4xH1f/QqWuWPen7cbPY1d/Y=
Received: by 10.100.237.7 with SMTP id k7mr554435anh.42.1311267578230;
        Thu, 21 Jul 2011 09:59:38 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id k5sm1765398ang.0.2011.07.21.09.59.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 09:59:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4E278B34.70300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177583>

On 7/20/2011 9:13 PM, Neal Kreitzinger wrote:
> On 7/19/2011 12:56 PM, Ren=C3=A9 Scharfe wrote:
>> Am 19.07.2011 02:12, schrieb Neal Kreitzinger:
>>> On 7/18/2011 3:50 PM, Ren=C3=A9 Scharfe wrote:
>>>> Am 18.07.2011 20:13, schrieb Neal Kreitzinger:
>>>>> However, the permissions also need to change to 777 and tar
>>>>> --mode would not effect this in combination with --catenation
>>>>> or -x. Is there a way I can change the permissions without
>>>>> having to untar->chmod->retar, and without having to use a
>>>>> non-bare repo as an intermediary?
>>>> You can use the configuration setting tar.umask to affect the
>>>> permissions of the archive entries. Set it to 0 to pass the
>>>> permission bits from the repo unchanged.
>>>>
>>> The permissions in my repo are 775 and 664 and I want to change
>>> them to 777.
>> Git doesn't store all permission bits. If a file is marked as
>> executable then you get 777, otherwise 666 -- minus the umask,
>> which is 0002 by default. So in order to achive rwx permissions for
>> all in the archive, you need to A) mark the files as executable in
>> the repository and B) set tar.umask to 0 to get allow the world to
>> write.
>>
>> However, what's the reason for requiring this lack of access
>> control? Why o+w?
> tar.umask worked. Thank you for explaining how the permissions work
> in this context. I now see that 775 and 664 would work for the apache
>  component and for executing our binaries. Thanks for pointing this
> out. However, another element of our application is a proprietary
> runtime that runs on top of linux and runs our core binaries. This
> allows us to store our binaries in git and deploy them directly on
> the customer server from git (via git-archive). That runtime needs
> o+w in order to update the 'last run date' in the binary which is
> critical to our troubleshooting in the field. o+w is needed because
> the user's runtime instance runs with user permissions when executed
> from a linux command line terminal and our users are not setup in the
> same group as the binaries. Therefore, with tar.umask =3D 0000 I can
> deploy 777 and 666 permissions and everything will work.
>
> I suppose I could write a script to change the tar.umask entry to
> 0000 only when running git-archive for the binary portion, and use
> tar.umask 0002 when extracting the other portions. I could also
> change our setup to put the users and the runmodules in the same
> group and use tar.umask 0002 across the board. These would be more
> correct than the chmod 777 shotgun that we currently use to blast
> away our permissions problems.
>
> git-archive is a "quick" solution to our immediate deployment needs.
>  Eventually, I plan on using git on the source and target machines as
> the core mechanism to "promote to production" (ie. deploy to customer
>  servers). It looks like others are using git for deployment also. In
> my previous shops which used other VCS's on minicomputers and
> mainframes, "promote to production" meant the universal run path for
> all users (and especially for productional data transactions) on that
> central machine. In my current shop (my first linux shop) we have
> multiple concurrent versions of production on a multitude of
> productional machines and even concurrently on an individual
> productional machine in some cases. The main reason we chose git is
> because it is the only VCS that can handle this.
>
Actually, the apache user (web interface) also needs to be able to
update the binaries with 'last run date'. In this context the o+w allow=
s
this, also.  I don't know enough about apache and permissions to try an=
d=20
add apache to the same group as the binaries at this point.

-neal
