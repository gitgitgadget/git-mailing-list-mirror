From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: fix faulty paths for case insensitive systems
Date: Thu, 20 Aug 2015 08:55:35 -0700
Message-ID: <xmqq37ze7y4o.fsf@gitster.dls.corp.google.com>
References: <1440014686-63290-1-git-send-email-larsxschneider@gmail.com>
	<1440014686-63290-2-git-send-email-larsxschneider@gmail.com>
	<55D55EC9.6050002@web.de>
	<917E3751-4BC8-4034-9101-30C77426D81C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, luke@diamand.org, pw@padd.com,
	torarvid@gmail.com, ksaitoh560@gmail.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 17:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSSBq-0002Ay-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 17:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbbHTPzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 11:55:38 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34324 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbbHTPzh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 11:55:37 -0400
Received: by pdbfa8 with SMTP id fa8so15695044pdb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=D7ivIDIOujoRuSjtpP6RQiFjkiFRN7FWOd0wK0Bc6/Q=;
        b=v1fFWTIDGQTsbbYAYX6w6qQu60Ft3Oe2+PRqD5C/+ZYpn0JAUPuMXfbDSKH4ANTdwE
         R2SAKtfnJOI1WhRym/etvb/cei2wDNYjIdBa+DJKtzIOVHGVDq7NRL0RocNttgL45AIW
         T/eQamrk6P7yfw+0URQGD9BuYR0UV7PKfbEbYrfug85XobgXrdEIrPmU17Hgjfcr3bSM
         nvJjoAzo04wsPiDDd8sQK+qfQigVwVoRj3T68XW4t13khejowk73fXJVSr1DPoZnUZWk
         BcF6Xx4Elm/KocI9vXM2YyEhfnXbPwEoWrtZFEXaoi/0SZNsxeEfZlnPRHGf1P3rwV01
         +HHg==
X-Received: by 10.70.7.162 with SMTP id k2mr7627880pda.128.1440086136914;
        Thu, 20 Aug 2015 08:55:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id y1sm2955856pdh.37.2015.08.20.08.55.35
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 20 Aug 2015 08:55:35 -0700 (PDT)
In-Reply-To: <917E3751-4BC8-4034-9101-30C77426D81C@gmail.com> (Lars
	Schneider's message of "Thu, 20 Aug 2015 09:16:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276249>

Lars Schneider <larsxschneider@gmail.com> writes:

>>> +		find . | grep TWO/file1.txt &&
>>> +		find . | grep TWO/File2.txt &&
>>> +		find . | grep TWO/file3.txt &&
>> Not sure about the find | grep here either.
> See answers above.

These are not very good tests; they will match "OTWO/file1.txto",
too.  Besides, it is wasteful to run find three times.

        find ?* -print | sort >actual &&
        cat >expect <<-\EOF &&
        TWO/file1.txt
        ...
        EOF
	test_cmp expect actual

or something like that instead?
