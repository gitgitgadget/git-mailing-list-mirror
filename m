From: Ben Maurer <bmaurer@fb.com>
Subject: RE: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Mon, 6 Jan 2014 22:14:30 +0000
Message-ID: <5CDDBDF2D36D9F43B9F5E99003F6A0D4466885EE@PRN-MBX02-1.TheFacebook.com>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
 <20140106145723.GA15489@sigill.intra.peff.net>
 <5CDDBDF2D36D9F43B9F5E99003F6A0D4466883DF@PRN-MBX02-1.TheFacebook.com>,<20140106215713.GA7133@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 23:14:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0IRX-0007Mo-V8
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 23:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704AbaAFWOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 17:14:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29554 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755376AbaAFWOj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 17:14:39 -0500
Received: from pps.filterd (m0044010 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s06M9cUJ026320;
	Mon, 6 Jan 2014 14:14:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=duckJN+xzbSL1tAqQZuZtFsOik9isl9uRcYBTA5urDE=;
 b=EYh6g9DtpISdWHtXX5zZFwUBnuWyIVUnC9cJAenkxxJ9ws6m7Tx8ZBQY+ONOAmSV7VHO
 s9nefKO6V/6F87+4MBP4OtYOqWr/01LlEjB4thwQ00Ul5hb1NOrL2za8+z3jqfGAhDlU
 gqHe2H8ZyAOU0LVmCYTjY7RPZXvJ8e++30w= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1h82rjgney-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Mon, 06 Jan 2014 14:14:32 -0800
Received: from PRN-MBX02-1.TheFacebook.com ([169.254.1.64]) by
 PRN-CHUB01.TheFacebook.com ([fe80::d5cc:849:f520:db6b%12]) with mapi id
 14.03.0174.001; Mon, 6 Jan 2014 14:14:31 -0800
Thread-Topic: [PATCH] [RFC] Making use of bitmaps for thin objects
Thread-Index: AQHO/06wG06Z2WW/kESY1GiAdQ1uTpp4ZrUA//+vgJaAAMXMgP//e6Vm
In-Reply-To: <20140106215713.GA7133@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.16.4]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-06_04:2014-01-06,2014-01-06,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=5.68989300120393e-12 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401060159
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240074>

It looks like for my repo the size win wasn't as big (~10%). Is it possible that with the kernel test you got extremely lucky and there was some huge binary blob that thin packing turned into a tiny delta?

The repo I'm testing with here isn't a typical codebase -- it is used to store configuration information and it has very different update patterns than most codebases.

When you get a chance, it'd be handy if you could push an updated version of your change out to your public github repo. I'd like to see if folks here are interested in testing this more, and it'd be good to make sure we're testing the diff that is targeted for upstream.

Bitmap index, without thin packing:

Counting objects: 158825, done.
Delta compression using up to 32 threads.
Compressing objects: 100% (18113/18113), done.
Writing objects: 100% (158825/158825), 89.87 MiB | 11.23 MiB/s, done.
Total 158825 (delta 139493), reused 153076 (delta 135730)
real 15.60
user 34.38
sys 2.99


Bitmap index, with thin packing:

Counting objects: 158825, done.
Delta compression using up to 32 threads.
Compressing objects: 100% (12364/12364), done.
Writing objects: 100% (158825/158825), 81.35 MiB | 0 bytes/s, done.
Total 158825 (delta 135730), reused 158825 (delta 141479)
real 2.70
user 2.28
sys 0.65


________________________________________
From: Jeff King [peff@peff.net]
Sent: Monday, January 06, 2014 1:57 PM
To: Ben Maurer
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [RFC] Making use of bitmaps for thin objects

On Mon, Jan 06, 2014 at 09:15:04PM +0000, Ben Maurer wrote:

> > Let me know how this patch does for you. My testing has been fairly
> > limited so far.
>
> This patch looks like a much cleaner version :-). Works well for me,
> but my test setup may not be great since I didn't get any errors from
> completely ignoring the haves bitmap :-).

Great. Out of curiosity, can you show the before/after? The timings
should be similar to what your patch produced, but I'm really curious to
see how the pack size changes.

-Peff
