From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/8] Introduce new static function real_path_internal()
Date: Sat, 29 Sep 2012 06:56:30 +0200
Message-ID: <50667F7E.7040903@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu> <1348688090-13648-2-git-send-email-mhagger@alum.mit.edu> <7vk3vfp36g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 06:56:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THp6c-0002Mw-Nx
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 06:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab2I2E4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 00:56:37 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:58854 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348Ab2I2E4f (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 00:56:35 -0400
X-AuditID: 1207440c-b7f616d00000270b-a6-50667f82e689
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A6.E9.09995.28F76605; Sat, 29 Sep 2012 00:56:34 -0400 (EDT)
Received: from [192.168.69.140] (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T4uWUW023340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 00:56:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vk3vfp36g.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqNtUnxZg8Py0iUXXlW4mi4beK8wW
	R09ZWKx/d5XZgcVj56y77B4XLyl7fN4kF8AcxW2TlFhSFpyZnqdvl8Cdsf/wdKaC20IVH55z
	NDA+4O1i5OSQEDCRWLb1FDuELSZx4d56ti5GLg4hgcuMEvdXTmWHcM4wSfz9u4uli5GDg1dA
	W2L1E0GQBhYBVYl1s24xgdhsAroSi3qawWxRgRCJGZcnM4PYvAKCEidnPmEBsUUE1CQmth0C
	s5kFMiVavrxjA7GFBbwllt3/wQixazmjxJzbz8ESnAJmErP+rmeCaNCReNf3gBnClpfY/nYO
	8wRGgVlIdsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCEh
	zLOD8ds6mUOMAhyMSjy8WsdTA4RYE8uKK3MPMUpyMCmJ8oZUpwUI8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuHNKAYq501JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8KbW
	AQ0VLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VqfDEwVkFSPEB7/9UCtfMWFyTm
	AkUhWk8x6nKsvbvgAaMQS15+XqqUOG8tyA4BkKKM0jy4FbCE9YpRHOhjYV4XkCoeYLKDm/QK
	aAkT0JKlm5JAlpQkIqSkGhjbfKrCeXxb225vn77Vi2VnudJ0tUU/nKxmTukqfHjlzsx3Gusq
	xQJnflX6q7sn51jgtq0L5vj62p998XjR83dZYqsKLxTqvGxsCfe4+NvGoF2wLjch 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206623>

On 09/27/2012 11:27 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> @@ -54,20 +73,36 @@ const char *real_path(const char *path)
>>  		}
>>  
>>  		if (*buf) {
>> -			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
>> -				die_errno ("Could not get current working directory");
>> +			if (!*cwd && !getcwd(cwd, sizeof(cwd))) {
>> +				if (die_on_error)
>> +					die_errno("Could not get current working directory");
>> +				else
>> +					goto error_out;
>> +			}
>>  
>> -			if (chdir(buf))
>> -				die_errno ("Could not switch to '%s'", buf);
>> +			if (chdir(buf)) {
>> +				if (die_on_error)
>> +					die_errno("Could not switch to '%s'", buf);
>> +				else
>> +					goto error_out;
>> +			}
>> +		}
> 
> The patch makes sense, but while you are touching this code, I have
> to wonder if there is an easy way to tell, before entering the loop,
> if we have to chdir() around in the loop.  That would allow us to
> hoist the getcwd() that is done only so that we can come back to
> where we started outside the loop, making it clear why the call is
> there, instead of cryptic "if (!*cwd &&" to ensure we do getcwd()
> once and before doing any chdir().

I don't see an easy way to predict, before entering the loop, whether
chdir() will be needed.  For example, compare

    touch filename
    ln -s filename foo
    ./test-path-utils real_path foo

with

    touch filename
    ln -s $(pwd)/filename foo
    ./test-path-utils real_path foo

In the first case no chdir() is needed, whereas in the second case a
chdir() is needed but only on the second loop iteration.

All I can offer you is a palliative like the one below.

Michael

diff --git a/abspath.c b/abspath.c
index 5748b91..40cdc46 100644
--- a/abspath.c
+++ b/abspath.c
@@ -35,7 +35,14 @@ static const char *real_path_internal(const char
*path, int die_on_error)
 {
        static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf =
bufs[1];
        char *retval = NULL;
+
+       /*
+        * If we have to temporarily chdir(), store the original CWD
+        * here so that we can chdir() back to it at the end of the
+        * function:
+        */
        char cwd[1024] = "";
+
        int buf_index = 1;

        int depth = MAXDEPTH;

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
