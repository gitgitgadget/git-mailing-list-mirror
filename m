From: Christopher Wilson <cwilson@cdwilson.us>
Subject: Re: Why does adding an existing repo as a submodule modify .git/config?
Date: Tue, 24 May 2011 00:06:01 -0700
Message-ID: <4DDB58D9.2090701@cdwilson.us>
References: <irbq5a$h38$1@dough.gmane.org> <4DDAAAD2.1010708@web.de> <4DDB0786.5020006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 09:06:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOlh8-0004b0-Jq
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 09:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab1EXHGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 03:06:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:45909 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706Ab1EXHGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 03:06:15 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QOlh0-0004Ye-Nc
	for git@vger.kernel.org; Tue, 24 May 2011 09:06:14 +0200
Received: from c-98-210-218-165.hsd1.ca.comcast.net ([98.210.218.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 May 2011 09:06:14 +0200
Received: from cwilson by c-98-210-218-165.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 May 2011 09:06:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-210-218-165.hsd1.ca.comcast.net
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DDB0786.5020006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174314>

On 5/23/11 6:19 PM, Mark Levedahl wrote:
> On 05/23/2011 02:43 PM, Jens Lehmann wrote:
>> Am 22.05.2011 22:02, schrieb Christopher Wilson:
>>
>> Hmm, this looks like an inconsistency to me too. It would be great
>> to hear about the background, so I added Mark to the CC, maybe he
>> can shed some light.
>>
> I think the comment in c2f939170c651 describes the reasoning well
> enough. (You may disagree with the reasoning, but that is a different
> matter :^).
> 
> Mark

Mark, thanks for the reply.  Maybe I'm a bit daft, but I'm still a
little confused by your comment in the commit :)

I've included your commit message below with my questions interlaced.

C: "When adding a new submodule in place, meaning the user created the
submodule as a git repo in the superproject's tree first, we don't go
through "git submodule init" to register the module."

Q: Why don't we go through "git submodule init" to register the
submodule?  Isn't that the whole point of having a separate "submodule
init" command, to register the module in .git/config?

C: "Thus, the submodule's origin repository URL is not stored in
.git/config, and no subsequent submodule operation will ever do so."

I'm not sure this is true.  For example:

$ mkdir testing
$ cd testing
$ git init
$ git clone git@git.server:submodule.git
$ git submodule add git@git.server:submodule.git
$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
[submodule "submodule"]
    url = git@git.server:submodule.git

# At this point, I opened up .git/config in an editor and removed the
entire submodule section.

$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
$ git submodule init
$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
[submodule "submodule"]
    url = git@git.server:submodule.git

Q: As far as I can tell, a subsequent submodule operation (git submodule
init) has stored the submodule's origin repository URL in .git/config.
Can you elaborate on what you meant by the statement "no subsequent
submodule operation will ever do so"?

C: "In this case, assume the URL the user supplies to "submodule add" is
the one that should be registered, and do so."

Q: Can you elaborate on why a 2 step "git submodule add" + "git
submodule init" wasn't sufficient?  What is the reason for adding this
functionality into the "git submodule add" command, when "git submodule
init" does the same job?

Again, sorry if I'm asking dumb questions... :)  Just want to understand
the context for your commit.
