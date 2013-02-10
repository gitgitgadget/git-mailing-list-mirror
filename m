From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-bisect.txt: clarify that reset finishes bisect
Date: Sat, 9 Feb 2013 17:49:00 -0800
Message-ID: <20130210014900.GA7682@elie.Belkin>
References: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Mohr <andi@lisas.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:49:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4M34-0002p6-Ul
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 02:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760924Ab3BJBtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 20:49:11 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39848 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760903Ab3BJBtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 20:49:10 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so2677963pad.0
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 17:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CzaUv9rW63xiwfxuZSiXK4oYnqvtjbJA5yZFEKcgbIA=;
        b=Va/4FqjDlzKDUAIIFjZNcJIMfDuEsainJupLB+/m8Ff1/b3z+OX/fjrSpUX53sSbMr
         nDD6JyqIO1f/BpUrsNDisaz9TFA1TsV2X+wUfUPEg6gUchwLhJtbKFE5GrdSu1x4tpS/
         LQ/t4SIryfK3V9OIYNR4hj4lY3p31y/rs0syO2zXnPzucwdbLMh5hM6zx9beGBx6J3sH
         vv78nkpQXaPY2fqBcCEbbzuz2yKzvUPelTd8ZqYR3wehuOOv762mAdBf3xflEK9LlRS9
         F4VkGegHzXng2poQVkmHL+laKmK5io0BI+QcSOs42lwl3ekF/lTsXujv6pAYkVnMYJ8k
         85iQ==
X-Received: by 10.68.203.202 with SMTP id ks10mr7278096pbc.150.1360460949365;
        Sat, 09 Feb 2013 17:49:09 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id d1sm62105708pav.6.2013.02.09.17.49.06
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Feb 2013 17:49:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215891>

Hi,

Michael J Gruber wrote:

> "reset" can be easily misunderstood as resetting a bisect session to its
> start without finishing it. Clarify that it actually finishes the bisect
> session.

FWIW,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Addressing Andreas's original concern about the discoverability of
'git bisect reset' would presumably require doing two more things:

 1. adding an example of the normal bisection workflow to the EXAMPLES
    section

 2. training users to look to the EXAMPLES section

That is, something like the below.  But I'm not happy with it, because
it just runs over the same material as the current Description
section.  Maybe the current tutorial material could be moved to
examples and replaced with something terser that fleshes out the
descriptions in "git bisect -h" output.  What do you think?

diff --git i/Documentation/git-bisect.txt w/Documentation/git-bisect.txt
index e4f46bc1..b89abd78 100644
--- i/Documentation/git-bisect.txt
+++ w/Documentation/git-bisect.txt
@@ -356,6 +356,54 @@ $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
 This shows that you can do without a run script if you write the test
 on a single line.
 
+* Bisect to find which patch caused a boot failure:
++
+Install a recent kernel:
++
+------------
+$ cd ~/src/linux
+$ git checkout origin/master
+$ make deb-pkg # or binrpm-pkg, or tar-pkg
+$ dpkg -i ../<name of package> # as root (or rpm -i, or tar -C / -xf)
+$ reboot # as root
+------------
++
+Hopefully it fails to boot, so tell git so and begin bisection:
++
+------------
+$ cd ~/src/linux
+$ git bisect start HEAD v3.2 # assuming 3.2 works fine
+-------------
++
+A candidate revision to test is automatically checked out.
+Test it:
++
+-------------
+$ make deb-pkg # or binrpm-pkg, or tar-pkg
+$ dpkg -i ../<name of package> # as root (or rpm -i, or tar -C / -xf)
+$ reboot # as root
+-------------
++
+Record the result:
++
+-------------
+$ cd ~/src/linux
+$ git bisect good # if it booted correctly
+$ git bisect bad # if it failed to boot
+$ git bisect skip # if some other bug made it hard to test
+-------------
++
+Repeat until bored or git prints the "first bad commit".  When
+done:
++
+-------------
+$ git bisect log >log # let others pick up where you left off
+$ git bisect reset HEAD # exit the bisecting state
+-------------
++
+At any step, you can run `git bisect visualize` to watch the
+regression range narrowing.
+
 * Locate a good region of the object graph in a damaged repository
 +
 ------------
