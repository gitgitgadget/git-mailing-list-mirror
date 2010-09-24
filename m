From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 00/24] Re: [PATCH 1/3] t9300 (fast-import): style tweaks
Date: Fri, 24 Sep 2010 01:59:00 -0500
Message-ID: <20100924065900.GA4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:02:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2IE-00029A-SI
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab0IXHB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:01:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39832 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0IXHB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:01:56 -0400
Received: by ywh1 with SMTP id 1so854250ywh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7wLBqSbindyTyrihn7MrYRQDX1t4yJW7PUPkeYtgvjI=;
        b=G29IkJpjwbgkCoYkCpqmELJSqStdNPEqQnSCGsOfj+T/mPyi/XJJ99jCRHlY2rJa9K
         j1vfUKExEbPMQCSDFpfKdixjO3SXfAty4FKly52zHOkteyt1BuIYeFSAvJNS4kX5jAS1
         irl9mwOm/VzuEYAL/B2MwOS0x4vX+237zo8yE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iT9Go5YN4GC9YhSryLLSmHYfneTUPDl1mmRn+vFelQdQSYovxqKB1AogaT5rFOSttz
         1BB49etLqlRf+kj9a4zXL3Gy6wtiLp3TFCw+HHqsbFF99ZNPCw5iE23Z5u7tX+WKlwlR
         rnLbmy3JwJ7tRmX/h1PY+gDR8ZJjkFVC2vO+Y=
Received: by 10.150.195.9 with SMTP id s9mr3964757ybf.419.1285311715957;
        Fri, 24 Sep 2010 00:01:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q25sm1936660ybk.6.2010.09.24.00.01.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:01:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905032253.GB2344@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156934>

Hi,

Jonathan Nieder wrote:

> Clarify dependencies between tests to make the fast-import test
> script more approachable.  In particular:
... many things ...
> While at it:
... more things ...

The patch was a lazy way for me to add new assertions to the
fast-import test script without going crazy.  But it really was lazy:
it has almost nothing to do with the "fast-import protocol
experiments" series that it headed, and worse, that one patch did so
many things at once that it was basically guaranteed that (1) no one
would like all of it and (2) it bitrotted in a couple of days.

Oh well.  Tomorrow I would like to re-roll the fast-import experiment
so the svn-fe that understands deltas can get more attention, and of
course that series does not require these style fixes at all.

So why resend them?  I end up mentally making these changes every time
I add a new test to that script, so I imagine it would be nicer to
make the changes once.  Maybe it would help newcomers to dive into the
wonderful world of fast-import testing.

So here is a small chunk of that monster patch, ejected from the
original series and split up.

Patch 1 introduces a verify_packs () helper that makes the script much
easier to read (by including only two copies of an unpleasant loop).
The nominal justification is that giving the

	for each pack
	do
		git verify-pack $pack ||
		exit
	done

loop its own function allows use to write "return" instead of "exit",
resulting in better behavior when a test fails.

Patch 2 is the most important one to me.  It gets rid of some
hardcoded tree and blob names, most of which were not doing any
harm except to scare me.  At first glance it is not obvious when
a stray test_tick, for example, will ruin later tests (it turns out
never but there is at one test that does depend on the choice of
hash function), and at first glance, it is not obvious what is
actually the expected diff when a raw diff is presented as expected
output.

The approach adopted is to introduce some symbolic constants, like

	empty_blob=$(git hash-object --stdin </dev/null)

and use them in the expected output.

Patches 3-6 just pick nits.  The dividends are better output
with -v and more robust checking for failure of git commands.

Patch 7 changes some 4-space indents to tabs (since the latter
is predominant in the file).

Patches 8-24 change from traditional

	test_expect_failure \
		'description' \
		'commands &&
		 more commands'

to modern

	test_expect_success 'description' '
		commands &&
		more commands
	'

style.  They are meant to be squashed together and are only split
in tiny pieces for easier review.

Let's take whatever is useful and forget about the rest.

Thanks,
Jonathan Nieder (24):
  t9300 (fast-import): avoid exiting early on failure
  t9300 (fast-import): avoid hard-coded object names
  t9300 (fast-import): guard "export large marks" test
  t9300 (fast-import): check exit status from upstream of pipes
  t9300 (fast-import): check exit status from command substitution
  t9300 (fast-import): use test_cmp in place of test $(foo) = $(bar)
  t9300 (fast-import): use tabs to indent
  t9300 (fast-import), series A: re-indent
  t9300 (fast-import), series B: re-indent
  t9300 (fast-import), series C: re-indent
  t9300 (fast-import), series D: re-indent
  t9300 (fast-import), series E: re-indent
  t9300 (fast-import), series F: re-indent
  t9300 (fast-import), series H: re-indent
  t9300 (fast-import), series I: re-indent
  t9300 (fast-import), series J: re-indent
  t9300 (fast-import), series K: re-indent
  t9300 (fast-import), series L: re-indent
  t9300 (fast-import), series M: re-indent
  t9300 (fast-import), series N: re-indent
  t9300 (fast-import), series O: re-indent
  t9300 (fast-import), series P: re-indent
  t9300 (fast-import), series Q: re-indent
  t9300 (fast-import), series R: re-indent

 t/t9300-fast-import.sh | 1010 ++++++++++++++++++++++++++----------------------
 1 files changed, 539 insertions(+), 471 deletions(-)

-- 
1.7.2.3
