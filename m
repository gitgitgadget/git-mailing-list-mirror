From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/2] Quoting paths in tests
Date: Wed, 17 Oct 2007 19:15:50 +0200
Message-ID: <864pgpfyrd.fsf@lola.quinscape.zz>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com> <11926134961610-git-send-email-maillist@steelskies.com> <11926134961549-git-send-email-maillist@steelskies.com> <11926134961275-git-send-email-maillist@steelskies.com> <4715F2E6.1000708@viscovery.net> <6E65762D-FBC4-4A7C-97A9-20F6744E25DE@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 19:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiCdm-0000t9-P0
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 19:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758532AbXJQRY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 13:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758767AbXJQRY4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 13:24:56 -0400
Received: from main.gmane.org ([80.91.229.2]:52154 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758432AbXJQRYz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 13:24:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IiCa3-0004yF-EM
	for git@vger.kernel.org; Wed, 17 Oct 2007 17:21:15 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 17:21:15 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 17:21:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:3iZxm0TW/LiVyNFWGVbC7sRdOcg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61397>

Jonathan del Strother <maillist@steelskies.com> writes:

> On 17 Oct 2007, at 12:32, Johannes Sixt wrote:
>
>> Jonathan del Strother schrieb:
>>> --- a/t/lib-git-svn.sh
>>> +++ b/t/lib-git-svn.sh
>>> @@ -25,7 +25,7 @@ perl -w -e "
>>> use SVN::Core;
>>> use SVN::Repos;
>>> \$SVN::Core::VERSION gt '1.1.0' or exit(42);
>>> -system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or
>>> exit(41);
>>> +system(qw/svnadmin create --fs-type fsfs/, \"$svnrepo\") == 0 or
>>> exit(41);
>>
>> Here you have to work harder: The reason is that this is part of a
>> perl expression (as opposed to an eval'd string), which does not
>> have access to $svnrepo of the shell by which it is invoked. The
>> original version failed if there were single-quotes in $svnrepo, the
>> new version fails if it contains double-quotes.
> ...
>>
>> May I recommend that you run the test suite in a directory named
>> like this:
>>
>> 	$ mkdir \"\ \$GIT_DIR\ \'
>> 	$ ls
>> 	" $GIT_DIR '
>
>
> Eww.  I'm struggling a bit with paths this perverse, actually.
>
> For instance, git_editor in git-sh-setup expects the editor path to be
> pre-quoted.  So in t3404, you need to produce escaped double quotes &
> dollar signs, resulting in unpleasantness like this :
>
> VISUAL="`pwd`/fake-editor.sh"
> VISUAL=${VISUAL//\"/\\\"}
> VISUAL=${VISUAL//$/\\\$}
> VISUAL=\"$VISUAL\"
> export VISUAL

EDITORPWD="`pwd`"
VISUAL='$EDITORPWD/fake-editor.sh'
export EDITORPWD VISUAL

-- 
David Kastrup
