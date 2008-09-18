From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Help planning a git repo layout
Date: Thu, 18 Sep 2008 16:25:08 +0300
Message-ID: <48D256B4.90006@panasas.com>
References: <938E7E5C-4FCB-4131-A5C4-254CEEC70673@leevigraham.com> <48D24002.70709@panasas.com> <076A189D-66E9-4683-9C24-1C0A7A451892@leevigraham.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Leevi Graham <info@leevigraham.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 15:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgJWx-0001TZ-Mp
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 15:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbYIRNZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 09:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbYIRNZS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 09:25:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7928 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423AbYIRNZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 09:25:16 -0400
Received: by nf-out-0910.google.com with SMTP id d3so2011060nfc.21
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=zOQw6k1YO6WLRDcza34dxXOqnSfkP3/KkevkxhLqTYQ=;
        b=cdF77e+JUiySYahmzMf5GHY1eysrvZp/TwQNeLxwhByCOV6awHQvch7yg7KfgCS5AV
         3G5hJNFaXcMtakE2YMKsCXNcGuoOdJynq36HK1btzQ/ZHNp1vypoZTrqmF4VEk/RbGRx
         rjR7qRuq3+CZsPINnwH6zn/TpRfU2orynTAhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding:sender;
        b=Da+48VIyV8LXjgBW/mX6bkdZj/CpAOoIC3OiBPo9oJrMlyRbc+MHtBXVxWgTKoGLeJ
         kH38XXzG4p3B1BEfx/4+OlwLWGN+8ZpzUy7tqVRo4WCCuiE8DmX1x+wWiPJBbu2k4VLH
         cNxhzYAPgZ8k1r9yl4ac4kahEYVr/s4LnClxo=
Received: by 10.210.51.10 with SMTP id y10mr3445195eby.14.1221744313920;
        Thu, 18 Sep 2008 06:25:13 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com ( [212.235.53.3])
        by mx.google.com with ESMTPS id 20sm25710882eyc.9.2008.09.18.06.25.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 06:25:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <076A189D-66E9-4683-9C24-1C0A7A451892@leevigraham.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96196>

Leevi Graham wrote:
> Thanks for the advice Boaz,
> 
> So to clarify:
> 
> Create a new git repo in the root of the EE install. This will be the  
> master branch.
> 
> Then create branches (from the master branch) for each addon (product  
> branches) that only shows the files that relate to that addon. How do  
> I filter out the files I don't want to see?
> 
> Work on each product branch independently merging as I go.
> 
> Occasionally merge everything back into the master branch so I know  
> that there are no conflicts with the product branches.
> 
> I think I have it pretty clear in my head.
> 
> Thanks for your patience and help
> 
> Leevi

NP. Please don't top-post when on a mailing list. It's good
when chatting with individuals, but it is a mess, for people
that need to view it on a mailing list archives.

Basically yes. You start with master and commit some basic/common
files like:
$ git add .gitignore; git-commit ...
$ git tag BEGIN
then create a branch
$ git checkout -b foo
selectively add files
$ git add foo/ include/foo doc/foo
$ git-commit
You might want to add all these in a set of patches for readability.
Then
$ git-checkout -b bar BEGIN
Note that all foo's files vanished
$ git add bar/ include/bar ...
$ git-commit ...
and so on...

Then at the end
$ git-checkout master
Note that all files have vanished
$ git-merge foo
$ git-merge bar
All the files are back

then you can clone locally to trees, one with foo checked-out,
one with bar, if you need to commit to both at once. Then push
and merge at master

Good luck
Boaz

> 
> On 18/09/2008, at 9:48 PM, Boaz Harrosh wrote:
> 
>> Leevi Graham wrote:
>>> Hey everyone,
>>>
>>> I'm after some advice on how to layout my git repo(s).
>>>
>>> Here's my current situation:
>>>
>>> I am developing 10 different ExpressionEngine addons that all live
>>> inside one ExpressionEngine installation. A simplified EE  
>>> installation
>>> has the following folders (all cruft removed):
>>>
>>> |-root
>>>   |-ee-admin
>>>   |---extensions
>>>   |---language
>>>   |---modules
>>>   |-themes
>>>   |---site_themes
>>>
>>> My addons are a combination of files located in the extensions,
>>> language, modules and themes folders. An simple extension may look  
>>> like:
>>>
>>> |-root
>>>   |-ee-admin
>>>   |---extensions
>>>   |-----ext.lg_data_matrix.php
>>>   |---language
>>>   |-----english
>>>   |---------lang.lg_data_matrix.php
>>>   |---modules
>>>   |-themes
>>>   |---site_themes
>>>
>>> The extension above contains two files:
>>>
>>> - /ee-admin/extensions/ext.lg_data_matrix.php
>>> - /ee-admin/language/english/ext.lg_data_matrix.php
>>>
>>> I will be developing multiple extensions in the one EE install to  
>>> make
>>> sure they all work with the core and do not conflict with each other.
>>> So my directory will have more than one addon in it:
>>>
>>> |-root
>>>   |-ee-admin
>>>   |---extensions
>>>   |-----ext.lg_data_matrix.php
>>>   |-----ext.lg_minify.php
>>>   |-----ext.lg_better_meta_ext.php
>>>   |---language
>>>   |-----english
>>>   |---------lang.lg_data_matrix.php
>>>   |---------lang.lg_minify.php
>>>   |---------lang.lg_better_meta.php
>>>   |---------lang.lg_better_meta_ext.php
>>>   |---modules
>>>   |-----lg_better_meta
>>>   |---------mcp.lg_better_meta.php
>>>   |---------mod.lg_better_meta.php
>>>   |-themes
>>>   |---site_themes
>>>
>>> My problem comes when I want to tag and release an individual addon
>>> which is a collection of files in multiple folders.
>>>
>>> Just say I wanted to tag and release LG Better Meta. Ideally I would
>>> like to export a folder structure like:
>>>
>>> - /ee-admin/extensions/ext.lg_better_meta.php
>>> - /ee-admin/language/english/ext.lg_better_meta.php
>>> - /ee-admin/language/english/ext.lg_better_meta_ext.php
>>> - /ee-admin/modules/lg_better_meta/mcp.lg_better_meta.php
>>> - /ee-admin/modules/lg_better_meta/mod.lg_better_meta.php
>>>
>>> I would also like to give people the ability to clone each of the
>>> addons either as a full repo or part thereof.
>>>
>>> Any advice would be greatly appreciated.
>>>
>>> Cheers Leevi
>>>
>> Have branches with individual views of files like the above
>> LG-Better-Meta starts from a clean tree and only adds
>> - /ee-admin/extensions/ext.lg_better_meta.php
>> - /ee-admin/language/english/ext.lg_better_meta.php
>> - /ee-admin/language/english/ext.lg_better_meta_ext.php
>> - /ee-admin/modules/lg_better_meta/mcp.lg_better_meta.php
>> - /ee-admin/modules/lg_better_meta/mod.lg_better_meta.php
>>
>> Other branches with other individual views of files.
>> Commits will have to be on the individual branches.
>> Lets call these product-branches
>>
>> Then you have integration branches that merge from time
>> to time the product-branches, master been the merge of
>> all.
>>
>> Users that only need a single product-branch will checkout
>> that one. Users needing all will checkout master.
>>
>> For your convenience, you can locally clone the master
>> git, and have checkouts of single product-branches so
>> you can commit patches in parallel. Then push and merge.
>>
>> Don't forget to give all empty branches at least one
>> common ancestor before adding files. Like with .gitignore
>>
>> Boaz
>>
> 
