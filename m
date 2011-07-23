From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodule add does not consider git svn
Date: Sat, 23 Jul 2011 20:19:35 +0200
Message-ID: <4E2B10B7.3010903@web.de>
References: <CAJs9aZ9cMZd5PfOW7Zfza3un5JqKRM5eQdDpKPCWvLn-vkzktA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rupert THURNER <rupert.thurner@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 20:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkgne-0003ER-J5
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 20:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab1GWSTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 14:19:39 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57485 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab1GWSTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 14:19:37 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 28DFC1A70C798;
	Sat, 23 Jul 2011 20:19:36 +0200 (CEST)
Received: from [93.246.62.195] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QkgnY-0002Va-00; Sat, 23 Jul 2011 20:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAJs9aZ9cMZd5PfOW7Zfza3un5JqKRM5eQdDpKPCWvLn-vkzktA@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/fROIem10X2VGP1StI5HkMi8MbJEzSkbjnCryr
	4/up+Fw6fpqhnBdoAbXcYqUAnE6sKFIpUex4OjMsRVjQq0MRXz
	miazLYhduJGpyro807EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177700>

Am 23.07.2011 05:33, schrieb rupert THURNER:
> it seems that "git submodule add" looses information from "git svn
> clone". what am i missing here which would allow to "git svn rebase"
> the repository, even if it is newly added as submodule?
>
> the following example takes a little, as the repository has 15'000
> revisions, even 99% do not concern the checked out part.
> 
> rupert @ login : ~/tmp/subm-bug
>  mkdir -p  ~/tmp/subm-bug
>  cd ~/tmp/subm-bug
>  git svn clone https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg/GeoIP/trunk
> GeoIP
>  git init test
>  cd test
>  git submodule add ~/tmp/subm-bug/GeoIP
>  cd GeoIP
>  git svn rebase
> 
> Migrating from a git-svn v1 layout...
> Data from a previous version of git-svn exists, but
>         .git/svn
>         (required for this version (1.7.5.4) of git-svn) does not exist.
> Done migrating from a git-svn v1 layout
> Unable to determine upstream SVN information from working tree history

That is because in your example "git submodule add" clones that repo
*again* from where you put it using "git svn clone". I am not really
familiar with git svn, but I assume it is intended that when you clone
such a repo it "forgets" that it was connected with a svn repo. Try the
following instead:

git init test
cd test
git svn clone https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg/GeoIP/trunk GeoIP
git submodule add ./GeoIP      # Add existing git svn repo GeoIP in place
cd GeoIP
git svn rebase

Of course when you push that submodule somewhere else using git I expect
that "git svn rebase" won't work when you clone that somewhere else, just
like it happened in your example.
