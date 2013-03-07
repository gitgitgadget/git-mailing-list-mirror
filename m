From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] setup.c: Fix prefix_pathspec from looping pass end of string
Date: Thu, 7 Mar 2013 17:25:46 -0500
Message-ID: <CADgNjakrBCD2jMNUz95E-7FkyKmNgcQeuz8grDWczb-hM6yHhg@mail.gmail.com>
References: <1362674163-24682-1-git-send-email-andrew.kw.w@gmail.com>
	<7vobeulw4d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 23:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDjGP-0005Du-Ti
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 23:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab3CGWZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 17:25:48 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34795 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab3CGWZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 17:25:47 -0500
Received: by mail-wg0-f42.google.com with SMTP id 12so7582440wgh.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 14:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AEkZME3M5Oeru6CAWBIHyd01POe0scXl6bzuqifloQA=;
        b=Q0XpA9PL3ZCKCGxTyb8A++88cCJPbMIJPK3pdFsKJpsBVymSWLbkqRm0w8gcCRW1ou
         AEZa/8MPNjTbzfrtP6CkDaRD4DSbYdsVLS7/MbLO+j02NWcbHV5ZGPLQtkDckjRYg5R9
         XFljKmcGzf8WXrElPOJmZ85g4eDIFL431sv5fz7FKh9Or0v1HaD9gJAmh/E+cxiNma03
         S/lnT9Zc59MalrzoRDdvOlAISfaZN8nDg15TuHsbMdSOJalyl2KQswzuWoI6rj3quOUi
         5T2+DEblHtpFYjbiz7LJD5J/F45dS+GE0K9Dz0bXkWE3M2aGHm9yzPpBhL5ZEqXrRs7C
         ACCA==
X-Received: by 10.180.92.129 with SMTP id cm1mr36719055wib.10.1362695146353;
 Thu, 07 Mar 2013 14:25:46 -0800 (PST)
Received: by 10.194.39.202 with HTTP; Thu, 7 Mar 2013 14:25:46 -0800 (PST)
In-Reply-To: <7vobeulw4d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217623>

On 3/7/13, Junio C Hamano <gitster@pobox.com> wrote:
> The parser that goes past the end of the string may be a bug worth
> fixing, but is this patch sufficient to diagnose such an input as an
> error?

Yea, the patch should fix the passing end of string too. The parser
was going past end of string because the nextat is set to "copyfrom +
len + 1" for the '\0' case too. Then "+ 1" causes the parser to go
pass end of string. If we handle the '\0' case separately, then the
parser ends properly, and shouldn't be able to go pass the end of
string.

Hm, should I be paranoid and put an "else" clause to call die() as
well? In case there's a scenario where none of the 3 cases is true...

Andrew
