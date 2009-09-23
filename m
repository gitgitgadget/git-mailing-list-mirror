From: Deon George <deon.george@gmail.com>
Subject: Feature Enhancement Idea.
Date: Wed, 23 Sep 2009 16:17:58 +1000
Message-ID: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 08:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqLGg-0007v9-8F
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 08:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbZIWGXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 02:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbZIWGXt
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 02:23:49 -0400
Received: from mail-pz0-f191.google.com ([209.85.222.191]:45810 "EHLO
	mail-pz0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbZIWGXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 02:23:48 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2009 02:23:48 EDT
Received: by pzk29 with SMTP id 29so337685pzk.33
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=JgeI1WxvEsKIGgVRFgshMTwAj0PPFxzopDgDiccgu7A=;
        b=gNAqyMIcrvKDxkw6YQ/9TmPqVkC1JKsTc9hbrIgJp5NJPMGAFawg5E+dbl9MXUy51f
         tohfyn6k70pcx5nro46Yfag5l5vy397IUX1mlbND6zoQcOC/oHfiaaQd/rEmx0Eef6Uo
         1lla3RPlNsS0o4APyGdsaiHzFJ99reFaSdSYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pQ6jS/PMndQHxPI0JRCkz63WCbc9p0yJR9jnJCsppmPE6jpmMaiXV/OBw8yKs5ZocS
         hGuEcGGQ1ndoMGF3SKFDcLcW1hDTSgd47dAvwtNkriw2Usx4n7JyYu/CUW7seuGYsy/r
         aR3HRMzKh4Q5x9DAo56HJJ0tY04ZDkES9r7cQ=
Received: by 10.140.203.11 with SMTP id a11mr107947rvg.69.1253686678183; Tue, 
	22 Sep 2009 23:17:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128969>

Hi,

I'm not sure if this is the right place, but I thought I'd post my
idea and maybe somebody will either redirect me to the right place, or
give me that "that wont happen".

Im fairly new to GIT (wish I had discovered it long ago), and I really
like using it - great work guys/garls :)

My idea is to enhance GIT to support (I'll call it) development
"layers". The current design of GIT is that the working repository and
working directory assume that all files belong together in the same
project. I would like to see GIT go 3D and support layers, so that
files (and/or file content) can belong to multiple repositories (or
considered unique projects), even though the working tree presents all
files as if they were one.

To explain further...

Lets say, I am not the primary developer of a project, however I am a
"module"/"plugin"/"addon" contributor to a project - ie: my primary
involvement is to write additions to existing projects. (EG: I
write/support a driver in the kernel (that is not included in the base
tree), or I write an "addon" to an existing application, using that
existing applications "module" capability).

As part of me developing my "module" (or modules if I develop more
than one), I need the working tree to have the "base" and "my bits". I
want to manage both the changes I make to "my bits", and also record
any changes that need to be made to the "base" (so that "my module(s)"
will work). Normally, the changes to the "base" would be submitted
upstream (and hopefully accepted), while I would normally be
responsible for the packaging and change control of "my bits".

If the upstream chooses not to accept my contributions (ie: my changes
never appear in base), then whenever I package "my bits", GIT would
also include the base components as well.

I know I can achieve some of this by using GIT branches (I've been
doing that so far), however, GIT branches has a few limitations that I
am sure that GIT "layers" would overcome... Ultimately, I believe GIT
can handle my layers idea - and it should be possible to have multiple
layers (where multiple components could come from different GIT
repositories), however, they are all "checked out" into the one
working tree.

Thinking about this further, there would be two possible layer
scenarios (I think GIT can handle both).
* File autonomy (most cases)
This is where files (by filename) belong to different projects. EG: If
my working tree had files "a, b & c", "1, 2 & 3", and "X Y & Z". Files
"abc" could be layer one (the base), files "123" could be layer two
(dependant on base) and files XYZ could be layer three (which could be
dependant on base OR dependant on layer two).

Whenever modifications were done to any file, GIT would know which
layer owns the file and GIT processing is done as normal. Upstream
pulls from any layer should not normally generated any conflicts,
unless there are filename clashes between layers (and in this
situation the layer hierarchy should be considered authoritative, with
the conflict needed to be resolved in a lower layer.)

* Content autonomy
This is were some content in files belongs to "my work" (eg: Modifying
a Makefile to compile my work when the base is compiled). In this
situation, I may have two outcomes - I either want the changes to
flagged for upstream (to hopefully be included), or I may want to keep
the changes with my work, because I know it upstream would never
accept them (or it isnt appropriate).

In either cases, upstream pulls should be considered authoritative and
any conflicts I would need to resolve as normal commit (either wanting
them to be resubmittable for upstream, or commiting them as part of my
work.)

Like I mentioned, I can achieve some of this by the use of branches
already, however, where it comes complicated, is when:
* I commit a change to the wrong branch (and thus upstream will never
see my enhancements),
* I want to identify changes to one layer (that I went to send to
upstream for review), without including the other layers (because it
probably isnt relevant)
* I want to work on more than one layer (I need to be diligent about
pulling and merging)

An example of usage might be:
* git clone ... (or git init) -layer "A"
* git checkout -b mywork -layer "A"
* git clone ... (or git init) -layer "B" -dependson "A"
* git checkout -b mymodule -layer "B"
* add/remove/edit files
* git add file x -layer "A"
* git add file y -layer "B"
* git rm file z -layer "A"
* git commit (as usual)
* git tag "V2.8" -layer "A"
* git tag "mymodule V1.0" -layer "B"

git diff -layer "A" mywork.. would show my changes that I would want
sent upstream (without mymodule commits)
git archive -layer "B" would package up my module for distribution
(without layer "A")
git archive -layer "A" would package up my version of layer A (without
layer "B")

Could this be included as part of GITs functionality (or is it
possible already) ?

...deon
