From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] t9010-svn-fi: Add tests for svn-fi
Date: Wed, 2 Feb 2011 08:19:49 +0530
Message-ID: <20110202024944.GA11339@kytes>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
 <1296570403-9082-3-git-send-email-artagnon@gmail.com>
 <20110201185817.GG3771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 03:49:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkSmO-00019y-91
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 03:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab1BBCs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 21:48:58 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50581 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1BBCs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 21:48:57 -0500
Received: by gwj20 with SMTP id 20so2796094gwj.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xGHtZkJ0j8dBQkVCatFDRXfzozHwc1/pzPOgGKj8OTk=;
        b=O3dSyk2QfkVvw3mXmjux30/hzvOTNNJzMvB424kc1Wvx4qsje2WzmArbSPG6qgspAj
         wdyBeXGJtoQTAnW4CXNuC8rG0HPYcWqpjVQsg+bAh/GqVsw7Tj9GWOrPLOg6/HNAFR+Y
         6irDENYVVvnjACOJ6CSosBPNsPXFYRD41lu/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Fi/LyCjaBCdBQ9CKuQKYBTqZYsk+I70DkUDikwMmEhtl5vxJ3/Cq7JddwiJXKPVAHD
         JRKvgEA/xnnxMV0WY2jXc9D0vXeXdzerYQ6nT6ZznBkrt4sGOXZcatqpSAuLCLqv7HE1
         YnRnayNDvSnj36LpC/Ksl0K5Dnb1JBllQ5Csc=
Received: by 10.90.100.8 with SMTP id x8mr518425agb.53.1296614936796;
        Tue, 01 Feb 2011 18:48:56 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id r41sm14655374yba.16.2011.02.01.18.48.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 18:48:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110201185817.GG3771@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165888>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Create a test-svn-fi in toplevel directory, add rules to build it, and
> > add some basic tests.
> 
> Thanks.  Probably this should be squashed with patch #1?

Right. Will do.

> > --- /dev/null
> > +++ b/t/t9010-svn-fi.sh
> 
> Test number's already taken.  9012 is free, though.

Ok. Will rename in the next iteration.

> > @@ -0,0 +1,303 @@
> > +#!/bin/sh
> > +
> > +test_description='check svn dumpfile exporter'
> > +
> > +. ./test-lib.sh
> > +
> > +if ! svnadmin -h >/dev/null 2>&1
> > +then
> > +	skip_all='skipping svn-fi tests, svn not available'
> > +	test_done
> > +fi
> 
> Is it impossible to test without svn present or otherwise speed
> these up?  Some random ideas:
> 
>  - feed svn-fi output into svn-fe and compare git repos
>  - check if "svn-fi after svn-fe" is idempotent (should it be?)
>  - check for individual salient features from svn-fi output, using
>    "grep", "sed", or "awk" to ignore the rest
>  - use svnrdump in place of "svnadmin load" if available (is it
>    faster?)
>  - find the bottleneck in svnadmin and fix it
> 
> Of course at least one test of the "svn-fe | svnadmin load"
> pipeline seems worthwhile; I'm just thinking we should avoid
> habits that slow down the test suite too much.

Hm, I'm not entirely convinced -- the final verdict is always dictated
by whether or not the emitted dumpstream loads. Many streams that look
alright to the eye don't actually load because of small intricacies
like missing newlines. It'll be awfully complicated reverse-engineer
all these intricate rules and write them in terms of sed/ awk
commands. Yes, svnrdump will be faster, but it'll only be available
with the later versions of Subversion (same problem with fixing
svnadmin bottlenecks).

> > +svn_look () {
> > +	subcommand=$1 &&
> > +	shift &&
> > +	svnlook "$subcommand" "$svnrepo" "$@"
> > +}
> 
> Needed?  The svn_cmd function exists to point to a configuration
> directory.

Just a convinience: I am using svn_look to look at the properties of
nodes in several tests. If I don't use this in enough tests, I'll
factor it out.

> > +test_expect_success 'normal empty files' '
> > +	reinit_svn &&
> > +	cat >expect.tree <<-\EOF &&
> > +	/
> > +	 foo
> > +	 bar
> > +	EOF
> > +	cat >input <<-\EOF &&
> > +	reset refs/heads/master
> > +	commit refs/heads/master
> > +	mark :1
> > +	author nobody <nobody@localhost> 1170199019 +0100
> > +	committer nobody <nobody@localhost> 1170199019 +0100
> 
> Where do the dates come from?  Why should I (the reader) expect
> them?

What do you suggest? I need some valid "generic" timestamp + offset.

> > +# TODO: How to test date? Need to convert from local timestamp
> 
> Ah, you saw. :)
> 
> One possibility is to fuzz away whatever is unimportant when
> comparing results (and using tools like "awk" to extract the
> date to perform whatever tests on it are appropriate where it
> matters).

Okay, I'll try this. Is there no other way? Can we whip up a shell
script to convert the timestamp?

> > +test_expect_success 'malformed fast-import stream: author 2' '
> > +	reinit_svn &&
> > +	cat >input <<-\EOF &&
> > +	reset refs/heads/master
> > +	commit refs/heads/master
> > +	mark :1
> > +	author nobody <localhost> 1170199019 +0100
> > +	committer nobody <nobody@localhost> 1170199019 +0100
> > +	data 0
> > +	M 100644 inline foo
> > +	data 0
> > +
> > +	EOF
> > +	try_load input must_fail
> 
> What's wrong with this stream?

author nobody <localhost>
                        ^
Parse error there, since build_svn_author tries to use the part of the
email address appearing before the '@'. This is just a temporary test
-- we should make the svn_author generation logic configurable.

> > +test_expect_success 'svn:special and svn:executable' '
> > +	reinit_svn &&
> > +	cat >input <<-\EOF &&
> > +	reset refs/heads/master
> > +	commit refs/heads/master
> > +	mark :1
> > +	author nobody <nobody@localhost> 1170199019 +0100
> > +	committer nobody <nobody@localhost> 1170199019 +0100
> > +	data 7
> > +	nothing
> > +	M 100755 inline foo
> > +	data 0
> > +	M 755 inline moo
> > +	data 0
> > +	M 120000 inline bar
> > +	data 0
> > +
> > +	EOF
> > +	try_load input &&
> > +	svn_look propget svn:executable foo &&
> > +	svn_look propget svn:executable moo &&
> > +	svn_look propget svn:special bar
> 
> Maybe worth checking for the absence of svn:executable +
> svn:special from an ordinary file, too?

Good idea.

> > +test_expect_success 'replace symlink with normal file' '
> 
> Nice.  "replace symlink with executable" and "replace symlink
> with directory" might also be interesting.

Good idea. Will do.

-- Ram
