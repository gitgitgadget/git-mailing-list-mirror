From: Daniel Thomas <drt24@srcf.ucam.org>
Subject: [GSoC Proposal/RFC] Rolling commit message writing
Date: Sun, 28 Mar 2010 20:32:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.1003281834520.13534@pip.srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 28 21:32:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvyDV-0003ip-Ux
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 21:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065Ab0C1TcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 15:32:08 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:54620 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab0C1TcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 15:32:05 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from pip.srcf.societies.cam.ac.uk ([131.111.179.83]:46970)
	by ppsw-1.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.131]:25)
	with esmtp id 1NvyDK-0002m5-5k (Exim 4.70) for git@vger.kernel.org
	(return-path <drt24@srcf.ucam.org>); Sun, 28 Mar 2010 20:32:02 +0100
Received: from localhost ([127.0.0.1] ident=drt24)
	by pip.srcf.societies.cam.ac.uk with esmtp (Exim 4.69 #1 (Debian))
	id 1NvyDK-0002jv-Lq
	for <git@vger.kernel.org>; Sun, 28 Mar 2010 20:32:02 +0100
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143418>

Hello,

I looked at the ideas on the wiki ( 
https://git.wiki.kernel.org/index.php/SoC2010Ideas ) and then I remembered 
that I had an itch to scratch when it came to git.

So I have written a proposal for something which is not on that list:
https://git.wiki.kernel.org/index.php/User:Drt24/GSoC2010/

This is included below to allow for easier commenting on it.

Since this proposal is not on the ideas list I am also looking for someone 
to mentor this project.

However if it is considered that this is a silly idea (I hope it isn't) 
then I will write a proposal for the "Merge helper for LaTeX files" as 
this scratches another of my itches.

Begin proposal:

== Project Goals ==

=== What is the goal of your project? ===
To make it easier for developers to write good commit messages.

=== What you are going to try to accomplish with your project? ===
Currently it is fairly easy to write good commit messages but the effort 
that this requires of developers can be reduced still further.

This would be achieved by adding a built in system for working on a commit 
message during the stage of adding changes.

Currently this can be done manually using "-F <file>, --file=<file>" in 
git commit but we can do better than that. Specifically changes to git add 
[--interactive | -i] to add an 'am' or similar command to allow adding a 
file and then prompting for a message about the changes to that file. Also 
changes to git add [--patch | -p] to add 'm' and 'c' options to git add 
--patch to allow the addition of a message for the current hunk ('m') and 
to do a commit (prompting for review) before returning to the hunk 
currently in focus ('c').

=== How would you measure its success or failure? ===
* The creation of a good API for editing commit messages for work that is 
in the process of being added for commit.
* The integration of this API with currently existing CLI tools such as 
git add so that it fits seamlessly with developer's workflow.
* The modification of existing documentation to properly reflect this 
change.
* The addition of any additional documentation on how to use this new 
feature.
* The addition of thorough testing of this feature to 'git.git/t'.
* Compliance with SubmittingPatches and CodingGuidelines.
* Work should be undertaken with careful communication with the community.

=== The project in more detail. ===
A backend for storing the commit message that is being worked on, probably 
using a file called COMMIT_NEXTMSG in .git/ (following the standard set by 
COMMIT_EDITMSG). With a file format for describing the commit message, 
this would be a normal text file but with the use of 
"/path/to/file.extension:[line number | line-range:] <detail about this 
part of the commit>" to store the various bits of commit message as they 
are added. (alternatively it might be better to use the git notes system 
but I haven't looked into this yet)

Teaching 'git commit' about this so that it appends the contents of this 
file to the commit message supplied at the next commit if '-m' is used or 
if [-n | --nextmsg] is used then it just uses the contents of the file (of 
course [-e| --edit] would allow this to be subsequently edited.

Teaching 'git commit' --rolling or something similar which would open 
COMMIT_NEXTMSG in $GIT_EDITOR.

Teaching 'git add [-i | --interactive]' an 'am' or similar command for 
'add and prompt for message' (with care to not spoil the current 
interface.

Teaching 'git add [-p | --patch]' the 'm' and 'c' commands for adding a 
message about the changes in the current hunk and for committing changes 
added so far after being shown 'git status' being prompted as to whether 
the user wishes to continue (y/n) where 'y' shows the commit message in 
GIT_EDITOR such that writing from that commits and returns the user to the 
hunk they were looking at and 'n' takes them straight back to the hunk. 
This makes it easier to separate out multiple atomic changes from a file.

=== Schedule ===
* 3rd June begin work in earnest: (my last exam is on this day).
* 9th June finish first version of backend and API.
* 15th June finish writing tests on backend and API and any changes 
suggested by the testing or after reveiw.
* 22nd June finish teaching git commit --rolling
* 28th June finish teaching git add [-i | --interactive] the 'am' (add 
with message) command.
* 9th July finish teaching git add [-p | --patch] the 'm' (add with 
message) command.
* 12th July mid term evaluation
* 16th July finish teaching git add [-p | --patch] the 'c' (commit with 
edit returning here) command.
* 26th July finish teaching git commit [-n | --nextmsg] and to use the 
COMMIT_NEXTMSG if available.
* 2nd August write lots more tests on everything implemented so far. 
Ensure that all known bugs are properly fixed. Make any changes suggested.
* 9th August check all the documentation and make all the necessary 
changes. Write any more additional pieces of documentation necessary e.g. 
tutorials.
* 9th August suggested pencils down deadline.
* 16th August firm pencils down deadline, finish rechecking all code, 
documentation, tests and submitting patches to the mailing lists. Write 
final evaluation.
* 20th August final evaluation deadline.
* Continuing: provide any necessary support for these changes and fix any 
bugs that are found subsequently. Continue lurking on the mailing list and 
#git. Help with the continued development of git.

== Interfaces ==

===What parts of Git will you need to call?===
* editor.c
* strbuf.c
* string-list.c
* git show
* Those files which I am also modifying, see below.

=== What parts of Git might you need to change? ===
* git-add--interactive.perl
* commit.c
* builtin/{add.c,commit.c}
* Documentation/{git-commit.txt,git-add.txt}
* t/{t750?-commit*,t370?-add*} (probably just adding new files)

== About You ==

=== Projects that I have worked on ===

Last term I worked on the quebec project for my group project which is 
part of my University course. This can be seen here: 
https://www.srcf.ucam.org/quebec/tomcat/quebec/ and the code is here: 
https://www.srcf.ucam.org/quebec/quebec-0.1.tar.gz though it is not really 
in a fit state for use by anyone else and we never got around to talking 
about licenses. I wrote the User Management system, and ran the server 
(tomcat), version control (SVN after a vote by the group which had in 
general not used VCSs before) and unit testing (junit4). I also rewrote 
part of the comms system and wrote a test client for it. This project was 
also in Java. We did a lot of communication in person but we also used 
Google wave and Google docs. There were five developers in my group and we 
had a client from IBM.

Last summer (2009) I worked on the second iteration of the 
ReadYourMeter.org project (which is still in development) I wrote 8.7ksloc 
of Java and GWT. This code is available under the GPL v2 but since we 
haven't done a release yet it isn't linked to from anywhere. I was the 
only developer on this project, I communicated with my supervisor both in 
person and via email.

In Christmas 2008 I wrote a simple command line 
[https://www.srcf.ucam.org/~drt24/blog/2008/12/10-release-of-fractals/ 
fractal image generator] in SML for my own amusement.

In February 2007 I contributed a couple of minor patches to the 
Worldforge.org project (in python). Most communication was done on #lounge 
on irc.worldforge.org, but I also used the mailing list (particularly for 
the submission of patches). I had CVS commit rights but they have 
subsequently moved to Git and I have only been lurking on their mailing 
list since the summer of 2007.

[https://www.srcf.ucam.org/~drt24/onlineCVdrt24.pdf My CV.]<!-- This link 
will break once the application period is over. -->

===Do you have any prior Git experience?  Have you started to get 
involved?===

I have been using Git for over a year for various personal projects 
ranging from academic work and projects to websites I have worked on for 
various people. I haven't used it in a multi-user manner as in general it 
has been just me working on these projects in git.
I have pulled git.git and successfully compiled and installed it (which 
was pleasantly easy), I also ran the tests in git.git/t which seemed to go 
as well as it was supposed to.

I have been lurking on #git for a few days now and I have tried to provide 
support where I could for those questions which were asked when I was 
watching. I have joined the git mailing list and while I haven't been 
reading all the emails I have been reading a selection of them.

If accepted I would send a weekly progress report to the mailing list 
(unless people would object to that). I would ensure that I regularly 
pushed my changes to somewhere public so that anyone interested could look 
at them. I would ensure that I listened to advice given to me and acted 
upon it. I would start submitting patches to the mailing list as 
[PATCH/RFC] once I have finished a section of work to allow anyone to make 
suggestions on how to do it better early on in the project. I would also 
remain on #git and increase the proportion of mailing list emails which I 
read.

=== Prior contact with the Git community ===

I talked to 
[http://colabti.org/irclogger/irclogger_log/git?date=2010-03-23#l2369 
'Paradox' and 'charon' about this on #git] after 'Paradox' had asked if 
something similar was available. 'charon' mentioned that git commit 
--append --only or 'git rebase --interactiv

I posted a link to this proposal on #git a few hours before I posted it 
here but there were no responses to it.

--
Thank you,

Daniel
