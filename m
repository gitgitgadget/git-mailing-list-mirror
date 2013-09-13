From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Fri, 13 Sep 2013 15:59:46 +0200
Message-ID: <52331A52.3010300@web.de>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com> <5231CBFA.3070806@web.de> <5231F839.3080208@kdbg.org> <xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com> <CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 16:00:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKTv1-0007Vg-1F
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 16:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933711Ab3IMN74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 09:59:56 -0400
Received: from mout.web.de ([212.227.17.11]:55954 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932691Ab3IMN7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 09:59:54 -0400
Received: from birne.lan ([217.208.218.204]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0MAjet-1VD58H2zLn-00Brsh for <git@vger.kernel.org>; Fri,
 13 Sep 2013 15:59:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com>
X-Provags-ID: V03:K0:U9kzYSXG1L7vlBzoUp0uBZnUhd6sVq0toxWV/d55gsKAlLO5c5b
 Viji9yTOcEBeLo64rCWKqJz7EcQdwQcwOpWi2sCwuPT+SdKbSgdME99tdFuuN0xDsbRvNfo
 Ynb1T6+f58CdAQx0JAmF5rMg7uL65f/NczQg91oVMNgx63rUr0b8VDkgybtxKAU809Qwpuk
 1vb/K3bRFvWDmqfj+lhSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234753>

On 13.09.13 06:55, Jiang Xin wrote:
> 2013/9/13 Junio C Hamano <gitster@pobox.com>:
>> For systems that need POSIX escape hatch for Apollo Domain ;-), we
>> would need a bit more work.  When both path1 and path2 begin with a
>> double-dash, we would need to check if they match up to the next
>> slash, so that
>>
>>  - //host1/usr/src and //host1/usr/lib share the same root and the
>>    former can be made to ../src relative to the latter;
>>
>>  - //host1/usr/src and //host2/usr/lib are of separate roots.
>>
>> or something.
>>
>>
> But how could we know which platform supports network pathnames and
> needs such implementation.
Similar to the has_dos_drive_prefix:

For Windows/Mingw we do like this

mingw.h
#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')

And all other platforms defines has_dos_drive_prefix() to be 0 here
git-compat-util.h
#ifndef has_dos_drive_prefix
#define has_dos_drive_prefix(path) 0
#endif

mingw.h:
#define has_unc_path_prefix(path) ((path)[0] == '/' && (path)[1] == '/')
(Or may be)
#define has_unc_path_prefix(path) (is_dir_sep((path)[0])   && is_dir_sep((path)[1]))
 
