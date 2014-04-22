From: Dan Porter <dpreid@gmail.com>
Subject: Re: Fwd: git p4: feature request - branch check filtering
Date: Tue, 22 Apr 2014 10:29:19 +0100
Message-ID: <CADtnS+w9q0dmnGsZoDr12GZ-RSZzcfPs6rfii-4eK7Hhn2byag@mail.gmail.com>
References: <CADtnS+zWzPY6ftwxWUE+Gb-OKq_Kzf9y+fFfgJ-demWyX3azCg@mail.gmail.com>
	<CADtnS+weco6Lvk3hHuM7BcaRsvMkeDCmqH26s19TrgWvBYXAvA@mail.gmail.com>
	<20140223151247.GA1272@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 11:32:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcX17-0002R0-15
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 11:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbaDVJ3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 05:29:24 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45209 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbaDVJ3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 05:29:20 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so4963111iec.37
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sYmQo6KX3OtbOh1C8IUs3IYGfCGsZaswQtCzb2j+FpA=;
        b=vS+LJ5psBb6pn123UbG7UkTFhz7MqV9KXHlABnkDUcMOyhm6WO4G3Uj8sk9aoVUKoe
         E4VY/CwPYUMjEHwlm4enpH8Pp6+OoqaLjVJ3Z+6GtiF1Y2TCcPDE/9WFBNTOuwz4mTVA
         8T+96qlb0ToSvv+IHpG2Yoj2vg+ri2BOtZJZPAY8lCEOi7Eyuob5BpqQcOW90uU/ymIk
         7EdMdySBwIYYO6fLbvb2lfcs1wMQ6MsgQmOHQA5UJu/09dNoqCe97Ewm6XqyuEA2Qa0s
         AVo4JtRTmVAUiDO2P/zV9kmvhu8Uldr05/JHIbZfL2+wUsT/l+wnViB9fJjWCKvxmjyu
         HAKQ==
X-Received: by 10.50.28.84 with SMTP id z20mr28199090igg.0.1398158960044; Tue,
 22 Apr 2014 02:29:20 -0700 (PDT)
Received: by 10.64.28.233 with HTTP; Tue, 22 Apr 2014 02:29:19 -0700 (PDT)
In-Reply-To: <20140223151247.GA1272@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246722>

Hi Pete,

I should have updated on this earlier, but I wished to refine my work
on this feature before submitting.  With 2.0 looming I'll submit
what's there so far.

There is a patch viewable at this link:
https://github.com/Stealthii/git/commit/f7a2e611262fd977ac99e066872d3d0743b7df3c

For the use case this works perfectly - if I define branch mappings
with git config, followed by setting 'git-p4.skipBranchScan' to true,
git-p4 will skip scanning of all remote branches and limit to what's
defined in the map.  An example config:

[git-p4]
        skipBranchScan = true
        branchList = release_1.0.0:release_1.1.0
        branchList = release_1.1.0:release_1.2.0

If there is any more information I need to provide let me know. I have
been using this patch for over two months, testing both use cases with
and without git-p4.skipBranchScan and I have noticed no issues.  Logic
of git-p4 is not changed from default behaviour, unless the user
explicitly sets the boolean flag to skip scanning.

Dan


This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager. This message contains confidential information and
is intended only for the individual named. If you are not the named
addressee you should not disseminate, distribute or copy this e-mail.
Please notify the sender immediately by e-mail if you have received
this e-mail by mistake and delete this e-mail from your system. If you
are not the intended recipient you are notified that disclosing,
copying, distributing or taking any action in reliance on the contents
of this information is strictly prohibited.


On 23 February 2014 15:12, Pete Wyckoff <pw@padd.com> wrote:
> dpreid@gmail.com wrote on Tue, 18 Feb 2014 12:42 +0000:
>> I work at a company that has recently moved all CVS, SVN, and git
>> repositories to Perforce.  Depots have not been setup correctly in
>> every case, and there is one depot that contains literally hundreds of
>> projects under commercial development (and hundreds of branches as a
>> result)
>
> My condolences.
>
>> My project may be in //stupid_depot/commercial/teamporter/rok.  This
>> is the path I clone with git-p4.  The only branches in this depot that
>> contain files at this path are titled as
>> 'rok_porter_branch/release_1.x' or similar.
>>
>> When using '--detect-branches' git-p4 checks each key of branches to
>> see if any of them have files in the path I've cloned.  Whilst this is
>> good in practice there is unfortunately 6,809 branches, git-p4
>> processes about 2 a second and just under an hour to perform any
>> git-p4 rebase, submit, or similar operation.
>
> This is in getBranchMapping() presumably.  Where it loops
> over each branch doing "p4 branch -o".  Yuk.
>
> You could always avoid the --detect-branches if you don't really
> need it, instead doing, say, multiple "git p4 sync" for the
> different areas of the repo that interest you, each with its own
> destination branch in git ("p4/depot-part1", "p4/depot-part3",
> ...).  Or --use-client-spec to cobble together an exact mapping
> of where p4 files should land in git, all in a single git branch
> then.
>
>> I propose the addition of a branch list filtering option
>> (--filter-branches) that takes either a regular expression or list of
>> branches it should check.  This may be useful in sane situations where
>> you don't want to scan every branch in a Perforce repository, or
>> blacklist branches that have undesirable content (for example, one of
>> the branches is called 'svn-backup'.  It contains a single, multi-GB
>> tarball.)
>
> There is the existing git-p4.branchList option that explicitly
> adds (or overrides) branch information, beyond the ones auto-discovered.
>
> You might be able to use that option, but change its behavior
> to avoid the scan.  So that if that option is set in the config,
> p4 is not asked anything about its branches.  Not sure if this
> would break anyone's setup though.
>
> Another approach would be to add a config option
> git-p4.branchScan that defaults to True.  You could turn it off
> and use branchList.
>
>> It would be ideal to have this information (after initial clone or
>> sync) stored somewhere in the git config where is appropriate so that
>> future submit/rebase operations adhere to this list.
>>
>> Has something like this been worked on, or has been considered in the
>> past?  If not I will consider implementing this after reading up on
>> the Git code guidelines.
>>
>> Thanks for keeping the Git workflow accessible in painful areas.
>
> It would be great if you could get something like this to work.
> Start in getBranchMapping() and don't forget to write up your
> work in Documentation/git-p4.txt.  Also, this is sort of a messy
> area of the code, unfortunately.  t/t9801 tries to make sure some
> of it keeps working.
>
>                 -- Pete
>
