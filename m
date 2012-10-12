From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Fri, 12 Oct 2012 22:28:13 +0200
Message-ID: <50787D5D.3080509@web.de>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com> <7vd30panxo.fsf@alter.siamese.dyndns.org> <7v1uh5aar7.fsf@alter.siamese.dyndns.org> <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com> <507848DF.6060301@web.de> <7vbog74o59.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 22:29:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMlqy-0006nW-29
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 22:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414Ab2JLU2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 16:28:31 -0400
Received: from mout.web.de ([212.227.15.4]:55630 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab2JLU2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 16:28:31 -0400
Received: from wanderer.site ([195.67.191.22]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LpwMZ-1Ttbxb3LHz-00fFLv; Fri, 12 Oct 2012 22:28:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <7vbog74o59.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:Q+GUM5Ctr+TD9WetbTpErNm77eXJRdCLT0GBCHxqOJu
 ZkgBt2trCSEBXoQ3MHiGNLpdG2m+Wn+H06a47Vb1ITPoT1rTnG
 3uNxPCpxXHUCmakG5Ku0WAXWmAswrJiRpOJfWXNdkzWmXuDfFj
 peaqMjKk3YEiba+iGt7kCbASHovEOlzKehWei2Vw64qWGgZVlU
 yJOiicbuTLO60PtL4xIdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207564>

On 10/12/2012 07:05 PM, Junio C Hamano wrote:
>> Some problems even here (Mac OS) commit 2aeb6d4d7884f4c4425
>>
>> not ok 61 - wildmatch 0 0 \ \
>> not ok 62 - wildmatch 0 0 /\ */\
>> not ok 69 - wildmatch 1 1 [ab] [[:]ab]
>> not ok 71 - wildmatch 1 1 [ab] [[:digit]ab]
>> not ok 80 - wildmatch 1 0 1 [[:digit:][:upper:][:space:]]
>> not ok 81 - wildmatch 0 0 1 [[:digit:][:upper:][:spaci:]]
>> not ok 88 - wildmatch 1 0 _ [[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]
>> not ok 89 - wildmatch 1 0 _ [[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]
>> not ok 93 - wildmatch 1 1 y [a-c[:digit:]x-z]

> Nguyen, how about updating the match () shell function in 3070 so
> that it not just says not-ok, but indicates what failed (wildmatch
> failed, or wildmatch passed but fnmatch failed), at least when the
> test is run as "./t3070-*.sh -v -i"?

It seams to be the fnmatch, since removing the
fnmatch makes t3070 pass.

However, pullling in compat/fnmatch in the Makefile

  ifeq ($(uname_S),Darwin)
+       NO_FNMATCH = YesPlease

================
gives this result:
  ./t3070-wildmatch.sh 2>&1 | grep "not ok"
not ok 23 - wildmatch 1 1 a]b a[]]b
not ok 25 - wildmatch 1 1 a]b a[]-]b
not ok 43 - wildmatch 1 1 /foo **/foo
not ok 79 - wildmatch 1 1 A [[:digit:][:upper:][:space:]]
not ok 84 - wildmatch 1 1 . [[:digit:][:punct:][:space:]]
not ok 85 - wildmatch 1 1 5 [[:xdigit:]]
not ok 86 - wildmatch 1 1 f [[:xdigit:]]
not ok 87 - wildmatch 1 1 D [[:xdigit:]]
not ok 90 - wildmatch 1 1 . 
[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space:][:upper:][:xdigit:]]
not ok 92 - wildmatch 1 1 b [a-c[:digit:]x-z]
not ok 95 - wildmatch 1 1 ] [\\-^]
not ok 98 - wildmatch 1 1 ] [\]]

(Confused)
