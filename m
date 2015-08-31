From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 13:09:55 -0700
Message-ID: <xmqqa8t7usmk.fsf@gitster.mtv.corp.google.com>
References: <1441035616-39128-1-git-send-email-larsxschneider@gmail.com>
	<1441035616-39128-2-git-send-email-larsxschneider@gmail.com>
	<xmqqpp23we4d.fsf@gitster.mtv.corp.google.com>
	<55E4A965.8040305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: larsxschneider@gmail.com, git@vger.kernel.org, luke@diamand.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:10:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVP1-0007GT-OV
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbbHaUJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 16:09:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33438 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbbHaUJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:09:57 -0400
Received: by paczk9 with SMTP id zk9so1366737pac.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=GATzJVjVU1c24sjsVWp8dxbreWX3RZMiu1xyMWTUCqk=;
        b=Zk34qje0Blis7EQFOqP+vsPpvXa5qXmWMYZXm9GHSOoy8w9V0/HZsX74sx+u3sD2N0
         JUW4ucNZsX9P1/LRgO7N78M8FXxv3labgHMXTGjcG/zsaJ0GWmusiCvrBOqgbg/grz6P
         t9BvgRJJUQ762MJwGrFqZ5grgMTChdu7lpAT04VB9U+QSD1arhr+pHgmhAeXjmns23mD
         tdfJwM2S33Q+R0g5TMJ0beHxqD9CiCKnhjzKPtkM+GbywmdFC184U2SzNsTBsvaZVhMn
         RT8aAtXr61/bQaHq66cLTW6L205wap/XuT/5fAXgkDz2UsSlmHf/UEe2VuN1zfN0XGqi
         oU8g==
X-Received: by 10.68.228.36 with SMTP id sf4mr10297841pbc.0.1441051797212;
        Mon, 31 Aug 2015 13:09:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id pf10sm15674387pac.43.2015.08.31.13.09.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 13:09:56 -0700 (PDT)
In-Reply-To: <55E4A965.8040305@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 31 Aug 2015 21:22:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276931>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2015-08-31 19.40, Junio C Hamano wrote:
>> larsxschneider@gmail.com writes:
>
>>> +test_expect_success 'Create a repo containing cp1251 encoded paths=
' '
>>> +	cd "$cli" &&
>>> +
>>> +	FILENAME=3D"$(echo "a-=C2=A4_o-=C2=B6_u-=C2=BC.txt" | iconv -f ut=
f-8 -t cp1252)" &&
>>  ...
> Using file names and iconv like this may not be portable:
> - cp1252 may be called CP1252 (or may not be available)

"git grep 'cp[0-9]' t/" does tell us that we refrain from using them
and I am sure the portability worries is a big reason.  Thank you
for pointing it out.

> - reading from stdin is not necessarily supported by iconv

"git grep '| iconv' t/" tells me that this is irrelevant; we already
heavily depend on it.

> - creating files in CP1252 may not be supported under Mac OS
>    (Not sure about Windows)

The same as the first point, which is a good thing to worry about.

> One solution could be to use ISO-8859-1, convert into UTF-8,
> and "convert into UTF-8" one more time.

I do not quite get it; do you need to do anything more than just
replacing cp1252 with iso-8859-1 in the patch being discussed?
