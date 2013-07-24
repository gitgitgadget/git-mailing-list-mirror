From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v8 3/4] tests: add new test for the url_normalize function
Date: Wed, 24 Jul 2013 11:43:59 -0700
Message-ID: <D00D01B3-6B93-4881-9CA3-4745799373C5@gmail.com>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79> <60d85be89d27515d913ae15e10c332f@f74d39fa044aa309eaea14b9f57fe79> <20130724065933.GC30074@sigill.intra.peff.net> <7vy58v6fsc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 20:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V242l-0003yT-57
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 20:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab3GXSoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 14:44:06 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:65167 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab3GXSoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 14:44:04 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so10116577pbc.9
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=58gQHKmxxM3HIaUOBItlHFOT72xjx/anRWPiMpHBZm8=;
        b=M/1VqO70gPidQFoE/ZECcm4n42qBrVVvigfVsOB+ZlLszArycwGRqMKKGBW9b9onIG
         o/gOvlzgU2MLyMSwwlCiFLZG3Lnws0qp/Ff9SBzsAu5dJv5CvWc69yiaQg2NG6E+sDwS
         DgpHM/KQ8n0/yMKol5HzRKUWqlWgXlTi7C+Ob44YsovcW40GdfhiaPLPK+mqz+NK1Bqc
         Nlnx3tKeVgDgv+NveCGZ6g+DXOohrtVVJgEGLpSniSUAk2gbftc3WbsV2oeqKQ72J9iD
         Z7Pw3O7Qdlw+HQfio6k3sCTODPT7g/0YvdSvasmSwkhYBwsk54FzDvyVrt2hkyeve4JK
         ehOw==
X-Received: by 10.67.1.68 with SMTP id be4mr44089396pad.161.1374691443138;
        Wed, 24 Jul 2013 11:44:03 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id pv5sm52951513pac.14.2013.07.24.11.44.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jul 2013 11:44:01 -0700 (PDT)
In-Reply-To: <7vy58v6fsc.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231109>

On Jul 24, 2013, at 10:14, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> How hard would it be to convert the "-c" option of test-url-normalize
>> into something like:
>>
>>  git config --file=foo --url http noepsv $URL
>>
>> which would look for http.$URL.noepsv matches.
>
> Lovely.

[snip]

> Another thing we may want to consider is to see if we can
> restructure the http_options interface a bit, so that the caller can
> be agonistic to the actual meaning of the key.  For example,
>
>  "git config --url http notknownyet $URL"
>
> may want to be able to show the value for http.<pattern>.notknownyet
> for the most matching <pattern> for a given $URL, without knowing
> what the variable means, just like any other configuration that is
> queried via the "git config" program.  The caller may want to pass
> further type information like --bool, --int and --path as needed.
>
>>> +#define url_normalize(u) http_options_url_normalize(u)
>>
>> Does this macro do anything besides shorten the name? Is the extra
>> level of indirection to the reader worth it?
>
> Probably not.

It's a hint that the name of the function might change.  If it's going  
to be used in a more generic fashion it may not belong in http.c  
anymore in which case the name will likely change along with the  
location.  Nothing about the normalization function requires CURL or  
http/https, so it would work equally well on rsync, ftp, smtp etc.  
urls and could just move into url.{h,c} as url_normalize.
