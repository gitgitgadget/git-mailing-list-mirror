From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Help planning a git repo layout
Date: Thu, 18 Sep 2008 14:48:18 +0300
Message-ID: <48D24002.70709@panasas.com>
References: <938E7E5C-4FCB-4131-A5C4-254CEEC70673@leevigraham.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Leevi Graham <info@leevigraham.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 14:05:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgIFY-0002gL-7g
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 14:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbYIRMDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 08:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYIRMDe
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 08:03:34 -0400
Received: from gw-ca.panasas.com ([66.104.249.162]:10212 "EHLO
	laguna.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751801AbYIRMDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 08:03:33 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Sep 2008 08:03:33 EDT
Received: from daytona.int.panasas.com ([172.17.28.41]) by laguna.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Sep 2008 04:47:23 -0700
Received: from bh-buildlin2.bhalevy.com ([172.17.28.131]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Sep 2008 07:47:21 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <938E7E5C-4FCB-4131-A5C4-254CEEC70673@leevigraham.com>
X-OriginalArrivalTime: 18 Sep 2008 11:47:22.0098 (UTC) FILETIME=[4FBDB520:01C91984]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96195>

Leevi Graham wrote:
> Hey everyone,
> 
> I'm after some advice on how to layout my git repo(s).
> 
> Here's my current situation:
> 
> I am developing 10 different ExpressionEngine addons that all live  
> inside one ExpressionEngine installation. A simplified EE installation  
> has the following folders (all cruft removed):
> 
> |-root
>    |-ee-admin
>    |---extensions
>    |---language
>    |---modules
>    |-themes
>    |---site_themes
> 
> My addons are a combination of files located in the extensions,  
> language, modules and themes folders. An simple extension may look like:
> 
> |-root
>    |-ee-admin
>    |---extensions
>    |-----ext.lg_data_matrix.php
>    |---language
>    |-----english
>    |---------lang.lg_data_matrix.php
>    |---modules
>    |-themes
>    |---site_themes
> 
> The extension above contains two files:
> 
> - /ee-admin/extensions/ext.lg_data_matrix.php
> - /ee-admin/language/english/ext.lg_data_matrix.php
> 
> I will be developing multiple extensions in the one EE install to make  
> sure they all work with the core and do not conflict with each other.  
> So my directory will have more than one addon in it:
> 
> |-root
>    |-ee-admin
>    |---extensions
>    |-----ext.lg_data_matrix.php
>    |-----ext.lg_minify.php
>    |-----ext.lg_better_meta_ext.php
>    |---language
>    |-----english
>    |---------lang.lg_data_matrix.php
>    |---------lang.lg_minify.php
>    |---------lang.lg_better_meta.php
>    |---------lang.lg_better_meta_ext.php
>    |---modules
>    |-----lg_better_meta
>    |---------mcp.lg_better_meta.php
>    |---------mod.lg_better_meta.php
>    |-themes
>    |---site_themes
> 
> My problem comes when I want to tag and release an individual addon  
> which is a collection of files in multiple folders.
> 
> Just say I wanted to tag and release LG Better Meta. Ideally I would  
> like to export a folder structure like:
> 
> - /ee-admin/extensions/ext.lg_better_meta.php
> - /ee-admin/language/english/ext.lg_better_meta.php
> - /ee-admin/language/english/ext.lg_better_meta_ext.php
> - /ee-admin/modules/lg_better_meta/mcp.lg_better_meta.php
> - /ee-admin/modules/lg_better_meta/mod.lg_better_meta.php
> 
> I would also like to give people the ability to clone each of the  
> addons either as a full repo or part thereof.
> 
> Any advice would be greatly appreciated.
> 
> Cheers Leevi
> 

Have branches with individual views of files like the above
LG-Better-Meta starts from a clean tree and only adds
- /ee-admin/extensions/ext.lg_better_meta.php
- /ee-admin/language/english/ext.lg_better_meta.php
- /ee-admin/language/english/ext.lg_better_meta_ext.php
- /ee-admin/modules/lg_better_meta/mcp.lg_better_meta.php
- /ee-admin/modules/lg_better_meta/mod.lg_better_meta.php

Other branches with other individual views of files.
Commits will have to be on the individual branches.
Lets call these product-branches

Then you have integration branches that merge from time
to time the product-branches, master been the merge of
all.

Users that only need a single product-branch will checkout
that one. Users needing all will checkout master.

For your convenience, you can locally clone the master
git, and have checkouts of single product-branches so
you can commit patches in parallel. Then push and merge.

Don't forget to give all empty branches at least one
common ancestor before adding files. Like with .gitignore

Boaz
