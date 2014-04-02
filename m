From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/22] t3204: test deleting references when lock files
 already exist
Date: Wed, 02 Apr 2014 12:28:14 +0200
Message-ID: <533BE63E.5070508@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-2-git-send-email-mhagger@alum.mit.edu> <20140401195338.GA21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:34:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeMB-0000xS-O0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047AbaDBK2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 06:28:18 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:62444 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758002AbaDBK2R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 06:28:17 -0400
X-AuditID: 1207440d-f79d86d0000043db-ab-533be640c27f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C9.65.17371.046EB335; Wed,  2 Apr 2014 06:28:16 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s32ASE2U015368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 06:28:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <20140401195338.GA21715@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqOvwzDrYoPWaqUXXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7owLbSdYC5ZxVkzsmcfcwLiF
	vYuRk0NCwERiw7LLbBC2mMSFe+uBbC4OIYHLjBIr5vcwQTjnmCR2dzUzg1TxCmhL/P54FayD
	RUBV4tLCv2A2m4CuxKKeZiYQW1QgSOLwhlOsEPWCEidnPmEBsUUEZCW+H97ICGIzC1hLrHh9
	GKxeWCBKovvLShaIZasYJWa2TwA7jxOoqG3jMaAGDqDzxCV6GoNATGYBdYn184QgxshLbH87
	h3kCo+AsJNtmIVTNQlK1gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZI
	QPPuYPy/TuYQowAHoxIP78HzVsFCrIllxZW5hxglOZiURHktn1oHC/El5adUZiQWZ8QXleak
	Fh9ilOBgVhLhFXoMlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAG
	ggwVLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VvfDEwgkFSPEB780DaeYsLEnOB
	ohCtpxh1OTZsW9PIJMSSl5+XKiXOu/EJUJEASFFGaR7cClj6esUoDvSxMK8nyCgeYOqDm/QK
	aAkT0BLudVYgS0oSEVJSDYx8Kj27T8993H1yeV0s83b3ZepHzLZaPbT6WvlR4pPZMeZjBRdO
	fspz7H5wvM9chOXXohV1wn5Z3eo+LzkDEmuYOT8qWE96+Hb/tVKjH8HvCz09L8db 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245683>

On 04/01/2014 09:53 PM, Jeff King wrote:
> On Tue, Apr 01, 2014 at 05:58:09PM +0200, Michael Haggerty wrote:
> 
>> When deleting a reference, it might be that another process already
>> holds the lock on the loose reference file and/or the packed-refs
>> file.  In those cases, there is no alternative but for the delete to
>> fail.  Verify that in such cases the reference values are left
>> unchanged.
>>
>> But in fact, when the packed-refs file lock cannot be acquired, the
>> loose reference file is deleted anyway, potentially leaving the
>> reference with a changed value (its packed value, which might even
>> point at an object that has been garbage collected).  Thus one of the
>> new tests is marked test_expect_failure.
> 
> Nice find. If I understand correctly, the problem is at the plumbing
> level, and this could also be demonstrated with update-ref?
> 
> I don't think it is a big deal, but I was thrown for a minute by the use
> of "git branch" (as in, "is this something special with branches, or is
> this about all refs?").

Good point.  Will change.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
