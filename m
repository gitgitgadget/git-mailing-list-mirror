From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Scalable reference handling
Date: Fri, 07 Oct 2011 17:51:46 +0200
Message-ID: <4E8F2012.90108@alum.mit.edu>
References: <4E8CCC55.9070408@alum.mit.edu> <201110061616.39381.mfick@codeaurora.org> <4E8E6E8E.5070909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090801080100060904050304"
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 17:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCCiN-0001BB-9F
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 17:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab1JGPvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 11:51:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37600 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab1JGPvy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 11:51:54 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p97Fplge007960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 7 Oct 2011 17:51:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4E8E6E8E.5070909@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183082>

This is a multi-part message in MIME format.
--------------090801080100060904050304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 10/07/2011 05:14 AM, Michael Haggerty wrote:
> On 10/07/2011 12:16 AM, Martin Fick wrote:
>> I downloaded your patch series and tested it on my repos.
> 
> Very cool (though a bit premature, as you discovered).  The patch series
> still has a known performance regression in the area of
> do_for_each_ref(), which I hope to figure out soon.  I will definitely
> tell you when I think that the patch series is ready for more serious
> testing (hopefully today) in the hopes that you can benchmark it against
> your repo.

I just pushed versions to github that I think are ready for some
preliminary testing.  There were some silly inefficiencies in the
version that you tested earlier, so this version is considerably faster
in a few key tests.

I don't have complete benchmarking results, but I have attached what I
have.  I wouldn't put much weight on small differences in the numbers
because the computer was not 100% quiescent while I ran the tests.  But
I think the results are impressive: the new code (columns 5-8) is a bit
slower in only a few cases but faster (sometimes by a large factor) in
many other cases.

I can't write more now, but Martin, if you have time to benchmark
9944c7faf903a95d4ed9de284ace32debe21cdc1 against your repository, I
would be very interested to learn the results.

BTW I am not asking anybody to review the patch series yet; I would like
to do some more tests and cleanup first.  But of course I wouldn't
object to feedback.  A good starting point would be the comments at the
top of refs.c, where the basic data structures are explained.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------090801080100060904050304
Content-Type: text/plain;
 name="refperf-summary-3.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="refperf-summary-3.out"

===================================  =======  =======  =======  =======  =======  =======  =======  =======  =======
Test name                                [0]      [1]      [2]      [3]      [4]      [5]      [6]      [7]      [8]
===================================  =======  =======  =======  =======  =======  =======  =======  =======  =======
branch-loose-cold                       5.14     5.80     4.98     4.55     5.03     0.41     0.45     0.45     0.51
branch-loose-warm                       0.10     0.12     0.12     0.19     0.11     0.02     0.02     0.03     0.02
for-each-ref-loose-cold                 6.02     6.36     7.48     5.62     6.27     5.32     5.02     5.24     5.01
for-each-ref-loose-warm                 0.25     0.25     0.27     0.25     0.25     0.26     0.26     0.25     0.26
checkout-loose-cold                     5.47     5.03     5.66     5.39     5.72     0.65     0.77     0.95     0.59
checkout-loose-warm                     0.11     0.11     0.11     0.11     0.11     0.02     0.03     0.03     0.03
checkout-orphan-loose                   0.09     0.09     0.10     0.10     0.10     0.03     0.01     0.01     0.02
checkout-from-detached-loose-cold        N/A      N/A      N/A      N/A      N/A      N/A      N/A      N/A      N/A
checkout-from-detached-loose-warm        N/A      N/A      N/A      N/A      N/A      N/A      N/A      N/A      N/A
branch-contains-loose-cold             14.69    13.95    13.76    13.84    14.07    14.08    14.12    14.01    14.77
branch-contains-loose-warm              8.99     8.89     8.74     8.82     8.80     8.81     8.84     8.76     8.91
pack-refs-loose                         1.23     1.02     1.02     1.02     1.01     1.02     1.00     0.99     1.03
branch-packed-cold                      0.66     0.65     0.84     0.67     0.52     0.76     0.58     0.55     0.59
branch-packed-warm                      0.01     0.01     0.03     0.03     0.02     0.02     0.05     0.02     0.05
for-each-ref-packed-cold                1.38     1.29     1.07     1.13     1.05     1.08     1.26     1.05     1.27
for-each-ref-packed-warm                0.17     0.16     0.17     0.17     0.17     0.16     0.17     0.16     0.16
checkout-packed-cold                    8.74     7.75     7.75     1.59     1.61     1.79     1.54     1.55     1.53
checkout-packed-warm                    0.03     0.05     0.04     0.04     0.05     0.05     0.03     0.05     0.06
checkout-orphan-packed                  0.04     0.01     0.01     0.03     0.02     0.02     0.05     0.05     0.02
checkout-from-detached-packed-cold      8.88     8.22     8.12     1.98     1.81     1.94     1.99     1.88     1.97
checkout-from-detached-packed-warm      6.55     6.43     6.44     0.44     0.46     0.45     0.46     0.46     0.49
branch-contains-packed-cold            11.59    10.73    10.37     9.42     9.24     9.40     9.37     9.56     9.34
branch-contains-packed-warm            10.20     9.79     9.83     8.68     8.61     8.68     8.61     8.82     9.33
clone-loose-cold                      105.58    86.98    89.42    88.96    88.19    87.01    87.20    87.11    88.20
clone-loose-warm                        3.26     3.11     3.18     3.10     3.17     3.14     3.14     3.21     3.16
fetch-nothing-loose                     0.85     0.84     0.86     0.85     0.84     0.88     0.84     0.84     0.84
pack-refs                               0.12     0.14     0.16     0.13     0.15     0.14     0.14     0.15     0.14
fetch-nothing-packed                    0.84     0.84     0.86     0.85     0.89     0.85     0.84     0.84     0.83
clone-packed-cold                       2.72     2.33     2.11     2.19     2.23     2.14     2.24     2.01     2.16
clone-packed-warm                       0.40     0.40     0.33     0.40     0.28     0.29     0.33     0.31     0.31
fetch-everything-cold                 106.28    92.92    94.12    88.76    91.62    88.75    89.49    89.78    91.43
fetch-everything-warm                   5.56     5.63     5.70     5.62     5.63     5.66     5.69     5.71     5.78
===================================  =======  =======  =======  =======  =======  =======  =======  =======  =======


[0] v1.7.6 (refperf.times.d78c84e8698e750139667bc724b08eb34e795b65)
[1] v1.7.7 (refperf.times.a258e475eb74e183e9e68ca30e32c5253081356d)
[2] origin/master (refperf.times.27897d25f1b36d400b82b655701b87fd205dbc2f)
[3] 16583974c20b856bb60b5a733020425c16a19670^ (refperf.times.558b49c8489c95cf966b959c3444c95d177dc4dc)
[4] 16583974c20b856bb60b5a733020425c16a19670 (refperf.times.16583974c20b856bb60b5a733020425c16a19670)
[5] origin/hierarchical-refs^^^^ (refperf.times.5f5a126553eef88455f7deb2745c5f93073bfe69)
[6] origin/hierarchical-refs^^^ (refperf.times.a306af145856f8296bf2ff4a3ace5e86ac3b1fc8)
[7] origin/hierarchical-refs^ (refperf.times.fd53cf7a7fcc360f30ea0ec5b964cefeec70c11b)
[8] origin/hierarchical-refs (refperf.times.9944c7faf903a95d4ed9de284ace32debe21cdc1)


--------------090801080100060904050304--
