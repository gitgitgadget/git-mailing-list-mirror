From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Fri, 19 Jun 2015 08:27:42 -0700
Message-ID: <xmqqegl7btw1.fsf@gitster.dls.corp.google.com>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
	<CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
	<CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
	<20150617191235.GB25304@peff.net> <20150618101353.GA6525@lanh>
	<xmqqioalezhq.fsf@gitster.dls.corp.google.com>
	<20150619103946.GA20493@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 17:27:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5yCx-0001Do-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 17:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbbFSP1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 11:27:46 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33248 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbFSP1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 11:27:45 -0400
Received: by igbqq3 with SMTP id qq3so18586632igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n1T3g2q8wRvhT6fx7QVs+r57EnRWcojzWDNAdGdruPI=;
        b=kzmuMblqwPG+y1h7YKHePByMt1+O7Ut2Xze152DTxUwI7Hc8t5zB/wpP4LTP8bkFWA
         ZWGWSFNBkS8iXaaZ2Iz9DxEEpqbpWgNYgMROCIXRXYHbBI2hxXurd5hjRcpcO1+9DEGH
         XgBUSiqXOyOalJ7KcDfwtUrg2yWYmzrlQhzhQZugpLX/tOa8Bb91KArMzTD/mDAXKiJZ
         LeI78FylcFbCsl0MxZAiPfQZB4351DTr0wsaG5wz7hiQnC/A5jjcdKwx93yPqsJSmOMc
         1EwnWt9FISY1k7vfCbMIS/Uj8StdgOf5cCDFz09xWi0Bbz9BDlm395FgQlTSdUuHJUGP
         NAVQ==
X-Received: by 10.107.8.210 with SMTP id h79mr2118289ioi.27.1434727664556;
        Fri, 19 Jun 2015 08:27:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id j20sm1853702igt.5.2015.06.19.08.27.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 08:27:43 -0700 (PDT)
In-Reply-To: <20150619103946.GA20493@lanh> (Duy Nguyen's message of "Fri, 19
	Jun 2015 17:39:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272161>

Duy Nguyen <pclouds@gmail.com> writes:

> Anyway it does not put strbuf_slopbuf in .rodata.

That's sad.  I wa hoping that it would behave the same as this,
which does give me SEGV:

#include <stdio.h>

static const char x = '\0';
static char *y = (char *)&x;

int main (void) {
	*y = 1;
}
