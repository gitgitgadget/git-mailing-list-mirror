From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 4 Feb 2016 20:39:56 +0000
Message-ID: <56B3B71C.1000907@ramsayjones.plus.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
 <1454443734.5545.1.camel@twopensource.com>
 <CACsJy8Cau0mpz8zVjvz7RPt-s=xmaCCmz0p8OCup9-Q1MnwWCQ@mail.gmail.com>
 <1454617535.5545.10.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 21:40:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRQhA-0003bf-R9
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 21:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933136AbcBDUkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 15:40:00 -0500
Received: from avasout04.plus.net ([212.159.14.19]:46233 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933045AbcBDUj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 15:39:59 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id ELfw1s0014mu3xa01LfxkH; Thu, 04 Feb 2016 20:39:57 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=6NG_XSeZAAAA:8 a=zh6Lpc9XrAXnAO6vC3IA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1454617535.5545.10.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285493>



On 04/02/16 20:25, David Turner wrote:
> On Thu, 2016-02-04 at 18:42 +0700, Duy Nguyen wrote:
>> On Wed, Feb 3, 2016 at 3:08 AM, David Turner <
>> dturner@twopensource.com> wrote:
>>> Are there any more reviews on this?  I do have some changes from
>>> this
>>> set, but they're pretty minor so I don't want to post a new one
>>> (unless
>>> folks would rather see those changes before reviewing).  Let me
>>> know.
>>
>> Last note. Since this is new code, maybe you can wrap translatable
>> strings with _(), basically any visible string that machines do not
>> need to recognize.
> 
> Fixed, thanks. 

Another minor point, could you please squash this in:

diff --git a/refs.c b/refs.c
index 3d4c0a6..4858d94 100644
--- a/refs.c
+++ b/refs.c
@@ -17,7 +17,6 @@ static const char split_transaction_fail_warning[] =
 /*
  * We always have a files backend and it is the default.
  */
-struct ref_storage_be refs_be_files;
 static struct ref_storage_be *the_refs_backend = &refs_be_files;
 /*
  * List of all available backends

The above (on Linux, anyway) is a 'tentative definition' of the
refs_be_files variable and so a common symbol definition is issued
in refs.o. This then gets 'combined' with the *actual* symbol
definition in  refs/files-backend.c. So everything 'works', except
that I have used some unix (let alone non-unix) systems which would
not output a common symbol for the above and would fail to link
with a 'multiple symbol definition' error.

[Also note that an external declaration is already in effect from
the refs/refs-internal.h header file! ;-) ]

ATB,
Ramsay Jones
