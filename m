From: Jonathan Nieder <jrnieder@gmail.com>
Subject: guarding everything with test_expect_success (Re: [PATCH 6/7]
 t1303 (config): style tweaks)
Date: Tue, 7 Sep 2010 00:12:18 -0500
Message-ID: <20100907051218.GO1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
 <20100907015317.GG1182@burratino>
 <20100907043050.GA13291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 07:14:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsqVl-0002eY-I8
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 07:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab0IGFOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 01:14:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62826 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab0IGFOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 01:14:18 -0400
Received: by gyd8 with SMTP id 8so1832459gyd.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 22:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ggdrLz0wUasNMY4d1gmWE3cFNwPB+KbFfvh+7Vs4VMA=;
        b=bwIsQVjA4w6AORDD8Q/g/R83NMN9rlCe5S6K3F+YYMR6WQmPB/+41rO4WyG0+ybD9C
         3hDv0m3n1iwwbLIgCkzihP5gZ0U96rD9j6zU2MOg5dvOM9YPdtN2Arjd2yXEmzmQmgK2
         pZ06kWiwatyVpHixYZla96+GRbkgqpBalM3S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=b8rvIMzB383gZ+RRf29mavLHnysP4lZ5XHcA1kpZYdOWFZ3Bg0bk1cA/lpXPSIIfvI
         Idotb+hN3eCbuRS1g03fFFp7wFXS4Kd7fahwtz/EDD/lK4BZbRNUSCL2H6MWezWGg/dk
         oLHKHswAA7jZleyFqe/+mZbOVNL6AxDOX+Pq8=
Received: by 10.151.11.3 with SMTP id o3mr493591ybi.35.1283836457132;
        Mon, 06 Sep 2010 22:14:17 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c2sm4558691ybi.9.2010.09.06.22.14.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 22:14:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907043050.GA13291@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155675>

(+cc: =C3=86var in case he is interested)

Hi,

Jeff King wrote:

> So I dunno. Most of it I am fine with, though I question whether it i=
s
> really worth the effort. But I really don't want to be too draconian
> about "everything must go into test_expect_success".

Thanks for the comments; that is very useful.  I'm sure you won't
be surprised to hear that that is a part I am more attached to than
the () vs {}, say.  I think I did not explain it well.

As you mentioned, it is a big departure from the style of the existing
tests.  So why push it?  A quick story:

1. Long ago, when I first debugged a test script with -v, I was a bit
   confused because the transcript did not tell the whole story
   (because some commands are run outside test assertions).  No big
   deal, but I remembered it.

2. Sometimes the setup commands outside of test scripts produce
   output.  This is annoying, so people silence it.

3. Sometimes the setup commands outside of test scripts are broken.
   Tests do not use "set -e" or check for errors outside of test
   assertions, so simple typos can go undetected for a long time.

4. What actually provoked me to care about it: when trying to add a
   test to t9301-fast-import.sh, say, I found myself completely lost.
   It is really hard to figure out what the state is supposed to be
   at a particular point in the test script.  Sometimes I am tempted
   to write a new test script when adding a new behavior, only
   because I do not understand the existing one on a topic.  All the
   tests can be well-behaved and follow sane invariants, but that
   does not matter, because the invariants are not documented anywhere.

How to fix that?  I would like to see tests look roughly like this:

 test_description=3D'description of purpose

 description of state maintained between tests
 '

 . ./test-lib.sh

 test_expect_success 'setup' '
	...
 '

 test_expect_success 'some good thing holds' '
	... commands that do not break global state ...
 '

 test_expect_success 'another good thing holds' '
	... more peaceful test commands ...
 '

 test_expect_success 'setup: update global state somehow' '
	...
 '
 ...
 test_done

Some of my other puzzling patches (test_might_fail, test_when_finished)
are also meant for this purpose.  Of course, it will take a while.

The result would be:

 - test commands all shown with "-v", output all suppressed without;
 - all commands pass at least the sanity check of exiting with 0
   status;
 - easy to write a GIT_SKIP_TESTS specification.  Would be possible
   to add the ability to try a single test (plus all setup tests in
   that script that precede it);
 - as long as all the setup tests pass, the list of failed tests
   from a test failure can be more informative;
 - state can be tracked by just reading the setup tests.

> Sure, if you are
> executing commands that might have output, or might be of interest to
> the user, put them there. But I find this a lot more readable:
>=20
> cat >expect <<'EOF'
> ... some expected output ...
> EOF
> test_expect_success 'frob it' '

I don't know: I think

	cat >expect <<-\EOF &&
	...
	EOF

is pretty readable.  The problem with sticking to

cat >expect <<\EOF
=2E..
EOF

is that once someone wants to include a commit id, they change
it to

cat >expect <<EOF
=2E.. $(git rev-parse ... )
=2E..
EOF

and we have nontrivial code outside the test now.

On the other hand:

> , but IMO you are
> making at least one of them less readable, because you have to deal w=
ith
> the extra quoting layer of test_expect_success. IOW:
>
>> -SECTION=3D"test.q\"s\\sq'sp e.key"
>>  test_expect_success 'make sure git config escapes section names pro=
perly' '
>> +       SECTION=3D"test.q\"s\\sq'\''sp e.key" &&
>
> seems like a net loss to me.

I wholeheartedly agree, and maybe I should have done

	apos=3D"'\''" &&
	SECTION=3D"test.q\"s\\sq${apos}sp e.key" &&

or something; this detail of quoting has never brought much happiness
to me.

Sorry for the ramble.  Thoughts welcome.
Jonathan
