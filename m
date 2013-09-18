From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v3 2/3] relative_path should honor DOS and UNC paths
Date: Wed, 18 Sep 2013 17:02:12 +0800
Message-ID: <CANYiYbF1XwKbD13AMZhE1c4hGMqVzpH9hZ-J8Gk-8AVFUCnn0g@mail.gmail.com>
References: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com>
	<2c56935842ceef4d5933c299dd2d55286eb0ba3a.1379406453.git.worldhello.net@gmail.com>
	<xmqqli2v1l7f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 11:02:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMDeM-0002GR-T9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 11:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab3IRJCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 05:02:14 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:47191 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab3IRJCN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 05:02:13 -0400
Received: by mail-wg0-f41.google.com with SMTP id l18so5433540wgh.2
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ct8OjUjGMMKOqrVZYzhlXyvw2/hbDar5g7Nq/iwLe7I=;
        b=loLAQIB70PLpS6s1wyDRnhOSMQgEyfqaCG60wGlWZC6fSFLofc8jLljnm6p1c1HRLm
         OZiO/d3HTT9+KGsMxzpnqHJ+uJDc08KjRZtow7cxhSwG+sQ32u+bsrwHcas2lmHs0/pr
         IRMnZ/oL/3/0V0hQa2QKMTGEsAoR0gynOwxkmqFyF8YKJPcZRmDe+xxC8keMWEXP65H6
         koulX2Syvfg8KAwzMYkuaZ68P0zOzecEYMcZ/3q02b4SuvjX3qt2o8DKgMWMtiUPFMod
         8mXFV6bznGze+vRJzvBdb/nGJWdkZwWvL8odVZOeHLBwg9VRQZ0RkCIGHT742wTHFzjs
         ro+w==
X-Received: by 10.194.21.131 with SMTP id v3mr934169wje.44.1379494932329; Wed,
 18 Sep 2013 02:02:12 -0700 (PDT)
Received: by 10.216.122.202 with HTTP; Wed, 18 Sep 2013 02:02:12 -0700 (PDT)
In-Reply-To: <xmqqli2v1l7f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234958>

2013/9/18 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> diff --git a/compat/mingw.h b/compat/mingw.h
>> index bd0a88b..06e9f49 100644
>> --- a/compat/mingw.h
>> +++ b/compat/mingw.h
>> @@ -311,6 +311,15 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
>>
>>  #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
>>  #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
>> +static inline int is_unc_path(const char *path)
>> +{
>> +     if (!is_dir_sep(*path) || !is_dir_sep(*(path+1)) || is_dir_sep(*(path+2)))
>> +             return 0;

A UNC path must start with two slashes, but not three or more slashes.

>
> If path[1] == '\0', it would be !is_dir_sep() and we end up
> inspecting past the end of the string?

The funciton "is_unc_path" will return false (0), if path is
"", "/", "//", "///three/slashes/", or "/usr/local".
So the problem is ?

-- 
Jiang Xin
