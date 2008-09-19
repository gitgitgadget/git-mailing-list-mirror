From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from
 git-gui.
Date: Fri, 19 Sep 2008 15:04:54 +0200
Message-ID: <48D3A376.30905@viscovery.net>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>	 <1221685659-476-2-git-send-email-angavrilov@gmail.com>	 <1221685659-476-3-git-send-email-angavrilov@gmail.com>	 <1221685659-476-4-git-send-email-angavrilov@gmail.com>	 <1221685659-476-5-git-send-email-angavrilov@gmail.com>	 <1221685659-476-6-git-send-email-angavrilov@gmail.com>	 <1221685659-476-7-git-send-email-angavrilov@gmail.com>	 <48D396A8.4050607@viscovery.net> <bb6f213e0809190538m5bbfeb38o5510d06fa6757dd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 15:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgfgb-0004WA-4h
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 15:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbYISNE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 09:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYISNE6
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 09:04:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42265 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYISNE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 09:04:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KgffL-0007DH-5Q; Fri, 19 Sep 2008 15:04:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DCEDF54D; Fri, 19 Sep 2008 15:04:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <bb6f213e0809190538m5bbfeb38o5510d06fa6757dd1@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96282>

Alexander Gavrilov schrieb:
> On Fri, Sep 19, 2008 at 4:10 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> If I run
>>
>>  $ LANG=C gitk 146ed90
>>
>> with this series on the git-gui repository, then I hoped to see the text
>> in the patches in the right encoding. But I understand that I expected too
>> much - the patch text is just a stream of bytes that comes from different
>> files, and the best you can do is to apply the system encoding.
>>
>> But if the view is switched to the tree view, and file contents are
>> inspected, then this patch should help. But it doesn't. If you look at
>> po/ja.po, it is appearent that the file was not read as UTF-8, which is
>> dictated by .gitattributes.
> 
> On my system everything works. You must have made a mistake somewhere.

Indeed. I was running above command form a git.git clone. Now, looking at
anything that is in 146ed90 produces paths like

   po/de.po
   po/ja.po

Yet, .gitattributes says this:

   /po/*.po    encoding=UTF-8

which does not match any of the *.po files because the *.po are one level
deeper inside git-gui/po/. The change below made a difference.
Everything's fine now!

diff --git a/git-gui/.gitattributes b/git-gui/.gitattributes
index f96112d..8ad5766 100644
--- a/git-gui/.gitattributes
+++ b/git-gui/.gitattributes
@@ -1,3 +1,3 @@
 *           encoding=US-ASCII
 git-gui.sh  encoding=UTF-8
-/po/*.po    encoding=UTF-8
+*.po        encoding=UTF-8

> Also, it should work in the patch mode as well: it reads the patch as
> binary, and decodes each line separately, based on the encoding
> determined for the current file.

This is great. But we'll have to see how this works on a multi-file diff
on Windows. (I sense slowness.)

Thanks,
-- Hannes
