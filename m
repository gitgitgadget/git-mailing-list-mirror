From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: Reset by checkout?
Date: Sun, 01 Jun 2014 11:45:08 +0300
Message-ID: <538AE814.2010407@bracey.fi>
References: <20140531144610.754B.B013761@chejz.com> <53898448.8040105@bracey.fi> <20140601132624.821C.B013761@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Atsushi Nakagawa <atnak@chejz.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 10:45:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr1OR-0001lT-Hc
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 10:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbaFAIpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 04:45:17 -0400
Received: from mo68.mail-out.ovh.net ([178.32.228.68]:43866 "EHLO
	mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbaFAIpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 04:45:14 -0400
Received: from mail408.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with SMTP id A27CCFFB515
	for <git@vger.kernel.org>; Sun,  1 Jun 2014 10:45:12 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 1 Jun 2014 10:45:21 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 1 Jun 2014 10:45:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20140601132624.821C.B013761@chejz.com>
X-Ovh-Tracer-Id: 16726087543066890257
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrieejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500199/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrieejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250523>

On 01/06/2014 07:26, Atsushi Nakagawa wrote:
> Kevin Bracey <kevin@bracey.fi> wrote:
>> The original "git reset --hard" used to be a pretty top-level command.
>> It was used for aborting merges in particular. But I think it now
>> stands out as being one of the only really dangerous porcelain
>> commands, and I can't think of any real workflow it's still useful
>> for.
> My thoughts exactly.  I think the 'reset --soft/--mixed/--hard' pattern
> is so ingrained, that many people just don't realize there's a safer
> alternative.  (I've heard work mates on more than one occasion
> recommending 'reset --hard' as the go-to command for discarding commits.)
>
> I believe this is likely because many third party GUI tools just don't
> support 'reset --keep', and these tools present a "Reset..." dialog with
> the de facto Soft/Mixed/Hard options.  (Even 'gitk' does this.)
True on the GUI - "hard" really needs demotion.

It would help if the documentation explained better straight off what 
the different reset modes are intended /for/ in a more practical way, 
rather than the technical jargon.

There is the "EXAMPLES" section, but I think the problem is that it's 
not clearly laid out by mode, meaning people checking to see what "git 
reset" can do are inclined to go first to the "--xxx" mode list in 
"DESCRIPTION", and stop there, baffled, probably not finding any example 
for that mode. Maybe the examples should have clearer "--option" 
subheadings? (And all the existing examples for --hard should really 
suggest --keep instead).

But given that the "DISCUSSION" section now has the full internal 
details on what exactly each mode does in every state, and now that we 
have more than the "simple" soft/mixed/hard to deal with, I think the 
main "DESCRIPTION" could be simplified for end users.

Most useful for visualisation, I feel, would just showing what "git 
status" will look like afterwards, primarily from the point of view of a 
"backwards" reset to HEAD~n. In particular, normal users don't think in 
terms of the absolute contents of the index, but rather in terms of diffs.

Maybe something like this:

"All modes move the current branch pointer so that HEAD now points to 
the specified commit. ORIG_HEAD is set to the original HEAD location. 
The modes differ in what happens to the contents of ORIG_HEAD, that are 
no longer on the reset branch; and also what happens to your 
not-yet-committed changes.

--soft
      Retains the contents of ORIG_HEAD in the index+work area, leaving 
the difference as "changes to be committed". "git reset --soft HEAD~1" 
would be the first step if you want to remove the last commit, but 
intend to recommit most or all of its changes.

"git status" after reset --soft shows:

   To be committed:
        Changes in ORIG_HEAD relative to HEAD
        (+Any initial staged changes)

   Not staged:
        (Any initial unstaged changes)

--mixed (default)
     Retains the contents of ORIG_HEAD in the work area, leaving the 
difference as unstaged changes. "git reset HEAD~1" would be the first 
step if you want to remove the last commit, and think again from scratch 
about which of its changes should be committed.

"git status" after reset --mixed shows:

    Not staged:
        Changes in ORIG_HEAD relative to HEAD
        (+Any initial staged changes)
        (+Any initial unstaged changes)

--keep
    The contents of ORIG_HEAD are dropped, leaving the work area and 
index containing the new HEAD; your uncommitted changes to unaffected 
files are retained. If you have uncommitted changes to any files that 
differ in the proposed new HEAD, the operation is refused; you would 
need to "git stash" first. "git reset --keep HEAD~1" can be used to 
totally remove the last commit. (This removal can itself be undone with 
another "git reset --keep ORIG_HEAD", or "git reset --keep 
<branch>@{<n>}" - see git-reflog(1)). "git reset --keep" is a safe 
alternative to "--hard", and is roughly equivalent to "git checkout -B 
<current-branch-name>".

"git status" after reset --keep shows:

    Not staged
        (Any initial staged changes)  [should these be left staged, as 
per "git checkout"?]
        (+Any initial unstaged changes)

--hard
    All other changes are dropped, and the work area and index are 
forcibly reset to the new HEAD. Note that this is dangerous if used 
carelessly: ALL uncommitted changes to ALL tracked files will be lost, 
even if you were only trying to drop an unrelated commit that didn't 
touch those files. Older documentation often recommends "git reset 
--hard" to undo commits; the newer "--keep" option is a much better 
alternative in almost all cases.

"git status" after reset --hard shows:

    Work area clean (or untracked files present)

--merge
    Performs the operation of "git merge --abort", intended for use 
during a merge resolution - see git-merge(1) for more information. This 
form is not normally used directly. [Not really true? Still the best 
command to abort "git checkout --merge"/"git stash pop|apply"? Do those 
need "--abort"?]


> If people just forgot about '--hard' and used '--mixed/--keep' for
> regular cases, '--hard' would effectively be -f. ;)

True, but this is quite a big shift. And I think "--keep" isn't a clear 
name in isolation. It's named relative to "--hard", rather than 
absolutely...  "Soft/Mixed/Keep" is a sensible 3-way choice, but it 
doesn't sound like it. "Keep" keeps less than soft or mixed!

Maybe a new parallel naming scheme is in order? Could we instead phrase 
it from the point of view of what we want to do with the stuff in 
ORIG_HEAD? "--to-index"/"--to-workspace"/"--drop"? (--hard deliberately 
excluded...)

Kevin
