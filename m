From: Andrew Wang <andrew@umbrant.com>
Subject: GSoC proposal: git mirror-sync
Date: Wed, 25 Mar 2009 00:00:32 -0400
Message-ID: <1c7233eb0903242100v406bda32h4803f54cd4c09ebb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 05:02:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKJe-0002JK-9t
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 05:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbZCYEAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 00:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbZCYEAj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 00:00:39 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:61549 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZCYEAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 00:00:38 -0400
Received: by bwz17 with SMTP id 17so2499204bwz.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 21:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=j8uqpPvMqC7YKKa+ZePYudJ0suU4v34Zph8ngbwzc1k=;
        b=rxZJsBVn4MHgzXGwyA55QNXw/K4WL7MwziHR0CG+g1mAQXk48KPpYRCYI+3Ia4jajk
         8GP2SYuQBwNWashlLJb6d+w8nhSzszRn3O5LyEVkRiMUk59L4gAujkqDlU1+JYUHrc6i
         K/Wm0eWeeTm9Mltexg0GPPEvg3loi2TLuCL1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=WtgfpoymzGlsBWO8HzFqprE7QEBWyW9e7sLUw3mV/tOeF3zEGcygwpfwYHAc85LcVe
         HfianQwGx02UE05AggIlUM+4pZ7IguprPKX27B255Ev6qXZPNxgRWj0ft8mzYV3SXsPR
         C2d4xU4EIHtaNxzZ2jCDMsN+NdjkJCLJNXaGU=
Received: by 10.103.172.9 with SMTP id z9mr3975617muo.39.1237953632893; Tue, 
	24 Mar 2009 21:00:32 -0700 (PDT)
X-Google-Sender-Auth: 5304109f498aafba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114555>

Greetings,

I'm applying for a Google Summer of Code project for git mirror-sync,
mentioned on the Ideas wiki page. I've submitted my first draft to the
GSoC website already, but if any kind mailing list members have any
comments or questions I'd be happy to take them. Thanks go out to Sam
Vilian, who already helped me with my app :)

Cheers,
Andrew

==================================

Project Goals

What is the goal of your project?

The goal is to implement the MirrorSync protocol
(http://code.google.com/p/gittorrent/wiki/MirrorSync and
http://tinyurl.com/c7j3m7) as a continuation of previous Google Summer
of Code projects involving peer to peer distribution of Git
repositories to increase download speeds and decentralize
distribution. It's a refinement of the GitTorrent protocol
(http://gittorrent.utsl.gen.nz/rfc.html), which in turn was based on
the popular BitTorrent protocol
(http://www.bittorrent.org/beps/bep_0003.html). MirrorSync offers a
simplified version of GitTorrent more tailored to the design of Git
and without all the unnecessary BitTorrent cruft.

How would you measure its success or failure?

The MirrorSync overview goes over the three parts of functionality
that need to be implemented. Completing all three would be highly
desirable, but each part is useful in its own right since they add
mirror downloading functionality. However, the scope of the project
seems such that all three could be completed in a single Summer of
Code project, and that's what I'll aim for. There's going to be a
significant amount of work on formalizing the protocol and talking
with Git developers, and that'll also be part of my work for the
summer.

Part one is Mirror List. This lets a client hit a repository and get a
list of mirrors that the client could try downloading from, along with
the most recent update to the repository and the signing key for
verifying updates.

Part two is Mirror Notify. This is how a client can tell a repository
that the client has a copy of the repository, and is willing to act as
a mirror.

Part three is Mirror Sync. This is where the actual exchange of
repository contents occurs. The peers start by comparing each other's
latest packed-refs files, and then start requesting desired packs from
each other. This means new changes will quickly propagate through the
network, and since the objects are fragmented reproducibly, downloads
can be spread across many peers.

Describe your project in more detail.

The necessary steps to implementing all of MirrorSync have already
been laid out in skeleton form by Sam Vilain
(http://tinyurl.com/crdq9f). The three messages will be implemented
Mirror List first, followed by Mirror Notify and then Mirror Sync.
These are major milestones for progress, and more formal documentation
and specifications on each part should emerge along the way.

My plan for all three parts is to write the bulk of the code in
Python, since git-daemon can wrap the Python executables with
execl_git_cmd(). This means there are going to be additions to
git-daemon to accommodate this, but no big changes.

Mirror List requires modifications to git-tag to create the necessary
"push objects".These are tags containing a packed-refs file in the
comments section, signed so a mirror can verify the state of the
repository. The server has to maintain a list of mirrors and which
signing key IDs are allowed to push back to which branches. The client
has to make use of this key info to verify push objects, ensuring that
the push objects are only changing the allowed refs. Adding keys to
the keyring can be done through prompting similarly to how it's
handled in SSH. Finally, git-fetch will be modified to have a
"--use-mirror" flag to select from the list to download from a local
mirror.

Mirror Notify has to handle maintaining the list of mirrors and
responding appropriately. The main repository should attempt to verify
notify requests by checking that the repo exists on the mirror.
Writing the client commands for notifying the server should be pretty
easy.

Mirror Sync is probably the hardest to implement, since it's the most
complicated and requires the most investigation into Git internals. It
makes use of Mirror List to get a list of peers, and then it needs to
start advertising bundles it has and bundles it wants. Then the actual
downloading and uploading process happens, and this keeps happening
until everyone is in sync.

The timeline for the three months would look something like this: one
week of research  and planning, three weeks for Mirror List, two weeks
for Mirror Notify, five weeks for Mirror Sync, and one week for
cleanups and documentation. This is a total of 12 weeks, the time
allotted for Summer of Code.

Interfaces

What parts of Git will you need to call?

There won't be much code reuse, since the MirrorSync additions are
fairly separate from the rest of the Git codebase. The tag creation
facilities will be used in making "push objects", and the existing
framework in git-daemon for handling fetch requests will be extended
to handle the new MirrorSync requests.

What parts of Git might you need to change?

There are two things that will be changed: git-tag and git-daemon.
git-tag needs to be changed to accommodate creating the "push objects"
necessary for peer communication, and the required additions will
hopefully be minor. git-daemon needs to be modified to call out to the
new mirror-* functionality when it's hit with a request. Besides that,
three new commands are being added (mirror-list, mirror-notify,
mirror-sync) so the Makefile will need to be modified.

About You

Can you list some prior projects that you have worked on?

I haven't been involved in any open source projects much beyond bug
reporting and triaging, for KDE and a few other projects. I have a
couple very minor patches to Basket Note Pads in their Git tree, a KDE
project written in Qt and C++ (http://basket.kde.org/). As with most
open source projects, communication within Basket is primarily through
email, and I've also been subscribed on and off to development mailing
lists for KDE, Enlightenment, Gentoo, and now Git.

I've done plenty of coding on my own projects though, the most
relevant being Python implementations of a BitTorrent tracker and a
threaded XML feed grabber and parser. Both of these were done on my
own as self learning projects, using mainly the extensive standard
Python libraries. Python is my goto language for projects big and
small, and I'm pretty comfortable in it.

Besides that, my professional background has been in websites, so I
have exposure to all types of web development technologies and related
programming languages. My resume (http://www.linkedin.com/in/aawang)
is the best place to go for a run down on that part of my skill set.
I've also been producing copious amounts of Java code for school
related projects; right now we're doing development with Lego NXT
robots with communication over Bluetooth with a WiiRemote.

Do you have any prior Git experience? Have you started to get involved?

I don't have any prior Git experience except as a user. I asked Sam
Vilain a bit about MirrorSync when I saw the Git Ideas page, and now
I'm on the developer mailing list. I've also started browsing through
the source code, but I don't have any patches to my name right now.
