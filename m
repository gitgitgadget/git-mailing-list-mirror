From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v3 05/10] abspath: convert real_path_internal() to strbuf
Date: Tue, 29 Jul 2014 00:20:33 +0200
Message-ID: <53D6CCB1.7000809@web.de>
References: <53D694A2.8030007@web.de> <53D6964E.1070100@web.de> <20140728190946.GC11265@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBtHr-0001qH-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 00:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbaG1WUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 18:20:51 -0400
Received: from mout.web.de ([212.227.15.4]:58568 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbaG1WUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 18:20:50 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M24vT-1WMo6C0Skt-00u4v1; Tue, 29 Jul 2014 00:20:35
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140728190946.GC11265@peff.net>
X-Provags-ID: V03:K0:RfCK+mMjLnS8RQQlll/8WQ4VgBycpZonEkEqaMzUJCiKZ+b0ADI
 iObAiyzrPDWlDz4H4uqXZKCZ0GVdojHnv3rBzolcC6s3tNVBGuuYh8GqA0yyCjZW/vy4B5i
 ToYObb4Q5FkPnkis2AEyjaV6iz3FgYpuEyA9g/PIFmtBK5DqysJE7kKanVMJRo1tVfhvN/P
 VklCxopBf78ql4G7SeM0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254359>

Am 28.07.2014 um 21:09 schrieb Jeff King:
> On Mon, Jul 28, 2014 at 08:28:30PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>   static const char *real_path_internal(const char *path, int die_on=
_error)
>>   {
>> -	static char bufs[2][PATH_MAX + 1], *buf =3D bufs[0], *next_buf =3D=
 bufs[1];
>> +	static struct strbuf sb =3D STRBUF_INIT;
>
> Hrm. I thought at first that this was our usual trick of keeping two
> "simultaneous" static buffers, so that we can do:
>
>    printf("paths '%s' and '%s'\n", real_path(foo), real_path(bar));
>
> But it looks like that is not the case, and we only have two for
> swapping back and forth as we figure out the answer (but they both ne=
ed
> to be static, because we do not know which one we will return in the
> end). Is that right?

AFAICS it's only swapped to avoid copying the results of a readlink()=20
call against one buffer into the other.  So, yes, that's how I=20
understand it as well.

Ren=C3=A9
