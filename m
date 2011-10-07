From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: 66 patches and counting
Date: Fri, 07 Oct 2011 05:14:22 +0200
Message-ID: <4E8E6E8E.5070909@alum.mit.edu>
References: <4E8CCC55.9070408@alum.mit.edu> <201110061616.39381.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090405060709050706070305"
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 05:14:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC0tO-00046N-AL
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 05:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759519Ab1JGDO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 23:14:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33453 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184Ab1JGDO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 23:14:28 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEA323.dip.t-dialin.net [84.190.163.35])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p973EMDn022556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 7 Oct 2011 05:14:22 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <201110061616.39381.mfick@codeaurora.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183057>

This is a multi-part message in MIME format.
--------------090405060709050706070305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 10/07/2011 12:16 AM, Martin Fick wrote:
> I downloaded your patch series and tested it on my repos.

Very cool (though a bit premature, as you discovered).  The patch series
still has a known performance regression in the area of
do_for_each_ref(), which I hope to figure out soon.  I will definitely
tell you when I think that the patch series is ready for more serious
testing (hopefully today) in the hopes that you can benchmark it against
your repo.

In the future, please tell me the SHA1 of any versions that you test, as
I am still frequently non-ff updating the hierarchical-refs branch.

> Here are the best timings for all the good patches that 
> others have submitted to fix many of the previous problems I 
> brought up:

What are, in your measurements, the "good patches" that you consider
contenders performance-wise?  (I've lost track because there have been
so many suggestions in this area.)

It would be great if you would serve as a kind of benchmarking
referee/clearinghouse for the various suggested patches.  I have been
benchmarking with some rough scripts that I wrote [1]; the current
status is appended below (the numbers are clock times in seconds).  FWIW
the attached output was generated using roughly the following commands:

t/make-refperf-repo --refs=10000 --commits=20000
cp t/refperf-many .
# Adjust REFPERF_BRANCH in ./refperf-many:
$EDITOR ./refperf-many
revs="v1.7.6 v1.7.7 origin/master origin/hierarchical-refs^^
origin/hierarchical-refs^ origin/hierarchical-refs origin/master"
./refperf-many $revs
t/refperf-summary $revs >refperf-summary.out

See the comments at the top of the scripts for more details.  Please
suggest more tests to be added to t/refperf!

> It would be nice if you could rebase your work on top of 
> some of the other patches also so that I could see those 
> results. I might give that a try if I have the time and it 
> is easy (or I might rebase those patches on yours).

I believe that at least some of the other patches will be superseded by
mine.  When I get my patch series done I will look into it in more detail...

Michael

[1] Branch "refperf" at git://github.com/mhagger/git.git

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------090405060709050706070305
Content-Type: text/plain;
 name="refperf-summary.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="refperf-summary.out"

===================================  =======  =======  =======  =======  =======  =======
Test name                                [0]      [1]      [2]      [3]      [4]      [5]
===================================  =======  =======  =======  =======  =======  =======
branch-loose-cold                       5.84     5.38     6.05     0.53     0.47     0.56
branch-loose-warm                       0.12     0.11     0.13     0.00     0.02     0.03
for-each-ref-loose-cold                 6.83     6.45     6.13     8.21     8.69     8.28
for-each-ref-loose-warm                 0.25     0.25     0.25     0.84     0.84     0.84
checkout-loose-cold                     4.55     5.08     5.76     0.73     0.60     0.68
checkout-loose-warm                     0.11     0.11     0.12     0.03     0.02     0.04
checkout-orphan-loose                   0.10     0.10     0.11     0.01     0.02     0.01
checkout-from-detached-loose            0.97     1.05     0.95     7.80     8.27     8.37
branch-contains-loose-cold             14.98    15.44    18.54    16.46    16.91    17.54
branch-contains-loose-warm              9.44     8.97    10.15     9.60     9.58     9.71
pack-refs-loose                         0.97     1.00     1.37     1.69     1.62     1.65
branch-packed-cold                      0.49     0.63     0.81     1.38     1.37     1.45
branch-packed-warm                      0.02     0.02     0.05     0.77     0.74     0.80
for-each-ref-packed-cold                1.18     0.97     1.56     1.33     2.03     1.51
for-each-ref-packed-warm                0.15     0.15     0.16     0.52     0.52     0.50
checkout-packed-cold                    0.84     0.60     0.70     0.96     0.94     1.28
checkout-packed-warm                    0.02     0.09     0.04     0.41     0.41     0.44
checkout-orphan-packed                  0.01     0.02     0.10     0.38     0.39     0.42
checkout-from-detached-packed           6.94     7.35     9.18     1.31     1.35     1.45
branch-contains-packed-cold            11.19    10.81    12.35    10.91    10.09    10.16
branch-contains-packed-warm            10.24     9.90    11.19     9.13     9.07     9.13
clone-loose-cold                       93.77    90.65    98.07    99.03   103.72   101.85
clone-loose-warm                        3.12     3.19     3.24     3.56     3.60     3.50
fetch-nothing-loose                     0.85     0.84     0.87     1.20     1.18     1.21
pack-refs                               0.12     0.13     0.14     0.51     0.54     0.51
fetch-nothing-packed                    0.85     0.84     0.86     1.20     1.19     1.20
clone-packed-cold                       2.17     2.38     2.50     2.28     2.46     2.34
clone-packed-warm                       0.32     0.34     0.39     0.40     0.38     0.30
fetch-everything-cold                  92.37    95.96   102.20   100.80   104.72   106.85
fetch-everything-warm                   5.55     5.65     5.53     6.26     6.27     6.35
===================================  =======  =======  =======  =======  =======  =======


[0] v1.7.6 (refperf.times.d78c84e8698e750139667bc724b08eb34e795b65)
[1] v1.7.7 (refperf.times.a258e475eb74e183e9e68ca30e32c5253081356d)
[2] origin/master (refperf.times.27897d25f1b36d400b82b655701b87fd205dbc2f)
[3] origin/hierarchical-refs^^ (refperf.times.eabcf1ed884d95878f12ca5ea32a3e20c70194f2)
[4] origin/hierarchical-refs^ (refperf.times.be9118234275c4fa6002ef97d989b0d28c94c0bd)
[5] origin/hierarchical-refs (refperf.times.74d1ae38f70f4f97745caf235ef3f34b3e326ad4)


--------------090405060709050706070305--
