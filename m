From: Ephrim Khong <dr.khong@gmail.com>
Subject: Re: [PATCH v3] sha1_file: do not add own object directory as alternate
Date: Wed, 16 Jul 2014 08:47:43 +0200
Message-ID: <53C6200F.30103@gmail.com>
References: <53BFB055.206@gmail.com>	<xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>	<53C26309.5040401@gmail.com> <53C39CB0.6040909@gmail.com>	<CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com>	<53C3D2AD.9050204@gmail.com> <53C4BFC7.2000507@kdbg.org>	<53C510A9.4010208@gmail.com> <xmqq8unuv1wm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:48:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7J0o-0002gJ-3L
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 08:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934815AbaGPGsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 02:48:18 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:41522 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbaGPGsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 02:48:17 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so406097wgh.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 23:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AVL8cZF1P3jli1/rMmbOQpwdYM2KHVPfjkY19YclMy0=;
        b=Ov+ij3Mp2ZOKoAW1ao+q8a+OptBsGnSnYUOFQSrirN9bt4tg41vEx8i3oacqMUxtr4
         yw8uuVbsQA5EXMrK54E7vQAr9xYepKSEHZH2xHFpZKfx3PabN3kBPPwvzt0Gd46S8ZPq
         b3NlLwhiO9osiC8mJ7SmjhTjPCai8/IdGaRtuXi7am+TZFvHEl7T0eOZFx4WXzC8OtZ3
         sVMuQiHRSvEnduMivVMQSay7Gb51hJ0xr9RlPRGJ281sJBI9jZnOZ6wSyHSx5C6ZGOb5
         1MP2eXcqM8kRH8wQB3kpPJa4XWHzdopGa60N27KspJwGSBtClYiTJV3rczxOeeWP++ja
         kwqQ==
X-Received: by 10.180.7.230 with SMTP id m6mr10951042wia.3.1405493296303;
        Tue, 15 Jul 2014 23:48:16 -0700 (PDT)
Received: from [192.168.32.231] (merlin.mvtec.com. [62.96.232.130])
        by mx.google.com with ESMTPSA id w9sm5341543wif.12.2014.07.15.23.48.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 23:48:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq8unuv1wm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253657>

On 15.07.2014 21:48, Junio C Hamano wrote:
> Ephrim Khong <dr.khong@gmail.com> writes:
>> +test_expect_success setup '
>> +	GIT_OBJECT_DIRECTORY=.git//../.git/objects &&
>> +	export GIT_OBJECT_DIRECTORY &&
>
> Do you need this artificially strange environment settings for the
> problem to manifest itself, or is it sufficient to have a
> non-canonical pathname in the info/alternates file?

The test should check the normalization of both the paths in 
info/alternates and of GIT_OBJECT_DIRECTORY, so I'd prefer to leave it 
in. It is not necessary to reproduce the original problem, though.

> Exporting an environment early in the test and having later tests in
> the file depend on it makes it harder to debug when things go wrong,
> than leaving an info/alternates file in the repository, primarily
> because the latter can be inspected more easily in the trash
> directory after "t7702-*.sh -i" dies, hence the above question.

That sounds reasonable. The variable is not required at the 
initialization anyway, so I'll set it right before the actual test and 
wrap it into a subshell to make debugging easier.
