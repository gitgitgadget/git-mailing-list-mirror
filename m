From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Sparse checkout not working as expected (colons in filenames on Windows)
Date: Tue, 24 Mar 2015 23:50:25 -0000
Organization: OPDS
Message-ID: <90D5D4B5F2ED41A6AB07E291004AA615@PhilipOakley>
References: <BE2660C974C9415E997F20A49ABC766E@PhilipOakley> <CACsJy8BOuhohQzaGzD+4cthqOaL4sz1ADRD-ekhFhKt4wMcg7A@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Yue Lin Ho" <yuelinho777@gmail.com>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:49:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaYZZ-0006E0-M1
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 00:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbbCXXtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 19:49:21 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:52931 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103AbbCXXtU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 19:49:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DfGQCB9xFVPHgvBlxcgwZSWoMShBq/I4VtBAKBTE0BAQEBAQEGAQEBATggG0EBg00FAQEBAQMIAQEZFR4BASELAgMFAgEDDgcDAgIFIQICFAEECBIGBwMGAQ0GEwgCAQIDAYgKAxUJrmWGU411DYVEDBwEgSGKAIJHgi+Cby+BFgWQUGGDDoQzgmiMHEyGKYIkHIFQPjGCQwEBAQ
X-IPAS-Result: A2DfGQCB9xFVPHgvBlxcgwZSWoMShBq/I4VtBAKBTE0BAQEBAQEGAQEBATggG0EBg00FAQEBAQMIAQEZFR4BASELAgMFAgEDDgcDAgIFIQICFAEECBIGBwMGAQ0GEwgCAQIDAYgKAxUJrmWGU411DYVEDBwEgSGKAIJHgi+Cby+BFgWQUGGDDoQzgmiMHEyGKYIkHIFQPjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.11,461,1422921600"; 
   d="scan'208";a="139307700"
Received: from host-92-6-47-120.as43234.net (HELO PhilipOakley) ([92.6.47.120])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 24 Mar 2015 23:49:17 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266240>

From: "Duy Nguyen" <pclouds@gmail.com>
> On Fri, Mar 20, 2015 at 6:07 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> Hi, I was expecting that sparse checkout could be used to avoid the 
>> checking
>> out, by git, of files which have colons in their name into the 
>> worktree when
>> on Windows.
>>
>> Yue Lin Ho reported on the Msygit list [1] that he had a repo where 
>> there
>> was already committed a file with a colon in it's name, which was a 
>> needed
>> file and had been committed by a Linux user. The problem was how to 
>> work
>> with that repo on a Windows box where such a file is prohibited to 
>> exist on
>> the FS (hence the expectation that a sparse checkout would suffice). 
>> Yue has
>> created a short test repo [2]
>>
>> Even after getting the pathspec escaping right, I still haven't been 
>> able to
>> make this expected behaviour work [3].
>>
>> Am I wrong to expect that sparse checkout (and the skip-worktree bit) 
>> can be
>> used to avoid files with undesirable filenames hitting the OS's file 
>> system?
>>
>> If it should be OK, what's the correct recipe?
>>
>> --
>> Philip
>>
>> [1]
>> https://groups.google.com/forum/?hl=en_US?hl%3Den#!topic/msysgit/D4HcHRpxPgU
>> "How to play around with the filename with colon on Windows?"
>> [2] Test repo https://github.com/t-pascal/tortoisegit-colons
>>
>> [3] test sequence::
>> $ mkdir colons && cd colons
>> $ git clone -n https://github.com/t-pascal/tortoisegit-colons
>> $ cd tortoisegit-colons/
>> $ git config core.sparseCheckout true
>> $ cat .git/info/sparse-checkout # external editor
>> /*
>> !ifcfg-eth0\:0
>
> Colons have no special meaning in gitignore rules and therefore need
> not be escaped. The backslash is considered a literal character in
> this case, probably not what you want.
>
>> $ git update-index --skip-worktree -- ifcfg-eth0\:0
>> Ignoring path ifcfg-eth0:0
>> $ git checkout -b test 7f35d34bc6160cc # tip commit, we are still 
>> unborn!
>> error: Invalid path 'ifcfg-eth0:0
>> D       ifcfg-eth0:0
>> Switched to a new branch 'test'
> -- 
I've corrected the sparse-checkout, but won't the command line 'git 
update-index --skip-worktree' will still need it? (demo commands below)

That said, the final error (which I'd missed in the earlier post) is:
fatal: make_cache_entry failed for path 'ifcfg-eth0:0'

This is on the Windows (pre-compiled msysgit at v1.9.5) Git bash, so 
could be a catch path in that code for make_cache_entry (I've not 
checked the code yet). So at the moment it doesn't look like sparse 
checkout can be used to avoid colons in windows on-disk files based on 
the current code.
--
Philip

Philip@PHILIPOAKLEY /d/Git_repos/colons
$ cd tortoisegit-colons/

Philip@PHILIPOAKLEY /d/Git_repos/colons/tortoisegit-colons (test)
$ git update-index --skip-worktree -- ifcfg-eth0\:0
Ignoring path ifcfg-eth0:0

Philip@PHILIPOAKLEY /d/Git_repos/colons/tortoisegit-colons (test)
$ git reset
error: Invalid path 'ifcfg-eth0:0'
fatal: make_cache_entry failed for path 'ifcfg-eth0:0'
