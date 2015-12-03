From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Make error message after failing commit_lock_file()
 less confusing
Date: Thu, 03 Dec 2015 11:30:34 +0100
Message-ID: <20151203113034.Horde.-yFsRNWlpgbiVEym_u1l1wY@webmail.informatik.kit.edu>
References: <1448883653-9140-1-git-send-email-szeder@ira.uka.de>
 <CAPig+cROdVgf=EL3jKyyPpLiRA_JyHD8P336-YDCWhK8nGSQaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 11:31:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4RAQ-0002qM-8m
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 11:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759616AbbLCKbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 05:31:04 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50886 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759597AbbLCKbB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 05:31:01 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1a4RA7-00028q-Gm; Thu, 03 Dec 2015 11:30:55 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1a4R9m-0000oT-UQ; Thu, 03 Dec 2015 11:30:34 +0100
Received: from x4db27217.dyn.telefonica.de (x4db27217.dyn.telefonica.de
 [77.178.114.23]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 03 Dec 2015 11:30:34 +0100
In-Reply-To: <CAPig+cROdVgf=EL3jKyyPpLiRA_JyHD8P336-YDCWhK8nGSQaQ@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1449138655.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281948>


Quoting Eric Sunshine <sunshine@sunshineco.com>:

>> diff --git a/config.c b/config.c
>> @@ -64,7 +64,8 @@ static void rewrite_credential_file(const char  
>> *fn, struct credential *c,
>>                 print_line(extra);
>>         parse_credential_file(fn, c, NULL, print_line);
>>         if (commit_lock_file(&credential_lock) < 0)
>> -               die_errno("unable to commit credential store");
>> +               die_errno("unable to write credential store: %s",
>> +                         strerror(errno));
>
> Hmm, this is already calling die_errno(), so adding another strerror()
> to the mix seems superfluous.

Oops, of course.

>>  }
>>
>>  static void store_credential_file(const char *fn, struct credential *c)
>> diff --git a/fast-import.c b/fast-import.c
>> @@ -1824,7 +1824,7 @@ static void dump_marks(void)
>>
>>         dump_marks_helper(f, 0, marks);
>>         if (commit_lock_file(&mark_lock)) {
>> -               failure |= error("Unable to commit marks file %s: %s",
>> +               failure |= error("Unable to write file %s: %s",
>>                         export_marks_file, strerror(errno));
>
> Since you're already doing some normalization of the error messages
> with this patch, do you want to drop capitalization on this one?

The neighboring error messages are capitalized as well, as are many  
(but not all) other error and warning messages in fast-import.c.
