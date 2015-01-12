From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv12 06/10] receive-pack.c: negotiate atomic push support
Date: Mon, 12 Jan 2015 15:43:59 -0800
Message-ID: <CAGZ79kaxFqtxBE+LaWbh92b8RK-qganuADjsnwHU5WO-oJebcw@mail.gmail.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
	<1420687404-13997-7-git-send-email-sbeller@google.com>
	<CAPig+cQv6Dr7z56qXiqzZLmuBt=_TWcPSpQSTyLv0euT-k+umA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:44:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAoeU-0003F0-It
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 00:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbbALXoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 18:44:01 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:41225 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbALXoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 18:44:00 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so28155960iec.8
        for <git@vger.kernel.org>; Mon, 12 Jan 2015 15:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mUuentTOnste8MqsdkKwOpN3qLC5TWDhqSIIYDYWLoM=;
        b=SU3knWkMG3iFADswKkws3upZNyV/Vfios0CLOx8GbVtDrQ+Y0CXuwiKjyHZx8OqNwn
         go1ARCoTEbCB2g53enzyCr7YSYMf0XVUa81DTFSOitKKsFfC4IlRQEslps/0BB2p/qfn
         cvf6RShquNltQtbMynmPG9oLFeAjw/iMcAisuYS1fiSxJYbcnXeIZ+mUTQ1n2nen8Sxf
         Dt77+XjxmHEi52ZCHDg37J+7WPzyPNvA0iUc5gbmL7cEZZOIB5PDG7XIIMdj8Cgh0/QC
         8yW6bDaPUbeYsQiTPtqd2zgwrORT2elNzM+fqZkxAWzorUCOjT+vFbCiw38EbvzPDHRH
         XzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mUuentTOnste8MqsdkKwOpN3qLC5TWDhqSIIYDYWLoM=;
        b=WSkLW2mlg2akTLUofouNhESutbvIVsK10on2GgZA8TpDk6ywi+71Te3nkfoO4iwsy0
         waVl/hemOWZDSC8VuiRDhxB4beDi+pJPP5JlS5akHSnPlM9GEsCJCkuTGXSDt4uQeIsw
         dpKZKgRAQYEzx0XZhtLkTosoIHXAiU3WNvX0eL6d8vW3iHhErL3aKBLM4iggEVKWU0eq
         YtkkxEWmeeVP/HAlAkfaX6uCqhQ/ccSoNsO0tl0llGYGJiyraTfgvA/rlqN20zNid4YZ
         OirqpkztVtzQieiOcESzkx6jU9yQ4yWSalMk6I0gEV8KDmc+DylBJ8TpavgKWQ+Z095N
         39CQ==
X-Gm-Message-State: ALoCoQkKRmiqLu1h74JLVkbtVexfd5iqHndIYtf3hOfdUOMFi2xvuRKPtyoT+iueSEfyf4WTzYAQ
X-Received: by 10.50.117.68 with SMTP id kc4mr18013390igb.25.1421106239527;
 Mon, 12 Jan 2015 15:43:59 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 12 Jan 2015 15:43:59 -0800 (PST)
In-Reply-To: <CAPig+cQv6Dr7z56qXiqzZLmuBt=_TWcPSpQSTyLv0euT-k+umA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262304>

On Mon, Jan 12, 2015 at 3:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:

> Is this needed only to support the tests you add in t5543, or do you
> intend it to be useful to end users?
>
> If it is for end users, then it deserves to be documented. Is also
> deserves proper mention and justification in the commit message.
>
> If it's only intended to assist automated testing, then perhaps
> control it via an environment variable rather than a configuration
> option. (See, for instance, GIT_TEST_SPLIT_INDEX or GIT_USE_LOOKUP as
> precedent.)

I added that after reading
https://www.marc.info/?l=git&m=141995803919542&w=2
which makes me believe we actually want to expose this to the enduser.

Documentation will follow soon.
