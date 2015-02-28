From: Colin Walters <walters@verbum.org>
Subject: weaning distributions off tarballs: extended verification of git tags
Date: Sat, 28 Feb 2015 09:48:05 -0500
Message-ID: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 15:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRigg-0005KP-HD
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 15:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbbB1OsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 09:48:11 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42781 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961AbbB1OsI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2015 09:48:08 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B5085206AD
	for <git@vger.kernel.org>; Sat, 28 Feb 2015 09:48:04 -0500 (EST)
Received: from web2 ([10.202.2.212])
  by compute1.internal (MEProxy); Sat, 28 Feb 2015 09:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:x-sasl-enc:from:to
	:mime-version:content-transfer-encoding:content-type:subject
	:date; s=smtpout; bh=1MmKzEPEPpJPGjFfnaLOcXZPk5o=; b=jq+ojcT9oiC
	AdIyPU8hlXrVrHIw9cuGacgNIdXgUAGVV4PxGOXkFZWBSj/daorHwMeZrEzVE7vW
	Aet5yZ83/C48+9NAv3OSKkU2FRLI4v7WSlB7afpZlHhSgPQxB+pJQyB4wLYb5+Vz
	l0PCsmTFz3Al5POf89ZmHobMX5a7y5eA=
Received: by web2.nyi.internal (Postfix, from userid 99)
	id 86B355402BA; Sat, 28 Feb 2015 09:48:05 -0500 (EST)
X-Sasl-Enc: dBYOrPyp3+5xnggZLjhVY3Qo1hDhAkFWgzDdcm5LuFc7 1425134885
X-Mailer: MessagingEngine.com Webmail Interface - ajax-4ba7306c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264533>

Hi, 

TL;DR: Let's define a standard for embedding stronger checksums in tags and commit messages:
https://github.com/cgwalters/homegit/blob/master/bin/git-evtag

I think tarballs should go away as a source distribution mechanism in favor of pure git.  I won't go into too many details of the "why" here (hopefully most of you agree!) but that's the background.

Now, there are a few things that the classical tarball model provides:

- Version numbers compatible with dpkg/rpm/etc
  -> Do the same with your tag names, and use a well known scheme like "v$VERSION"
- The assumption that this source has been run through some tests
  -> Broken assumption, and regardless you want to rerun tests downstream
- Hosting providers typically offer a strong checksum over the entire source
  -> The topic of this post

The above strawman code allows embedding the SHA256(git archive | tar).  Now,
in order to make this work, the byte output of "git archive" must never change in the
future.  I'm not sure how valid an assumption this is.  Timestamps are set to the
commit timestamp, but I could imagine someone wanting to come along later
and tweak the output to be compatible with some variant of tar or something.

We could define the checksum to be over the stream of raw objects, sorted by their checksum,
and that way be independent of archiving format variations.

Is there agreement that something like this makes sense in the git core?  Does the
concept make sense?  Does anything like this exist today?  Other thoughts/objections?
