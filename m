From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 22:57:33 +0200
Message-ID: <5421DEBD.1030508@redhat.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>	<5421CAA6.3040107@redhat.com>	<xmqqwq8ui00n.fsf@gitster.dls.corp.google.com>	<5421D900.7060607@redhat.com> <xmqqbnq6hxyt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:05:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWX9f-0008CT-KA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 22:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbaIWU5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 16:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46851 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932211AbaIWU5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 16:57:42 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8NKvbn1005701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2014 16:57:38 -0400
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8NKvYs8025767;
	Tue, 23 Sep 2014 16:57:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqqbnq6hxyt.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257444>

On 09/23/14 22:40, Junio C Hamano wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> On 09/23/14 21:56, Junio C Hamano wrote:
>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>
>>>> What do you think about accepting only "/dev/null\n" and "/dev/null\r\n"?
>>>
>>> I thought we agreed that what you are doing is not workable in the
>>> first place, no?
>>>
>>> I suspect one way to handle "In this project, the files that are
>>> checked out must be with CRLF line endings no matter what the
>>> platform is" might be to use the line ending attributes to force
>>> that while keeping the in-repository data with LF line endings.  The
>>> diff output (format-patch output is just one of them) comes from
>>> comparing the in-repository representation, so you won't have \r\n
>>> that will be stripped via MTA in it, "apply" and "am" will apply the
>>> patch without having to worry about \r\n, _and_ the line ending
>>> attributes would end the lines in your in-working-tree files with
>>> CRLF that way.
>>
>> This would be a perfect solution if the git repository was not a mirror
>> of a Subversion repository that contains all files with embedded CRLFs.
> 
> Yikes.
> 
>> Anyway I accept defeat, thanks for your time.
> 
> I do not consider that a "defeat".  It is just I do not think it is
> the right solution for the problem you are having to butcher "apply".
> You'd need to find some other way to solve it, and other people on
> the list may be able to offer a solution neither of us thought of in
> this thread.
> 
> Perhaps those who are on Windows have more experience in situations
> like yours?

I'm not on Windows, "obviously". :)

The overwhelming majority of the EDK II developers use windows, and
connect directly to subversion. They work with CRLF line endings "natively".

Jordan (CC'd) operates a robot that mirrors SVN commits to the git repo
on github, with "git svn". "git svn rebase --use-log-author" fetches the
new SVN commits to the robots local git clone, and then "git push" (as
usual) pushes them to github. This is being done so that people knowing
git don't lose their sanity, trying to work with SVN.

The process works very well, up to a point (git-loving people clone the
github mirror, and submit patches with git-format-patch / git send-email
to edk2-devel). The problem is when you want to apply patches with
git-am from the list -- the CRLFs are a mess. Hence my thread starter here.

We can get around this by maintaining personal forks on github, pushing
our patches there too in parallel with the email postings. People can
then fetch directly, and avoid git-am altogether. But this is very
cumbersome -- you need a github account, you need an edk2 fork on
github, others need to add your repo as a remote, etc etc, while the
review occurs anyway in our MUAs.

Thanks
Laszlo
