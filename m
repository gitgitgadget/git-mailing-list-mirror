From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git-rebase eats empty commits
Date: Wed, 16 Jul 2008 11:24:38 +0200
Message-ID: <487DBE56.9020201@fastmail.fm>
References: <g4vrrm$g35$1@ger.gmane.org> <20080712221207.GB22323@leksak.fem-net> <g5fpnm$3jb$1@ger.gmane.org> <20080715201902.GC6244@leksak.fem-net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090703080406050407010800"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 11:25:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ3Ge-0003P0-Go
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 11:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbYGPJYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 05:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbYGPJYs
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 05:24:48 -0400
Received: from main.gmane.org ([80.91.229.2]:41221 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbYGPJYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 05:24:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJ3Fd-0006hG-Ds
	for git@vger.kernel.org; Wed, 16 Jul 2008 09:24:45 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 09:24:45 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 09:24:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080715201902.GC6244@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88652>

This is a multi-part message in MIME format.
--------------090703080406050407010800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephan Beyer venit, vidit, dixit 15.07.2008 22:19:
> Hi,
...
> any version of git. Or I am missing a point.
> 
> 	$ git cherry-pick empty		# empty is an empty commit tagged as "empty"
> 	Already uptodate!
> 	Finished one cherry-pick.
> 	# Not currently on any branch.
> 	# Untracked files:
> 	[...]
> 	nothing added to commit but untracked files present (use "git add" to track)

How would an empty commit produce untracked files? You seem to be 
testing something different.

I reattach the test case from my original post, as well as the log of 
runs with git 1.5.6.3: once with rebase and once with rebase -i.

Uuuh, doh: I interpreted

Finished one cherry-pick.
# Not currently on any branch.
nothing to commit (working directory clean)
Could not apply e1f497c... empty 1
8d0c67a675bc65d375e8a9d019500bb2a16fb1e9 rewritten 1

as the end of the (interactive) rebase operation! Nothing indicated it 
was interrupted: no message and no git status output. It all looked like 
a failed rebase.

Now, thanks to your persistence, I tried going ahead with commit --amend 
and rebase --continue, and all went fine (stopped again for empty 2, 
giving no clue; amend & cont).

So, you're right: cherry-pick stops at empty commits, so that rebase -i 
is the way to go. rebase (non-i) uses format-patch resp. merge (-m), 
which eat empty commits.

I recall some discussion about informative rb-i messages, may upcoming 
git would have saved me and will save others from this misinterpretation.

Thanks!
Michael

--------------090703080406050407010800
Content-Type: application/x-shellscript;
 name="empty.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="empty.sh"

IyEvYmluL3NoCnJtIC1SZiBlbXB0eQpta2RpciBlbXB0eQpjZCBlbXB0eQpnaXQgaW5pdApl
Y2hvIDEgPiBhCmdpdCBhZGQgYQpnaXQgY29tbWl0IC1tIDEKZ2l0IHRhZyByZXdyaXRlCmdp
dCBjb21taXQgLS1hbGxvdy1lbXB0eSAtbSAiZW1wdHkgMSIKZWNobyAyID4gYgpnaXQgYWRk
IGIKZ2l0IGNvbW1pdCAtbSAyCmdpdCBjb21taXQgLS1hbGxvdy1lbXB0eSAtbSAiZW1wdHkg
MiIKZ2l0IGxvZyAtLXByZXR0eT1vbmVsaW5lCiNub3cgcmViYXNlCmdpdCBjaGVja291dCAt
YiB0ZW1wIHJld3JpdGUKZWNobyBvbmUgPiBhCmdpdCBjb21taXQgLS1hbWVuZCAtYSAtbSAi
cmV3cml0dGVuIDEiCmdpdCByZWJhc2UgLS1vbnRvIHRlbXAgcmV3cml0ZSBtYXN0ZXIKZ2l0
IGxvZyAtLXByZXR0eT1vbmVsaW5lCg==
--------------090703080406050407010800
Content-Type: text/x-log;
 name="empty.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="empty.log"

Initialized empty Git repository in /tmp/mjg/t/empty/.git/
Created initial commit 6b9e2af: 1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
Created commit 8387962: empty 1
Created commit 6c4c3fe: 2
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 b
Created commit 3521900: empty 2
3521900fb7b032aa9e1f5a50a82f71785aa5c208 empty 2
6c4c3fe8b7619e1107256d0b47d0f419c05ceb69 2
8387962b740bb47662dd866eb57b4fe5ad21b355 empty 1
6b9e2afad8bed27378f0c9d23e77631be8447d37 1
Switched to a new branch "temp"
Created commit 1cced89: rewritten 1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
First, rewinding head to replay your work on top of it...
Applying 2
a4116113335fc6be47fb9f8481547ea0923ac09d 2
1cced892a90024f4230a9f7aec1989ffe0b6c16f rewritten 1

--------------090703080406050407010800
Content-Type: text/x-log;
 name="empty-i.log"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="empty-i.log"

SW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL3RtcC9tamcvdC9lbXB0eS8u
Z2l0LwpDcmVhdGVkIGluaXRpYWwgY29tbWl0IDI3OTZjOWQ6IDEKIDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGEKQ3JlYXRlZCBjb21taXQgZTFmNDk3YzogZW1wdHkgMQpDcmVhdGVkIGNvbW1pdCBiMzg2
N2FlOiAyCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMo
LSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBiCkNyZWF0ZWQgY29tbWl0IDJlZGFkNDM6IGVtcHR5
IDIKMmVkYWQ0MzYyODZmMzllNDA3YjgzYmJiNDQ4YjNhYTYyYjkxYWViOSBlbXB0eSAyCmIz
ODY3YWUyYTM0NWFiMzBiZmQ2OGExYzdlMGUxOTk5OWExZWI5ZWIgMgplMWY0OTdjNGVlN2Ew
NDAxNjJmYWE3ZGNjMmI2ZDhlNDFkNWZkOTIwIGVtcHR5IDEKMjc5NmM5ZDlmOGZjZWQ4NjEz
NGU1YjM2NDYyOTE2YzkzOGM2ZjgxOSAxClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAidGVt
cCIKQ3JlYXRlZCBjb21taXQgOGQwYzY3YTogcmV3cml0dGVuIDEKIDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGEKUmViYXNpbmcgKDEvMykNQWxyZWFkeSB1cHRvZGF0ZSEKRmluaXNoZWQgb25lIGNoZXJy
eS1waWNrLgojIE5vdCBjdXJyZW50bHkgb24gYW55IGJyYW5jaC4Kbm90aGluZyB0byBjb21t
aXQgKHdvcmtpbmcgZGlyZWN0b3J5IGNsZWFuKQpDb3VsZCBub3QgYXBwbHkgZTFmNDk3Yy4u
LiBlbXB0eSAxCjhkMGM2N2E2NzViYzY1ZDM3NWU4YTlkMDE5NTAwYmIyYTE2ZmIxZTkgcmV3
cml0dGVuIDEK
--------------090703080406050407010800--
