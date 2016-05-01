From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/6] connect: uniformize and group CONNECT_DIAG_URL
 handling code
Date: Sun, 1 May 2016 15:37:24 +0200
Message-ID: <ee3d1928-38c5-372c-223f-bd50bfb14930@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-3-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 15:38:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awrZQ-0000KD-Jr
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 15:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbcEANhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 09:37:53 -0400
Received: from mout.web.de ([212.227.15.3]:63765 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbcEANhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 09:37:52 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MYI9h-1bASVP1uyH-00VAzB; Sun, 01 May 2016 15:37:30
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <1462082573-17992-3-git-send-email-mh@glandium.org>
X-Provags-ID: V03:K0:GzkZDAP0ZXBMMm8UW7E1RNydE9Jmx2ogKkwP2OVWWIrmBhU+CaD
 rgjesD2f41S0JoEIvCQ31iBlbDa6+S2F3wkEZwNy+j/9KHankHSynrjtQvP6Z0FpGvcB0HR
 IZa6tNe4h5FxXtnNnMQ7cKZ8HUtGYmrgtnIVlfKjHsLzTVVz29c6s+d0LWHe9uXol8wMwmS
 f10U7GcxgAyCItWVo/TdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r6uj6xH0VTM=:9YuPIaednHIdDYYyj9Dctw
 mI3C2Nov8kOTOBa4+sBTqAehQyypwrS6b7mxk76INWAGzG4iUH6U6BGP2UmMKqngKu8Wej5tr
 I5qoOJ5HzHrllBeHBLMAF3X1A2xKMAvz+d4RX5n163vFrZrLZ9Uoy7IUMYUlVrXrkv0uoxgfP
 R03unAyIyn4Vfb2DGaMireJRkgEzI7I3vlWpbSO9suEYoTBXzqc7uuyiKgZPauG6QxE6JBh6k
 pwehtbgPufM2eGN8WebAe7NrknSzASP5P/qMtIPhOEU2YOJz2rOxo9GPO6MMe5U5Cfc2l+VLt
 cRqQhdFXJq2wSrYh118rZUIQNzo3LvYEz4QVAPe2IYUC0wmK1EbnH/P9wHjj8leO7+UdWZkDr
 dxHHB+hrkn+G7wWUcjPjUxbYhjDsuWUEUUf6FmxykJO7LFy5+aLMJf0I3De/uZw/zTXEkqogk
 zjYKRtiepDkN1n0PAiwG8e7QL1PDboCahudRLG1RzhK+VRqpGhlVIO/oGbU2GHEHIqNb2DxAJ
 SfljSL8SFPZW7oZA/gr31aOLHYwcKVk6KggPoVhmVI/zbv0KJ3OKUZtzMHMwKrD3SABZcV2l3
 s0p55mNxsoyK2oJgI13GAwYfoLDUkHD/Lf4eWGn8yzRDWqv82aJbkWEX+iHU01ds+Q7N3CAaf
 PHbbMxmuLs8aBikTAafRTXX3MELQOwbgsibau0LjN4s5jNBh12WF8XLum3fILkbGf670/lTpP
 ZnyRbJlfCvUpQlJuJqS+84A08QipRqviS7w1rjn/64bM67oSjzMIivFozmDL4OmFH+uBsw12 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293193>



On 01.05.16 08:02, Mike Hommey wrote:
> The CONNECT_DIAG_URL code for PROTO_GIT and PROTO_SSH were different in
> subtle ways.
Yes, and there (historical) reasons for that.
The first implementation did support IPV6 with SSH:


commit 5ba884483fe1a5f9ce1ce5e3c5e1c37c0fd296c4
    [PATCH] GIT: Try all addresses for given remote name
   
    Try all addresses for given remote name until it succeeds.  Also
    supports IPv6.

This lead to a regression, which was fixed here:
commit ce6f8e7ec2bbebe2472e23b684cae0a4adf325ad
    Fix git protocol connection 'port' override
   
    It was broken by the IPv6 patches - we need to remove the ":" part from
    the hostname for a successful name lookup.


Later the ssh:// syntax was added:

commit c05186cc38ca4605bff1f275619d7d0faeaf2fa5
    Support git+ssh:// and ssh+git:// URL
   
Later support for [] was added:
commit 356bece0a2725818191b12f6e991490d52baa1d1
    GIT: Support [address] in URLs
    Allow IPv6address/IPvFuture enclosed by [] in URLs, like:
       git push '[3ffe:ffff:...:1]:GIT/git'
    or
       git push 'ssh://[3ffe:ffff:...:1]/GIT/git'

Later, support for a trailing ':' was added:
commit 608d48b2207a6152839a9762c7a66f217bceb440
    Fix "getaddrinfo()" buglet
    So when somebody passes me a "please pull" request pointing to something
    like the following
    	git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
    (note the extraneous colon at the end of the host name), git would happily
    try to connect to port 0, which would generally just cause the remote to
    not even answer, and the "connect()" will take a long time to time out.

Then it was possible to use ssh:// with a port number:
commit 2e7766655abd0312a6bf4db6a6ff141e7e4ac8b6
    URL: allow port specification in ssh:// URLs


Parsing of the port number was improved here:
commit 8f1482536ad680fcd738158e76e254a534f2e690
    connect.c: stricter port validation, silence compiler warning


Then, it was possible to pass the port number to putty or plink:
commit 36ad53ffee6ed5b7c277cde660f526fd8ce3d68f
    connect.c: Support PuTTY plink and TortoisePlink as SSH on Windows

This caused a regression, see below.

Later, there was a fix for [] together with a port number:
commit 7acf438215d1b0e8e47a707f3585de8486a2e5fe
    git: Wrong parsing of ssh urls with IPv6 literals ignores port


A better way to distinguish "local file system" URLS from scp like URLs,
(None of them has a scheme, but they are nice to use)
commit 60003340cda05f5ecd79ee8522b21eda038b994b
    clone: allow cloning local paths with colons in them

This fix lead to another regression, which was partly resolved here
(And that's where test cases came in)
commit 8d3d28f5dba94a15a79975e4adc909c295c80d80
    clone: tighten "local paths with colons" check a bit
   

 In order to allow diagnostics in the parser, the diag-url feature was added:
commit 5610b7c0c6957cf0b236b6fac087c1f4dc209376
    git fetch-pack: add --diag-url
 
The the parser was improved:
commit 6a59974869c0a6e9399101bc02223b4c00a8aff2
    git fetch: support host:/~repo

and refactored:
commit 83b058752707a6ba4af51ebc98c47913bc7d2d25
    git_connect(): refactor the port handling for ssh

And more refactored:
commit c59ab2e52a64abd7fded97e0983a9b7f3d0508a0
    connect.c: refactor url parsing

And more refactored:
commit a2036d7e00ad8aa16ba010a80078e10f0e4568a3
    git_connect(): use common return point

Later the parser was improved:
commit 86ceb337ec340c7db9b060b90bfab05a08b8251b
    connect.c: allow ssh://user@[2001:db8::1]/repo.git
commit 3f55ccab8e0fec73c8e38b909e9bb4963bfb8f6a
    t5500: show user name and host in diag-url

However, one of the refactoring broke a use case,
which was valid before, leading to regressions around the world:

commit 6b6c5f7a2f66751a93afce54277a1f30ab0dc521
    connect.c: ignore extra colon after hostname

Now back to the regression introduced by supporting plink/putty with
ports, it was improved by a preparing commit, followed by the fix:

commit baaf233755f71c057d28b9e8692e24d4fca7d22f
    connect: improve check for plink to reduce false positives

commit 37ee646e72d7f39d61a538e21a4c2721e32cb444
    connect: simplify SSH connection code path

Later IPV6/IPV4 only connections had been supported:
commit c915f11eb4922e154e29cf62d3b549d65c06a170
    connect & http: support -4 and -6 switches for remote operations

I skipped the dates and names (I was responsible for one regression)
I hope this gives a half-correct overview,
why I am reluctant to change any code in connect.c
unless there is a fix for a real world problem.

And even here, the test cases should be changed first (and reviewed) in an own commit.
Marked as test_must_failure.
The c-code can be changed in the next commit, and the TC are marked as "test_expect_success"


Back to another topic:
If you want to support the native Git-support for native HG via hg-serve,
I will be happy to assist with reviews.
Please, if possible, don't touch connect.c at all.
(Beside the memory leak fix).

It may be better to start with a real remote-helper and copy the code from connect.c
And, later, if there are common code paths, refactor stuff.
