From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Patches exchange is bad?
Date: Wed, 17 Aug 2005 22:27:55 +0100
Message-ID: <1124314075.7130.49.camel@localhost.localdomain>
References: <20050817173522.14386.qmail@web26305.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 23:30:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5VSb-0001tI-ME
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 23:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVHQV2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVHQV2b
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 17:28:31 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:25640 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751289AbVHQV2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 17:28:30 -0400
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050817212829.CLZG23002.mta08-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Wed, 17 Aug 2005 22:28:29 +0100
Received: from cpc2-cmbg5-3-0-cust11.cmbg.cable.ntl.com ([81.104.193.11])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050817212829.IFGU13593.aamta11-winn.ispmail.ntl.com@cpc2-cmbg5-3-0-cust11.cmbg.cable.ntl.com>;
          Wed, 17 Aug 2005 22:28:29 +0100
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050817173522.14386.qmail@web26305.mail.ukl.yahoo.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-08-17 at 10:35 -0700, Marco Costalba wrote:
> Sorry if the answer is silly, but I still don't know well StGIT .

It's probably because there is no document really explaining the
concepts. The Quilt documentation would be a good starting point since
StGIT uses the same ideas but implemented on top if GIT instead of a
series of GNU diff files.

> What you describe it's an asymmetrical or one way scenario, new code 
> goes always from HEAD to MAIN. But how is the workflow if:

It is asymmetrical since HEAD uses StGIT and MAIN uses plain GIT but it
is a two way data flow: 'git pull HEAD' in MAIN and 'stg pull MAIN' in
HEAD.

> 1) There is more then one contributor feeding MAIN and you need to update 
> the StGIT patch stack from MAIN.

The base of the StGIT stack in the HEAD repository (branch) should
always be the head of the MAIN repository. You update it via the 'stg
pull' command, which takes care of updating the patches so that they are
seen as individual commits on top of the base.

That's how you would normally do development on Linux using StGIT -
clone the mainline kernel, create patches in your StGIT tree and submit
them either via e-mail or ask the gatekeeper to pull directly from your
tree (assuming that you only push those patches that need to be merged).
Doing a 'stg pull' would retrieve the latest changes from the mainline
kernel (including the changes made by your patches which were merged
upstream).

> 2) You made something terribly wrong with HEAD (I don't know what can be 
> 'terribly wrong') and you need to recreate a clean base from MAIN.
> 
> In this cases, if I understand correctly, you need to clone a new StGIT archive from 
> MAIN and push the interesting stuff from old/broken HEAD.

This is not clear for me. What do you mean by 'terribly wrong'? Broken
HEAD because of a bug in StGIT or GIT? Quite unlikely but in this case
the repository would be corrupt. I would recommend periodically doing a
'stg export' to keep the series of patches in GNU diff files.

If you refer to a patch which breaks the code, you can simply pop it
from the stack and even delete it with 'stg delete'. Popping it removes
the changes it makes to HEAD and the corresponding commit won't be seen
with 'git log'. You don't need to clone a new repository since StGIT
allows you to choose which of your patches (commits) are included in
HEAD (via 'stg push' and visible with 'stg applied').

> Or you can always merge back pulling from MAIN as in case of two pure git archives?

The base of the StGIT stack is identical to MAIN. Doing a 'stg pop -a'
makes the HEAD and MAIN identical.

Please let me know if this needs further clarification.

-- 
Catalin
