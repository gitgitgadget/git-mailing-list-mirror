From: Jehan Bing <jehan@orb.com>
Subject: [BUG] Fail to add a module in a subdirectory if module is already
 cloned
Date: Tue, 24 Jan 2012 11:11:55 -0800
Message-ID: <jfmvpp$4v7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 20:12:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rplmv-0003LM-Qp
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 20:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab2AXTMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 14:12:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:58524 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab2AXTMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 14:12:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rplmn-0003H0-Bj
	for git@vger.kernel.org; Tue, 24 Jan 2012 20:12:05 +0100
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 20:12:05 +0100
Received: from jehan by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 20:12:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189058>

Hi,

I'm getting an error if I try to add a module in a subdirectory and that 
module is already cloned.
Here are the steps to reproduce (git 1.7.8.3):

git init module
cd module
echo foo > foo
git add foo
git commit -m "init"
cd ..
git init super
cd super
echo foo > foo
git add foo
git commit -m "init"
git branch b1
git branch b2
git checkout b1
git submodule add ../module lib/module
git commit -m "module"
git checkout b2
rm -rf lib
git submodule add ../module lib/module

The last command returns:
     fatal: Not a git repository: ../.git/modules/lib/module
     Unable to checkout submodule 'lib/module'

The file lib/modules/.git contains:
     gitdir: ../.git/modules/lib/module
(missing an additional "../")

In branch b1, after adding the module, the file contained the full path:
     gitdir: /[...]/super/.git/modules/lib/module
Or contains the correct relative path after checking out b1 later:
     gitdir: ../../.git/modules/lib/module


Regards,
	Jehan
