From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 18/19] fsck: git receive-pack: support excluding objects from fsck'ing
Date: Fri, 19 Jun 2015 13:39:45 -0700
Message-ID: <xmqqwpyz5t66.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<e843f9f1defca543d3f2eb3143cf9fee8c72f695.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:48:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63DT-0002AH-6C
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbbFSUso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:48:44 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33972 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756292AbbFSUjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:39:48 -0400
Received: by iebmu5 with SMTP id mu5so82133830ieb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mA70uuHFEjlDWfEJlX6WQN2QuyCuRn3CB/TE3A17fuQ=;
        b=0LySeABWR1FYc6YqR8LcM26sK99pXCnTcPf/VUSLRXDT2Ms0Srwqm2WdSR081UMXt1
         MLlWa96vIl9xJBD5rCozZDWheVjoVGb6YTdyXexVmMXkRO/JKiRIrTBOo9gdCapVecQj
         oQoHyixL2QzX+SSymMNiSz7pBBRWyZy7GjFywnxZP74pVnUOTEdYCtBkw1pedmGBjJad
         o5dQ/Ys24XXPFifxYrKVzj4Uis5vk2fm0b2kIzNmY7Z9Slr7FkSjZut5rMTcP7DFyOet
         1rtl9waMYLIwPO8bdzXd2D6h5ZQEbT5zbXVGLzxohx450nxgLEN1mt4T6TjxEpwaBzwc
         koLg==
X-Received: by 10.107.149.133 with SMTP id x127mr24962943iod.20.1434746387277;
        Fri, 19 Jun 2015 13:39:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id a82sm7750312ioe.22.2015.06.19.13.39.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:39:46 -0700 (PDT)
In-Reply-To: <e843f9f1defca543d3f2eb3143cf9fee8c72f695.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:35:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272202>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	if (strcmp(var, "receive.fsck.skiplist") == 0) {
> +		const char *path = is_absolute_path(value) ?
> +			value : git_path("%s", value);

This "either absolute or inside $GIT_DIR" looks somewhat strange to
me.  Shouldn't we mimick what "git config --path" does instead?
