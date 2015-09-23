From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 12:47:36 -0700
Message-ID: <xmqq37y4yl2f.fsf@gitster.mtv.corp.google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
	<xmqqeghpzm0y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYaqFRPfRORbknTyez5u0d6_BD0d5wBtAnjSkb4sUBUBA@mail.gmail.com>
	<xmqqlhbxxbai.fsf@gitster.mtv.corp.google.com>
	<xmqq7fnhx74i.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka8MAKKSzXQbA+ARFynkSzB36C-4v_a5JBKooUoWsgqRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 21:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zeq11-0007PG-AX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 21:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbbIWTri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 15:47:38 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36112 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbIWTri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 15:47:38 -0400
Received: by pablk4 with SMTP id lk4so1648823pab.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=j92XiOJEtMcwnRken+EXK1ReNl7Nlxo44b/fL5C2F3w=;
        b=Rv7+rg749OzACvPQUGO1f3esfu7BL3mLvnPsMPtk2qbOESyWgRmA4zto/xeY8gE2IG
         SGmIjk1C+jwMv1QAjDnfgRwddBw5TXVcoi5I6rtrsq7MUh2rdCjqgfBdmfz1Sxma4Deq
         R+q6F77qhB6SIL7fDDsnDeszkan2txmdp/nRp0JYJN5xr+l5I2z8UIeMo2YbWmqb+Vmr
         IDegjdULFkAeYOePtM6FuxE4C3/7M2lJLg0YVj09jT5Gjx0DXalEfwl6BbjsBeuVfaR5
         h9soP1ETjanmTYFhnGrxj+7udxJmy8TMM2iosY/GYGgsiIv8aqXs3fn30lT5EcozimwN
         2k2A==
X-Received: by 10.68.57.137 with SMTP id i9mr38643543pbq.101.1443037657645;
        Wed, 23 Sep 2015 12:47:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id lc9sm9430885pbc.52.2015.09.23.12.47.36
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 12:47:36 -0700 (PDT)
In-Reply-To: <CAGZ79ka8MAKKSzXQbA+ARFynkSzB36C-4v_a5JBKooUoWsgqRA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 23 Sep 2015 12:39:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278509>

Stefan Beller <sbeller@google.com> writes:

> I can confirm this now.
>
>     git fetch --recurse-submodules=yes -j 400
>
> in an submodule-ified Android tree takes very long to start putting out useful
> information, but if I hardcode the SPAWN_CAP to 4 it looks pretty amazing
> fast.

Nice to hear that parallel fetching does work ;-)
