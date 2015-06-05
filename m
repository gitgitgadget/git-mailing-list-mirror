From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make git checkout safer
Date: Fri, 05 Jun 2015 11:03:52 -0700
Message-ID: <xmqqd21arq0n.fsf@gitster.dls.corp.google.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
	<loom.20150603T114527-151@post.gmane.org>
	<20150603194756.GB29730@vps892.directvps.nl>
	<loom.20150604T124827-124@post.gmane.org> <5570B1AC.2060108@web.de>
	<loom.20150605T113129-339@post.gmane.org>
	<CAPig+cTK4pXgweoGZc1-nj41aYo0bEK6Zrsc9291xQr5v8=p8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ed Avis <eda@waniasset.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 20:04:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0vyJ-0006OO-GR
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 20:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbbFESDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 14:03:55 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33266 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbbFESDy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 14:03:54 -0400
Received: by igbpi8 with SMTP id pi8so21100380igb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dvfDZOPOAEKYHqmhmk9zuuyFByKEknNjcOXhYlvcPLo=;
        b=ratVIi121Nc35eondsW5DgZryUq6pN9vuclVRTDv+ivxKouidj9YLqEWdIgTrbyibW
         m0yU+xjoGc38+LmTRLY0cT/m28FlSz8A1C2FTEtr4v3bYNrGKQFOg9+cxXi6USDEbDMg
         4rHefsTQk7a1ljikn4fKfL9dHUB4+RWBcd/M93tSNjCItR6f/SXGOzRbZDO+GX2O7LPx
         87NWhawDO8r7MCTE70xf9Bv9Gt8qgXF2sl9prpnkyW2bqhllh4lTGNACd3tAbYh4ciA6
         7bFfdbg3y/0OtkVnzi0ghY6LbukgQNS1/0ty4390cFWeCbiHzvg4pQTMc//vqWr3pOuE
         owlA==
X-Received: by 10.107.154.70 with SMTP id c67mr5987684ioe.22.1433527433981;
        Fri, 05 Jun 2015 11:03:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d0d:eed3:5800:fefa])
        by mx.google.com with ESMTPSA id 72sm2455162ioj.27.2015.06.05.11.03.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 11:03:53 -0700 (PDT)
In-Reply-To: <CAPig+cTK4pXgweoGZc1-nj41aYo0bEK6Zrsc9291xQr5v8=p8g@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 5 Jun 2015 13:44:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270869>

Eric Sunshine <sunshine@sunshineco.com> writes:

> ...
> Again:
>
>     ...`hello.c` will also be restored,...
>
>>  because the file globbing is used to match entries in the index
>>  (not in the working tree by the shell).

Thanks for a thorough review.  I agree with all the comments and
suggestions you gave.  Also, Ed, thanks for an attempt to improve
the documentation.

I think the biggest problem with this patch is that the tone of the
updated text is geared a lot more towards venting the initial
frustration of the writer than helping the readers of the document.

By explaining what the behaviour is meant to solve and help, the
readers would get useful information (e.g. "this is to be used to
restore pristine contents").  The same thing said in the negative
way only serve to unnecessarily repel readers (e.g. "this will
unconditionally overwrite and lose contents").

Technically, they are the descriptions of the same thing---in order
to restore pristine contents to the workng tree, you have to discard
the botched changes you made in the working tree, and that is done
"unconditionally" by "overwriting" and "losing contents".  But
saying it in the negative way does not serve as a useful warning.

The readers are intelligent, and they will understand (and will even
appreciate) that a request to replace their botched contents in the
working tree out of the index is done unconditionally without being
asked an unnecessary "are you sure?" and done by overwriting the
files, losing the botched contents from there, once they are
explained why they want to "git checkout $paths", what the operation
is meant to be used for.

Perhaps taking a deep breath and waiting for a few days for the head
to coll down and frustrations to dissipate may be a good thing to do
;-)
