From: jaseem abid <jaseemabid@gmail.com>
Subject: Testing JavaScript code in gitweb.
Date: Sun, 20 May 2012 03:14:55 +0530
Message-ID: <CAH-tXsDif9YOrkEcj7AdRfn6gvLx4mj4+SKCB4GzyW6QJpx=9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 19 23:46:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVrTd-0001ah-Ba
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 23:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab2ESVpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 17:45:38 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35942 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab2ESVph (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 17:45:37 -0400
Received: by wibhj8 with SMTP id hj8so1189560wib.1
        for <git@vger.kernel.org>; Sat, 19 May 2012 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=T+kc6TKEowojLYSjMUgh1BhSDRkyDz6w3Qofr+zoRww=;
        b=MyzWWZkXKGFwPabyR1J/H+GDKcGYkm4MrrWe2zsgcujXs4innPUXdYVuqZD8O/Qf+V
         Oxl91wpT9Oklw4gDafadGXbKZXJYGiCbFgm2hGzpnaAVsPm5DNHeDeeTILlhDW6GrM6c
         BdUyDdCdxWwLMJ1NX/5SvhsNLXXfV3ToZb33u9yf0076qFfydjifBdqbV4qzvC/zJzc3
         YkLSxHNRbjuTesUyuQDFE+1nhtSUsjzT3X1L2CLxhvjXo371ag+uwSaSCs1lTHMgLWEv
         x3mZDLAYjwJ29yJCC9GdsqA1Cj1krQlXJj0H3022Yd4whw+uh3mDPPGJxiTMI1hbwmpQ
         wxmg==
Received: by 10.180.101.103 with SMTP id ff7mr12297737wib.6.1337463935431;
 Sat, 19 May 2012 14:45:35 -0700 (PDT)
Received: by 10.227.39.96 with HTTP; Sat, 19 May 2012 14:44:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198039>

Hi,

Over the last few days, I explored ways to test the JavaScript code in
gitweb, and this is what I came up with.

Tests can be split into 2 major categories.

- Tests in the console.
	Pros
		- Can stick to the existing TAP, t/95xx testing pattern.
		- Easier integration with the existing test system.
	Cons
		- Will need a run time environment for JavaScript. Major ones are
node.js[1], spidermonkey and Rhino. All add *huge* dependencies to
git.
		- [IMP] The code is ultimately going to be run in a browser. Its
best to test in the same environment.
			From [2]:
				> JS test suites generally run in the browser because knowing that
your  tests pass in some sane command-line compiler tells you nothing
about  how it will be mangled by IE (or in rare cases, other
browsers).

- Tests in the browser.

	Pros
		- Test in the same environment where the code is going to be run.
Andrew mentioned this [2]
		- Ideal way to test in all those browsers out there across platforms
and versions effectively.  Can host the test page publicly with
gitweb, so that people can test it quickly in their won browsers and
report bugs.
		- No new dependencies.
		- Great libraries available.

	Cons
		- Wont go with the existing system.
			There are no tests for JavaScript now[3] . This would definitely
make it only better.  The perl code can be tested in the existing
manner and the JavaScript code can run in browser with no issues.
			Jakub mentioned this wont be a problem [4]
			
- Here are a few frameworks I considered for the task.

- Jasmine.
	BDD style testing. Current priority #1.
	Runs in the browser. Benefits mentioned above.
	Powerful and feature rich. A good tool for the task.

- node-tap [5]
	Needs node.js as previously mentioned.  This is the one that is
officially recommenced[6].

- JSdev
- TestSwarm
- JSTestDriver
- sinon.js

	Rejected by Jakub as not suitable after discussions[4].

-Qunit

	Priority #2. Runs in the browser.


I would prefer BDD style Jasmine for testing. The argument against it
was that It cant be run from terminal (node.js). That will add a new
dependency and hence cant be done. And as Andrew mentioned earlier, I
think its better to run JavaScript tests in a real browser itself,
because that's where it ultimately needs to run. He also mentioned
that TDD would be a nice way to go [7]. I guess BDD will be ok in the
context.
Jakub almost agreed with browsers after the previous discussion thread[8].

I would love to hear from all about testing JavaScript code in the
browser with Jasmine.

More on testing frameworks[9]


1 : http://nodejs.org
2 : http://git.661346.n2.nabble.com/GSOC-Contributing-to-git-tp7420040p7423349.html
3 : http://git.661346.n2.nabble.com/GSOC-Contributing-to-git-tp7420040p7420271.html
4 : http://git.661346.n2.nabble.com/GSOC-Contributing-to-git-tp7420040p7423442.html
5 : https://github.com/twada/qunit-tap
6 : http://testanything.org/wiki/index.php/TAP_Consumers
7 : http://colabti.org/irclogger/irclogger_log/git-devel?date=2012-05-13#l57
8 : http://git.661346.n2.nabble.com/GSOC-Contributing-to-git-tp7420040p7432237.html
9 : http://en.wikipedia.org/wiki/List_of_unit_testing_frameworks#JavaScript


-- 
Jaseem Abid
http://jaseemabid.github.com
