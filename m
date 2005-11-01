From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull - strange (copy/rename) messages ?!
Date: Tue, 1 Nov 2005 08:10:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511010801370.27915@g5.osdl.org>
References: <43678C73.1080601@excelsior-online.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 17:15:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWyjy-0001NV-GZ
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 17:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVKAQLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 11:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVKAQLG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 11:11:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750832AbVKAQLF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 11:11:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA1GAvW6006347
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 1 Nov 2005 08:10:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA1GArGn003605;
	Tue, 1 Nov 2005 08:10:55 -0800
To: Duncan Mac Leod <duncan@excelsior-online.org>
In-Reply-To: <43678C73.1080601@excelsior-online.org>
X-Spam-Status: No, hits=0.014 required=5 tests=PLING_QUERY
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10938>



On Tue, 1 Nov 2005, Duncan Mac Leod wrote:
>
> One Team-Member of our dev.-team has deleted one file called
> Graphics/PaletteGroups.cs in our shared git repository.
> 
> As I updated my working dir with git-pull I noticed some strange messages...
> 
> What do these many copy and rename messages below the summary '14 files
> changed, 933 insertions(+), 263 deletions(-)' mean ????

First off, you should realize that whenever git says "copy" or "rename", 
it never actually tracked the data at that level. git itself never did a 
copy or rename operation at all, it just tracked your data contents.

However, the normal "git pull" will show purely for your edification what 
git thinks the other end did to get to that data content. And it does so 
with copy and rename detection enabled, so in this case it says:

>  copy Graphics/{PaletteGroups.cs => PaletteCategories.cs} (80%)
>  copy Graphics/PaletteGroups.cs => Plot/Dialogs/Dialog.cs (75%)
>  copy Graphics/PaletteGroups.cs => Plot/Dialogs/DialogEntry.cs (74%)
>  copy Graphics/PaletteGroups.cs => Plot/Dialogs/DialogSection.cs (64%)
>  copy Graphics/PaletteGroups.cs => Plot/Journals/Journal.cs (75%)
>  copy Graphics/PaletteGroups.cs => Plot/Journals/JournalEntry.cs (73%)
>  copy Graphics/PaletteGroups.cs => Plot/Journals/JournalSection.cs (64%)
>  copy Graphics/PaletteGroups.cs => Runtime/CompilerServices/eScriptCompiler.cs (74%)
>  copy Graphics/PaletteGroups.cs => Runtime/Scripting/Script.cs (75%)
>  rename Graphics/PaletteGroups.cs => Runtime/Scripting/ScriptLibrary.cs (64%)

Which means that git notices that there are a number of new files, and the 
new files all bear a striking resemblance to one file that was deleted.

So it tells you that the new files are probably copies of the old one 
(with one final "rename", since the old file doesn't actually exist any 
more).

Which may or may not be true, of course. But even if it's not "true", it's 
still interesting information - it is a totally objective "those new files 
look like the old file" thing. In other words, it tells you something 
true about the file contents.

To some degree it would be much more interesting to have 
"--find-copies-harder" enabled (which it isn't), which gives better copy 
information for new files (it also looks at _unchanged_ old files). 
However, that's prohibitively expensive for big projects, so it's not on 
by default.

Btw, Junio, I thought "git pull" was only supposed to do rename 
detection, not copy detection.

			Linus
