From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Truncating and cleaning a imported git repositary to make it
 more usable
Date: Fri, 28 Mar 2008 17:43:58 +0100
Message-ID: <47ED204E.3020602@viscovery.net>
References: <1206707716.9819.15.camel@malory>	 <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>	 <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com> <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 17:45:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfHhn-0002cQ-Q7
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 17:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbYC1QoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 12:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755419AbYC1QoG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 12:44:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38655 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbYC1QoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 12:44:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JfHfV-0002qW-Fp; Fri, 28 Mar 2008 17:43:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AC902546; Fri, 28 Mar 2008 17:43:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78428>

Alex Bennee schrieb:
> On Fri, Mar 28, 2008 at 3:52 PM, Alex Bennee <kernel-hacker@bennee.com> wrote:
> 
>>  ajb@pitcairn:/export/git/fresh.git$ git-filter-branch --tree-filter
>>  'rm -rf big_dira big_dirb' dev-branch
>>  warning: refname 'dev-branch' is ambiguous.
>>  Which ref do you want to rewrite?
> 
> Ignore me. Not sure why but:
> 
> git-checkout dev-branch
> git-filter-branch --tree-filter  'rm -rf big_dira big_dirb' HEAD

You really shouldn't do it this way, unless you do it on a ramdisk. Better
use an --index-filter. This is modeled after the last example in the man
page (and, of course, untested):

git filter-branch --index-filter \
        'git ls-files -s |
	 grep -v "	big_dira" |
	 grep -v "	big_dirb" |
                GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
                        git update-index --index-info &&
         mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD

where the space before big_dir is actually a literal TAB!

-- Hannes
