From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH v2 1/2] Ensure consistent usage of mergetool.keepBackup
 in git
Date: Fri, 10 Apr 2009 08:58:42 +0200
Message-ID: <49DEEE22.5030500@pelagic.nl>
References: <20090409153033.GN23604@spearce.org> <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl> <20090410032731.GA1545@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 09:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsAiw-0006lW-Jp
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 09:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761962AbZDJG6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 02:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759499AbZDJG6q
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 02:58:46 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:33655 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751728AbZDJG6p (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 02:58:45 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 2810B58BDA0;
	Fri, 10 Apr 2009 08:58:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090410032731.GA1545@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116241>

David Aguilar wrote:
> Hi
> 
> On  0, Ferry Huberts <ferry.huberts@pelagic.nl> wrote:
>> In several places merge.keepBackup is used i.s.o.
>> mergetool.keepBackup. This patch makes it all
>> consistent for git
>>
>> Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
>> ---
>>  contrib/difftool/git-difftool.txt |    2 +-
>>  git-mergetool.sh                  |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> You missed the usage of merge.keepBackup in
> contrib/difftool/git-difftool-helper.
> 

I did miss it. didn't read the grep good enough I guess. thanks

> But.. (for better or worse) the "keep backup" feature
> was completely removed from difftool, so patching this for
> difftool now isn't very useful.
> 
> See 2e8af7e4 which is currently in origin/pu:
> 
> 	difftool: remove the backup file feature
> 
> 
> Also, we just got through a very large round of
> mergetool/difftool changes.  The latest version is sitting in
> Junio's pu branch.  The "da/difftool" branch's head is
> currently pointing at 21d0ba7e.
> 
> It might be worth basing your work on top of that series since
> that'd make things much easier to merge.
> 

on pu? I'll do that

> 
> My only other comment is:
> 
> Aside from git-gui, there are other scripts out there that
> use merge.keepBackup instead of mergetool.keepBackup,
> so changing the name of the config variable has negligable
> user benefit and will cause problems for people that:
> 
> A) already have merge.keepBackup configured and then get
> surprised when one day all of a sudden git starts leaving
> around these ".orig turds" (technical term, overheard from an
> actual user) for no apparent reason even though they had
> already configured it to do otherwise in the past, or
> 
> B) have written GUIs or scripts that know about
> merge.keepBackup.
> 
> Aside from the naming, there's little user benefit to this
> change in my opinion.
> 

I patched it this way because contrib/completion/git-completion.bash and
Documentation/config.txt talk about mergetool.keepBackup while only
contrib/difftool/git-difftool.txt talks about merge.keepBackup. That
seemed the most logical way of doing it.

I agree that some users might be surprised after this patch, otoh: I was
quite surprised that I still had turds even when I set
mergetool.keepBackup, which is what the documentation told me to do :-)
Do we really want to keep using 2 names for the same thing?

[rebasing now...]

I'm seeing the following grep on pu:

contrib/completion/git-completion.bash:	mergetool.keepBackup
Documentation/config.txt:mergetool.keepBackup::
git-gui/lib/mergetool.tcl:if {[is_config_true merge.keepbackup]} {
git-gui/git-gui:set default_config(merge.keepbackup) true
git-gui/git-gui.sh:set default_config(merge.keepbackup) true
git-mergetool.sh:merge_keep_backup="$(git config --bool merge.keepBackup
|| echo true)"

So it seems that merge.keepBackup is actually used consistently in the
code while the completion and documentation talk about mergetool.keepBackup.

Shall I just patch the completion and documentation instead?
